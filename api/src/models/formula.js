const mongoose = require("mongoose");
const { Schema } = mongoose;

const formulasSchema = 
new Schema({formulaName: String,
            modules: Number,
            selectedModule: String,
            recurringPrice: Number,
            startDatePrice: Date,
            endDatePrice: Date,
            TPE: Boolean,
            active: Boolean
})

// Manage decimal places -> 2
for (const key in formulasSchema.paths) {
  if (key.includes("forumla")) {
      const field = formulasSchema.paths[key];
      if (field instanceof mongoose.SchemaTypes.Number) {
          field.get((v) => parseFloat(v).toFixed(2));
          field.set((v) => parseFloat(v).toFixed(2));
      }
  }
}
             
const Formula = mongoose.model('formulas', formulasSchema);

module.exports = Formula;