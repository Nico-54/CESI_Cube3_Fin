const mongoose = require("mongoose");
const { Schema } = mongoose;

const moduleSchema = 
new Schema({moduleName: String,
            idFormula:{ type: Schema.Types.ObjectId, ref: 'Formula' },
            moduleName: String,
            type: String
           });

const Module = mongoose.model('module', moduleSchema);

module.exports = Module;