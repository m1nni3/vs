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

echo "Embedding images using Perl..."

# Process each HTML file
find "$WORK_DIR" -name "*.html" -type f -not -path "*/backup_*/*" | while read html_file; do
    echo "Processing: $(basename "$html_file")"
    
    # Process each image
    for img in "$IMAGES_DIR"/*.png "$IMAGES_DIR"/*.jpg "$IMAGES_DIR"/*.jpeg; do
        if [ -f "$img" ]; then
            filename=$(basename "$img")
            mime=$(get_mime_type "$img")
            
            # Use perl for in-place editing with base64 embedding
            perl -i -pe "
                BEGIN {
                    use MIME::Base64;
                    open(my \$fh, '<', '$img') or die;
                    binmode \$fh;
                    local \$/;
                    my \$data = <\$fh>;
                    close \$fh;
                    \$base64 = encode_base64(\$data, '');
                    \$data_uri = 'data:$mime;base64,' . \$base64;
                }
                s/href=\"Images\/$filename\"/href=\"\$data_uri\"/g;
                s/src=\"Images\/$filename\"/src=\"\$data_uri\"/g;
                s/src=\"\.\.\/Images\/$filename\"/src=\"\$data_uri\"/g;
            " "$html_file"
        fi
    done
done

echo ""
echo "✅ All HTML files are now self-contained!"
echo "Original files backed up to: backup_20260107_165039/"

