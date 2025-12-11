#!/bin/bash

# This script checks and sets the correct SELinux context for a given file or directory.
# It ensures programs like Docker can access the specified path without permission errors.
# If the context is already set, it does nothing; otherwise, it applies 'chcon'.
# Author: Pramod Phuyal

echo "Please Proceed Only If You Know What Your're Doing"
echo "=================================================="
echo ""
echo "Plugin to Set SELinux Context"

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

PATH_TO_FILE="$1"

# Check if the path exists
if [ ! -e "$PATH_TO_FILE" ]; then
    echo "Warning: Path does not exist - $PATH_TO_FILE"
    exit 1
fi

CURRENT_CONTEXT=$(ls -Z "$PATH_TO_FILE" | awk '{print $1}')

# Expected SELinux context
EXPECTED_CONTEXT="unconfined_u:object_r:svirt_sandbox_file_t:s0"

# Check if the context is already set
if [[ "$CURRENT_CONTEXT" == *"svirt_sandbox_file_t"* ]]; then
    echo "SELinux context is already set correctly: $CURRENT_CONTEXT"
else
    echo "Setting SELinux context on: $PATH_TO_FILE"
    sudo chcon -Rt svirt_sandbox_file_t "$PATH_TO_FILE"
    echo "SELinux context updated successfully."
fi
