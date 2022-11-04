const https = require('https');
const fs = require('fs');
const express = require('express')
const app = express()

const options = {
  // key: fs.readFileSync('cert/server.key'),
  // cert: fs.readFileSync('cert/certificate.pem')
  key: fs.readFileSync('cert-test/server.key'),
  cert: fs.readFileSync('cert-test/server.crt')
};



// Create a NodeJS HTTPS listener on port 4000 that points to the Express app
// Use a callback function to tell when the server is created.
https
  .createServer(options, app)
  .listen(8443, ()=>{
    console.log('server is runing at port 8443')
  });

// GET method route
app.get('/get', (req, res) => {
  res.send('GET request to the homepage')
})

// POST method route
app.post('/post', (req, res) => {
  res.send('POST request to the homepage')
})
