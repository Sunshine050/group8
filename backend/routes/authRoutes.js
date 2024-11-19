const express = require('express');
const authController = require('../controllers/authController');
const router = express.Router();
// const { verifyToken } = require('../middleware/authMiddleware');

//----------------------------------------------------------------------------------------------------//

router.post('/login', authController.login);
//----------------------------------------------------------------------------------------------------//

router.post('/register', authController.register);
//----------------------------------------------------------------------------------------------------//

router.get('/users', authController.getAll);
//----------------------------------------------------------------------------------------------------//


module.exports = router;
