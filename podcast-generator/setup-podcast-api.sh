#!/data/data/com.termux/files/usr/bin/bash

# Interactive setup for Google NotebookLM Podcast API

echo "=== Google NotebookLM Podcast API Setup ==="
echo ""

# Check gcloud
if ! command -v gcloud &> /dev/null; then
  echo "⚠ gcloud CLI not found"
  echo ""
  echo "Install options:"
  echo "1. Termux: pkg install google-cloud-sdk"
  echo "2. Manual: https://cloud.google.com/sdk/docs/install"
  echo ""
  read -p "Install now via pkg? (y/n): " INSTALL_GCLOUD

  if [ "$INSTALL_GCLOUD" == "y" ]; then
    pkg install google-cloud-sdk
  else
    echo "Please install gcloud CLI and run this script again"
    exit 1
  fi
fi

# Authenticate
echo ""
echo "Step 1: Authentication"
echo "Current accounts:"
gcloud auth list
echo ""
read -p "Already authenticated? (y/n): " AUTHENTICATED

if [ "$AUTHENTICATED" != "y" ]; then
  echo "Opening browser for authentication..."
  gcloud auth login
fi

# Get project ID
echo ""
echo "Step 2: Project Configuration"
echo "Tip: Find your project ID at https://console.cloud.google.com/"
read -p "Enter your Google Cloud Project ID: " PROJECT_ID

if [ -z "$PROJECT_ID" ]; then
  echo "Error: Project ID cannot be empty"
  exit 1
fi

# Set default project
gcloud config set project "$PROJECT_ID"

# Enable API
echo ""
echo "Step 3: Enable Discovery Engine API"
read -p "Enable API now? (y/n): " ENABLE_API

if [ "$ENABLE_API" == "y" ]; then
  echo "Enabling Discovery Engine API..."
  gcloud services enable discoveryengine.googleapis.com --project="$PROJECT_ID"
  echo "✓ API enabled"
fi

# Check IAM permissions
echo ""
echo "Step 4: Verify Permissions"
echo "Checking if you have required role..."

CURRENT_USER=$(gcloud config get-value account)
HAS_ROLE=$(gcloud projects get-iam-policy "$PROJECT_ID" \
  --flatten="bindings[].members" \
  --filter="bindings.members:user:$CURRENT_USER AND bindings.role:roles/discoveryengine.podcastApiUser" \
  --format="value(bindings.role)")

if [ -z "$HAS_ROLE" ]; then
  echo "⚠ Warning: You may not have the required IAM role"
  echo "Required role: roles/discoveryengine.podcastApiUser"
  echo ""
  echo "Ask your Google Cloud admin to grant this role, or run:"
  echo "  gcloud projects add-iam-policy-binding $PROJECT_ID \\"
  echo "    --member='user:$CURRENT_USER' \\"
  echo "    --role='roles/discoveryengine.podcastApiUser'"
else
  echo "✓ IAM role verified"
fi

# Create directories
echo ""
echo "Step 5: Create Directories"
mkdir -p "$HOME/saved-conversations/podcasts"
mkdir -p "$HOME/.claude/skills/podcast-generator"

# Create config
CONFIG_DIR="$HOME/.claude/skills/podcast-generator"

cat > "$CONFIG_DIR/config.json" <<EOF
{
  "google_cloud": {
    "project_id": "$PROJECT_ID",
    "endpoint": "https://discoveryengine.googleapis.com/v1"
  },
  "podcast_settings": {
    "length": "STANDARD",
    "focus": "Provide a comprehensive, engaging discussion of the key insights and frameworks presented. Make it accessible and valuable for listeners.",
    "default_title": "Claude Conversation Podcast",
    "default_description": "AI-generated podcast discussion"
  },
  "output": {
    "directory": "~/saved-conversations/podcasts",
    "naming": "[transcript-name]-podcast.mp3"
  }
}
EOF

echo "✓ Configuration saved: $CONFIG_DIR/config.json"

# Make scripts executable
chmod +x "$CONFIG_DIR/generate-podcast.sh"
chmod +x "$CONFIG_DIR/setup-podcast-api.sh"

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Configuration:"
echo "  Project ID: $PROJECT_ID"
echo "  Output directory: ~/saved-conversations/podcasts/"
echo ""
echo "Next steps:"
echo "1. Verify API access (may require approval from Google)"
echo "2. Use Claude to generate podcasts: 'create podcast from [transcript]'"
echo "3. Or run manually: ./generate-podcast.sh ~/saved-conversations/[file].md"
echo ""
echo "Note: Podcast API is available to select Google Cloud customers"
echo "      Request access at: https://cloud.google.com/ai/notebooklm"
