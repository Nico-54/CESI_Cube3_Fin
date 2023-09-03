const express = require('express');
const Payment = require('../models/payment');
const router = new express.Router();
const authentification = require('../middlewares/authentification');



//CREATE PAYMENT
router.post('/payment', authentification, async (req, res) => {
    try {
        const { invoiceNumber, paymentDetail, paymentStatus } = req.body;

        const payment = new Payment({
            invoiceNumber,
            paymentDetail,
            paymentStatus
        });

        const newPayment = await payment.save();

        res.status(201).send(newPayment);
    } catch (e) {
        res.status(400).send(e);
    }
});


//READ PAYMENT BY ID 
router.get('/payment/id', authentification, async (req, res) => {
    try {
        const paymentId = req.body.idpayment; 
        const payment = await Payment.findById(paymentId);

        if (!payment) {
            return res.status(404).send("Aucun payement trouvée pour cet ID.");
        }

        res.send(payment);
    } catch (e) {
        res.status(500).send(e);
    }
});


//READ ALL PAYMENT COMPANY
// a modifier !!!!
router.get('/payments/company', authentification, async (req, res) => {
    try {
        const companyId = req.body.companyId;

        const payments = await Payment.find({ companyId });

        res.send(payments);
    } catch (e) {
        res.status(500).send(e);
    }
});


module.exports = router;