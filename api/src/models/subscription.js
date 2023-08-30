const mongoose = require("mongoose");
const { Schema } = mongoose;

const subscriptionSchema = 
new Schema({idCompany: { type: Schema.Types.ObjectId, ref: 'Company' },
            idFormula:{ type: Schema.Types.ObjectId, ref: 'Formula' },
            renewal: Boolean,
            startDate: Date,
            endDate: Date,
            updateDate: Date,
            purchaseOrder: String,
            active: Boolean})

const Subscription = mongoose.model('subscription', subscriptionSchema);

module.exports = Subscription;