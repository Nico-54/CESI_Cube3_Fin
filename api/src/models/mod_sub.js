const mongoose = require("mongoose");
const { Schema } = mongoose;

const mod_subSchema = 
new Schema({idModule: { type: Schema.Types.ObjectId, ref: 'Module' },
            idSubscription: { type: Schema.Types.ObjectId, ref: 'Subscription' }})
             
const Mod_sub = mongoose.model('mod_sub', mod_subSchema);

module.exports = Mod_sub;