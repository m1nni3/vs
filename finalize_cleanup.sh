#!/bin/bash

echo "Finalizing project structure..."
echo ""

BACKUP="backup_20260108_032702_redundant"

# Move additional redundant/test files to backup
echo "Moving additional redundant files..."

# These appear to be duplicates or test versions
redundant_files=(
    "checkout-ecommerce.html"
    "checkout-preview.html"
    "checkout-pro.html"
    "contact_page.html"
    "generate-images.html"
    "index-ecommerce.html"
    "index-pro.html"
    "privacy_policy.html"
)

for file in "${redundant_files[@]}"; do
    if [ -f "$file" ]; then
        mv "$file" "$BACKUP/"
        echo "  ✅ Moved $file"
    fi
done

echo ""
echo "Keeping only essential production files:"
echo "──────────────────────────────────────────"
ls -1 *.html 2>/dev/null | while read file; do
    echo "  ✓ $file"
done

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "Essential files ready for production:"
echo "  • index.html (homepage)"
echo "  • bundles.html (pricing)"
echo "  • services.html (services)"
echo "  • contact.html (contact)"
echo "  • privacy.html (privacy policy)"
echo "  • checkout-payfast.html (payment checkout)"
echo "  • payment-success.html (success page)"
echo "  • payment-cancelled.html (cancel page)"
echo "  • payfast-test.html (testing dashboard)"
echo ""

