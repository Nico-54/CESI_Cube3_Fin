require('dotenv').config();
const { connectDb } = require('./src/services/mongoose');
const userRoutes = require('./src/routes/user');
const companyRoutes = require('./src/routes/company');
const subscriptionRoutes = require('./src/routes/subscription');
const priceRoutes = require('./src/routes/price');
const cors = require('cors'); // Importez le package CORS


const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

const corsOptions = {
  origin: 'http://localhost:8080', // Remplacez par l'URL de votre application Vue.js
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
};

app.use(cors(corsOptions));

connectDb().catch(err => console.log(err));

app.use(express.json());
app.use(userRoutes);
app.use(companyRoutes);
app.use(subscriptionRoutes);
app.use(priceRoutes);

app.listen(port, () => {
  console.log(`Le serveur est lancé à : http://localhost:${port}`)
});


  