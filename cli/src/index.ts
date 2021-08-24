#!/usr/bin/env node

import { program } from "commander";
import { deployDigitalOcean } from "./deploys/deployDigitalOcean";
import packageJson from "../package.json";

const main = async () => {
  program
    .version(packageJson.version)
    .description("deploy code-server to Digital Ocean");
  program.parse();
  await deployDigitalOcean();
  process.exit(0);
};

main();
