const express = require('express');
const router = express.Router();
const bookingController = require('../controllers/bookingController');

// Route สำหรับการสร้างการจองใหม่
router.post('/bookings', bookingController.requestBooking);

router.get('booking/:user_id', bookingController.viewBookings);

// Route สำหรับการอนุมัติหรือปฏิเสธการจอง
router.put('/bookings/approve', bookingController.approveBooking);

module.exports = router;
