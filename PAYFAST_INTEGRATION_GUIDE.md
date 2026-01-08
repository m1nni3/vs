# VettedStay PayFast Integration Guide

## Overview
This document explains the PayFast payment integration for VettedStay tenant screening services.

## Files Created

### 1. `checkout-payfast.html`
**Purpose:** Main checkout page with package selection and customer information form  
**Features:**
- Three package options (QuickCheck R99, SmartScreen R249, SecureLease R499)
- Customer information collection (name, email, phone)
- Optional tenant details (name, property reference)
- Real-time order summary update
- Secure form submission to PayFast

### 2. `payment-success.html`
**Purpose:** Success page shown after completed payment  
**Features:**
- Animated success confirmation
- Order details display
- Email confirmation notice
- Links to return home or contact support

### 3. `payment-cancelled.html`
**Purpose:** Page shown when user cancels payment  
**Features:**
- Clear cancellation message
- Help information
- Option to try again or return home
- Contact information

### 4. `payment-notify.php`
**Purpose:** Server-side ITN (Instant Transaction Notification) handler  
**Features:**
- Receives payment notifications from PayFast
- Performs 4 security checks (signature, IP, data, server confirmation)
- Logs all transactions
- Ready for database integration
- Email confirmation sending

## Configuration

### Sandbox Testing (Current Setup)
```
Merchant ID: 10000100
Merchant Key: 46f0cd694581a
Passphrase: jt7NOE43FZPn
URL: https://sandbox.payfast.co.za/eng/process
```

### Production Setup (When Going Live)

1. **Get Live Credentials:**
   - Login to https://www.payfast.co.za
   - Go to Settings → Integration
   - Copy your Merchant ID and Merchant Key

2. **Set Passphrase:**
   - Go to Settings → Integration
   - Set a secure "Salt Passphrase"
   - Use this in both checkout and notify scripts

3. **Update checkout-payfast.html:**
   ```html
   <!-- Line 224-226: Change these values -->
   <input type="hidden" name="merchant_id" value="YOUR_LIVE_MERCHANT_ID">
   <input type="hidden" name="merchant_key" value="YOUR_LIVE_MERCHANT_KEY">
   
   <!-- Line 1: Change form action -->
   <form action="https://www.payfast.co.za/eng/process" method="post">
   ```

4. **Update payment-notify.php:**
   ```php
   // Line 12: Change to production mode
   define('SANDBOX_MODE', false);
   
   // Line 14: Set your live passphrase
   $pfPassphrase = 'your_live_passphrase_here';
   ```

5. **Update Return URLs:**
   - Line 227-229 in checkout-payfast.html
   - Change to your actual domain:
   ```html
   <input type="hidden" name="return_url" value="https://www.vettedstay.com/payment-success.html">
   <input type="hidden" name="cancel_url" value="https://www.vettedstay.com/payment-cancelled.html">
   <input type="hidden" name="notify_url" value="https://www.vettedstay.com/payment-notify.php">
   ```

## Security Considerations

### Important: Signature Generation
**Current Implementation:** The checkout form uses client-side signature generation for demonstration purposes.

**Production Requirement:** For security, signature MUST be generated server-side.

**Recommended Implementation:**
1. Create a server endpoint (e.g., `generate-payment.php`)
2. Generate signature server-side with your passphrase
3. AJAX call from checkout to get signed payment data
4. Submit to PayFast with server-generated signature

**Example server-side signature generation:**
```php
<?php
function generateSignature($data, $passPhrase) {
    $pfOutput = '';
    foreach($data as $key => $val) {
        if($val !== '') {
            $pfOutput .= $key .'='. urlencode(trim($val)) .'&';
        }
    }
    $getString = substr($pfOutput, 0, -1);
    if($passPhrase !== null) {
        $getString .= '&passphrase='. urlencode(trim($passPhrase));
    }
    return md5($getString);
}

// Usage
$data = [
    'merchant_id' => '10000100',
    'merchant_key' => '46f0cd694581a',
    'amount' => '99.00',
    'item_name' => 'QuickCheck',
    // ... other fields
];

$signature = generateSignature($data, 'jt7NOE43FZPn');
?>
```

### SSL/HTTPS Required
- PayFast requires HTTPS for production
- Obtain SSL certificate for your domain
- Configure your web server for HTTPS

## Testing with Sandbox

### 1. Access Sandbox
- URL: https://sandbox.payfast.co.za
- Create account with your email
- No real money transactions

### 2. Test Buyer Credentials
```
Username: sbtu01@payfast.io
Password: clientpass
```

### 3. Test Payment
- Use the sandbox buyer account
- Test wallet has R99,999,999.99
- Click "Pay Now Using Your Wallet"

### 4. View ITN Notifications
- Login to sandbox dashboard
- Navigate to "ITN (Instant Transaction Notification)"
- View all sent notifications

## Payment Notification (ITN) Setup

### Local Development Testing
To receive ITN notifications locally:

1. **Use Ngrok or Expose:**
   ```bash
   # Install ngrok
   brew install ngrok  # macOS
   
   # Start tunnel
   ngrok http 80
   
   # Copy HTTPS URL (e.g., https://abc123.ngrok.io)
   ```

2. **Update notify_url:**
   ```html
   <input type="hidden" name="notify_url" 
          value="https://abc123.ngrok.io/payment-notify.php">
   ```

