const express = require('express');
const Subscription = require('../models/subscription');
const router = new express.Router();
const authentification = require('../middlewares/authentification');


// CREATE SUBSCRIPTION FOR CURRENT USER'S COMPANY
router.post('/subscriptions', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;

        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        // check subscription already exist for current company
        const existingSubscription = await Subscription.findOne({ idCompany: companyId });

        if (existingSubscription) {
            return res.status(400).send("Une souscription existe déjà pour cette entreprise.");
        }

        const startDate = new Date();
        const endDate = new Date(startDate);
        endDate.setFullYear(startDate.getFullYear() + 2);

        const subscription = new Subscription({
            idCompany: companyId,
            idPrice: req.body.idPrice,
            renewal: req.body.renewal,
            startDate: startDate,
            endDate: endDate,
            purchaseOrder: req.body.purchaseOrder,
            active: req.body.active
        });

        await subscription.save();

        res.status(201).send({ subscription });
    } catch (e) {
        res.status(400).send(e);
    }
});


// READ SUBSCRIPTION BY CURRENT USER'S COMPANY
router.get('/subscriptions', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;

        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const subscription = await Subscription.findOne({ idCompany: companyId });

        if (!subscription) {
            return res.status(404).send("Aucune souscription trouvée pour cette entreprise.");
        }

        res.send(subscription);
    } catch (e) {
        res.status(500).send(e);
    }
});


// UPDATE SUBSCRIPTION BY CURRENT USER'S COMPANY
router.patch('/subscriptions', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;

        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const subscription = await Subscription.findOne({ idCompany: companyId });

        if (!subscription) {
            return res.status(404).send("Aucune souscription trouvée pour cette entreprise.");
        }

        subscription.renewal = req.body.renewal;
        subscription.purchaseOrder = req.body.purchaseOrder;
        subscription.active = req.body.active;
        subscription.updateDate = new Date();

        await subscription.save();

        res.send(subscription);
    } catch (e) {
        res.status(400).send(e);
    }
});


// DELETE SUBSCRIPTION BY CURRENT USER'S COMPANY
router.delete('/subscriptions/me', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;

        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const subscription = await Subscription.findOneAndDelete({ idCompany: companyId });

        if (!subscription) {
            return res.status(404).send("Aucune souscription trouvée pour cette entreprise.");
        }

        res.send(subscription);
    } catch (e) {
        res.status(500).send(e);
    }
});


module.exports = router;