const db = require('../config/database');

//----------------------------------------------------------------------------------------------------//

const Booking = {
  create: ({ userId, roomId, reason }) => {
    return new Promise((resolve, reject) => {
      db.query(
        'INSERT INTO bookings (user_id, room_id, status, reason) VALUES (?, ?, ?, ?)',
        [userId, roomId, 'pending', reason],
        (err, results) => {
          if (err) return reject(err);
          resolve(results);
        }
      );
    });
  },

  //----------------------------------------------------------------------------------------------------//

  updateStatus: (id, status) => {
    return new Promise((resolve, reject) => {
      db.query('UPDATE bookings SET status = ? WHERE id = ?', [status, id], (err, results) => {
        if (err) return reject(err);
        resolve(results);
      });
    });
  },

  //----------------------------------------------------------------------------------------------------//

  getById: (id) => {
    return new Promise((resolve, reject) => {
      db.query('SELECT * FROM bookings WHERE id = ?', [id], (err, results) => {
        if (err) return reject(err);
        resolve(results[0]);
      });
    });
  },

  //----------------------------------------------------------------------------------------------------//

  getByUserId: (userId) => {
    return new Promise((resolve, reject) => {
      db.query('SELECT * FROM bookings WHERE user_id = ?', [userId], (err, results) => {
        if (err) return reject(err);
        resolve(results);
      });
    });
  },

  //----------------------------------------------------------------------------------------------------//

  findAll: (conditions) => {
    return new Promise((resolve, reject) => {
      const query = 'SELECT * FROM bookings WHERE room_id = ? AND booking_date = ? AND slot = ?';
      const { room_id, booking_date, slot } = conditions;
      db.query(query, [room_id, booking_date, slot], (err, results) => {
        if (err) return reject(err);
        resolve(results);
      });
    });
  }
};

//----------------------------------------------------------------------------------------------------//

module.exports = Booking;
