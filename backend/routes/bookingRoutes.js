const express = require('express');
const router = express.Router();
const bookingController = require('../controllers/bookingController');

//----------------------------------------------------------------------------------------------------//

// Route สำหรับการสร้างการจองใหม่
router.post('/request-student', bookingController.requestBooking);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับการดูสถานะการจองของผู้ใช้
router.get('/booking/:user_id', bookingController.viewBookings);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับการอนุมัติหรือปฏิเสธการจอง
router.put('/approve', bookingController.approveBooking);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับดึงการจองที่มีสถานะ pending
router.get('/pending-bookings', bookingController.getPendingBookings);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับดึงประวัติการอนุมัติ/ปฏิเสธการจอง
router.get('/booking-history', bookingController.getBookingHistory);

//----------------------------------------------------------------------------------------------------//

module.exports = router;
