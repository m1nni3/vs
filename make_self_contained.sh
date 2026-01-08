#!/bin/bash

# Script to make HTML files self-contained by:
# 1. Removing Google Fonts links (use system fonts instead)
# 2. Converting image references to base64 data URIs

WORK_DIR="/Users/m1nni3/Downloads/vettedStay-main"
IMAGES_DIR="$WORK_DIR/Images"
BACKUP_DIR="$WORK_DIR/backup_$(date +%Y%m%d_%H%M%S)"

echo "Creating backup in $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

# Find all HTML files
find "$WORK_DIR" -name "*.html" -type f | while read html_file; do
    echo "Processing: $html_file"
    
    # Create backup
    cp "$html_file" "$BACKUP_DIR/$(basename "$html_file")"
    
    # Create temporary file
    temp_file="${html_file}.tmp"
    cp "$html_file" "$temp_file"
    
    # Remove Google Fonts preconnect and font links
    sed -i '' '/<link rel="preconnect" href="https:\/\/fonts\.googleapis\.com">/d' "$temp_file"
    sed -i '' '/<link rel="preconnect" href="https:\/\/fonts\.gstatic\.com"/d' "$temp_file"
    sed -i '' '/<link href="https:\/\/fonts\.googleapis\.com\/css2/d' "$temp_file"
    
    # Replace font-family references with system fonts
    sed -i '' "s/'Inter',/-apple-system,/g" "$temp_file"
    
    # Move temp file to original
    mv "$temp_file" "$html_file"
done

echo "Step 1 complete: Removed external font dependencies"
echo ""
echo "Now processing images..."
echo "Note: Image embedding will be done in next step"

