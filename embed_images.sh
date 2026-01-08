#!/bin/bash

WORK_DIR="/Users/m1nni3/Downloads/vettedStay-main"
IMAGES_DIR="$WORK_DIR/Images"

# Function to get MIME type
get_mime_type() {
    case "$1" in
        *.png) echo "image/png" ;;
        *.jpg|*.jpeg) echo "image/jpeg" ;;
        *.gif) echo "image/gif" ;;
        *.svg) echo "image/svg+xml" ;;
        *) echo "application/octet-stream" ;;
    esac
}

# Create a temporary file with image mappings
declare -A image_map

echo "Building image base64 cache..."
for img in "$IMAGES_DIR"/*.png "$IMAGES_DIR"/*.jpg "$IMAGES_DIR"/*.jpeg; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")
        mime=$(get_mime_type "$img")
        base64_data=$(base64 -i "$img")
        data_uri="data:${mime};base64,${base64_data}"
        
        echo "Processed: $filename (${#data_uri} bytes)"
        
        # Store in temp file for sed replacement
        echo "${filename}|${data_uri}" >> /tmp/image_mappings.txt
    fi
done

echo ""
echo "Embedding images in HTML files..."

# Process each HTML file
find "$WORK_DIR" -name "*.html" -type f | while read html_file; do
    echo "Updating: $html_file"
    
    # Read mappings and replace
    while IFS='|' read -r filename data_uri; do
        # Replace href="Images/filename"
        sed -i '' "s|href=\"Images/${filename}\"|href=\"${data_uri}\"|g" "$html_file"
        # Replace src="Images/filename"  
        sed -i '' "s|src=\"Images/${filename}\"|src=\"${data_uri}\"|g" "$html_file"
        # Replace ../Images/filename
        sed -i '' "s|src=\"../Images/${filename}\"|src=\"${data_uri}\"|g" "$html_file"
    done < /tmp/image_mappings.txt
done

rm -f /tmp/image_mappings.txt
echo ""
echo "✅ All HTML files are now self-contained!"

