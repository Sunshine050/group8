const db = require('../config/database');

//----------------------------------------------------------------------------------------------------//

const User = {
    getAll: () => {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM users', (err, results) => {
                if (err) {
                    console.error('Database error:', err); // แสดงข้อผิดพลาด
                    return reject(err);
                }
                console.log('Fetched users:', results); // แสดงผลลัพธ์ที่ได้
                resolve(results);
            });
        });
    },

    //----------------------------------------------------------------------------------------------------//


    getByUsername: (username) => {
        return new Promise((resolve, reject) => {
            db.query('SELECT * FROM users WHERE username = ?', [username], (err, results) => {
                if (err) return reject(err);
                resolve(results[0]); // Return user object
            });
        });
    },

    //----------------------------------------------------------------------------------------------------//

    create: (userData) => {
        const { username, email, password } = userData;
        return new Promise((resolve, reject) => {
            db.query(
                'INSERT INTO users (username, email, password ) VALUES (?, ?, ?)',
                [username, email, password],
                (err, results) => {
                    if (err) return reject(err);
                    resolve(results);
                }
            );
        });
    },
};

//----------------------------------------------------------------------------------------------------//

module.exports = User;
