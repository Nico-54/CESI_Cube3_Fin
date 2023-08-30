const mongoose = require('mongoose');
const { Schema } = mongoose;
const validator = require('validator');
const bcrypt = require('bcryptjs');
const jwt = require ('jsonwebtoken');
const Company = require('../models/company');



const userSchema = 
new Schema({idCompany: { type: Schema.Types.ObjectId, ref: 'Company' },
            role: { type: String,
                    enum: ['admin', 'super_admin', 'utilisateur'],},
            firstName: { type: String,
                         required:true }, 
            lastName: { type: String, 
                        required:true },
            email: { type: String, 
                    required:true,
                    unique:true, 
                    validate(v) {if (!validator.isEmail(v)) throw new Error('Email non valide')} },
            pwd: { type: String, 
                   required: true, 
                   validate(v) {if (!validator.isLength(v, { min :8, max:80})) throw new Error('Le mot de passe doit être entre 8 et 80 caractères');}
                  },
            userCreated: Date,
            userModified: Date,
            userDeleted: Date,
            modifiedBy: String,
            authTokens: [{authToken: {type: String, required: true} }]
            });


// Function generateAuthTokenAndSaveUser - Manage Token
userSchema.methods.generateAuthTokenAndSaveUser = async function () {
  const authToken = jwt.sign({ _id: this._id.toString() }, 'secret', { expiresIn: '30m' });
  // save token in BDD
  this.authTokens.push({ authToken });
  await this.save();
  return authToken;
}


// Function FindUser - check pwd (statics : add a function to the model)
userSchema.statics.findUser = async(email, pwd) => {
  const user = await User.findOne({email});
  if (!user) throw new Error('erreur de connection')
  const isPwdValid = await bcrypt.compare(pwd, user.pwd);
  if (!isPwdValid) throw new Error('erreur de connection')
  return user;
}


// Middleware (hash before save)
userSchema.pre('save', async function() {
  if (this.isModified('pwd')) this.pwd = await bcrypt.hash(this.pwd, 8);
} );


// Function toJSON - modif JSON
userSchema.methods.toJSON = function () {
  const user = this.toObject();

  delete user.pwd;
  delete user.authTokens;

  return user;
}

const User = mongoose.model('User', userSchema);

module.exports = User