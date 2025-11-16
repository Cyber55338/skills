# Podcast Generator Skill

## Overview
Automatically converts saved conversation transcripts into AI-generated podcasts using Google NotebookLM Podcast API. Creates natural-sounding discussions between two AI hosts about your content.

## How It Works

1. **Reads markdown transcript** from `~/saved-conversations/`
2. **Sends to Google NotebookLM API** with configured settings
3. **Downloads generated MP3 podcast** to `~/saved-conversations/podcasts/`
4. **Returns playback information** to user

## Prerequisites

### Google Cloud Setup (Required)
User must have:
1. Google Cloud project with Discovery Engine API enabled
2. IAM role: `roles/discoveryengine.podcastApiUser`
3. gcloud CLI installed and authenticated: `gcloud auth login`
4. Project ID configured

**Note**: Access to Podcast API is available to select Google Cloud customers. User may need to request access.

### Configuration File
Location: `~/.claude/skills/podcast-generator/config.json`

```json
{
  "google_cloud": {
    "project_id": "your-project-id",
    "endpoint": "https://discoveryengine.googleapis.com/v1"
  },
  "podcast_settings": {
    "length": "STANDARD",
    "focus": "Provide a comprehensive discussion of the key insights and frameworks presented",
    "default_title": "Claude Conversation Podcast",
    "default_description": "AI-generated podcast discussion of a Claude Code conversation"
  },
  "output": {
    "directory": "~/saved-conversations/podcasts",
    "naming": "[transcript-name]-podcast.mp3"
  }
}
```

## Instructions for Claude

When this skill is activated:

### Step 1: Identify the Source
Ask user:
- Which conversation to convert? (list available transcripts from `~/saved-conversations/`)
- OR use most recent transcript automatically if user specifies

### Step 2: Validate Setup
Check if configuration exists:
```bash
if [ ! -f ~/.claude/skills/podcast-generator/config.json ]; then
  echo "Config not found. Creating template..."
  # Create template config
fi
```

Check if gcloud is authenticated:
```bash
gcloud auth print-access-token > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Please authenticate: gcloud auth login"
  exit 1
fi
```

### Step 3: Read Transcript
```bash
TRANSCRIPT_PATH="~/saved-conversations/[filename].md"
CONTENT=$(cat "$TRANSCRIPT_PATH")
```

### Step 4: Prepare API Request
Create JSON payload:
```json
{
  "podcastConfig": {
    "focus": "Provide a comprehensive, engaging discussion of the key insights, frameworks, and actionable advice from this conversation. Make it accessible and valuable for listeners.",
    "length": "STANDARD",
    "languageCode": "en-US"
  },
  "contexts": [
    {
      "text": "[FULL MARKDOWN CONTENT HERE]"
    }
  ],
  "title": "[Conversation Topic] - AI Podcast",
  "description": "AI-generated podcast discussion exploring [brief topic description]"
}
```

**Important**:
- Ensure content is under 100,000 tokens
- Escape special characters in JSON
- Generate meaningful title/description from transcript

### Step 5: Send to API
```bash
PROJECT_ID="[from config]"
API_ENDPOINT="https://discoveryengine.googleapis.com/v1/projects/$PROJECT_ID/locations/global/podcasts"

RESPONSE=$(curl -X POST \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "Content-Type: application/json" \
  "$API_ENDPOINT" \
  -d @payload.json)

OPERATION_NAME=$(echo "$RESPONSE" | jq -r '.name')
```

### Step 6: Poll for Completion
The API is asynchronous. Poll the operation status:
```bash
while true; do
  STATUS=$(curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    "https://discoveryengine.googleapis.com/v1/$OPERATION_NAME" | jq -r '.done')

  if [ "$STATUS" == "true" ]; then
    break
  fi

  echo "Generating podcast... (this may take 2-5 minutes)"
  sleep 15
done
```

### Step 7: Download Podcast
```bash
OUTPUT_FILE="~/saved-conversations/podcasts/[transcript-name]-podcast.mp3"

curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  "https://discoveryengine.googleapis.com/v1/$OPERATION_NAME:download?alt=media" \
  --output "$OUTPUT_FILE"
```

