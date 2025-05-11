module.exports = {
    HOST: process.env.DB_HOST || 'your-rds-endpoint.amazonaws.com',
    USER: process.env.DB_USER || 'admin',
    PASSWORD: process.env.DB_PASSWORD || 'password123',
    DB: process.env.DB_NAME || 'ecommerce',
    dialect: 'postgres'
  };
  