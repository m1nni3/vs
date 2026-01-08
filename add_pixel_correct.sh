#!/bin/bash

# Create the Meta Pixel as a temporary file
cat > /tmp/meta_pixel.txt << 'PIXELEOF'
<!-- Meta Pixel Code -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '1494593548316291');
fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=1494593548316291&ev=PageView&noscript=1"
/></noscript>
<!-- End Meta Pixel Code -->
PIXELEOF

echo "Adding Meta Pixel to HTML files..."
echo ""

count=0

# Find all HTML files (excluding backup)
find . -name "*.html" -not -path "./backup_*/*" -type f | while read file; do
    # Check if Meta Pixel already exists
    if grep -q "1494593548316291" "$file"; then
        echo "⏭️  Skipped (already exists): $file"
    else
        # Use sed to insert before </head>
        if grep -q "</head>" "$file"; then
            # Create backup
            cp "$file" "${file}.bak"
            
            # Insert Meta Pixel before </head>
            sed -i '' '/<\/head>/e cat /tmp/meta_pixel.txt' "$file"
            
            echo "✅ Added to: $file"
            ((count++))
        else
            echo "⚠️  No </head> tag found: $file"
        fi
    fi
done

# Clean up
rm -f /tmp/meta_pixel.txt

echo ""
echo "✅ Meta Pixel installation complete!"

