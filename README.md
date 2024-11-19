ติดตั้งตามนี้ก่อนถึงจะเริ่มใช้งานได้

1) npm init -y
2) npm install
3) npm install --save-dev nodemon
4) npm install bcrypt body-parser dotenv express jsonwebtoken mysql2
5) ก๊อปปี้ script นี้ไปแทนที่ script ใน package.json
"scripts": {
    "test": "node server.js",
    "dev": "nodemon server.js"
  },
6) npm run dev


ลิงค์ postman รวม api ทั้งหมดที่ต้องใช้
https://app.getpostman.com/join-team?invite_code=b56024ebfae5db5ad39878663ec302a9&target_code=920bb7c544e66f86fdaeee936e5dcc76
