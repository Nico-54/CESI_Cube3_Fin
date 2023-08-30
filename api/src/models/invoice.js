const mongoose = require('mongoose');
const { Schema } = mongoose;
const validator = require('validator');

const invoiceSchema = 
new Schema({idCompany: Number,
            idSubscription: Number,
            dateInvoice: Date,
            dateSale: Date,
            buyerIdentity: String,
            invoiceAddress: String,
            numberIdVAT: String,
            assetInvoice: String,
            catPrice: Number,
            invoiceVAT: Number,
            increasePrice: Number,
            reducePrice: Number,
            htPrice: Number,
            ttcPrice: Number,
          });

// Manage decimal places -> 2
for (const key in invoiceSchema.paths) {
  if (key.includes("price") || key === "invoiceVAT") {
      const field = invoiceSchema.paths[key];
      if (field instanceof mongoose.SchemaTypes.Number) {
          field.get((v) => parseFloat(v).toFixed(2));
          field.set((v) => parseFloat(v).toFixed(2));
      }
  }
}

const Invoice = mongoose.model('invoice', invoiceSchema);

module.exports = Invoice;