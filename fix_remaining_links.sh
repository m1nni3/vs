#!/bin/bash

WORK_DIR="/Users/m1nni3/Downloads/vettedStay-main"

echo "Fixing remaining broken links..."

# Process each HTML file
find "$WORK_DIR" -name "*.html" -not -path "*/backup_*/*" | while read html_file; do
    # Fix all ultra variants
    sed -i '' 's|href="index-ultra\.html"|href="index.html"|g' "$html_file"
    sed -i '' 's|href="contact-ultra\.html"|href="contact.html"|g' "$html_file"
    sed -i '' 's|href="privacy-ultra\.html"|href="privacy.html"|g' "$html_file"
    sed -i '' 's|href="privacy-policy\.html"|href="privacy.html"|g' "$html_file"
    
    # Also check for any variant with dashes
    sed -i '' 's|href="services-ultra\.html"|href="services.html"|g' "$html_file"
    sed -i '' 's|href="bundles-ultra\.html"|href="bundles.html"|g' "$html_file"
done

echo "✅ All remaining links fixed!"
echo ""
echo "Final verification..."

# Show what links remain
echo "=== All HTML links now in files ==="
find "$WORK_DIR" -name "*.html" -not -path "*/backup_*/*" -exec grep -h "href=\"[^\"]*\.html\"" {} \; | \
  grep -o 'href="[^"]*\.html"' | sort -u

echo ""
echo "=== Checking for non-existent file references ==="
find "$WORK_DIR" -name "*.html" -not -path "*/backup_*/*" -exec grep -h "href=\"[^\"]*\.html\"" {} \; | \
  grep -o 'href="[^"]*\.html"' | sed 's/href="//;s/"//' | sort -u | while read linkfile; do
    # Check main directory
    if [ ! -f "$WORK_DIR/$linkfile" ] && [ ! -f "$WORK_DIR/untitled folder/$linkfile" ]; then
        echo "⚠️  Referenced but not found: $linkfile"
    fi
done

echo ""
echo "✅ Link correction complete!"