### Step 8: Confirm & Provide Playback Info
```bash
FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$OUTPUT_FILE" 2>/dev/null | awk '{printf "%d:%02d", $1/60, $1%60}')

echo "✓ Podcast generated successfully!"
echo ""
echo "File: $OUTPUT_FILE"
echo "Size: $FILE_SIZE"
echo "Duration: $DURATION"
echo ""
echo "Play with: mpv \"$OUTPUT_FILE\""
echo "Or: termux-media-player play \"$OUTPUT_FILE\""
```

## Output Format

After successful generation, inform user:

```
✓ **Podcast generated successfully!**

**Title**: [Conversation Topic] - AI Podcast
**File**: ~/saved-conversations/podcasts/[name]-podcast.mp3
**Size**: [X] MB
**Duration**: [X:XX]

**Play now**:
  mpv ~/saved-conversations/podcasts/[name]-podcast.mp3

**Features**:
- Two AI hosts discussing your conversation
- Natural conversational flow
- Key insights highlighted
- Accessible explanations

The podcast captures the essence of your conversation in an engaging audio format!
```

## Error Handling

### Common Errors:

**1. Authentication Failed**
```
Error: gcloud authentication required
Solution: Run 'gcloud auth login' in terminal
```

**2. API Access Denied**
```
Error: User lacks required IAM role
Solution: Contact Google Cloud admin to grant 'roles/discoveryengine.podcastApiUser'
```

**3. Content Too Large**
```
Error: Content exceeds 100,000 token limit
Solution: Split conversation or summarize before sending
```

**4. API Quota Exceeded**
```
Error: Quota exceeded
Solution: Check Google Cloud console for API quotas, wait or request increase
```

### Error Response Template:
```
✗ **Podcast generation failed**

**Error**: [Error message]
**Suggestion**: [How to fix]

**Need help?** Check:
1. gcloud authentication: gcloud auth list
2. API enabled: gcloud services list --enabled
3. IAM permissions: gcloud projects get-iam-policy [PROJECT_ID]
```

## Helper Scripts

### Script 1: generate-podcast.sh
Location: `~/.claude/skills/podcast-generator/generate-podcast.sh`

```bash
#!/data/data/com.termux/files/usr/bin/bash

# Usage: ./generate-podcast.sh <transcript-path>

TRANSCRIPT_PATH="$1"
CONFIG_FILE="$HOME/.claude/skills/podcast-generator/config.json"

# Validate inputs
if [ ! -f "$TRANSCRIPT_PATH" ]; then
  echo "Error: Transcript not found: $TRANSCRIPT_PATH"
  exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Config not found. Run setup first."
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

if [ "$OPERATION_NAME" == "null" ]; then
  echo "Error: API request failed"
  echo "$RESPONSE" | jq .
  exit 1
fi

echo "Operation: $OPERATION_NAME"
echo "Generating podcast (2-5 minutes)..."

# Poll for completion
while true; do
  STATUS_RESPONSE=$(curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    "$ENDPOINT/$OPERATION_NAME")

  DONE=$(echo "$STATUS_RESPONSE" | jq -r '.done')

  if [ "$DONE" == "true" ]; then
    ERROR=$(echo "$STATUS_RESPONSE" | jq -r '.error')
    if [ "$ERROR" != "null" ]; then
      echo "Error during generation:"
      echo "$STATUS_RESPONSE" | jq '.error'
      exit 1
    fi
    break
  fi

  echo -n "."
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

# Report
FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)

echo ""
echo "✓ Podcast generated successfully!"
echo "File: $OUTPUT_FILE"
echo "Size: $FILE_SIZE"
echo ""
echo "Play with: mpv \"$OUTPUT_FILE\""
```

### Script 2: setup-podcast-api.sh
Location: `~/.claude/skills/podcast-generator/setup-podcast-api.sh`

