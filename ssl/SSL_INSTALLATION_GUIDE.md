# SSL Certificate Installation Guide for vetstay.click

## Certificate Information

**Domain:** vetstay.click (including www.vetstay.click)
**Issuer:** ZeroSSL RSA Domain Secure Site CA
**Valid From:** January 8, 2026
**Valid Until:** April 8, 2026 (3 months)
**Certificate Type:** Domain Validation (DV)

⚠️ **IMPORTANT:** This certificate expires on April 8, 2026. Set a reminder to renew before this date!

## Files Created

All SSL files are located in the `ssl/` directory:

1. **certificate.crt** - Your domain certificate
2. **ca_bundle.crt** - Certificate Authority bundle (intermediate certificate)
3. **private.key** - Private key (KEEP THIS SECURE!)

## Security Warning

🔒 **CRITICAL:** The `private.key` file must be kept absolutely secure:
- Never share it publicly
- Never commit it to version control
- Set strict file permissions (400 or 600)
- Only the web server should have access

## Installation Instructions

### Option 1: cPanel Installation (Recommended for Beginners)

1. **Login to cPanel**
   - Go to your hosting control panel
   - Navigate to "Security" section

2. **SSL/TLS Manager**
   - Click on "SSL/TLS"
   - Select "Manage SSL sites"

3. **Install Certificate**
   - Domain: vetstay.click
   - Certificate (CRT): Paste contents of `ssl/certificate.crt`
   - Private Key (KEY): Paste contents of `ssl/private.key`
   - Certificate Authority Bundle (CABUNDLE): Paste contents of `ssl/ca_bundle.crt`
   - Click "Install Certificate"

4. **Verify Installation**
   - Visit https://vetstay.click
   - Check for padlock icon in browser
   - Click padlock → Certificate should show valid

### Option 2: Apache Server Installation

1. **Upload Certificate Files**
   ```bash
   # SSH into your server
   ssh user@your-server.com
   
   # Create SSL directory (if not exists)
   sudo mkdir -p /etc/ssl/vetstay
   
   # Upload files (from your local machine)
   scp ssl/certificate.crt user@server:/etc/ssl/vetstay/
   scp ssl/ca_bundle.crt user@server:/etc/ssl/vetstay/
   scp ssl/private.key user@server:/etc/ssl/vetstay/
   ```

2. **Set Secure Permissions**
   ```bash
   sudo chmod 600 /etc/ssl/vetstay/private.key
   sudo chmod 644 /etc/ssl/vetstay/certificate.crt
   sudo chmod 644 /etc/ssl/vetstay/ca_bundle.crt
   sudo chown root:root /etc/ssl/vetstay/*
   ```

3. **Configure Apache**
   
   Edit your Apache SSL configuration (usually `/etc/apache2/sites-available/vetstay-ssl.conf`):
   
   ```apache
   <VirtualHost *:443>
       ServerName vetstay.click
       ServerAlias www.vetstay.click
       
       DocumentRoot /var/www/vetstay
       
       SSLEngine on
       SSLCertificateFile /etc/ssl/vetstay/certificate.crt
       SSLCertificateKeyFile /etc/ssl/vetstay/private.key
       SSLCertificateChainFile /etc/ssl/vetstay/ca_bundle.crt
       
       # Modern SSL Configuration
       SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
       SSLCipherSuite ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384
       SSLHonorCipherOrder off
       SSLSessionTickets off
       
       # HSTS (Optional but recommended)
       Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
       
       <Directory /var/www/vetstay>
           Options -Indexes +FollowSymLinks
           AllowOverride All
           Require all granted
       </Directory>
   </VirtualHost>
   
   # HTTP to HTTPS Redirect
   <VirtualHost *:80>
       ServerName vetstay.click
       ServerAlias www.vetstay.click
       
       Redirect permanent / https://vetstay.click/
   </VirtualHost>
   ```

4. **Enable SSL Module and Site**
   ```bash
   sudo a2enmod ssl
   sudo a2enmod headers
   sudo a2ensite vetstay-ssl.conf
   sudo systemctl restart apache2
   ```

5. **Test Configuration**
   ```bash
   sudo apache2ctl configtest
   sudo systemctl status apache2
   ```

