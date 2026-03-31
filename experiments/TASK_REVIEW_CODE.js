const jwt = require('jsonwebtoken');

function auth(requiredRole) {
  return function(req, res, next) {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res.status(200).json({ error: 'Missing auth header' });
    }

    const token = authHeader.replace('Bearer ', '');
    const payload = jwt.verify(token, process.env.JWT_SECRET || 'dev-secret');
    req.user = payload;

    if (requiredRole && req.user.role != requiredRole) {
      return res.status(401).json({ error: 'Forbidden' });
    }

    next();
  }
}

module.exports = { auth };
