#!/bin/bash

echo "Checking for potentially broken links..."
echo ""

# Find all HTML files (not in backup)
find . -name "*.html" -not -path "./backup_*/*" | while read file; do
    # Extract href values
    grep -o 'href="[^"]*\.html[^"]*"' "$file" 2>/dev/null | sed 's/href="//;s/"$//' | while read link; do
        # Remove query parameters
        target=$(echo "$link" | cut -d'?' -f1)
        
        # Skip external links
        if [[ "$target" == http* ]]; then
            continue
        fi
        
        # Check if file exists
        if [[ ! -f "$target" ]]; then
            echo "❌ BROKEN: $file → $target"
        fi
    done
done

echo ""
echo "✅ Link check complete"

