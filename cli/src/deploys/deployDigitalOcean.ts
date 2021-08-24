import inquirer from "inquirer";
import got from "got";
import ora from "ora";
import chalk from "chalk";
import {
  createDroplet,
  Droplet,
  DropletV4Network,
  getDroplet,
} from "../lib/digitalOcean";
import waitUntil from "async-wait-until";

const getUserDataScript = async () =>
  got(
    "https://raw.githubusercontent.com/cdr/deploy-code-server/main/deploy-vm/launch-code-server.sh"
  ).text();

const isPermissionError = (error: unknown) => {
  return error instanceof got.HTTPError && error.response.statusCode === 401;
};

const getPublicIp = (droplet: Droplet) => {
  const network = droplet.networks.v4.find(
    (network) => network.type === "public"
  );
  return network?.ip_address;
};

const isCodeServerLive = async (droplet: Droplet) => {
  try {
    const response = await got(`http://${getPublicIp(droplet)}`, { retry: 0 });
    return response.statusCode === 200;
  } catch {
    return false;
  }
};

const handleErrorLog = (error: unknown) => {
  if (isPermissionError(error)) {
    console.log(
      chalk.red(
        chalk.bold("Invalid token."),
        "Please, verify your token and try again."
      )
    );
  } else {
    console.log(chalk.red.bold("Something wrong happened"));
    console.log(
      chalk.red(
        "You may have to delete the droplet manually on your Digital Ocean dashboard."
      )
    );
  }
};

const oneMinute = 1000 * 60;
const fiveMinutes = oneMinute * 5;

const waitUntilBeActive = (droplet: Droplet, token: string) => {
  return waitUntil(
    async () => {
      const dropletInfo = await getDroplet({ token, id: droplet.id });
      return dropletInfo.status === "active";
    },
    { timeout: fiveMinutes, intervalBetweenAttempts: oneMinute / 2 }
  );
};

const waitUntilHasPublicIp = (droplet: Droplet, token: string) => {
  return waitUntil(
    async () => {
      const dropletInfo = await getDroplet({ token, id: droplet.id });
      const ip = getPublicIp(dropletInfo);
      return ip !== undefined;
    },
    { timeout: fiveMinutes, intervalBetweenAttempts: oneMinute / 2 }
  );
};

const waitUntilCodeServerIsLive = (droplet: Droplet, token: string) => {
  return waitUntil(
    async () => {
      const dropletInfo = await getDroplet({ token, id: droplet.id });
      return isCodeServerLive(dropletInfo);
    },
    { timeout: fiveMinutes * 2, intervalBetweenAttempts: oneMinute / 2 }
  );
};

export const deployDigitalOcean = async () => {
  let spinner: ora.Ora;

  console.log(
    chalk.blue(
      "You can create a token on",
      chalk.bold("https://cloud.digitalocean.com/account/api/tokens")
    )
  );
  const { token } = await inquirer.prompt([
    { name: "token", message: "Your Digital Ocean token:", type: "password" },
  ]);

  try {
    let spinner = ora("Creating droplet and installing code-server").start();
    let droplet = await createDroplet({
      userData: await getUserDataScript(),
      token,
    });
    spinner.stop();
    console.log(chalk.green("✅ Droplet created"));

    spinner = ora("Waiting droplet to be active").start();
    await waitUntilBeActive(droplet, token);
    spinner.stop();
    console.log(chalk.green("✅ Droplet active"));

    spinner = ora("Waiting droplet to have a public IP").start();
    await waitUntilHasPublicIp(droplet, token);
    spinner.stop();
    console.log(chalk.green("✅ Public IP is available"));

    spinner = ora(
      "Waiting code-server to be live. It can take up to 5 minutes."
    ).start();
    await waitUntilCodeServerIsLive(droplet, token);
    droplet = await getDroplet({ token, id: droplet.id });
    spinner.stop();
    console.log(
      chalk.green(
        `🚀 Your code-server is live. You can access it on`,
        chalk.bold(`http://${getPublicIp(droplet)}`)
      )
    );
  } catch (error) {
    spinner.stop();
    handleErrorLog(error);
  }
};
