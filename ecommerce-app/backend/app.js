const express = require('express');
const app = express();
const port = 3000;


app.get('/', (req, res) => {
  res.send('Welcome to PeaCommerce');
});


app.listen(port, () => {
  console.log(`Backend API listening at http://localhost:${port}`);
});
const Product = require('./models/product');

// Create product
app.post('/products', async (req, res) => {
  const product = await Product.create(req.body);
  res.json(product);
});

// Get all products
app.get('/products', async (req, res) => {
  const products = await Product.findAll();
  res.json(products);
});

// backend/app.js
const express = require('express');
const sequelize = require('./db');
const app = express();
app.use(express.json());

sequelize.authenticate()
  .then(() => {
    console.log('✅ Connected to Postgres');
    return sequelize.sync(); // optional: auto-create tables
  })
  .catch((err) => {
    console.error('❌ Unable to connect to DB:', err);
  });

app.get('/', (req, res) => {
  res.send('Hello from EKS + RDS!');
});
// Add a new product
app.post('/products', async (req, res) => {
  const { name, price } = req.body;
  const product = await Product.create({ name, price });
  res.status(201).json(product);
});
module.exports = app;
// backend/models/product.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const Product = sequelize.define('Product', {
  name: {
    type: DataTypes.STRING,
    allowNull: false
  },
  price: {
    type: DataTypes.NUMERIC,
    allowNull: false
  }
});

module.exports = Product;