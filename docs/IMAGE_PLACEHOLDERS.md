# 🖼️ Image Placeholder Reference - VettedStay

## Complete List of All Image Placeholders

This document lists **ALL 23 image placeholders** used across the VettedStay website, organized by page and purpose.

---

## 📊 Summary

| Page | Image Count | Purpose |
|------|-------------|---------|
| index.html | 14 | Hero + Trust badges + Service cards |
| services.html | 9 | Service cards |
| bundles.html | 0 | No images |
| contact_page.html | 0 | No images |
| **TOTAL** | **23** | All placeholders |

---

## 🏠 index.html (14 images)

### Hero Section (1 image)

```html
<!-- Line 83 - Main hero image -->
<img src="https://via.placeholder.com/600x400/667eea/ffffff?text=Tenant+Screening+Dashboard" 
     alt="Tenant screening dashboard" />
```
**Purpose**: Hero dashboard/screenshot  
**Size**: 600x400px  
**Color**: Purple-Blue (#667eea)  
**Replace with**: Actual dashboard screenshot or tenant screening interface

---

### Trust Strip (4 images)

```html
<!-- Line 90 - Official Data Sources badge -->
<img src="https://via.placeholder.com/48x48/7cb342/ffffff?text=✓" 
     alt="Verified" />

<!-- Line 94 - POPIA Compliant badge -->
<img src="https://via.placeholder.com/48x48/2e7d99/ffffff?text=🔒" 
     alt="Secure" />

<!-- Line 98 - Fast Turnaround badge -->
<img src="https://via.placeholder.com/48x48/667eea/ffffff?text=⚡" 
     alt="Fast" />

<!-- Line 102 - Trusted by Landlords badge -->
<img src="https://via.placeholder.com/48x48/7cb342/ffffff?text=👥" 
     alt="Landlords" />
```
**Purpose**: Trust indicator icons  
**Size**: 48x48px  
**Colors**: Green (#7cb342), Teal (#2e7d99), Purple (#667eea)  
**Replace with**: Icon/logo badges for data verification, compliance, speed, users

---

### Service Cards (9 images)

```html
<!-- Line 116 - Identity Verification -->
<img src="https://via.placeholder.com/400x180/667eea/ffffff?text=Identity+Verification" 
     alt="Identity verification" />

<!-- Line 125 - Home Affairs -->
<img src="https://via.placeholder.com/400x180/764ba2/ffffff?text=Home+Affairs+Check" 
     alt="Home Affairs verification" />

<!-- Line 134 - Credit Profile -->
<img src="https://via.placeholder.com/400x180/f093fb/ffffff?text=Credit+Profile" 
     alt="Credit profile" />

<!-- Line 143 - Detailed Report -->
<img src="https://via.placeholder.com/400x180/4facfe/ffffff?text=Detailed+Report" 
     alt="Detailed credit report" />

<!-- Line 152 - Rental History -->
<img src="https://via.placeholder.com/400x180/00f2fe/ffffff?text=Rental+History" 
     alt="Rental history" />

<!-- Line 161 - Employment -->
<img src="https://via.placeholder.com/400x180/43e97b/ffffff?text=Employment+Check" 
     alt="Employment verification" />

<!-- Line 170 - Income Assessment -->
<img src="https://via.placeholder.com/400x180/38f9d7/ffffff?text=Income+Assessment" 
     alt="Income verification" />

<!-- Line 179 - Criminal Check -->
<img src="https://via.placeholder.com/400x180/fa709a/ffffff?text=Criminal+Check" 
     alt="Criminal record check" />

<!-- Line 188 - Fraud Screening -->
<img src="https://via.placeholder.com/400x180/fee140/333333?text=Fraud+Screening" 
     alt="Fraud screening" />
```
**Purpose**: Service card header images  
**Size**: 400x180px  
**Colors**: Each service has unique gradient color (see color guide below)  
**Replace with**: Service-specific graphics/illustrations

---

## 🔧 services.html (9 images)

### Service Cards (9 images - identical to index.html)

```html
<!-- Line 90 - Identity Verification -->
<img src="https://via.placeholder.com/400x180/667eea/ffffff?text=Identity+Verification" 
     alt="Identity verification" />

<!-- Line 101 - Home Affairs -->
<img src="https://via.placeholder.com/400x180/764ba2/ffffff?text=Home+Affairs+Check" 
     alt="Home Affairs verification" />

<!-- Line 112 - Credit Profile -->
<img src="https://via.placeholder.com/400x180/f093fb/ffffff?text=Credit+Profile" 
     alt="Credit profile" />

<!-- Line 123 - Detailed Report -->
<img src="https://via.placeholder.com/400x180/4facfe/ffffff?text=Detailed+Report" 
     alt="Detailed credit report" />

<!-- Line 134 - Rental History -->
<img src="https://via.placeholder.com/400x180/00f2fe/ffffff?text=Rental+History" 
     alt="Rental history" />

<!-- Line 145 - Employment -->
<img src="https://via.placeholder.com/400x180/43e97b/ffffff?text=Employment+Check" 
     alt="Employment verification" />

<!-- Line 156 - Income Assessment -->
<img src="https://via.placeholder.com/400x180/38f9d7/ffffff?text=Income+Assessment" 
     alt="Income verification" />

<!-- Line 167 - Criminal Check -->
<img src="https://via.placeholder.com/400x180/fa709a/ffffff?text=Criminal+Check" 
     alt="Criminal record check" />

<!-- Line 178 - Fraud Screening -->
<img src="https://via.placeholder.com/400x180/fee140/333333?text=Fraud+Screening" 
     alt="Fraud screening" />
```
**Purpose**: Service card header images  
**Size**: 400x180px  
**Replace with**: Same images as index.html service cards

---

## 🎨 Color-Coded Service Categories

Each service has a unique color for easy identification:

| Service | Color Code | RGB | Usage |
|---------|-----------|-----|--------|
| **Identity Verification** | `#667eea` | Purple-Blue | Identity/verification services |
| **Home Affairs DHA** | `#764ba2` | Purple | Government verification |
| **Credit Profile** | `#f093fb` | Pink | Basic credit checks |
| **Detailed Report** | `#4facfe` | Blue | Comprehensive credit |
| **Rental History** | `#00f2fe` | Cyan | Rental tracking |
| **Employment** | `#43e97b` | Green | Job verification |
| **Income Assessment** | `#38f9d7` | Teal | Financial capacity |
| **Criminal Check** | `#fa709a` | Rose | Background screening |
| **Fraud Screening** | `#fee140` | Yellow | Risk detection |

---

## 🔄 Replacement Syntax

### Option 1: Local Images (Recommended)

```html
<!-- OLD (Placeholder) -->
<img src="https://via.placeholder.com/400x180/667eea/ffffff?text=Identity+Verification" 
     alt="Identity verification" />

<!-- NEW (Local Image) -->
<img src="Images/identity-verification.jpg" 
     alt="Identity verification" />
```

### Option 2: External URLs

```html
<!-- NEW (External URL) -->
<img src="https://yourdomain.com/images/identity-verification.jpg" 
     alt="Identity verification" />
```

### Option 3: Keep Placeholders (Testing)

Leave as-is for development/testing. Placeholders display immediately without real images.

---

## 📋 Replacement Checklist

### Hero Section
- [ ] Hero dashboard image (600x400px)

### Trust Badges (48x48px)
- [ ] Official Data Sources icon
- [ ] POPIA Compliant icon
- [ ] Fast Turnaround icon
- [ ] Trusted by Landlords icon

### Service Images (400x180px) - Need 9 unique images
- [ ] Identity Verification
- [ ] Home Affairs DHA
- [ ] Credit Profile
- [ ] Detailed Credit Report
- [ ] Rental Payment Profile
- [ ] Employment Verification
- [ ] Income & Affordability
- [ ] Criminal Record Check
- [ ] Fraud & Risk Screening

---

## 🔍 Finding Images in Files

### Using grep (Terminal)
```bash
cd /Users/m1nni3/Downloads/vettedStay-main
grep -n "via.placeholder.com" *.html
```

### Using Find & Replace (Text Editor)
**Find**: `https://via.placeholder.com/`  
**Replace with**: `Images/`

---

## 💡 Image Recommendations

### Hero Image (600x400px)
- Dashboard screenshot showing tenant data
- Professional screening interface
- Modern, clean UI design

### Trust Badges (48x48px)
- Simple icons with single color
- Transparent background (PNG)
- High contrast for visibility

### Service Cards (400x180px)
**Style Options:**
1. **Illustrated Icons** - Custom service illustrations
2. **Photos** - Professional stock photos
3. **Graphics** - Abstract gradients/patterns matching color scheme
4. **Screenshots** - Service-specific UI screenshots

**Recommended Specs:**
- Format: JPG or PNG
- Resolution: 800x360px (2x for retina)
- Optimization: Compress for web (<100KB each)
- Aspect Ratio: 2.22:1 (400:180)

---

## 🚀 Bulk Replacement Script

### Using find & sed (macOS/Linux)
```bash
cd /Users/m1nni3/Downloads/vettedStay-main

# Replace all placeholders with local images
sed -i '' 's|https://via.placeholder.com/600x400/667eea/ffffff?text=Tenant+Screening+Dashboard|Images/hero-dashboard.jpg|g' index.html

sed -i '' 's|https://via.placeholder.com/48x48/7cb342/ffffff?text=✓|Images/icon-verified.png|g' index.html

# Continue for each image...
```

### Using VS Code (Recommended)
1. Open project in VS Code
2. Press `Cmd+Shift+F` (Find in Files)
3. Search: `https://via.placeholder.com`
4. Replace with: `Images/`
5. Manually adjust each filename

---

## 📝 Notes

- **Total Placeholders**: 23 images across 2 HTML files
- **No Images**: bundles.html and contact_page.html have no images
- **Duplicate Images**: Services appear on both index.html and services.html (use same images)
- **Color Consistency**: Placeholder colors match site color scheme
- **Alt Text**: All images have proper alt attributes for accessibility

---

## ✅ Quick Summary

```
TOTAL IMAGES NEEDED:
├── 1x Hero image (600x400px)
├── 4x Trust badge icons (48x48px)
└── 9x Service card images (400x180px)
    └── Used on both index.html and services.html (same images)

TOTAL UNIQUE IMAGES: 14
TOTAL PLACEHOLDER INSTANCES: 23
```

---

**Status**: All 23 placeholders identified and documented  
**Ready for**: Image replacement when assets are available  
**Current State**: Website functional with placeholders
