#!/bin/bash

# Script to copy SDF file and models folder from a relative path to the current package

if [ $# -lt 2 ]; then
    echo "Usage: $0 <relative_path> <sdf_filename>"
    echo "Example: $0 ../world_pkg world"
    exit 1
fi

RELATIVE_PATH="$1"
SDF_FILE="$2.sdf"

# Get absolute path
SOURCE_PATH="$(cd "$RELATIVE_PATH" 2>/dev/null && pwd)"
if [ ! -d "$SOURCE_PATH" ]; then
    echo "Error: Path does not exist: $RELATIVE_PATH"
    exit 1
fi

SOURCE_WORLDS="$SOURCE_PATH/worlds"
SOURCE_MODELS="$SOURCE_PATH/models"
DEST_WORLDS="$(pwd)/worlds"
DEST_MODELS="$(pwd)/models"

# Check if source worlds folder exists
if [ ! -d "$SOURCE_WORLDS" ]; then
    echo "Error: Source worlds folder not found: $SOURCE_WORLDS"
    exit 1
fi

# Check if SDF file exists
if [ ! -f "$SOURCE_WORLDS/$SDF_FILE" ]; then
    echo "Error: SDF file not found: $SOURCE_WORLDS/$SDF_FILE"
    exit 1
fi

# Create destination folders if they don't exist
mkdir -p "$DEST_WORLDS"
mkdir -p "$DEST_MODELS"

# Copy SDF file
cp "$SOURCE_WORLDS/$SDF_FILE" "$DEST_WORLDS/"
echo "Copied: $SDF_FILE to $DEST_WORLDS/"

# Copy models folder if it exists
if [ -d "$SOURCE_MODELS" ]; then
    cp -r "$SOURCE_MODELS"/* "$DEST_MODELS/"
    echo "Copied: models folder to $DEST_MODELS/"
else
    echo "Warning: Models folder not found at $SOURCE_MODELS"
fi

echo "Done!"