const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // ใส่รหัสผ่านถ้ามี
  database: 'group8',
});

connection.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err);
    process.exit(1); // ออกจากโปรแกรมหากเชื่อมต่อไม่ได้
  }
  console.log('Connected to the database.');
});



module.exports = connection;
