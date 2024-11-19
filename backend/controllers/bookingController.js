const Booking = require('../models/Booking');
const Room = require('../models/Room');
const db = require('../config/database');

// การสร้างการจองใหม่
const bookingController = {
  requestBooking: async (req, res) => {
    const { roomId, slot, reason, user_id } = req.body;

    try {
      if (!roomId || !slot || !reason || !user_id) {
        return res.status(400).json({ message: 'Invalid input. Room ID, slot, reason, and user_id are required.' });
      }

      // ตรวจสอบว่า slot ที่เลือกว่างหรือไม่
      db.query(
        'SELECT * FROM rooms WHERE id = ? AND ?? = "free"', // ใช้ ?? แทนการแทรกชื่อฟิลด์เพื่อป้องกันการโจมตี SQL Injection
        [roomId, slot], 
        (err, result) => {
          if (err) {
            return res.status(500).json({ message: 'Error checking slot availability', error: err.message });
          }

          if (result.length === 0) {
            return res.status(400).json({ message: 'Room slot is not available for booking' });
          }

          // สร้างการจองใหม่
          db.query(
            'INSERT INTO bookings (user_id, room_id, slot, status, reason) VALUES (?, ?, ?, "pending", ?)',
            [user_id, roomId, slot, reason], 
            (err, result) => {
              if (err) {
                return res.status(500).json({ message: 'Failed to create booking request', error: err.message });
              }

              // อัปเดตสถานะ slot เป็น 'pending'
              db.query(
                'UPDATE rooms SET ?? = "pending" WHERE id = ?',
                [slot, roomId], 
                (err, result) => {
                  if (err) {
                    return res.status(500).json({ message: 'Failed to update room slot status', error: err.message });
                  }

                  return res.status(201).json({ message: 'Booking request submitted successfully' });
                }
              );
            }
          );
        }
      );
    } catch (err) {
      res.status(500).json({ message: 'Failed to create booking request', error: err.message });
    }
  },

  // ฟังก์ชัน approveBooking
  approveBooking: async (req, res) => {
    const { bookingId, status } = req.body;

    try {
      const booking = await Booking.findByPk(bookingId);
      if (!booking) {
        return res.status(404).json({ message: 'Booking not found' });
      }

      const slot = booking.slot; // ใช้ค่า slot ที่จองจากข้อมูลในฐานข้อมูล
      const slotField = `slot_${slot}`; // สร้างชื่อ field ของ slot ที่ถูกจอง

      if (status === 'approved') {
        await Room.update({ [slotField]: 'reserved' }, { where: { id: booking.room_id } });
      } else if (status === 'rejected') {
        await Room.update({ [slotField]: 'free' }, { where: { id: booking.room_id } });
      }

      await Booking.update({ status }, { where: { id: bookingId } });

      res.json({ message: 'Booking status updated successfully' });
    } catch (err) {
      res.status(500).json({ message: 'Failed to update booking status', error: err.message });
    }
  },

  // ฟังก์ชันสำหรับดูสถานะการจองของผู้ใช้
  viewBookings: async (req, res) => {
    const { user_id } = req.params;  // รับ user_id จาก URL params
  
    try {
      // ดึงรายการการจองทั้งหมดของผู้ใช้จากฐานข้อมูล
      const bookings = await Booking.getByUserId(user_id);
  
      if (bookings.length === 0) {
        return res.status(404).json({ message: 'No bookings found for this user' });
      }
  
      return res.json({ bookings });
    } catch (err) {
      res.status(500).json({ message: 'Failed to retrieve bookings', error: err.message });
    }
  }
};

module.exports = bookingController;
