import { Command } from "commander"
import { deployDigitalOceanAction } from "./deployDigitalOceanAction"

export const addDeployCommand = (program: Command) => {
  program
    .command('deploy')
    .description('deploy code-server to Digital Ocean')
    .action(deployDigitalOceanAction)
}