```bash
#!/data/data/com.termux/files/usr/bin/bash

# Interactive setup for Google NotebookLM Podcast API

echo "=== Google NotebookLM Podcast API Setup ==="
echo ""

# Check gcloud
if ! command -v gcloud &> /dev/null; then
  echo "Error: gcloud CLI not found"
  echo "Install: pkg install google-cloud-sdk"
  exit 1
fi

# Authenticate
echo "Step 1: Authentication"
gcloud auth list
echo ""
read -p "Already authenticated? (y/n): " AUTHENTICATED

if [ "$AUTHENTICATED" != "y" ]; then
  gcloud auth login
fi

# Get project ID
echo ""
echo "Step 2: Project Configuration"
read -p "Enter your Google Cloud Project ID: " PROJECT_ID

# Enable API
echo ""
echo "Step 3: Enable Discovery Engine API"
read -p "Enable API now? (y/n): " ENABLE_API

if [ "$ENABLE_API" == "y" ]; then
  gcloud services enable discoveryengine.googleapis.com --project="$PROJECT_ID"
fi

# Create config
CONFIG_DIR="$HOME/.claude/skills/podcast-generator"
mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_DIR/config.json" <<EOF
{
  "google_cloud": {
    "project_id": "$PROJECT_ID",
    "endpoint": "https://discoveryengine.googleapis.com/v1"
  },
  "podcast_settings": {
    "length": "STANDARD",
    "focus": "Provide a comprehensive discussion of the key insights and frameworks presented",
    "default_title": "Claude Conversation Podcast",
    "default_description": "AI-generated podcast discussion"
  },
  "output": {
    "directory": "~/saved-conversations/podcasts",
    "naming": "[transcript-name]-podcast.mp3"
  }
}
EOF

echo ""
echo "✓ Configuration saved: $CONFIG_DIR/config.json"
echo ""
echo "Next steps:"
echo "1. Ensure you have IAM role: roles/discoveryengine.podcastApiUser"
echo "2. Request API access if needed (available to select customers)"
echo "3. Use 'podcast-generator' skill to create podcasts!"
```

## Usage Examples

### Example 1: Generate from Latest Conversation
```
User: "create a podcast from my latest conversation"

Claude:
1. Lists recent transcripts
2. User confirms or selects
3. Generates podcast using API
4. Provides playback instructions
```

### Example 2: Generate from Specific File
```
User: "make a podcast from Crypto-Wealth-Family-Strategy-Chat-Transcript-2025-11-05.md"

Claude:
1. Reads specified file
2. Sends to API with optimized settings
3. Downloads MP3
4. Reports completion
```

### Example 3: Batch Generation
```
User: "create podcasts for all my saved conversations"

Claude:
1. Lists all transcripts in ~/saved-conversations/
2. Confirms with user
3. Processes each sequentially
4. Reports progress and completion
```

## Integration with Save-Conversation Skill

The save-conversation skill can be updated to automatically trigger podcast generation:

```
User: "save this conversation and make a podcast"

Claude:
1. Saves transcript to ~/saved-conversations/
2. Automatically triggers podcast-generator skill
3. Returns both transcript and podcast locations
```

## Advanced Features

### Custom Focus Prompts
User can specify custom focus for the podcast:
```
User: "create a podcast focusing on the FLOW framework explanation"

Focus prompt: "Deep dive into the FLOW framework methodology, explaining each component with practical examples"
```

### Length Options
- **SHORT**: 4-5 minutes (quick overview)
- **STANDARD**: ~10 minutes (comprehensive discussion)

### Language Support
Supports multiple languages via BCP47 codes (en-US, es-ES, etc.)

## Troubleshooting

### Podcast Quality Issues
- Ensure transcript is well-formatted markdown
- Use clear section headers
- Include enough context for AI hosts

### API Rate Limits
- Standard quota: Check Google Cloud console
- Wait time between requests: ~15 seconds
- Batch processing: Process sequentially

### File Size Concerns
- Standard podcasts: 5-15 MB
- Storage: Monitor ~/saved-conversations/podcasts/
- Cleanup: Remove old podcasts if needed

## Success Criteria

✓ One-command podcast generation from any transcript
✓ Natural-sounding two-host discussion
✓ Audio quality suitable for mobile listening
✓ Complete in under 5 minutes
✓ Seamless integration with save-conversation workflow

---

**Ready to use!** Activate with: "use podcast-generator skill" or "create podcast from [file]"
