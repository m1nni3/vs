# VettedStay Deployment Guide

This guide will help you deploy your VettedStay website to GitHub Pages.

## Quick Start (5 minutes)

### 1. Create a GitHub Account
If you don't have one already, sign up at [github.com](https://github.com)

### 2. Create a New Repository
1. Click the "+" icon in the top right
2. Select "New repository"
3. Name it `vettedstay` (or any name you prefer)
4. Make it **Public** (required for free GitHub Pages)
5. Click "Create repository"

### 3. Upload Your Files

**Option A: Via GitHub Website (Easiest)**
1. On your repository page, click "uploading an existing file"
2. Drag and drop ALL files from the vettedStay-main folder
3. Make sure to include:
   - All HTML files (index.html, services.html, bundles.html, contact_page.html)
   - The .github folder with workflows
   - .gitignore file
   - README.md
4. Scroll down and click "Commit changes"

**Option B: Via Git Command Line**
```bash
cd /path/to/vettedStay-main
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/vettedstay.git
git push -u origin main
```

### 4. Enable GitHub Pages
1. Go to your repository on GitHub
2. Click "Settings" (top menu)
3. Click "Pages" (left sidebar)
4. Under "Source", select "GitHub Actions"
5. The deployment will start automatically

### 5. Wait for Deployment
- Go to the "Actions" tab in your repository
- Wait for the green checkmark (usually 1-2 minutes)
- Your site will be live at: `https://YOUR-USERNAME.github.io/vettedstay/`

## Updating Your Site

To make changes:
1. Edit the HTML files
2. Upload the changed files to GitHub (same as step 3 above)
3. GitHub Actions will automatically redeploy

## Adding Your Own Images

Your site currently uses placeholder images. To add real images:

1. Create an `images` folder in your repository
2. Upload your images there
3. Replace placeholder URLs in HTML files:

```html
<!-- Replace this: -->
<img src="https://via.placeholder.com/..." />

<!-- With this: -->
<img src="images/your-image-name.jpg" />
```

## Custom Domain (Optional)

To use your own domain (e.g., www.vettedstay.co.za):

1. Buy a domain from a registrar
2. Add a CNAME record pointing to: `YOUR-USERNAME.github.io`
3. In GitHub Settings > Pages, add your custom domain
4. Wait for DNS propagation (up to 24 hours)

## Troubleshooting

### Site Not Loading
- Check the Actions tab for error messages
- Ensure repository is set to Public
- Verify GitHub Pages is enabled in Settings

### Images Not Showing
- Make sure image paths are correct
- Check that image files are uploaded to the repository
- Ensure image filenames match exactly (case-sensitive)

### Navigation Links Broken
- Verify all HTML files are in the root directory
- Check that filenames match the links in the navigation

## Support

If you encounter issues:
1. Check the GitHub Actions logs for errors
2. Verify all files uploaded successfully
3. Ensure the repository is public

## Next Steps

1. **Replace Placeholders**: Add your real images
2. **Update Content**: Customize text for your business
3. **Add Contact Info**: Update email and phone numbers
4. **Test Everything**: Click through all pages and links
5. **Share**: Send your new website URL to clients!

---

**Your site will be live at:** `https://YOUR-USERNAME.github.io/vettedstay/`

Replace `YOUR-USERNAME` with your actual GitHub username.
