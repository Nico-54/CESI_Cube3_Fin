const express = require('express');
const router = new express.Router();
const authentification = require('../middlewares/authentification');
const Mod_sub = require('../models/mod_sub');
const Module = require('../models/module');
const Subscription = require('../models/subscription');



// CREATE MODULES ON SUBSCRIPTION
router.post('/mod_sub', authentification, async (req, res) => {
    try {
        const subscriptionId = req.body.subscriptionId;
        const moduleId = req.body.moduleId;

        const subscription = await Subscription.findById(subscriptionId);

        if (!subscription) {
            return res.status(404).send("Souscription non trouvée.");
        }

        const mod_sub = new Mod_sub({
            idSubscription: subscriptionId,
            idModule: moduleId
        });

        await mod_sub.save();

        res.status(201).send({ mod_sub });


    } catch (e) {
        res.status(500).send(e);
    }
});


// READ MODULES ON SUBSCRIPTION BY ID BY SUPER_ADMIN
router.get('/mod_sub/id_sub', authentification, async (req, res) => {
    try {
        if (req.user.role !== 'super_admin') {
            return res.status(403).send("Accès interdit - Réservé aux super admins");
        }

        const subscriptionId = req.body.subscriptionId;

        const subscription = await Subscription.findById(subscriptionId);

        if (!subscription) {
            return res.status(404).send("Souscription non trouvée.");
        }

        const modules_sub = await Mod_sub.find({ idSubscription: subscriptionId });
        const idmodules = [];
        modules_sub.forEach(function(record){
           idmodules.push(record.idModule);
        });
        const modules = await Module.find({'_id':{$in:idmodules}})
   
        res.send(modules);
    } catch (e) {
        res.status(500).send(e);
    }
});


// READ SUBSCRIPTION BY ID MODULE
router.get('/mod_sub/id_mod', authentification, async (req, res) => {
    try {
        const moduleId = req.body.moduleId;

        const module = await Module.findById(moduleId);

        if (!module) {
            return res.status(404).send("module non trouvée.");
        }

        const modules_sub = await Mod_sub.find({ idModule: moduleId });
        const idSubscriptions = [];
        modules_sub.forEach(function(record){
            idSubscriptions.push(record.idSubscription);
        });
        const subscriptions = await Subscription.find({'_id':{$in:idSubscriptions}})
   
        res.send(subscriptions);
    } catch (e) {
        res.status(500).send(e);
    }
});
module.exports = router;