### Production Setup
1. Upload `payment-notify.php` to your server
2. Ensure file is accessible at: `https://yourdomain.com/payment-notify.php`
3. Set correct file permissions (644)
4. Verify PHP has write permissions for log file
5. Test by checking log file after test transaction

## Database Integration

The `payment-notify.php` includes commented code for database integration. Implement this to:

1. **Store Order Details:**
   - Payment ID
   - PayFast Payment ID
   - Customer information
   - Package selected
   - Amount paid
   - Tenant details (if provided)

2. **Recommended Database Schema:**
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

## Email Notifications

### Automatic Emails from PayFast
PayFast automatically sends:
- Payment confirmation to buyer
- Payment notification to merchant (if enabled)

### Custom Email Implementation
Add to `payment-notify.php` after successful payment:

```php
// Send custom email
$to = $email;
$subject = "VettedStay - Screening Order Confirmed";
$headers = "From: VettedStay <noreply@vettedstay.com>\r\n";
$headers .= "Reply-To: support@vettedstay.com\r\n";
$headers .= "Content-Type: text/html; charset=UTF-8\r\n";

$message = "
<html>
<body>
    <h2>Thank you for your order!</h2>
    <p>Your payment has been received and your screening report is being processed.</p>
    
    <h3>Order Details</h3>
    <ul>
        <li>Order ID: $paymentId</li>
        <li>Package: $itemName</li>
        <li>Amount: R$amountGross</li>
    </ul>
    
    <p>Your report will be delivered within 24-48 hours to this email address.</p>
    
    <p>Questions? Contact us at info@vetstay.click or +27 72 215 7269</p>
</body>
</html>
";

mail($to, $subject, $message, $headers);
```

## Supported Payment Methods

PayFast supports multiple payment methods. To restrict to specific methods, add to form:

```html
<!-- Credit card only -->
<input type="hidden" name="payment_method" value="cc">

<!-- Other options: -->
<!-- 'ef' – EFT -->
<!-- 'dc' – Debit card -->
<!-- 'mp' – Masterpass -->
<!-- 'mc' – Mobicred -->
<!-- 'sc' – SCode -->
<!-- 'ss' – SnapScan -->
<!-- 'zp' – Zapper -->
```

## Custom Pass-Through Variables

The integration uses custom variables to store tenant information:

```html
<!-- Already implemented in checkout-payfast.html -->
<input type="text" name="custom_str1" placeholder="Tenant Name">
<input type="text" name="custom_str2" placeholder="Property Reference">

<!-- Available custom fields: -->
<!-- custom_str1 through custom_str5 (strings) -->
<!-- custom_int1 through custom_int5 (integers) -->
```

These are returned in the ITN notification and can be used to link payments to specific screening requests.

## Recurring Billing (Future Enhancement)

For subscription-based services, PayFast supports recurring billing:

```html
<!-- Add these fields for subscriptions -->
<input type="hidden" name="subscription_type" value="1">
<input type="hidden" name="recurring_amount" value="99.00">
<input type="hidden" name="frequency" value="3"> <!-- 3 = Monthly -->
<input type="hidden" name="cycles" value="0"> <!-- 0 = Indefinite -->
```

## Troubleshooting

### Common Issues

1. **Signature Mismatch**
   - Verify passphrase matches in both checkout and PayFast settings
   - Check parameter order (must match PayFast documentation)
   - Ensure URL encoding is correct (spaces as '+', uppercase hex)

2. **ITN Not Received**
   - Check notify_url is publicly accessible
   - Verify server returns HTTP 200
   - Check firewall allows PayFast IPs
   - Review PayFast sandbox ITN logs

3. **Payment Fails**
   - Verify all required fields are present
   - Check amount is >= R5.00 (minimum)
   - Ensure HTTPS in production
   - Test with sandbox first

### PayFast IP Whitelist
If using firewall/security rules, whitelist these IPs:
```
197.97.145.144/28
41.74.179.192/27
102.216.36.0/28
102.216.36.128/28
144.126.193.139
```

### Debug Mode
Enable detailed logging in `payment-notify.php`:
```php
// Already enabled - check payfast-notifications.log
// Location: same directory as payment-notify.php
```

## Going Live Checklist

- [ ] Obtain live PayFast credentials
- [ ] Set secure passphrase
- [ ] Update merchant_id and merchant_key in checkout
- [ ] Change to production URLs (www.payfast.co.za)
- [ ] Update SANDBOX_MODE to false in notify script
- [ ] Update all return/cancel/notify URLs to production domain
- [ ] Implement server-side signature generation
- [ ] Set up SSL certificate (HTTPS)
- [ ] Configure database for order storage
- [ ] Test complete payment flow in sandbox
- [ ] Upload payment-notify.php to server
- [ ] Verify ITN notifications work
- [ ] Set up email notifications
- [ ] Configure firewall to allow PayFast IPs
- [ ] Document live credentials securely
- [ ] Test live payment with small amount
- [ ] Monitor first few transactions closely

## Support

### PayFast Support
- Website: https://www.payfast.co.za
- Docs: https://developers.payfast.co.za
- Email: support@payfast.co.za
- Knowledge Base: https://support.payfast.co.za

### VettedStay Technical Support
- Email: info@vetstay.click
- Phone: +27 72 215 7269

## Compliance Notes

- PayFast is PCI DSS Level 1 compliant
- No credit card data touches your server
- POPIA compliant (requires user consent)
- All payments processed securely by PayFast

---

**Last Updated:** January 7, 2026  
**Version:** 1.0  
**Integration Type:** Custom Form Integration
