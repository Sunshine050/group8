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
