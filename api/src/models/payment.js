const mongoose = require("mongoose");
const { Schema } = mongoose;

const paymentSchema = 
new Schema({invoiceNumber: Number,
            paymentDetail: String,
            paymentStatus: String})
             
const Payment = mongoose.model('payment', paymentSchema);

module.exports = Payment;