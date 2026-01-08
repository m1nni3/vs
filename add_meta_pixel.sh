#!/bin/bash

# Meta Pixel code to insert
META_PIXEL='<!-- Meta Pixel Code -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='\''2.0'\'';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'\''script'\'',
'\''https://connect.facebook.net/en_US/fbevents.js'\'');
fbq('\''init'\'', '\''1494593548316291'\'');
fbq('\''track'\'', '\''PageView'\'');
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=1494593548316291&ev=PageView&noscript=1"
/></noscript>
<!-- End Meta Pixel Code -->'

echo "Adding Meta Pixel to HTML files..."
echo ""

# Find all HTML files (excluding backup)
find . -name "*.html" -not -path "./backup_*/*" -type f | while read file; do
    # Check if Meta Pixel already exists
    if grep -q "1494593548316291" "$file"; then
        echo "⏭️  Skipped (already exists): $file"
    else
        # Check if file has a </head> tag
        if grep -q "</head>" "$file"; then
            # Create temp file with Meta Pixel inserted before </head>
            awk -v pixel="$META_PIXEL" '
                /<\/head>/ {
                    print pixel
                }
                { print }
            ' "$file" > "${file}.tmp"
            
            # Replace original with modified
            mv "${file}.tmp" "$file"
            echo "✅ Added to: $file"
        else
            echo "⚠️  No </head> tag found: $file"
        fi
    fi
done

echo ""
echo "✅ Meta Pixel installation complete!"

