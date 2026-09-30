#!/bin/bash
set -e

# Install essential tools
sudo apt-get update && sudo apt-get install -y wget unzip curl

# Set up Android SDK directory
export ANDROID_HOME=/workspaces/android-sdk
mkdir -p $ANDROID_HOME/cmdline-tools

# Download Android Command-line Tools
CMD_TOOLS_URL="https://google.com"
curl -o cmdline-tools.zip $CMD_TOOLS_URL
unzip -q cmdline-tools.zip -d temp_tools
mv temp_tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest
rm -rf cmdline-tools.zip temp_tools

# Export environment variables permanently
echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools" >> ~/.bashrc
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Accept licenses and install platform tools & build tools
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
