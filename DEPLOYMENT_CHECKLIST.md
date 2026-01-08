# VettedStay - Deployment Master Checklist

## Project Status: ✅ COMPLETE - Ready for Production

All development phases complete. This checklist will guide you through deployment.

---

## Phase 1: SSL Certificate Installation ⏰ DO FIRST

### Prerequisites
- [ ] Access to web server (SSH or cPanel)
- [ ] Backup of current site
- [ ] SSL certificate files ready (in ssl/ directory)

### Installation
- [ ] Read `ssl/QUICK_START.txt` completely
- [ ] Choose installation method (cPanel/Apache/Nginx)
- [ ] Follow `ssl/SSL_INSTALLATION_GUIDE.md` instructions
- [ ] Set file permissions: `chmod 600 ssl/private.key`
- [ ] Upload certificates to server
- [ ] Configure web server
- [ ] Restart web server

### Verification
- [ ] Visit https://vetstay.click (no warnings)
- [ ] Visit https://www.vetstay.click (works)
- [ ] HTTP redirects to HTTPS
- [ ] Green padlock shows in browser
- [ ] Run SSL Labs test: https://www.ssllabs.com/ssltest/
- [ ] Target grade: A or A+
- [ ] No mixed content warnings

### Important Reminders
- [ ] Set calendar reminder for April 1, 2026 (renewal)
- [ ] Document SSL installation details
- [ ] Save certificate files securely

---

## Phase 2: Update PayFast URLs to HTTPS

### Update checkout-payfast.html
File: `checkout-payfast.html`

Change these lines (227-229) from http:// to https://:
```html
<input type="hidden" name="return_url" value="https://vetstay.click/payment-success.html">
<input type="hidden" name="cancel_url" value="https://vetstay.click/payment-cancelled.html">
<input type="hidden" name="notify_url" value="https://vetstay.click/payment-notify.php">
```

- [ ] Line 227: return_url updated to HTTPS
- [ ] Line 228: cancel_url updated to HTTPS
- [ ] Line 229: notify_url updated to HTTPS
- [ ] File saved

### Update payment-notify.php
File: `payment-notify.php`

Change line 12:
```php
define('SANDBOX_MODE', false); // Changed to false for production
```

- [ ] SANDBOX_MODE set to false
- [ ] File saved

### Check Other Files
- [ ] Search all HTML files for hardcoded http:// links
- [ ] Update any remaining HTTP links to HTTPS
- [ ] Verify internal links use relative paths where possible

---

## Phase 3: Upload Files to Production Server

### Files to Upload
Main directory:
- [ ] index.html
- [ ] bundles.html
- [ ] services.html
- [ ] contact.html
- [ ] privacy.html
- [ ] checkout.html

PayFast files:
- [ ] checkout-payfast.html (with HTTPS URLs)
- [ ] payment-success.html
- [ ] payment-cancelled.html
- [ ] payment-notify.php (production mode)

Images directory:
- [ ] Upload entire Images/ directory (if not using embedded images)

### File Permissions
- [ ] HTML files: 644
- [ ] PHP files: 644
- [ ] payment-notify.php has write access for logs
- [ ] Images directory: 755 (if separate)

---

## Phase 4: PayFast Production Configuration

### Get Live Credentials
- [ ] Register/login at https://www.payfast.co.za
- [ ] Navigate to Settings → Integration
- [ ] Copy Merchant ID
- [ ] Copy Merchant Key
- [ ] Set secure Passphrase
- [ ] Save credentials securely

### Update checkout-payfast.html
File: `checkout-payfast.html`

Lines 224-226, replace sandbox credentials with live:
```html
<input type="hidden" name="merchant_id" value="YOUR_LIVE_MERCHANT_ID">
<input type="hidden" name="merchant_key" value="YOUR_LIVE_MERCHANT_KEY">
```

Line 1, change form action:
```html
<form action="https://www.payfast.co.za/eng/process" method="post">
```

- [ ] Live Merchant ID inserted
- [ ] Live Merchant Key inserted
- [ ] Form action uses www.payfast.co.za (not sandbox)
- [ ] File saved and uploaded

### Update payment-notify.php
File: `payment-notify.php`

Line 14, update passphrase:
```php
$pfPassphrase = 'your_live_passphrase_here';
```

