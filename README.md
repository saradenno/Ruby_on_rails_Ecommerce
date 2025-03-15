# 🛒 Ecommerce Rails

This is a fully functional **Ecommerce Web Application** built with **Ruby on Rails**. It includes features such as product management, category filtering, a shopping cart system, checkout with Stripe, and stock management.

## 🚀 Features

### 🔹 User Features
- Browse products and filter by categories
- View detailed product descriptions
- Add multiple items to the shopping cart
- Adjust item quantities in the cart
- Checkout using **Stripe** payment gateway
- View a summary of orders after purchasing
- Receive alerts for out-of-stock items

### 🔹 Admin Features
- Secure admin authentication (login/logout)
- Manage product categories (create, edit, delete)
- Manage products (add, edit, delete, update stock levels)
- View all orders placed by customers

### 🔹 Stock Management
- Products have a **stock count** that updates automatically when purchased
- Customers cannot add more items than available stock
- Orders with out-of-stock items cannot be placed

---

## 📌 Installation Guide

### 🔧 Prerequisites
Make sure you have the following installed:
- Ruby (3.x recommended)
- Rails (7.x recommended)
- PostgreSQL
- Node.js & Yarn
- Stripe API Keys

### 🛠 Setup Steps

1️⃣ **Clone the Repository**
```sh
 git clone https://github.com/yourusername/ecommerce-rails.git
 cd ecommerce-rails
```

2️⃣ **Install Dependencies**
```sh
 bundle install
 yarn install
```

3️⃣ **Set Up Database**
```sh
 rails db:create db:migrate db:seed
```

4️⃣ **Set Up Environment Variables**
Create a `.env` file and add your **Stripe API keys** and other sensitive credentials:
```
STRIPE_PUBLISHABLE_KEY=your_publishable_key
STRIPE_SECRET_KEY=your_secret_key
```

5️⃣ **Start the Server**
```sh
 rails server
```
Visit `http://localhost:3000` in your browser 🎉

---

## 💳 Stripe Checkout
This project integrates **Stripe** for payments. The checkout process supports:
- Embedded Stripe Checkout Sessions
- Secure payment processing
- Shipping address collection

To test payments, use [Stripe's test cards](https://stripe.com/docs/testing).

---

