const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

//----------------------------------------------------------------------------------------------------//

const authController = {
  login: async (req, res) => {
    const { username, password } = req.body;

    try {
      const user = await User.getByUsername(username);
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }

      const isPasswordValid = await bcrypt.compare(password, user.password);
      if (!isPasswordValid) {
        return res.status(401).json({ message: 'Invalid credentials' });
      }

      const token = jwt.sign(
        { id: user.id, role: user.role },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      res.json({ token, role: user.role });
    } catch (err) {
      res.status(500).json({ message: 'Internal server error', error: err.message });
    }
  },

  //-------------------------------------------------------------------------------------------//

  register: async (req, res) => {
    const { username, email, password } = req.body;
  
    console.log('Request Body:', req.body); // ตรวจสอบว่ามีค่า username หรือไม่
  
    try {
      const hashedPassword = await bcrypt.hash(password, 10);
      await User.create({ username, email, password: hashedPassword });
  
      res.status(201).json({ message: 'User registered successfully' });
    } catch (err) {
      res.status(500).json({ message: 'Internal server error', error: err.message });
    }
},
  

  //-------------------------------------------------------------------------------------------//

  getAll: async (req, res) => {
    try {
      const users = await User.getAll(); // เรียกใช้ฟังก์ชัน getAll
      console.log('Users:', users); // ตรวจสอบข้อมูลที่ได้
      res.json(users); // ส่งผลลัพธ์เป็น JSON
    } catch (err) {
      console.error('Error fetching users:', err); // แสดงข้อผิดพลาด
      res.status(500).json({ message: 'Internal server error', error: err.message });
    }
  },
};

//----------------------------------------------------------------------------------------------------//

module.exports = authController;