- [ ] Live passphrase inserted
- [ ] SANDBOX_MODE is false
- [ ] File saved and uploaded

### Implement Server-Side Signature Generation (CRITICAL!)
⚠️ The current checkout uses client-side signature generation for demo purposes.

For production security, you MUST:
- [ ] Create server endpoint (e.g., generate-payment.php)
- [ ] Move signature generation to server-side
- [ ] Use AJAX from checkout to get signed data
- [ ] Never expose passphrase in client-side code

See `PAYFAST_INTEGRATION_GUIDE.md` for implementation details.

---

## Phase 5: Database Setup (Required for Production)

### Create Database
- [ ] Create database (e.g., vetstay_orders)
- [ ] Create database user
- [ ] Grant appropriate permissions

### Create Orders Table
```sql
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id VARCHAR(50) UNIQUE,
    pf_payment_id VARCHAR(50),
    status ENUM('pending', 'paid', 'cancelled', 'processing', 'complete'),
    package VARCHAR(50),
    amount DECIMAL(10,2),
    customer_first_name VARCHAR(100),
    customer_last_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20),
    tenant_name VARCHAR(100),
    property_ref VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_payment_id (payment_id),
    INDEX idx_email (customer_email),
    INDEX idx_status (status)
);
```

- [ ] Database created
- [ ] Table created
- [ ] Test database connection

### Update payment-notify.php
Uncomment and configure database code (lines ~80-120):
- [ ] Update database credentials
- [ ] Test database inserts
- [ ] Verify error handling works

---

## Phase 6: Email Configuration

### Set Up Email System
- [ ] Configure mail server (SMTP)
- [ ] Test email sending from server
- [ ] Create email templates
- [ ] Add VettedStay branding

### Configure payment-notify.php
Update email settings:
- [ ] Set proper "From" address
- [ ] Add company branding to email templates
- [ ] Test email delivery
- [ ] Check spam folder
- [ ] Verify all email addresses work

---

## Phase 7: Meta Pixel Verification

### Test Pixel Installation
- [ ] Install Meta Pixel Helper Chrome extension
- [ ] Visit https://vetstay.click
- [ ] Verify pixel fires (green checkmark)
- [ ] Check PageView event appears

### Events Manager
- [ ] Login to Facebook Business Manager
- [ ] Go to Events Manager
- [ ] Select pixel (1494593548316291)
- [ ] Verify PageView events showing
- [ ] Test from multiple browsers

### Optional: Add Conversion Events
Consider adding to key pages:
- [ ] Purchase event (payment-success.html)
- [ ] InitiateCheckout event (checkout-payfast.html)
- [ ] Lead event (contact form)

---

## Phase 8: Final Testing (Production)

### SSL/HTTPS Testing
- [ ] https://vetstay.click loads correctly
- [ ] https://www.vetstay.click works
- [ ] All pages load over HTTPS
- [ ] No mixed content warnings
- [ ] Images display correctly
- [ ] SSL Labs test: Grade A or A+

### Navigation Testing
- [ ] Test all menu links
- [ ] Verify footer links work
- [ ] Check mobile navigation
- [ ] Test on multiple browsers (Chrome, Firefox, Safari, Edge)
- [ ] Test on mobile devices (iOS, Android)

### Payment Flow Testing (Sandbox First!)
- [ ] Open checkout page
- [ ] Select package (QuickCheck)
- [ ] Fill customer information
- [ ] Submit to PayFast sandbox
- [ ] Complete test payment
- [ ] Verify redirect to success page (HTTPS)
- [ ] Check ITN notification received
- [ ] Verify database entry created
- [ ] Check email sent

### Payment Flow Testing (Small Live Transaction)
- [ ] Repeat above with REAL payment
- [ ] Use small amount (R5-10)
- [ ] Verify entire flow works
- [ ] Check PayFast dashboard
- [ ] Confirm payment received

### Cross-Browser Testing
Test on:
- [ ] Chrome (Windows)
- [ ] Chrome (Mac)
- [ ] Firefox
- [ ] Safari (Mac)
- [ ] Safari (iOS)
- [ ] Chrome (Android)
- [ ] Edge

