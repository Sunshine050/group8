const Room = require('../models/Room');
const Booking = require('../models/Booking');
const db = require('../config/database');

const roomController = {
    // การดึงข้อมูลห้องทั้งหมด
    getAllRooms: async (req, res) => {
        try {
            const rooms = await Room.getAll(); // ใช้ getAll() สำหรับดึงข้อมูลห้องทั้งหมด
            res.json(rooms);
        } catch (err) {
            console.error('Error retrieving rooms:', err);
            res.status(500).json({ message: 'Failed to retrieve rooms', error: err.message });
        }
    },

    //----------------------------------------------------------------------------------------------------//

    // การสร้างห้องใหม่
    createRoom: async (req, res) => {
        const { roomName, description, slot_1, slot_2, slot_3, slot_4 } = req.body;

        try {
            // ตรวจสอบค่าที่รับมาจาก request
            console.log({
                room_name: roomName,
                description: description,
                slot_1: slot_1 || "free",
                slot_2: slot_2 || "free",
                slot_3: slot_3 || "free",
                slot_4: slot_4 || "free"
            });

            // ใช้ "free" เป็นค่าเริ่มต้นถ้าไม่ระบุค่า status ของแต่ละ slot
            const room = await Room.create({
                room_name: roomName,
                description: description, // ใช้ description จาก request
                slot_1: slot_1 || "free", // ถ้าไม่ได้ส่งค่ามาให้ใช้ 'free'
                slot_2: slot_2 || "free",
                slot_3: slot_3 || "free",
                slot_4: slot_4 || "free"
            });

            // ตรวจสอบค่าผลลัพธ์จากการสร้างห้อง
            console.log('Room created:', room);

            // ดึงข้อมูลห้องที่เพิ่งถูกสร้าง
            const newRoom = await Room.getById(room.insertId);  // ใช้ insertId เพื่อดึงข้อมูลห้องที่สร้างใหม่
            console.log('New room details:', newRoom);

            // ส่งผลลัพธ์แค่ข้อมูลที่ต้องการ
            res.status(201).json({
                message: 'Room created successfully',
                id: newRoom.id,
                slot_1: newRoom.slot_1,
                slot_2: newRoom.slot_2,
                slot_3: newRoom.slot_3,
                slot_4: newRoom.slot_4
            });
        } catch (err) {
            console.error('Error creating room:', err);
            res.status(500).json({ message: 'Failed to create room', error: err.message });
        }
    },
    //----------------------------------------------------------------------------------------------------//


    // การแก้ไขข้อมูลห้องทั่วไป
    editRoom: async (req, res) => {
        const { id, room_name, description } = req.body;

        try {
            if (!id || !room_name || !description) {
                return res.status(400).json({ message: 'Invalid input' });
            }

            await Room.edit(id, { room_name: room_name, description });
            res.json({ message: 'Room details updated successfully' });
        } catch (err) {
            console.error('Error updating room details:', err);
            res.status(500).json({ message: 'Failed to update room details', error: err.message });
        }
    },

    //----------------------------------------------------------------------------------------------------//

    // การอัปเดตสถานะห้อง (disable)
    disableRoom: async (req, res) => {
        const { id } = req.params;
        const { slot_1, slot_2, slot_3, slot_4 } = req.body;

        try {
            if (!id || (!slot_1 && !slot_2 && !slot_3 && !slot_4)) {
                return res.status(400).json({ message: 'Invalid input' });
            }

            await Room.updateSlot(id, { slot_1, slot_2, slot_3, slot_4 });
            res.json({ message: 'Room slots updated to disabled successfully' });
        } catch (err) {
            console.error('Error disabling room slots:', err);
            res.status(500).json({ message: 'Failed to disable room slots', error: err.message });
        }
    },
}
    //----------------------------------------------------------------------------------------------------//

    
module.exports = roomController;