### Option 3: Nginx Server Installation

1. **Upload Certificate Files**
   ```bash
   # Create SSL directory
   sudo mkdir -p /etc/nginx/ssl/vetstay
   
   # Upload files
   scp ssl/certificate.crt user@server:/etc/nginx/ssl/vetstay/
   scp ssl/ca_bundle.crt user@server:/etc/nginx/ssl/vetstay/
   scp ssl/private.key user@server:/etc/nginx/ssl/vetstay/
   ```

2. **Create Combined Certificate**
   ```bash
   # Nginx requires certificate + CA bundle in one file
   sudo cat /etc/nginx/ssl/vetstay/certificate.crt /etc/nginx/ssl/vetstay/ca_bundle.crt > /etc/nginx/ssl/vetstay/fullchain.crt
   ```

3. **Set Permissions**
   ```bash
   sudo chmod 600 /etc/nginx/ssl/vetstay/private.key
   sudo chmod 644 /etc/nginx/ssl/vetstay/*.crt
   sudo chown root:root /etc/nginx/ssl/vetstay/*
   ```

4. **Configure Nginx**
   
   Edit `/etc/nginx/sites-available/vetstay`:
   
   ```nginx
   # HTTPS Server
   server {
       listen 443 ssl http2;
       listen [::]:443 ssl http2;
       
       server_name vetstay.click www.vetstay.click;
       root /var/www/vetstay;
       index index.html;
       
       # SSL Configuration
       ssl_certificate /etc/nginx/ssl/vetstay/fullchain.crt;
       ssl_certificate_key /etc/nginx/ssl/vetstay/private.key;
       
       # Modern SSL Configuration
       ssl_protocols TLSv1.2 TLSv1.3;
       ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384';
       ssl_prefer_server_ciphers off;
       
       # HSTS
       add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
       
       # Security Headers
       add_header X-Frame-Options "SAMEORIGIN" always;
       add_header X-Content-Type-Options "nosniff" always;
       add_header X-XSS-Protection "1; mode=block" always;
       
       location / {
           try_files $uri $uri/ =404;
       }
       
       # PHP Processing (if needed)
       location ~ \.php$ {
           fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
           fastcgi_index index.php;
           include fastcgi_params;
           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
       }
   }
   
   # HTTP to HTTPS Redirect
   server {
       listen 80;
       listen [::]:80;
       
       server_name vetstay.click www.vetstay.click;
       
       return 301 https://vetstay.click$request_uri;
   }
   ```

5. **Enable and Restart**
   ```bash
   sudo ln -s /etc/nginx/sites-available/vetstay /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

### Option 4: Cloudflare (CDN/Proxy)

If using Cloudflare:

1. **Full (Strict) SSL Mode**
   - Login to Cloudflare
   - Go to SSL/TLS settings
   - Select "Full (strict)"

2. **Origin Certificate**
   - Use the provided certificates on your origin server
   - Configure Apache/Nginx as above
   - Cloudflare will handle visitor connections

3. **Always Use HTTPS**
   - Enable in Cloudflare SSL/TLS settings
   - Automatic HTTPS Rewrites: ON

## Verification Steps

### 1. Browser Check
- Visit https://vetstay.click
- Click padlock icon
- Verify certificate details:
  - Domain: vetstay.click
  - Valid until: April 8, 2026
  - Issuer: ZeroSSL

### 2. SSL Labs Test
- Go to: https://www.ssllabs.com/ssltest/
- Enter: vetstay.click
- Should get A or A+ rating

### 3. Command Line Test
```bash
# Check certificate
openssl s_client -connect vetstay.click:443 -servername vetstay.click

