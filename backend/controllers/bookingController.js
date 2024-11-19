const mysql = require('mysql2');
const db = require('../config/database'); // เรียกใช้งานการเชื่อมต่อฐานข้อมูล

//----------------------------------------------------------------------------------------------------//

const bookingController = {
    // การสร้างการจองใหม่
    requestBooking: async (req, res) => {
        const { room_Id, slot, reason, user_id } = req.body;

        try {
            if (!room_Id || !slot || !reason || !user_id) {
                return res.status(400).json({ message: 'Invalid input. room_Id, slot, reason, and user_id are required.' });
            }

            // ตรวจสอบว่า slot ที่เลือกว่างหรือไม่
            const [result] = await db.promise().query('SELECT ?? FROM rooms WHERE id = ?', [slot, room_Id]);

            if (result.length === 0 || result[0][slot] !== 'free') {
                return res.status(400).json({ message: 'Room slot is not available for booking' });
            }

            // สร้างการจองใหม่
            await db.promise().query(
                'INSERT INTO bookings (user_id, room_id, slot, status, reason) VALUES (?, ?, ?, "pending", ?)',
                [user_id, room_Id, slot, reason]
            );

            // อัปเดตสถานะ slot เป็น 'pending'
            await db.promise().query(`UPDATE rooms SET ?? = 'pending' WHERE id = ?`, [slot, room_Id]);

            return res.status(201).json({ message: 'Booking request submitted successfully' });

        } catch (err) {
            return res.status(500).json({ message: 'Failed to create booking request', error: err.message });
        }
    },

    //----------------------------------------------------------------------------------------------------//

    // ฟังก์ชันสำหรับ approveBooking
    approveBooking: async (req, res) => {
        const { bookingId, status, approvedBy } = req.body; // รับ approvedBy จาก req.body

        try {
            // ดึงข้อมูลการจองจาก table bookings
            const [bookings] = await db.promise().query('SELECT * FROM bookings WHERE id = ?', [bookingId]);

            if (bookings.length === 0) {
                return res.status(404).json({ message: 'Booking not found' });
            }

            const booking = bookings[0];
            const slot = booking.slot;
            const slotField = slot; // ใช้ค่า slot ที่ได้มาโดยตรงเป็นชื่อฟิลด์

            // อัปเดตสถานะ slot ใน table rooms
            if (status === 'approved') {
                // ตรวจสอบให้แน่ใจว่า slotField มีอยู่ในฐานข้อมูล
                await db.promise().query(`UPDATE rooms SET ?? = 'reserved' WHERE id = ?`, [slotField, booking.room_id]);
            } else if (status === 'rejected') {
                await db.promise().query(`UPDATE rooms SET ?? = 'free' WHERE id = ?`, [slotField, booking.room_id]);
            }

            // อัปเดตสถานะการจองใน table bookings พร้อมกับการบันทึกชื่อผู้อนุมัติหรือปฏิเสธ
            await db.promise().query(
                'UPDATE bookings SET status = ?, approved_by = ? WHERE id = ?',
                [status, approvedBy, bookingId]
            );

            return res.json({ message: 'Booking status updated successfully' });
        } catch (err) {
            return res.status(500).json({ message: 'Failed to update booking status', error: err.message });
        }
    },

    //----------------------------------------------------------------------------------------------------//

    // ฟังก์ชันสำหรับดูสถานะการจองของผู้ใช้
    viewBookings: async (req, res) => {
        const { user_id } = req.params; // รับ user_id จาก URL params

        try {
            // ตรวจสอบว่า user_id ถูกต้องหรือไม่
            if (!user_id) {
                return res.status(400).json({ message: 'User ID is required' });
            }

            // ดึงรายการการจองทั้งหมดของผู้ใช้จากฐานข้อมูล
            const [bookings] = await db.promise().query('SELECT * FROM bookings WHERE user_id = ?', [user_id]);

            // ตรวจสอบว่าพบข้อมูลการจองหรือไม่
            if (bookings.length === 0) {
                return res.status(404).json({ message: 'No bookings found for this user' });
            }

            // คืนค่ารายการการจอง
            return res.json({ bookings });
        } catch (err) {
            // ส่งข้อความแจ้งข้อผิดพลาด
            return res.status(500).json({ message: 'Failed to retrieve bookings', error: err.message });
        }
    },

    //----------------------------------------------------------------------------------------------------//

    // ฟังก์ชันสำหรับดึงรายการการจองที่มีสถานะ 'pending'
    getPendingBookings: async (req, res) => {
        try {
            // ดึงข้อมูลการจองที่มีสถานะ 'pending'
            const [pendingBookings] = await db.promise().query(
                'SELECT * FROM bookings WHERE status = "pending"'
            );

            // ตรวจสอบว่าพบการจองที่มีสถานะ pending หรือไม่
            if (pendingBookings.length === 0) {
                return res.status(404).json({ message: 'No pending bookings found' });
            }

            // คืนค่ารายการการจองที่มีสถานะ pending
            return res.json({ pendingBookings });
        } catch (err) {
            // ส่งข้อความแจ้งข้อผิดพลาด
            return res.status(500).json({ message: 'Failed to retrieve pending bookings', error: err.message });
        }
    },

    //----------------------------------------------------------------------------------------------------//

    // ฟังก์ชันสำหรับดึงประวัติการอนุมัติ/ปฏิเสธ
    getBookingHistory: async (req, res) => {
        try {
            // ดึงประวัติการอนุมัติ/ปฏิเสธจาก table bookings
            const [history] = await db.promise().query(
                'SELECT id, user_id, room_id, slot, status, approved_by, reason FROM bookings WHERE status IN ("approved", "rejected") ORDER BY id DESC'
            );

            // ตรวจสอบว่าพบประวัติการอนุมัติ/ปฏิเสธหรือไม่
            if (history.length === 0) {
                return res.status(404).json({ message: 'No approval/rejection history found' });
            }

            // คืนค่าประวัติการอนุมัติ/ปฏิเสธ
            return res.json({ history });
        } catch (err) {
            return res.status(500).json({ message: 'Failed to retrieve approval/rejection history', error: err.message });
        }
    }
};

//----------------------------------------------------------------------------------------------------//

module.exports = bookingController;
