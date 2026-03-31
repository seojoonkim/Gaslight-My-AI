#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# 🕯️ Gaslight My AI — 5-Minute Demo
# ═══════════════════════════════════════════════════════════════
#
# This demo shows the difference between:
#   1. Asking an LLM to "review this code" (baseline)
#   2. Asking an LLM to "review this code written by a rival" (gaslight mode)
#
# You'll see the gaslight version finds significantly more issues.
#
# Usage:
#   ./examples/demo.sh
# ═══════════════════════════════════════════════════════════════

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GASLIGHT_SH="$SCRIPT_DIR/../gaslight.sh"

echo "🕯️ Gaslight My AI Demo"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Sample code with intentional issues (but they look reasonable at first glance)
SAMPLE_CODE='
import express from "express";
import { db } from "./database";

const app = express();
app.use(express.json());

// User authentication endpoint
app.post("/api/login", async (req, res) => {
  const { username, password } = req.body;
  const user = await db.query(
    `SELECT * FROM users WHERE username = "${username}" AND password = "${password}"`
  );
  if (user.length > 0) {
    const token = Buffer.from(username + ":" + Date.now()).toString("base64");
    res.json({ token, user: user[0] });
  } else {
    res.status(401).json({ error: "Invalid credentials" });
  }
});

// Get user profile
app.get("/api/user/:id", async (req, res) => {
  const user = await db.query(`SELECT * FROM users WHERE id = ${req.params.id}`);
  res.json(user[0]);
});

// Update user
app.put("/api/user/:id", async (req, res) => {
  const updates = req.body;
  await db.query(`UPDATE users SET ${Object.entries(updates).map(([k,v]) => `${k}="${v}"`).join(",")} WHERE id = ${req.params.id}`);
  res.json({ success: true });
});

app.listen(3000);
'

echo "📝 Sample code (an Express.js auth API with subtle issues):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "$SAMPLE_CODE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "════════════════════════════════════════════════"
echo "  TEST 1: Baseline Review (no gaslight)"
echo "════════════════════════════════════════════════"
echo ""
echo "Prompt: 'Review this code for issues.'"
echo ""
echo "→ Copy this prompt + the code above into Claude/GPT."
echo "  Count how many issues it finds."
echo ""

echo "════════════════════════════════════════════════"
echo "  TEST 2: Gaslight Review"
echo "════════════════════════════════════════════════"
echo ""
echo "Now use the gaslight prompt instead:"
echo ""
"$GASLIGHT_SH" review "$SAMPLE_CODE"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "→ Copy the gaslight prompt + code into the SAME model."
echo "  Count how many issues it finds this time."
echo ""
echo "Expected results:"
echo "  Baseline:  2-4 issues (usually just SQL injection)"
echo "  Gaslight:   8-12 issues (SQL injection, auth flaws,"
echo "             missing validation, no rate limiting,"
echo "             password in plaintext, token weakness,"
echo "             no error handling, mass assignment, etc.)"
echo ""
echo "Same model. Same code. The only difference: the gaslight prompt."
echo ""
echo "🕯️ That's Gaslight My AI. Same model. Different delusions. Better code."
