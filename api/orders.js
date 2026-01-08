// Serverless API Functions for VettedStay
// Deploy to: Vercel, Netlify, Firebase, or AWS Lambda

// ======================
// ORDER PROCESSING API
// ======================

export async function createOrder(request, response) {
  const { item, customer, payment } = JSON.parse(request.body);
  
  const order = {
    id: `VS${Date.now()}${Math.random().toString(36).substr(2, 5).toUpperCase()}`,
    timestamp: new Date().toISOString(),
    item,
    customer,
    payment,
    status: 'pending',
    total: calculateTotal(item)
  };
  
  // Save to database (Firebase/Supabase/DynamoDB)
  await saveOrder(order);
  
  // Send confirmation email
  await sendEmail(customer.email, order);
  
  response.json({ success: true, orderId: order.id });
}

// ======================
// PAYMENT PROCESSING
// ======================

export async function processPayment(request, response) {
  const { orderId, method, amount } = JSON.parse(request.body);
  
  let result;
  switch(method) {
    case 'googlepay':
      result = await processGooglePay(request.body);
      break;
    case 'card':
      result = await processCard(request.body);
      break;
    case 'eft':
      result = await generateEFTReference(orderId);
      break;
  }
  
  response.json(result);
}

// ======================
// HELPER FUNCTIONS
// ======================

function calculateTotal(item) {
  const prices = {
    basic: 99,
    standard: 249,
    comprehensive: 449
  };
  const subtotal = prices[item] || 249;
  const fee = 15;
  return subtotal + fee;
}

async function saveOrder(order) {
  // Firebase example:
  // await db.collection('orders').doc(order.id).set(order);
  
  // Supabase example:
  // await supabase.from('orders').insert(order);
  
  console.log('Order saved:', order.id);
}

async function sendEmail(email, order) {
  // SendGrid/Mailgun/AWS SES integration
  console.log(`Email sent to ${email}`, order.id);
}
