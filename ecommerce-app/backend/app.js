const express = require('express');
const app = express();
const port = 3000;

const products = [
  { id: 1, name: 'Laptop', price: 1200 },
  { id: 2, name: 'Phone', price: 800 },
  { id: 3, name: 'Headphones', price: 150 }
];

app.get('/', (req, res) => {
  res.send('Welcome to the ecommerce API');
});

app.get('/products', (req, res) => {
  res.json(products);
});

app.listen(port, () => {
  console.log(`Backend API listening at http://localhost:${port}`);
});
