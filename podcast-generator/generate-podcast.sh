#!/data/data/com.termux/files/usr/bin/bash

# Generate podcast from transcript using Google NotebookLM API
# Usage: ./generate-podcast.sh <transcript-path>

TRANSCRIPT_PATH="$1"
CONFIG_FILE="$HOME/.claude/skills/podcast-generator/config.json"

# Validate inputs
if [ ! -f "$TRANSCRIPT_PATH" ]; then
  echo "Error: Transcript not found: $TRANSCRIPT_PATH"
  exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Config not found. Run setup-podcast-api.sh first."
  exit 1
fi

# Check gcloud authentication
if ! gcloud auth print-access-token > /dev/null 2>&1; then
  echo "Error: Not authenticated with gcloud"
  echo "Run: gcloud auth login"
  exit 1
fi

# Load config
PROJECT_ID=$(jq -r '.google_cloud.project_id' "$CONFIG_FILE")
ENDPOINT=$(jq -r '.google_cloud.endpoint' "$CONFIG_FILE")
LENGTH=$(jq -r '.podcast_settings.length' "$CONFIG_FILE")
FOCUS=$(jq -r '.podcast_settings.focus' "$CONFIG_FILE")

# Read transcript
CONTENT=$(cat "$TRANSCRIPT_PATH")
FILENAME=$(basename "$TRANSCRIPT_PATH" .md)

# Create payload
cat > /tmp/podcast-payload.json <<EOF
{
  "podcastConfig": {
    "focus": "$FOCUS",
    "length": "$LENGTH",
    "languageCode": "en-US"
  },
  "contexts": [
    {
      "text": $(echo "$CONTENT" | jq -Rs .)
    }
  ],
  "title": "$FILENAME - AI Podcast",
  "description": "AI-generated podcast from Claude conversation"
}
EOF

# Submit to API
echo "Submitting to Google NotebookLM API..."
RESPONSE=$(curl -s -X POST \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  "$ENDPOINT/projects/$PROJECT_ID/locations/global/podcasts" \
  -d @/tmp/podcast-payload.json)

OPERATION_NAME=$(echo "$RESPONSE" | jq -r '.name')

if [ "$OPERATION_NAME" == "null" ] || [ -z "$OPERATION_NAME" ]; then
  echo "Error: API request failed"
  echo "$RESPONSE" | jq .
  rm /tmp/podcast-payload.json
  exit 1
fi

echo "Operation: $OPERATION_NAME"
echo "Generating podcast (typically 2-5 minutes)..."
echo ""

# Poll for completion
DOTS=0
while true; do
  STATUS_RESPONSE=$(curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    "$ENDPOINT/$OPERATION_NAME")

  DONE=$(echo "$STATUS_RESPONSE" | jq -r '.done')

  if [ "$DONE" == "true" ]; then
    ERROR=$(echo "$STATUS_RESPONSE" | jq -r '.error')
    if [ "$ERROR" != "null" ]; then
      echo ""
      echo "Error during generation:"
      echo "$STATUS_RESPONSE" | jq '.error'
      rm /tmp/podcast-payload.json
      exit 1
    fi
    break
  fi

  echo -n "."
  DOTS=$((DOTS + 1))
  if [ $DOTS -eq 60 ]; then
    echo ""
    DOTS=0
  fi
  sleep 15
done

echo ""
echo "Downloading podcast..."

# Download
OUTPUT_DIR="$HOME/saved-conversations/podcasts"
mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/${FILENAME}-podcast.mp3"

curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  "$ENDPOINT/$OPERATION_NAME:download?alt=media" \
  --output "$OUTPUT_FILE"

# Cleanup
rm /tmp/podcast-payload.json

# Check if download successful
if [ ! -f "$OUTPUT_FILE" ]; then
  echo "Error: Download failed"
  exit 1
fi

# Report
FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)

echo ""
echo "✓ Podcast generated successfully!"
echo ""
echo "File: $OUTPUT_FILE"
echo "Size: $FILE_SIZE"
echo ""
echo "Play with: mpv \"$OUTPUT_FILE\""
echo "Or: termux-media-player play \"$OUTPUT_FILE\""
