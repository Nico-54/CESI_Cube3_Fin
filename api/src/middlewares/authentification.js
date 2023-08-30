const jwt = require ('jsonwebtoken')
const User = require('../models/user');

// Funtion authentification - check token
const authentification = async(req, res, next) => {
    try {
        const authToken = req.header('Authorization').replace('Bearer ', '');
        const decodedToken = jwt.verify(authToken, 'secret');
        const user = await User.findOne({ _id: decodedToken._id, 'authTokens.authToken': authToken});

        if (!user) throw new Error();

        // Storage info user and token
        req.user = user;
        req.authToken = authToken;

        next();
    } catch (e) {
        res.status(401).send('Merci de vous authentifier');
    }
} 


module.exports = authentification;