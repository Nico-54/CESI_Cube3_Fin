const mongoose = require("mongoose");
const { Schema } = mongoose;

const pricesSchema = 
new Schema({formulaName: String,
            module: Number,
            recurringPrice: Number,
            startDatePrice: Date,
            endDatePrice: Date,
})

// Manage decimal places -> 2
for (const key in pricesSchema.paths) {
  if (key.includes("price")) {
      const field = pricesSchema.paths[key];
      if (field instanceof mongoose.SchemaTypes.Number) {
          field.get((v) => parseFloat(v).toFixed(2));
          field.set((v) => parseFloat(v).toFixed(2));
      }
  }
}
             
const Price = mongoose.model('prices', pricesSchema);

module.exports = Price;