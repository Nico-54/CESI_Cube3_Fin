require('dotenv').config();
const mongoose = require('mongoose');

async function connectDb() {
    await mongoose.connect('mongodb://127.0.0.1:27017/test');
    console.log('Db connecté');    
}
    
module.exports = { connectDb }