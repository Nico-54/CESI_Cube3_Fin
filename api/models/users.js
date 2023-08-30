const mongoose = require("mongoose");
//const bcrypt = require("bcryptjs");
const { Schema } = mongoose;
//const { company } = require("./companies");

const usersSchema = 
new Schema({idCompany: Number,
            idRole: Number,
            firstName: { type: String, required:true }, 
            lastName: { type: String, required:true },
            email: { type: String, required:true },
            pwd: { type: String, required:true },
            userCreated: Date,
            userModified: Date,
            userDeleted: Date,
            modifiedBy: String, 
            }

          );

const user = mongoose.model('users', usersSchema);



// CREATE User
function create_user (input_firName, 
                      input_lasName, 
                      input_email, 
                      input_pwd) {
  const userCreated = new Date();
  const creatuser = new user({firstName:input_firName,
                              lastName:input_lasName,
                              email:input_email,
                              pwd:input_pwd,
                              userCreated:userCreated});                          
  return creatuser
}

  // SAVE User
  function save(creatuser) {
    creatuser.save();
  }

  // CHECK User
  async function checkAndSaveUser(input_user) {
    try {
      const existingUser = await user.findOne({ email: input_user.email }).exec();

      if (existingUser) {
        console.log("Un utilisateur avec cette adresse mail existe déjà.");
      } else {
        const createdUser = new user(input_user);
        await save(createdUser);
        console.log("L'utilisateur a été ajouté.");
      }
    } catch (error) {
      console.error("Erreur lors de la vérification de l'utilisateur :", error);
    }
  }

// GET User
async function getUsers(queryType, value) {
  try {
    let query;

    if (queryType === 'name') {
      query = {
        $or: [{ firstName: value }, { lastName: value }]
      };
    } else if (queryType === 'email') {
      query = { email: value };
    } else if (queryType === 'userCreated') {
      query = { userCreated: value };
    } else {
      console.log("Type de requête non pris en charge.");
      return null;
    }

    const result = await user.find(query);
    return result;
  } catch (error) {
    console.error("Erreur lors de la récupération des utilisateurs :", error);
    return null;
  }
}


// UPDATE User
async function updateUser(userEmail, updatedInfo) {
  try {
    const existingUser = await user.findOne({ email: userEmail });

    if (!existingUser) {
      console.log("Utilisateur non trouvé.");
      return null;
    }

    // Info to update
    if (updatedInfo.firstName) {
      existingUser.firstName = updatedInfo.firstName;
    }
    if (updatedInfo.lastName) {
      existingUser.lastName = updatedInfo.lastName;
    }
    if (updatedInfo.email) {
      existingUser.email = updatedInfo.email;
    }
    if (updatedInfo.pwd) {
      existingUser.pwd = updatedInfo.pwd;
    }
    
    // Set updateDate 
    existingUser.userModified = new Date();

    // Update save
    await existingUser.save();
    console.log("Informations de l'utilisateur mises à jour.");
    return existingUser;
  } catch (error) {
    console.error("Erreur lors de la mise à jour de l'utilisateur :", error);
    return null;
  }
}

module.exports = { user, create_user, checkAndSaveUser, getUsers, updateUser }