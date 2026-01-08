#!/bin/bash

echo "════════════════════════════════════════════════════════"
echo "  VettedStay Cleanup & Domain Update Script"
echo "════════════════════════════════════════════════════════"
echo ""

BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)_redundant"
DOMAIN="vetstay.click"

# Create backup directory for redundant files
mkdir -p "$BACKUP_DIR"

echo "Step 1: Moving redundant files to backup..."
echo "──────────────────────────────────────────────────────"

# Move the entire "untitled folder" - it contains duplicate/old versions
if [ -d "untitled folder" ]; then
    mv "untitled folder" "$BACKUP_DIR/"
    echo "✅ Moved 'untitled folder' (12 old HTML files)"
fi

# Move old checkout files (we're using checkout-payfast.html now)
if [ -f "checkout.html" ]; then
    mv checkout.html "$BACKUP_DIR/"
    echo "✅ Moved old checkout.html"
fi

# Keep only the main working files
echo ""
echo "Redundant files moved to: $BACKUP_DIR/"
echo ""

echo "Step 2: Updating domain in all HTML files..."
echo "──────────────────────────────────────────────────────"

# Find all HTML files in main directory
for file in *.html; do
    if [ -f "$file" ]; then
        echo "Processing: $file"
        
        # Update relative links to use full domain
        # href="index.html" → href="https://vetstay.click/index.html"
        # But keep # anchors as-is
        
        perl -i.bak -pe '
            # Skip lines that already have http:// or https://
            next if /href="https?:\/\//;
            
            # Skip anchor links (#)
            next if /href="#/;
            
            # Update relative .html links
            s/href="([^"#]*\.html)"/href="https:\/\/vetstay.click\/$1"/g;
            
            # Fix double slashes if any
            s/vetstay\.click\/\//vetstay.click\//g;
        ' "$file"
        
        # Also update any example.com or placeholder domains
        perl -i -pe 's/www\.example\.com/vetstay.click/g' "$file"
        perl -i -pe 's/example\.com/vetstay.click/g' "$file"
        
        # Update any www.vettedstay references
        perl -i -pe 's/www\.vettedstay\.com/vetstay.click/g' "$file"
        
    fi
done

# Clean up .bak files
rm -f *.bak

echo ""
echo "✅ Domain updates complete!"
echo ""

echo "Step 3: Updating PHP files..."
echo "──────────────────────────────────────────────────────"

if [ -f "payment-notify.php" ]; then
    perl -i.bak -pe 's/www\.vettedstay\.com/vetstay.click/g' payment-notify.php
    perl -i -pe 's/example\.com/vetstay.click/g' payment-notify.php
    rm -f payment-notify.php.bak
    echo "✅ Updated payment-notify.php"
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo "  Cleanup Complete!"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Summary:"
echo "  • Redundant files moved to: $BACKUP_DIR/"
echo "  • All links updated to: vetstay.click"
echo "  • Main working files ready for deployment"
echo ""

