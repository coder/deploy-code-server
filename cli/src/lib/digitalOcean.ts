import got from "got";

const DIGITALOCEAN_API_URL = "https://api.digitalocean.com/v2";

export type DropletV4Network = {
  ip_address: string;
  type: "private" | "public";
};
export type Droplet = {
  id: string;
  name: string;
  networks: { v4: DropletV4Network[] };
  status: "new" | "active";
};

type CreateDropletOptions = {
  userData: string;
  token: string;
};

export const createDroplet = async ({
  token,
  userData,
}: CreateDropletOptions) => {
  return got
    .post(`${DIGITALOCEAN_API_URL}/droplets`, {
      json: {
        name: "code-server",
        region: "nyc3",
        size: "s-1vcpu-1gb",
        image: "ubuntu-20-10-x64",
        user_data: userData,
      },
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
    .json<{ droplet: Droplet }>()
    .then((data) => data.droplet);
};

type GetDropletOptions = {
  id: string;
  token: string;
};

export const getDroplet = async ({ token, id }: GetDropletOptions) => {
  return got(`${DIGITALOCEAN_API_URL}/droplets/${id}`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  })
    .json<{ droplet: Droplet }>()
    .then((data) => data.droplet);
};
