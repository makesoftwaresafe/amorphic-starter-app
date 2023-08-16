const session = require('express-session');
const RedisStore = require('connect-redis')(session);
const options = process.env.REDIS_URL !== undefined ? {url: process.env.REDIS_URL} : {};
const sessionStore = new RedisStore(options);
console.log('Waiting for redis to start up amorphic...');
sessionStore.on('connect', function() {
  require('amorphic').listen(__dirname, sessionStore);
});
