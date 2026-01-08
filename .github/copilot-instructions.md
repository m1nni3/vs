# VettedStay - AI Coding Agent Instructions

## Project Overview
VettedStay is a static HTML/CSS/JavaScript website for professional tenant screening services in South Africa. The site includes e-commerce functionality with PayFast payment integration and serverless order processing.

## Architecture
- **Frontend**: Pure HTML/CSS/JS (no frameworks) with inline styles
- **Backend**: Serverless Node.js functions (`api/orders.js`) for order processing
- **Payments**: PayFast (South African gateway) with PHP notification handler
- **Deployment**: Multi-platform support (Vercel, Firebase, GitHub Pages)
- **Database**: Configurable (Firebase Firestore, Supabase, or MongoDB Atlas)

## Key Files & Structure
- `index.html` - Homepage with hero, services overview, FAQ
- `services.html` - Individual screening services with pricing
- `bundles.html` - Package deals with comparison table
- `contact.html` - Contact form and business information
- `checkout-payfast.html` - PayFast-integrated checkout flow
- `payment-success.html` / `payment-cancelled.html` - Payment result pages
- `api/orders.js` - Serverless order processing functions
- `payment-notify.php` - PayFast ITN (Instant Transaction Notification) handler
- `Images/` - Image assets folder (replace placeholder URLs here)
- `docs/` - Comprehensive documentation and guides
- `backup_*/` - Previous versions (basic, pro, ecommerce variants)

## Development Workflow
### Local Testing
```bash
# Simply open HTML files in browser
open index.html
# No build process required
```

### Image Management
```bash
# Generate placeholder images
open generate-images.html  # Click "Download All Images"

# Replace placeholders in HTML
# From: <img src="https://via.placeholder.com/...">
# To:   <img src="Images/your-image.jpg">
```

### Deployment
```bash
# Quick deploy (supports Vercel/Firebase)
chmod +x deploy.sh
./deploy.sh

# Manual options:
# Vercel: vercel --prod
# Firebase: firebase deploy
# GitHub Pages: Push to repo, enable Pages
```

## Code Patterns & Conventions
### Styling
- **Inline styles only** - All CSS within `<style>` tags in HTML files
- No external CSS files or preprocessors
- Consistent color scheme: `#1a365d` (navy), `#00d4aa` (teal), `#f8fafc` (light gray)

### HTML Structure
```html
<!-- Navigation pattern -->
<nav class="navbar">
  <div class="nav-container">
    <a href="index.html" class="nav-logo">VettedStay</a>
    <ul class="nav-menu">
      <li><a href="services.html">Services</a></li>
      <!-- etc -->
    </ul>
  </div>
</nav>

<!-- Hero section pattern -->
<section class="hero">
  <div class="hero-container">
    <h1>Tenant Screening from R99</h1>
    <p>Professional background checks...</p>
    <a href="#services" class="btn-primary">Get Started</a>
  </div>
</section>
```

### JavaScript Integration
- Cart functionality in `index-ecommerce.html` variants
- Form validation with micro-interactions
- Modal dialogs for cart review
- Real-time total calculations

### Payment Integration
- PayFast sandbox/production modes in `payment-notify.php`
- Order IDs: `VS{timestamp}{random}` format
- Email confirmations via SendGrid/Mailgun
- Database persistence (Firebase/Supabase examples in `api/orders.js`)
- ITN handler validates signature, IP, data, and server confirmation
- Sandbox credentials: Merchant ID 10000100, Key 46f0cd694581a, Passphrase jt7NOE43FZPn

## Maintenance Scripts
Located in root directory:
- `fix_links.sh` - Correct internal navigation links
- `embed_images.sh` - Convert external images to base64
- `make_self_contained.sh` - Prepare for standalone deployment
- `cleanup_and_update.sh` - Remove redundant files

## Deployment Configurations
- `vercel.json` - Serverless function routing, redirects to e-commerce version
- `config/firebase.json` - Firebase hosting setup

## Common Tasks
### Adding New Service
1. Update `services.html` with new service card
2. Add pricing to `api/orders.js` calculateTotal() function
3. Update `bundles.html` comparison table if applicable

### Updating Contact Info
Edit `contact.html`:
- Email addresses in mailto: links
- Phone numbers in tel: links
- Physical address in address element
- Business hours in schedule markup

### Testing Payments
1. Set `SANDBOX_MODE = true` in `payment-notify.php`
2. Use PayFast sandbox credentials
3. Check `payfast-notifications.log` for debugging
4. Test with `checkout-payfast.html` locally

## File Versioning
- `backup_*/` folders contain previous versions
- Current active files are in root
- E-commerce variants: `*-ecommerce.html`
- Professional variants: `*-pro.html`
- Ultra-enhanced variants: `*-ultra*.html`

## Security Considerations
- PayFast passphrase stored securely
- ITN validation in `payment-notify.php`
- HTTPS required for payment processing
- Security headers configured in deployment configs</content>
<parameter name="filePath">/workspaces/vs/.github/copilot-instructions.md