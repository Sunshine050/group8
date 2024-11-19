const express = require('express');
const router = express.Router();
const bookingController = require('../controllers/bookingController');
const { verifyToken } = require('../middleware/authMiddleware');
//----------------------------------------------------------------------------------------------------//

// Route สำหรับการสร้างการจองใหม่
router.post('/request-student',verifyToken, bookingController.requestBooking);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับการดูสถานะการจองของผู้ใช้
router.get('/booking/:user_id',verifyToken, bookingController.viewBookings);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับการอนุมัติหรือปฏิเสธการจอง
router.put('/approve', verifyToken,bookingController.approveBooking);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับดึงการจองที่มีสถานะ pending
router.get('/pending-bookings', verifyToken,bookingController.getPendingBookings);

//----------------------------------------------------------------------------------------------------//

// Route สำหรับดึงประวัติการอนุมัติ/ปฏิเสธการจอง
router.get('/booking-history',verifyToken, bookingController.getBookingHistory);

//----------------------------------------------------------------------------------------------------//

module.exports = router;
