const path = require('path');
const exGateway = require('express-gateway');

exGateway()
  .load(path.join(__dirname, 'config'))
  .run();