### Mobile Responsiveness
- [ ] Homepage looks good on mobile
- [ ] Bundles page works on mobile
- [ ] Checkout form easy to use
- [ ] All buttons clickable
- [ ] Text readable
- [ ] Images scale properly

---

## Phase 9: Security Audit

### Server Security
- [ ] Firewall configured
- [ ] Only necessary ports open (80, 443)
- [ ] PayFast IPs whitelisted (if using strict firewall)
- [ ] File permissions correct
- [ ] Private key secured (600)
- [ ] Unnecessary services disabled

### Code Security
- [ ] No hardcoded credentials in code
- [ ] Passphrase not in client-side code
- [ ] Input validation on all forms
- [ ] SQL injection prevention
- [ ] XSS protection enabled
- [ ] CSRF tokens on forms (if applicable)

### HTTPS Security
- [ ] HSTS header enabled
- [ ] TLS 1.2 minimum
- [ ] Strong cipher suites
- [ ] Certificate chain complete
- [ ] No SSL/TLS vulnerabilities

---

## Phase 10: Monitoring & Maintenance

### Set Up Monitoring
- [ ] Uptime monitoring (e.g., UptimeRobot)
- [ ] SSL certificate expiration monitoring
- [ ] PayFast transaction monitoring
- [ ] Error log monitoring
- [ ] Email delivery monitoring

### Regular Tasks
- [ ] Daily: Check orders/payments
- [ ] Weekly: Review error logs
- [ ] Monthly: SSL Labs test
- [ ] Monthly: Update software/plugins
- [ ] Quarterly: Security audit
- [ ] April 1, 2026: Renew SSL certificate

### Create Documentation
- [ ] Server access details (secure storage)
- [ ] PayFast credentials (secure storage)
- [ ] Database credentials (secure storage)
- [ ] SSL certificate info
- [ ] Deployment procedures
- [ ] Troubleshooting guide
- [ ] Contact information

---

## Phase 11: Go Live!

### Pre-Launch Final Checks
- [ ] All above checklists complete
- [ ] Backup created
- [ ] Rollback plan prepared
- [ ] Support contacts ready
- [ ] Team notified

### Launch
- [ ] Switch DNS to production server (if needed)
- [ ] Monitor for 24 hours
- [ ] Check first transactions carefully
- [ ] Respond to any issues immediately

### Post-Launch (First Week)
- [ ] Monitor transactions daily
- [ ] Check error logs daily
- [ ] Verify emails sending
- [ ] Review Meta Pixel data
- [ ] Check SSL certificate working
- [ ] Monitor site performance

---

## Emergency Contacts

**Hosting/Server Issues:**
- Your hosting provider support

**SSL Certificate:**
- ZeroSSL Support: support@zerossl.com

**PayFast Issues:**
- PayFast Support: support@payfast.co.za
- Phone: Check PayFast dashboard

**VettedStay:**
- Email: info@vetstay.click
- Phone: +27 72 215 7269

---

## Success Criteria

Your site is ready when ALL of these are true:

✅ HTTPS works perfectly (green padlock)
✅ SSL Labs grade A or A+
✅ PayFast payments process correctly
✅ ITN notifications received
✅ Emails sent on payment
✅ Database records created
✅ Meta Pixel tracking works
✅ Mobile site works perfectly
✅ All links functional
✅ No errors in logs
✅ Performance is good (fast loading)
✅ Team trained on order processing
✅ Monitoring systems active
✅ Renewal reminder set

---

## Resources

**Documentation Created:**
- ssl/QUICK_START.txt
- ssl/SSL_INSTALLATION_GUIDE.md
- PAYFAST_INTEGRATION_GUIDE.md
- META_PIXEL_SUMMARY.txt
- COMPLETE_SUMMARY.txt
- This file (DEPLOYMENT_CHECKLIST.md)

**External Resources:**
- PayFast Docs: https://developers.payfast.co.za
- SSL Labs: https://www.ssllabs.com/ssltest/
- Meta Events Manager: https://business.facebook.com/events_manager

---

**Checklist Version:** 1.0
**Last Updated:** January 8, 2026
**Status:** Ready for deployment
**Next Action:** Begin Phase 1 (SSL Installation)

---

Good luck with your deployment! 🚀
Remember: Test thoroughly in sandbox before going live with real payments.
