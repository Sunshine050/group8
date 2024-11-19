const express = require('express');
const roomController = require('../controllers/roomController');
const router = express.Router();
const { verifyToken } = require('../middleware/authMiddleware.js');

//----------------------------------------------------------------------------------------------------//

// เส้นทางสำหรับการดูห้องทั้งหมด
router.get('/all',verifyToken, roomController.getAllRooms);

//----------------------------------------------------------------------------------------------------//

// เส้นทางสำหรับการสร้างห้อง
router.post('/create',verifyToken, roomController.createRoom);

//----------------------------------------------------------------------------------------------------//

// เส้นทางสำหรับแก้ไขข้อมูลทั่วไปของห้อง (ต้องระบุ ID ของห้องที่ต้องการแก้ไข)
router.put('/edit/:id',verifyToken, roomController.editRoom);

//----------------------------------------------------------------------------------------------------//

// เส้นทางสำหรับตั้งค่า slot เป็น disabled (ต้องระบุ ID ของห้องที่ต้องการปิด slot)
router.put('/disable/:id',verifyToken, roomController.disableRoom);

//----------------------------------------------------------------------------------------------------//

module.exports = router;
