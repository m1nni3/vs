# 🖼️ Image Placeholder Generator

## Quick Start

1. **Open the generator**: Double-click `generate-images.html` in your browser
2. **Download all images**: Click the "Download All Images" button
3. **Save to Images folder**: Move downloaded files to `/Images` folder
4. **Update HTML**: Replace placeholder URLs with local image paths

---

## What This Tool Does

This HTML-based tool generates **14 placeholder images** for your VettedStay website:

- ✅ **1 Hero image** (600x400px) - Dashboard screenshot
- ✅ **4 Trust badges** (48x48px) - Icon badges  
- ✅ **9 Service cards** (400x180px) - Service images

All images are:
- Color-matched to your website's design
- Properly sized for their use case
- PNG format with transparent backgrounds
- Ready to use immediately

---

## Generated Files

### Hero Image
```
hero-dashboard.png (600x400px)
```

### Trust Badges
```
icon-verified.png (48x48px)
icon-secure.png (48x48px)
icon-fast.png (48x48px)
icon-landlords.png (48x48px)
```

### Service Cards
```
service-identity.png (400x180px)
service-home-affairs.png (400x180px)
service-credit.png (400x180px)
service-detailed-report.png (400x180px)
service-rental.png (400x180px)
service-employment.png (400x180px)
service-income.png (400x180px)
service-criminal.png (400x180px)
service-fraud.png (400x180px)
```

---

## After Generating Images

### Step 1: Organize Files
```bash
# Move all downloaded images to Images folder
mv ~/Downloads/hero-dashboard.png Images/
mv ~/Downloads/icon-*.png Images/
mv ~/Downloads/service-*.png Images/
```

### Step 2: Update HTML Files

Replace placeholder URLs with local paths:

**Before:**
```html
<img src="https://via.placeholder.com/600x400/667eea/ffffff?text=Tenant+Screening+Dashboard" alt="Tenant screening dashboard" />
```

**After:**
```html
<img src="Images/hero-dashboard.png" alt="Tenant screening dashboard" />
```

### Step 3: Bulk Replace (Recommended)

Use find & replace in your text editor:

#### Hero Image
```
FIND: https://via.placeholder.com/600x400/667eea/ffffff?text=Tenant+Screening+Dashboard
REPLACE: Images/hero-dashboard.png
```

#### Trust Badges
```
FIND: https://via.placeholder.com/48x48/7cb342/ffffff?text=✓
REPLACE: Images/icon-verified.png

FIND: https://via.placeholder.com/48x48/2e7d99/ffffff?text=🔒
REPLACE: Images/icon-secure.png

FIND: https://via.placeholder.com/48x48/667eea/ffffff?text=⚡
REPLACE: Images/icon-fast.png

FIND: https://via.placeholder.com/48x48/7cb342/ffffff?text=👥
REPLACE: Images/icon-landlords.png
```

#### Service Images (do this for both index.html and services.html)
```
FIND: https://via.placeholder.com/400x180/667eea/ffffff?text=Identity+Verification
REPLACE: Images/service-identity.png

FIND: https://via.placeholder.com/400x180/764ba2/ffffff?text=Home+Affairs+Check
REPLACE: Images/service-home-affairs.png

FIND: https://via.placeholder.com/400x180/f093fb/ffffff?text=Credit+Profile
REPLACE: Images/service-credit.png

FIND: https://via.placeholder.com/400x180/4facfe/ffffff?text=Detailed+Report
REPLACE: Images/service-detailed-report.png

FIND: https://via.placeholder.com/400x180/00f2fe/ffffff?text=Rental+History
REPLACE: Images/service-rental.png

FIND: https://via.placeholder.com/400x180/43e97b/ffffff?text=Employment+Check
REPLACE: Images/service-employment.png

FIND: https://via.placeholder.com/400x180/38f9d7/ffffff?text=Income+Assessment
REPLACE: Images/service-income.png

FIND: https://via.placeholder.com/400x180/fa709a/ffffff?text=Criminal+Check
REPLACE: Images/service-criminal.png

FIND: https://via.placeholder.com/400x180/fee140/333333?text=Fraud+Screening
REPLACE: Images/service-fraud.png
```

---

## Troubleshooting

### Images won't download
- **Solution**: Try downloading individually instead of "Download All"
- **Reason**: Some browsers block multiple downloads

### Images are low quality
- **Solution**: The generated images are basic placeholders. Replace with professional images when ready.

### Wrong file paths
- **Solution**: Make sure Images/ folder exists and images are inside it
- **Check**: File structure should be:
  ```
  vettedStay-main/
  ├── index.html
  ├── services.html
  └── Images/
      ├── hero-dashboard.png
      ├── icon-verified.png
      └── service-identity.png
      └── ... (all other images)
  ```

---

## Next Steps

1. ✅ Generate placeholder images
2. ✅ Save to Images/ folder
3. ✅ Update HTML files
4. ⏳ Replace with professional images later (optional)
5. ⏳ Test website locally
6. ⏳ Deploy to production

---

## Optional: Replace with Professional Images

These generated placeholders are functional but basic. For a production website, consider:

- **Stock Photos**: Unsplash, Pexels (free)
- **Custom Graphics**: Hire a designer on Fiverr
- **AI Generated**: Midjourney, DALL-E
- **Icon Sets**: Flaticon, Font Awesome

Keep the same filenames when replacing to avoid updating HTML again!

---

**Tool Location**: `/generate-images.html`  
**Generated**: 14 placeholder images  
**Status**: Ready to use immediately
