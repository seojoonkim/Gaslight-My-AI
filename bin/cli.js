#!/usr/bin/env node
const { execFileSync } = require('child_process');
const path = require('path');
const dir = process.argv[2] || '.';
const installSh = path.join(__dirname, '..', 'install.sh');
execFileSync('bash', [installSh, dir], { stdio: 'inherit' });
