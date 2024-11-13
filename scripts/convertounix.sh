#!/bin/bash
find /opt/codedeploy-agent/deployment-root/deployment-archive -type f -name "*.sh" -exec dos2unix {} \;
