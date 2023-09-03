const express = require('express');
const Formula = require('../models/formula');
const Subscription = require('../models/subscription');
const router = new express.Router();
const authentification = require('../middlewares/authentification');



// READ FORMULA FOR CURRENT USER'S SUBSCRIPTION
router.get('/formula/me', authentification, async (req, res) => {
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
        res.status(500).send(e);
    }
});


//READ FORMULA BY ID
router.get('/formula/id', authentification, async (req, res) => {
    try {
        const formulaId = req.body.formulaId; 
        const formula = await Formula.findById(formulaId);

        if (!formula) {
            return res.status(404).send("Aucune formule trouvée pour cet ID.");
        }

        res.send(formula);
    } catch (e) {
        res.status(500).send(e);
    }
});


// READ ALL FORMULA
router.get('/formula/all', authentification, async (req, res) => {
    try {
        const formulas = await Formula.find();

        res.status(200).send({ formulas });
    } catch (e) {
        console.error(e);
        res.status(500).send(e);
    }
});


// UPDATE FORMULA ACTIVE BY SUPER_ADMIN
router.patch('/formulas', authentification, async (req, res) => {
    try {
        if (req.user.role !== 'super_admin') {
            return res.status(403).send("Accès interdit - Réservé aux super admins");
        }
        
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