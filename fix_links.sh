#!/bin/bash

WORK_DIR="$(pwd)"

echo "Analyzing HTML files and their links..."
echo ""

# Find all unique HTML links across all files
echo "=== Current link patterns found ==="
find "$WORK_DIR" -name "*.html" -not -path "*/backup_*/*" -exec grep -h "href=\"[^\"]*\.html\"" {} \; | \
  grep -o 'href="[^"]*\.html"' | sort -u

echo ""
echo "=== Files that exist in main directory ==="
ls -1 "$WORK_DIR"/*.html 2>/dev/null | xargs -n1 basename

echo ""
echo "=== Files that exist in untitled folder ==="
ls -1 "$WORK_DIR/untitled folder"/*.html 2>/dev/null | xargs -n1 basename

echo ""
echo "Creating link correction mappings..."
echo ""

# Common incorrect references to fix
declare -a old_links=(
  "index-ultra-enhanced.html"
  "services-ultra.html"
  "bundles-ultra.html"
  "contact_page.html"
  "privacy_policy.html"
)

declare -a new_links=(
  "index.html"
  "services.html"
  "bundles.html"
  "contact.html"
  "privacy.html"
)

echo "Fixing links in all HTML files..."

# Process each HTML file
find "$WORK_DIR" -name "*.html" -not -path "*/backup_*/*" | while read html_file; do
    echo "Processing: $(basename "$html_file")"
    
    # Fix common wrong references
    sed -i 's|href="index-ultra-enhanced\.html"|href="index.html"|g' "$html_file"
    sed -i 's|href="services-ultra\.html"|href="services.html"|g' "$html_file"
    sed -i 's|href="bundles-ultra\.html"|href="bundles.html"|g' "$html_file"
    sed -i 's|href="contact_page\.html"|href="contact.html"|g' "$html_file"
    sed -i 's|href="privacy_policy\.html"|href="privacy.html"|g' "$html_file"
    sed -i 's|href="checkout-ultra\.html"|href="checkout-payfast.html"|g' "$html_file"
    
    # Fix absolute URLs pointing to ultra versions
    sed -i 's|https://vetstay\.click/index-ultra-enhanced\.html|index.html|g' "$html_file"
    sed -i 's|https://vetstay\.click/services-ultra\.html|services.html|g' "$html_file"
    sed -i 's|https://vetstay\.click/bundles-ultra\.html|bundles.html|g' "$html_file"
    sed -i 's|https://vetstay\.click/contact-ultra\.html|contact.html|g' "$html_file"
    sed -i 's|https://vetstay\.click/privacy-ultra\.html|privacy.html|g' "$html_file"
    sed -i 's|https://vetstay\.click/contact_page\.html|contact.html|g' "$html_file"
    sed -i 's|https://vetstay\.click/privacy_policy\.html|privacy.html|g' "$html_file"
    
    # If file is in untitled folder, don't add ../ for same-folder references
    # If file is in main directory, references should be direct
done

echo ""
echo "✅ Link corrections complete!"
