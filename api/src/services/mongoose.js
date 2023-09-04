require('dotenv').config();
const mongoose = require('mongoose');

async function connectDb() {
    await mongoose.connect(process.env.DB_CONNECTION_STRING);
    console.log('Db connecté');    
}

module.exports = { connectDb }