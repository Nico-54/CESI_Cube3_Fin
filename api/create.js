// creation des tables de paramètrages


const { connectDb } = require('./src/services/mongoose');
const mongoose = require('mongoose');
const Formula = require('./src/models/formula');
const User = require('./src/models/user');
const Module = require('./src/models/module');



async function createFormulas() {
  try {
    await connectDb();

    // Create super_admin
    const superAdmin = new User({
      firstName: 'Super',
      lastName: 'Admin',
      email: "superadmin@test.com",
      pwd: 'Azerty01',
      companyName: 'Cogelis',
      role: 'super_admin',
    });

    await superAdmin.save();

    console.log('Utilisateur super_admin créé avec succès.');


    // Create Modules
   const modules = [
      {moduleName:'Anomalie',type:'déclencheur'}, 
      {moduleName:'Risque',type:'déclencheur'}, 
      {moduleName:'Accident',type:'déclencheur'}, 
      {moduleName:'Echéance',type:'déclencheur'}, 
      {moduleName:'Audit',type:'déclencheur'}, 
      {moduleName:'Signalement',type:'déclencheur'}, 
      {moduleName:'RPS',type:'déclencheur'}, 
      {moduleName:'Action',type:'action'}
    ];





    // Create Formulas
    const formulas = [
      {
        formulaName: 'DUER',
        recurringPrice: 15,
        modules: 2,
        TPE: true,
        active: true,
      },
      {
        formulaName: 'Primo',
        recurringPrice: 50,
        modules: 1,
        active: true,
      },
      {
        formulaName: 'Amélioration',
        recurringPrice: 80,
        modules: 2,
        active: true,
      },
      {
        formulaName: 'Performance',
        recurringPrice: 120,
        modules: 4,
        active: true,
      },
      {
        formulaName: 'Prévention',
        recurringPrice: 150,
        modules: 5,
        active: true,
      },
      {
        formulaName: 'Excellence',
        recurringPrice: 200,
        modules: 8,
        active: true,
      },
    ];

    await Module.insertMany(modules);

    console.log('Modules crées avec succès.');

    await Formula.insertMany(formulas);

    console.log('Formules crées avec succès.');

    mongoose.connection.close();
  } catch (error) {
    console.error('Erreur lors de la création :', error);
  }
}

createFormulas();