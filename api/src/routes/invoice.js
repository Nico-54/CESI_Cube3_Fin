const express = require('express');
const Invoice = require('../models/invoice');
const Subscription = require('../models/subscription');
const router = new express.Router();
const authentification = require('../middlewares/authentification');
const Formula = require('../models/formula');



//CREATE INVOICE
router.post('/invoice', authentification, async (req, res) => {
    
    const invoice = new Invoice(req.body);
    invoice.dateInvoice = new Date();

    const subscription = await Subscription.find({ idSubscription: req.body.idSubscription});
    const formula = await Formula.findOne({idFormula:subscription.idFormula});
  
    invoice.catPrice = formula.recurringPrice;
    invoice.invoiceVAT = 20;
    invoice.htPrice = formula.recurringPrice;
    invoice.ttcPrice = invoice.htPrice + (invoice.htPrice * (invoice.invoiceVAT / 100));
    invoice.idCompany = req.body.idCompany;
    invoice.idSubscription = subscription.idSubscription;

    try {
       
        await invoice.save();

        res.status(201).send(invoice);
    } catch (e) {
        res.status(400).send(e);
    }
});



//READ INVOICE BY ID 
router.get('/invoice/id', authentification, async (req, res) => {
    try {
        const invoiceId = req.body.idInvoice; 
        const invoice = await Invoice.findById(invoiceId);

        if (!invoice) {
            return res.status(404).send("Aucune facture trouvée pour cet ID.");
        }

        res.send(invoice);
    } catch (e) {
        res.status(500).send(e);
    }
});


//READ LAST INVOICE FOR COMPANY
router.get('/invoice/last', authentification, async (req, res) => {
    try {
        const companyId = req.body.idCompany;
        
        const subscription = await Subscription.find({ idSubscription: req.body.idSubscription});
        const formula = await Formula.find({idFormula:subscription.idFormula});

        const invoices = await Invoice.find({ idSubscription: subscription.subscriptionId,idCompany:companyId}).sort({dateInvoice:-1}).limit(1);

        res.status(200).send({ invoices });
    } catch (e) {
        res.status(500).send(e);
    }
});


//READ ALL INVOICE CURRENT COMPANY
router.get('/invoice/allcurrentcompany', authentification, async (req, res) => {
    try {
        const companyId = req.body.idCompany;
        
        const subscription = await Subscription.find({ idSubscription: req.body.idSubscription});
        const formula = await Formula.find({idFormula:subscription.idFormula});

        const invoices = await Invoice.find({ idSubscription: subscription.subscriptionId,idCompany:companyId});

        res.status(200).send({ invoices });
    } catch (e) {
        res.status(500).send(e);
    }
});


//READ ALL UNVOICE BY SUPER_ADMIN
router.get('/invoice/all', authentification, async (req, res) => {
    try {
        if (req.user.role !== 'super_admin') {
            return res.status(403).send("Accès interdit - Réservé aux super admins");
        }

        const invoices = await Invoice.find();

        res.status(200).send({ invoices });
    } catch (e) {
        res.status(500).send(e);
    }
});


module.exports = router;