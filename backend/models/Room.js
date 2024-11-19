const db = require('../config/database');

const Room = {
    // ดึงข้อมูลห้องทั้งหมด
    getAll: () => {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM rooms', (err, results) => {
                if (err) return reject(err);
                resolve(results);
            });
        });
    },

    // ดึงข้อมูลห้องตาม ID
    getById: (id) => {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM rooms WHERE id = ?', [id], (err, results) => {
                if (err) return reject(err);
                resolve(results[0]);  // คืนค่าห้องที่มี id ที่ตรงกับที่ดึงมา
            });
        });
    },

    // สร้างห้องใหม่
    create: ({ room_name, description, slot_1, slot_2, slot_3, slot_4 }) => {
        return new Promise((resolve, reject) => {
            db.query(
                'INSERT INTO rooms (room_name, description, slot_1, slot_2, slot_3, slot_4) VALUES (?, ?, ?, ?, ?, ?)',
                [room_name, description, slot_1, slot_2, slot_3, slot_4],
                (err, results) => {
                    if (err) return reject(err);
                    resolve(results);
                }
            );
        });
    },

    // แก้ไขข้อมูลห้อง (รวมถึงการอัปเดต slot)
    edit: (id, { room_name, description, slot_1, slot_2, slot_3, slot_4 }) => {
        return new Promise((resolve, reject) => {
            db.query(
                'UPDATE rooms SET room_name = ?, description = ?, slot_1 = ?, slot_2 = ?, slot_3 = ?, slot_4 = ? WHERE id = ?',
                [room_name, description, slot_1, slot_2, slot_3, slot_4, id],
                (err, results) => {
                    if (err) return reject(err);
                    resolve(results);
                }
            );
        });
    },

    // อัปเดต slot ของห้อง
    updateSlot: (id, slots) => {
        return new Promise((resolve, reject) => {
            const updates = [];
            const values = [];

            // ตรวจสอบแต่ละ slot และเพิ่มลงใน query ถ้ามีค่า
            Object.entries(slots).forEach(([key, value]) => {
                if (value !== undefined && value !== null) {
                    updates.push(`${key} = ?`);
                    values.push(value);
                }
            });

            if (updates.length === 0) {
                return reject(new Error('No slots provided for update'));
            }

            values.push(id); // ใส่ id ไว้สุดท้ายสำหรับ WHERE
            const query = `UPDATE rooms SET ${updates.join(', ')} WHERE id = ?`;

            db.query(query, values, (err, results) => {
                if (err) return reject(err);
                resolve(results);
            });
        });
    }
};

module.exports = Room;
