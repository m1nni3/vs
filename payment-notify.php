<?php
/**
 * PayFast ITN (Instant Transaction Notification) Handler
 * VettedStay Payment Notification Endpoint
 * 
 * This script handles payment notifications from PayFast
 * Place this file on your server at: https://vetstay.click/payment-notify.php
 */

// Tell PayFast that this page is reachable by triggering a header 200
header('HTTP/1.0 200 OK');
flush();

// Configuration
define('SANDBOX_MODE', false); // Set to false for production
$pfHost = SANDBOX_MODE ? 'sandbox.payfast.co.za' : 'www.payfast.co.za';
$pfPassphrase = 'Quinnyboy3m1nni3'; // Your passphrase - keep secure!

// Log file for debugging
$logFile = __DIR__ . '/payfast-notifications.log';

// Function to log messages
function logMessage($message) {
    global $logFile;
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($logFile, "[$timestamp] $message\n", FILE_APPEND);
}

logMessage("=== New PayFast Notification Received ===");

// Get posted data from PayFast
$pfData = $_POST;

if (empty($pfData)) {
    logMessage("ERROR: No POST data received");
    exit();
}

logMessage("Raw POST data: " . print_r($pfData, true));

// Strip any slashes in data
foreach($pfData as $key => $val) {
    $pfData[$key] = stripslashes($val);
}

// Convert posted variables to a string for signature verification
$pfParamString = '';
foreach($pfData as $key => $val) {
    if($key !== 'signature') {
        $pfParamString .= $key .'='. urlencode($val) .'&';
    }
}
// Remove last ampersand
$pfParamString = substr($pfParamString, 0, -1);

/**
 * SECURITY CHECK 1: Verify the signature
 */
function pfValidSignature($pfData, $pfParamString, $pfPassphrase = null) {
    if($pfPassphrase === null) {
        $tempParamString = $pfParamString;
    } else {
        $tempParamString = $pfParamString.'&passphrase='.urlencode($pfPassphrase);
    }
    
    $signature = md5($tempParamString);
    return ($pfData['signature'] === $signature);
}

$check1 = pfValidSignature($pfData, $pfParamString, $pfPassphrase);
logMessage("Security Check 1 - Signature Valid: " . ($check1 ? "YES" : "NO"));

/**
 * SECURITY CHECK 2: Verify the source IP is from PayFast
 */
function pfValidIP() {
    $validHosts = array(
        'www.payfast.co.za',
        'sandbox.payfast.co.za',
        'w1w.payfast.co.za',
        'w2w.payfast.co.za',
    );
    
    $validIps = [];
    
    foreach($validHosts as $pfHostname) {
        $ips = gethostbynamel($pfHostname);
        if($ips !== false) {
            $validIps = array_merge($validIps, $ips);
        }
    }
    
    $validIps = array_unique($validIps);
    
    // Check the actual remote IP address that made the request
    $remoteIp = $_SERVER['REMOTE_ADDR'];
    
    return in_array($remoteIp, $validIps, true);
}

$check2 = pfValidIP();
logMessage("Security Check 2 - Valid IP: " . ($check2 ? "YES" : "NO"));

/**
 * SECURITY CHECK 3: Verify payment data matches expected amount
 */
function pfValidPaymentData($pfData) {
    // You should verify the amount matches what you expected
    // For now, just check that amount_gross exists and is positive
    return isset($pfData['amount_gross']) && floatval($pfData['amount_gross']) > 0;
}

$check3 = pfValidPaymentData($pfData);
logMessage("Security Check 3 - Valid Payment Data: " . ($check3 ? "YES" : "NO"));

/**
 * SECURITY CHECK 4: Confirm with PayFast server
 */
function pfValidServerConfirmation($pfParamString, $pfHost) {
    if(in_array('curl', get_loaded_extensions(), true)) {
        $url = 'https://'. $pfHost .'/eng/query/validate';
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $pfParamString);
        
        $response = curl_exec($ch);
        curl_close($ch);
        
        return ($response === 'VALID');
    }
    return false;
}

$check4 = pfValidServerConfirmation($pfParamString, $pfHost);
logMessage("Security Check 4 - Server Confirmation: " . ($check4 ? "YES" : "NO"));

/**
 * Process the payment if all checks pass
 */
