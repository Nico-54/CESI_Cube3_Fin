const express = require('express');
const Price = require('../models/price');
const Subscription = require('../models/subscription');
const router = new express.Router();
const authentification = require('../middlewares/authentification');


// CREATE PRICE FOR CURRENT USER'S SUBSCRIPTION
// ACTUELLEMENT LES CONTROLES NE FONCTIONNE PAS POUR LIMITER LA CREATION
router.post('/prices', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;
        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const subscription = await Subscription.findOne({ idCompany: companyId });
        if (!subscription) {
            return res.status(404).send("Aucune souscription trouvée pour cette entreprise.");
        }

        const existingPrice = await Price.findOne({ idCompany: companyId });
        if (existingPrice) {
            return res.status(400).send("Un prix existe déjà pour cette souscription.");
        }

        const startDate = new Date();
        const endDate = new Date(startDate);
        endDate.setFullYear(startDate.getFullYear() + 2);

        const price = new Price({
            idCompany: companyId,
            formulaName: req.body.formulaName,
            module: req.body.module,
            recurringPrice: req.body.recurringPrice,
            startDatePrice: startDate,
            endDatePrice: endDate
        });

        await price.save();

        res.status(201).send({ price });
    } catch (e) {
        res.status(400).send(e);
    }
});


// READ PRICES FOR CURRENT USER'S SUBSCRIPTION
// ACTUELLEMENT NE FONCTIONNE PAS
// SUREMENT PROBLEME DE LIASION ENTRE COLLECTION
router.get('/prices', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;
        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const subscription = await Subscription.findOne({ idCompany: companyId });
        if (!subscription) {
            return res.status(404).send("Aucune souscription trouvée pour cette entreprise.");
        }

        const prices = await Price.find({ idCompany: companyId });

        res.status(200).send({ prices });
    } catch (e) {
        console.error(e);
        res.status(500).send(e);
    }
});


module.exports = router;