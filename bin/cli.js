#!/usr/bin/env node
const { execFileSync } = require('child_process');
const path = require('path');

const args = process.argv.slice(2);
if (args.includes('--help') || args.includes('-h')) {
  console.log(`Gaslight My AI\n\nUsage:\n  npx gaslight-my-ai            Install into the current directory\n  npx gaslight-my-ai <dir>      Install into a specific project directory\n  npx gaslight-my-ai --help     Show this help\n`);
  process.exit(0);
}

const dir = args[0] || '.';
const installSh = path.join(__dirname, '..', 'install.sh');

try {
  execFileSync('bash', [installSh, dir], { stdio: 'inherit' });
} catch (error) {
  console.error('\n[gaslight] install failed');
  console.error('[gaslight] try: npx gaslight-my-ai <project-dir>');
  process.exit(error.status || 1);
}