if($check1 && $check2 && $check3 && $check4) {
    logMessage("All security checks passed - Processing payment");
    
    // Extract payment details
    $paymentId = $pfData['m_payment_id'];
    $pfPaymentId = $pfData['pf_payment_id'];
    $paymentStatus = $pfData['payment_status'];
    $itemName = $pfData['item_name'];
    $amountGross = $pfData['amount_gross'];
    $amountFee = isset($pfData['amount_fee']) ? $pfData['amount_fee'] : 0;
    $amountNet = isset($pfData['amount_net']) ? $pfData['amount_net'] : 0;
    
    // Custom fields (tenant info, property ref, etc.)
    $tenantName = isset($pfData['custom_str1']) ? $pfData['custom_str1'] : '';
    $propertyRef = isset($pfData['custom_str2']) ? $pfData['custom_str2'] : '';
    
    // Customer details
    $firstName = isset($pfData['name_first']) ? $pfData['name_first'] : '';
    $lastName = isset($pfData['name_last']) ? $pfData['name_last'] : '';
    $email = isset($pfData['email_address']) ? $pfData['email_address'] : '';
    
    logMessage("Payment ID: $paymentId");
    logMessage("PayFast Payment ID: $pfPaymentId");
    logMessage("Status: $paymentStatus");
    logMessage("Package: $itemName");
    logMessage("Amount: R$amountGross");
    logMessage("Customer: $firstName $lastName ($email)");
    if($tenantName) logMessage("Tenant: $tenantName");
    if($propertyRef) logMessage("Property: $propertyRef");
    
    if($paymentStatus === 'COMPLETE') {
        logMessage("Payment successful - Processing order");
        
        // TODO: Your business logic here
        // 1. Update database with payment details
        // 2. Create screening order
        // 3. Send confirmation email to customer
        // 4. Trigger report generation
        // 5. Update order status
        
        // Example database update (adjust to your schema)
        /*
        try {
            $db = new PDO('mysql:host=localhost;dbname=vettedstay', 'username', 'password');
            
            $stmt = $db->prepare("
                INSERT INTO orders (
                    payment_id, pf_payment_id, status, package, amount,
                    customer_first_name, customer_last_name, customer_email,
                    tenant_name, property_ref, created_at
                ) VALUES (
                    :payment_id, :pf_payment_id, :status, :package, :amount,
                    :first_name, :last_name, :email,
                    :tenant_name, :property_ref, NOW()
                )
            ");
            
            $stmt->execute([
                ':payment_id' => $paymentId,
                ':pf_payment_id' => $pfPaymentId,
                ':status' => 'paid',
                ':package' => $itemName,
                ':amount' => $amountGross,
                ':first_name' => $firstName,
                ':last_name' => $lastName,
                ':email' => $email,
                ':tenant_name' => $tenantName,
                ':property_ref' => $propertyRef
            ]);
            
            logMessage("Database updated successfully");
            
            // Send confirmation email
            $to = $email;
            $subject = "VettedStay Order Confirmation - $itemName";
            $message = "Thank you for your order!\n\n";
            $message .= "Order ID: $paymentId\n";
            $message .= "Package: $itemName\n";
            $message .= "Amount: R$amountGross\n\n";
            $message .= "Your screening report will be delivered within 24-48 hours.\n\n";
            $message .= "Best regards,\nVettedStay Team";
            
            mail($to, $subject, $message);
            logMessage("Confirmation email sent to $email");
            
        } catch(Exception $e) {
            logMessage("ERROR: Database error - " . $e->getMessage());
        }
        */
        
        logMessage("Order processing complete");
        
    } else if($paymentStatus === 'CANCELLED') {
        logMessage("Payment cancelled by user");
        
        // TODO: Handle cancellation
        // 1. Update order status to cancelled
        // 2. Send cancellation notification if needed
        
    } else {
        logMessage("Unknown payment status: $paymentStatus");
    }
    
} else {
    logMessage("SECURITY CHECKS FAILED - Payment rejected");
    logMessage("Check 1 (Signature): " . ($check1 ? "PASS" : "FAIL"));
    logMessage("Check 2 (Valid IP): " . ($check2 ? "PASS" : "FAIL"));
    logMessage("Check 3 (Payment Data): " . ($check3 ? "PASS" : "FAIL"));
    logMessage("Check 4 (Server Confirm): " . ($check4 ? "PASS" : "FAIL"));
    
    // Log for manual investigation
    logMessage("MANUAL REVIEW REQUIRED - Check payment manually in PayFast dashboard");
}

logMessage("=== End of Notification Processing ===\n");

?>
