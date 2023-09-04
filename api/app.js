require('dotenv').config();
const { connectDb } = require('./src/services/mongoose');
const userRoutes = require('./src/routes/user');
const companyRoutes = require('./src/routes/company');
const subscriptionRoutes = require('./src/routes/subscription');
const formulaRoutes = require('./src/routes/formula');
const invoiceRoutes = require('./src/routes/invoice');
const paymentRoutes = require('./src/routes/payment');
const mod_subs = require('./src/routes/mod_sub');
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
app.use(formulaRoutes);
app.use(invoiceRoutes);
app.use(paymentRoutes);
app.use(mod_subs);


app.listen(port, () => {
  console.log(`Le serveur est lancé à : http://localhost:${port}`)
});


  