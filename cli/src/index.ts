#!/usr/bin/env node

import { program } from 'commander'
import { addDeployCommand } from './commands/deploy/addDeployCommand';

const main = async () => {
  program.version('0.0.1')
  addDeployCommand(program)
  await program.parseAsync(process.argv);
}

main();
