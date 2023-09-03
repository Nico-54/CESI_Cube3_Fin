const mongoose = require('mongoose');
const { Schema } = mongoose;

const companiesSchema = 
new Schema({companyName: { type: String, required:true, unique:true }, 
    companyAddress: { type: String, required:true },
    companyPostCode:{ type: String, required:true }, 
    companyCity: { type: String, required:true }, 
    intraComVATNumber: String, 
    TPE: Boolean, 
    registrationDate: Date,
    updateDate: Date,
    deletedDate: Date,
    updateBy: String})


const Company = mongoose.model('companies', companiesSchema);

module.exports = Company;