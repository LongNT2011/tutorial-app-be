#!/bin/bash
# Locate the deployment directory based on known parts of the path
DEPLOYMENT_DIR=$(find /opt/codedeploy-agent/deployment-root -type d -name 'deployment-archive' | head -n 1)

# Check if the deployment directory was found
if [ -z "$DEPLOYMENT_DIR" ]; then
  echo "Deployment directory not found."
  exit 1
fi

# Convert all .sh files to Unix format within the found directory
find "$DEPLOYMENT_DIR" -type f -name "*.sh" -exec dos2unix {} \;
