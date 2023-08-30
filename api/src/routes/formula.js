const express = require('express');
const Formula = require('../models/formula');
const Subscription = require('../models/subscription');
const router = new express.Router();
const authentification = require('../middlewares/authentification');


// CREATE FORMULA FOR CURRENT USER'S SUBSCRIPTION
// ACTUELLEMENT LES CONTROLES NE FONCTIONNE PAS POUR LIMITER LA CREATION
router.post('/formulas', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;
        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const subscription = await Subscription.findOne({ idCompany: companyId });
        if (!subscription) {
            return res.status(404).send("Aucune souscription trouvée pour cette entreprise.");
        }

        const existingFormula = await Formula.findOne({ idCompany: companyId });
        if (existingFormula) {
            return res.status(400).send("Une formule existe déjà pour cette souscription.");
        }

        const startDate = new Date();
        const endDate = new Date(startDate);
        endDate.setFullYear(startDate.getFullYear() + 2);

        
        
        // Retrieve the recurringPrice based on the formulaName
        const formulaName = req.body.formulaName;
        const foundFormula = await Formula.findOne({ formulaName });
        if (!foundFormula) {
            return res.status(404).send("Aucune formule trouvée avec ce nom.");
        }
        const recurringPrice = foundFormula.recurringPrice;


        const formula = new Formula({
            idCompany: companyId,
            formulaName: formulaName,
            modules: req.body.module,
            selectedModule: req.body.selectedModule,
            recurringPrice: recurringPrice,
            startDatePrice: startDate,
            endDatePrice: endDate
        });

        await formula.save();

        res.status(201).send({ formula });
    } catch (e) {
        res.status(400).send(e);
    }
});


// READ FORMULA FOR CURRENT USER'S SUBSCRIPTION
router.get('/formula', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;
        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const subscription = await Subscription.findOne({ idCompany: companyId });
        if (!subscription) {
            return res.status(404).send("Aucune formule trouvée pour cette entreprise.");
        }

        const formulas = await Formula.find({ idFormula: subscription.idFormula });

        res.status(200).send({ formulas });
    } catch (e) {
        console.error(e);
        res.status(500).send(e);
    }
});


// READ ALL FORMULA
router.get('/formulas', authentification, async (req, res) => {
    try {
        const formulas = await Formula.find();

        res.status(200).send({ formulas });
    } catch (e) {
        console.error(e);
        res.status(500).send(e);
    }
});


// UPDATE FORMULA ACTIVE BY super_admin
router.patch('/formulas', authentification, async (req, res) => {
    try {
        const { formulaName, active } = req.body;

        if (!formulaName) {
            return res.status(400).send("Le nom de la formule est requis.");
        }

        const formula = await Formula.findOneAndUpdate(
            { formulaName },
            { active },
            { new: true }   // indique à Mongoose de renvoyer le document mis à jour après la mise à jour. Sinon, Mongoose renverra le document avant la mise à jour.
        );

        if (!formula) {
            return res.status(404).send("Formule non trouvée.");
        }

        res.send(formula);
    } catch (e) {
        res.status(400).send(e);
    }
});


module.exports = router;