# Verify certificate chain
curl -vI https://vetstay.click
```

### 4. Check HTTP → HTTPS Redirect
```bash
curl -I http://vetstay.click
# Should show 301/302 redirect to https://
```

## Common Issues & Troubleshooting

### Issue: "Your connection is not private" Error

**Causes:**
- Certificate not installed correctly
- Missing CA bundle
- Wrong domain name in certificate

**Solutions:**
1. Verify certificate matches domain
2. Ensure CA bundle is included
3. Clear browser cache
4. Check server configuration

### Issue: Mixed Content Warnings

**Cause:** Page loading HTTP resources on HTTPS page

**Solution:**
- Update all links to use HTTPS or relative URLs
- Check for hardcoded HTTP links in HTML/CSS/JS
- Use browser console to identify mixed content

### Issue: Certificate Chain Error

**Cause:** Missing intermediate certificate (CA bundle)

**Solution:**
- Ensure ca_bundle.crt is properly configured
- For Nginx: verify fullchain.crt includes both certificates

### Issue: Private Key Mismatch

**Cause:** Certificate and private key don't match

**Solution:**
- Verify you're using the correct files
- Check file contents aren't corrupted
- Re-upload if necessary

## PayFast HTTPS Requirement

⚠️ **CRITICAL:** PayFast requires HTTPS for production payments.

After SSL installation:

1. **Update PayFast URLs in checkout-payfast.html:**
   - Line 227: return_url should use https://
   - Line 228: cancel_url should use https://
   - Line 229: notify_url should use https://

2. **Test Payment Flow:**
   - Complete test transaction
   - Verify redirect to HTTPS success page
   - Check ITN notifications reach your server

## Security Best Practices

1. **File Permissions**
   ```bash
   private.key: 600 (read/write owner only)
   certificate.crt: 644 (readable by all)
   ca_bundle.crt: 644 (readable by all)
   ```

2. **Firewall Configuration**
   ```bash
   # Allow HTTPS
   sudo ufw allow 443/tcp
   
   # Close unnecessary ports
   sudo ufw status
   ```

3. **Automatic Renewal**
   - Set calendar reminder for April 1, 2026
   - ZeroSSL certificates must be manually renewed
   - Consider Let's Encrypt for automatic renewal

4. **Security Headers**
   Already included in configurations above:
   - HSTS (HTTP Strict Transport Security)
   - X-Frame-Options
   - X-Content-Type-Options
   - X-XSS-Protection

5. **Regular Testing**
   - Monthly: Check certificate expiration
   - Quarterly: Run SSL Labs test
   - After changes: Verify HTTPS works

## Certificate Renewal (Before April 8, 2026)

### Option 1: ZeroSSL Portal
1. Login to ZeroSSL account
2. Find vetstay.click certificate
3. Click "Renew"
4. Follow validation steps
5. Download new certificate
6. Replace old files
7. Restart web server

### Option 2: Let's Encrypt (Free, Auto-Renew)
```bash
# Install Certbot
sudo apt install certbot python3-certbot-apache

# Get certificate (Apache)
sudo certbot --apache -d vetstay.click -d www.vetstay.click

# Or for Nginx
sudo certbot --nginx -d vetstay.click -d www.vetstay.click

# Auto-renewal is configured automatically
sudo certbot renew --dry-run
```

## File Checklist

Before installation, verify you have:
- [ ] certificate.crt (domain certificate)
- [ ] ca_bundle.crt (CA intermediate certificate)
- [ ] private.key (private key - keep secure!)
- [ ] Backup of current server configuration
- [ ] Access to server (SSH, cPanel, etc.)

## Support Resources

**ZeroSSL Support:**
- Website: https://zerossl.com
- Support: support@zerossl.com

**SSL Testing Tools:**
- SSL Labs: https://www.ssllabs.com/ssltest/
- Why No Padlock: https://www.whynopadlock.com/

**Web Server Documentation:**
- Apache: https://httpd.apache.org/docs/2.4/ssl/
- Nginx: https://nginx.org/en/docs/http/configuring_https_servers.html

## Next Steps

After SSL installation:

1. [ ] Test https://vetstay.click works
2. [ ] Verify HTTP redirects to HTTPS
3. [ ] Check for mixed content warnings
4. [ ] Run SSL Labs test (aim for A+)
5. [ ] Update PayFast URLs to HTTPS
6. [ ] Test complete payment flow
7. [ ] Update any hardcoded HTTP URLs in code
8. [ ] Set certificate renewal reminder
9. [ ] Document installation in your records
10. [ ] Celebrate! 🎉

---

**Certificate Installed:** [Pending]
**Last Updated:** January 8, 2026
**Valid Until:** April 8, 2026 (90 days)
**Next Action:** Install on web server