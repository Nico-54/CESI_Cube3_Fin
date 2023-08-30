const express = require('express');
const Company = require('../models/company');
const router = new express.Router();
const authentification = require('../middlewares/authentification');

// CREATE COMPANY
router.post('/companies', async (req, res) => {
    const company = new Company(req.body);
    company.registrationDate = new Date();
    try {
        await company.save();
        res.status(201).send(company);
    } catch (e) {
        res.status(400).send(e);
    }
});


// READ ALL COMPANY BY SUPER_ADMIN
router.get('/companies', authentification, async (req, res) => {
    try {
        if (req.user.role !== 'super_admin') {
            return res.status(403).send("Accès interdit - Réservé aux super admins");
        }

        const companies = await Company.find();
        res.send(companies);
    } catch (e) {
        res.status(500).send(e);
    }
});



//READ COMPANY BY CURRENT USER
router.get('/companies/me', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;

        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const company = await Company.findById(companyId);
        if (!company) {
            return res.status(404).send("Entreprise introuvable.");
        }

        res.send(company);
    } catch (e) {
        res.status(500).send(e);
    }
});


//UPDATE COMPANY BY CURRENT USER'S COMPANY
router.patch('/companies', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;

        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }
        const company = await Company.findById(companyId);
        if (!company) {
            return res.status(404).send("Entreprise introuvable.");
        }

        const updateInfo = Object.keys(req.body);
        updateInfo.forEach(update => company[update] = req.body[update]);
        company.updateDate =new Date();
        company.updateBy = `${req.user.firstName} ${req.user.lastName}`;
        await company.save();
        
        res.send(company);
    } catch (e) {
        res.status(500).send(e);
    }
});


// DELETE COMPANY BY CURRENT USER'S COMPANY
router.delete('/companies', authentification, async (req, res) => {
    try {
        const companyId = req.user.idCompany;

        if (!companyId) {
            return res.status(404).send("Aucune entreprise associée à l'utilisateur.");
        }

        const company = await Company.findById(companyId);
        if (!company) {
            return res.status(404).send("Entreprise introuvable.");
        }

        await company.remove();
        res.send(company);
    } catch (e) {
        res.status(500).send(e);
    }
});

module.exports = router;