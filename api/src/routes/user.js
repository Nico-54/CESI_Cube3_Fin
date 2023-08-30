const express = require('express');
const User = require('../models/user');
const Company = require('../models/company');
const authentification = require('../middlewares/authentification');
const router = new express.Router();




// CREATE USER
router.post('/users', async (req, res) => {
    try {
        const user = new User(req.body);

        user.role = 'utilisateur';

        user.userCreated = new Date();

        let company = await Company.findOne({ companyName: req.body.companyName });

        if (!company) {
            return res.status(400).send("L'entreprise spécifiée n'est pas valide.");

        }

        user.idCompany = company._id;
        const authToken = await user.generateAuthTokenAndSaveUser();

        res.status(201).send({ user, authToken });
    } catch (e) {
        res.status(400).send(e);
    }
});


// LOGIN USER
router.post('/users/login', async (req, res) => {
    try {
        const user = await User.findUser(req.body.email, req.body.pwd);
        const authToken = await user.generateAuthTokenAndSaveUser();
        res.send({ user, authToken });
    } catch(e) {
        res.status(400).send(e);
    }
});


// LOGOUT USER
router.post('/users/logout', authentification, async (req, res) => {
    try {
        // take all token and filter authToken in use
        req.user.authTokens = req.user.authTokens.filter((authToken) => {
            return authToken.authToken !== req.authToken;
        });

        await req.user.save();
        res.send();
    } catch(e) {
        res.status(500).send(e);
    }
});


// LOGOUT ALL - SUPP ALL TOKEN - BY SUPER_ADMIN
router.post('/users/logout/all', authentification, async (req, res) => {
    try {
        if (req.user.role !== 'super_admin') {
            return res.status(403).send("Accès interdit - Réservé aux super admins");
        }
        req.user.authTokens = [];
        await req.user.save();
        res.send();
    } catch(e) {
        res.status(500).send(e);
    }
});


// READ INFO ABOUT CURRENT USER
router.get('/users/me', authentification, async (req, res) => {
    try {
        // convert to JSON Object
        const user = req.user.toObject();
        const companyId = user.idCompany;

        if (companyId) {
            const company = await Company.findById(companyId);
            if (company) {
                user.companyName = company.companyName;
            }
        }

            res.send({
                user: req.user,
                role: user.role,
                companyName: user.companyName || null
        });
    } catch (e) {
        res.status(500).send(e)
    }
});

// READ INFO ALL USER BY SUPER_ADMIN
router.get('/users', authentification, async (req, res) => {
    try {
        if (req.user.role !== 'super_admin') {
            return res.status(403).send("Accès interdit - Réservé aux super admins");
        }

        const users = await User.find();
        res.send(users);
    } catch (e) {
        res.status(500).send(e);
    }
});


// UPDATE USER
router.patch('/users/me', authentification, async(req, res) => {
    const updateInfo = Object.keys(req.body);
    try {
        updateInfo.forEach(update => req.user[update] = req.body[update]);
        req.user.userModified = new Date();
        req.user.modifiedBy = `${req.user.firstName} ${req.user.lastName}`;
        await req.user.save();
        res.send(req.user);
    } catch (e) {
        res.status(500).send(e)
    }
});


// DELETE USER
router.delete('/users/me', authentification, async(req, res) => {
    try {
        req.user.userDeleted = new Date();
        await req.user.remove();
        res.send(req.user);
    } catch (e) {
        res.status(500).send(e)
    }
});



module.exports = router;