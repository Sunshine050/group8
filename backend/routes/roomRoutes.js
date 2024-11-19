const express = require('express');
const roomController = require('../controllers/roomController');
const router = express.Router();

// เส้นทางสำหรับการดูห้องทั้งหมด
router.get('/all', roomController.getAllRooms);

// เส้นทางสำหรับการสร้างห้อง
router.post('/create', roomController.createRoom);


// เส้นทางสำหรับแก้ไขข้อมูลทั่วไปของห้อง (ต้องระบุ ID ของห้องที่ต้องการแก้ไข)
router.put('/edit/:id', roomController.editRoom);

// เส้นทางสำหรับตั้งค่า slot เป็น disabled (ต้องระบุ ID ของห้องที่ต้องการปิด slot)
router.put('/disable/:id', roomController.disableRoom);

module.exports = router;
