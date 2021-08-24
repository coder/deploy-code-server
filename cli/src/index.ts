#!/usr/bin/env node

import { program } from "commander";
import { deployDigitalOcean } from "./deploys/deployDigitalOcean";
import packageJson from "../package.json";

const main = async () => {
  program.version(packageJson.version).description(packageJson.description);
  program.parse();
  await deployDigitalOcean();
  process.exit(0);
};

main();
