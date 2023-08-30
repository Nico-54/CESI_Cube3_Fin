const mongoose = require("mongoose");
const { Schema } = mongoose;

const paymentSchema = 
new Schema({invoiceNumber: { type: Schema.Types.ObjectId, ref: 'Invoice' },
            paymentDetail: String,
            paymentStatus: String})
             
const Payment = mongoose.model('payment', paymentSchema);

module.exports = Payment;