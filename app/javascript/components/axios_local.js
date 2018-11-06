import axios from 'axios';

let hostname;
switch(window.env) {
  case 'production':
  case 'development':
    hostname = 'http://localhost:3000';
    break;
  case 'test':
    hostname = 'http://127.0.0.1:3001';
    break;
};

const instance = axios.create({
  baseURL: hostname
});

export default instance;
