#!/bin/bash

# VettedStay E-Commerce Quick Deploy Script
# Run this to deploy your serverless e-commerce site

echo "🚀 VettedStay E-Commerce Deployment"
echo "===================================="
echo ""

# Check if in correct directory
if [ ! -f "index-ecommerce.html" ]; then
    echo "❌ Error: Please run this from the vettedStay-main directory"
    exit 1
fi

echo "Choose deployment platform:"
echo "1) Vercel (Recommended)"
echo "2) Netlify"
echo "3) Firebase"
echo "4) Test Locally"
echo ""
read -p "Enter choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo "📦 Deploying to Vercel..."
        echo ""
        
        # Check if Vercel CLI installed
        if ! command -v vercel &> /dev/null; then
            echo "Installing Vercel CLI..."
            npm install -g vercel
        fi
        
        echo "🚀 Starting deployment..."
        vercel --prod
        
        echo ""
        echo "✅ Deployed to Vercel!"
        echo "🌐 Your site is now live!"
        ;;
        
    2)
        echo ""
        echo "📦 Deploying to Netlify..."
        echo ""
        
        # Check if Netlify CLI installed
        if ! command -v netlify &> /dev/null; then
            echo "Installing Netlify CLI..."
            npm install -g netlify-cli
        fi
        
        echo "🚀 Starting deployment..."
        netlify deploy --prod
        
        echo ""
        echo "✅ Deployed to Netlify!"
        echo "🌐 Your site is now live!"
        ;;
        
    3)
        echo ""
        echo "📦 Deploying to Firebase..."
        echo ""
        
        # Check if Firebase CLI installed
        if ! command -v firebase &> /dev/null; then
            echo "Installing Firebase CLI..."
            npm install -g firebase-tools
        fi
        
        echo "🔐 Logging in to Firebase..."
        firebase login
        
        echo "⚙️ Initializing Firebase..."
        firebase init hosting
        
        echo "🚀 Starting deployment..."
        firebase deploy
        
        echo ""
        echo "✅ Deployed to Firebase!"
        echo "🌐 Your site is now live!"
        ;;
        
    4)
        echo ""
        echo "🧪 Opening local test..."
        echo ""
        
        # Open in default browser
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open index-ecommerce.html
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open index-ecommerce.html
        else
            start index-ecommerce.html
        fi
        
        echo "✅ Opened in browser!"
        echo ""
        echo "📝 Test checklist:"
        echo "  1. Add items to cart"
        echo "  2. View cart modal"
        echo "  3. Proceed to checkout"
        echo "  4. Fill form and test payment selection"
        echo "  5. Complete order"
        ;;
        
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "================================"
echo "✅ Deployment Complete!"
echo "================================"
echo ""
echo "📚 Next steps:"
echo "  1. Set up payment gateway (PayFast/Stripe)"
echo "  2. Configure database (Firebase/Supabase)"
echo "  3. Set up email service (SendGrid/Mailgun)"
echo "  4. Add custom domain"
echo "  5. Enable analytics"
echo ""
echo "📖 Full docs: docs/ECOMMERCE_IMPLEMENTATION.md"
echo "🎯 Quick ref: docs/ECOMMERCE_SUMMARY.md"
echo ""
echo "💡 Need help? Check the documentation or create an issue"
echo ""
