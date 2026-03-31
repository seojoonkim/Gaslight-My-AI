Design and/or review a JWT auth middleware for an Express API.
Requirements:
- Extract Bearer token from Authorization header
- Verify JWT
- Reject expired or invalid tokens
- Attach user id and role to request context
- Support role-based access check for admin routes
- Return appropriate HTTP status codes
- Avoid security footguns and ambiguous behavior
