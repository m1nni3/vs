#!/bin/bash

echo "Fixing broken links..."

# Fix main checkout.html
sed -i '' 's/index-ultra\.html/index.html/g' checkout.html
echo "✅ Fixed checkout.html"

# Fix untitled folder files - they reference files within same folder
cd "untitled folder"

# Files reference each other without folder prefix, so they should work
# But let's verify the actual issue
echo ""
echo "Files in untitled folder that reference each other:"
ls -1 *.html 2>/dev/null | head -5

