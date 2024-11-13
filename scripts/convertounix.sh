#!/bin/bash

# Print debug info to ensure environment variables are set
echo "DEPLOYMENT_GROUP_NAME: $DEPLOYMENT_GROUP_NAME"
echo "DEPLOYMENT_ID: $DEPLOYMENT_ID"

# Construct the exact path to the current deployment's archive directory
CURRENT_DEPLOYMENT_DIR="/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_NAME/$DEPLOYMENT_ID/deployment-archive"

# Check if the current deployment directory exists
if [ ! -d "$CURRENT_DEPLOYMENT_DIR" ]; then
  echo "Error: Current deployment directory not found: $CURRENT_DEPLOYMENT_DIR"
  exit 1
fi

# Find and convert all .sh files in the current deployment directory to Unix format
echo "Converting .sh files in $CURRENT_DEPLOYMENT_DIR to Unix format..."
find "$CURRENT_DEPLOYMENT_DIR" -type f -name "*.sh" -exec dos2unix {} \;

echo "Conversion completed for all .sh files in $CURRENT_DEPLOYMENT_DIR."
