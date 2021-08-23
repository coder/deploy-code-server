#!/usr/bin/env node

import { program } from "commander";
import { deployDigitalOcean } from "./deploys/deployDigitalOcean";

const main = async () => {
  program.version("0.1.0").description("deploy code-server to Digital Ocean");
  program.parse();
  await deployDigitalOcean();
  process.exit(0);
};

main();
