# n8n Funnel Deployment

This repository provides a modular setup to run n8n inside Docker and expose it securely over the internet using Tailscale Funnel, without requiring any domain. Everything is activated and deactivated manually through scripts to keep full user control.

## Repository Structure 

```bash
n8n_docker/
├─ n8n_data #You need to create
├─ docker-compose.yml
├─ n8n_start.sh
├─ n8n_stop.sh
├─ .env #You need to create
└─ README.md
```

## Requirements

Before using this project, ensure the following are installed on your system:

1. Docker and Docker Compose:

Install Docker by following the official documentation:
[Docker](https://docs.docker.com/engine/install/)

2. Tailscale Client

Tailscale must be installed to enable secure tunnel access through Funnel.

``` bash
curl -fsSL https://tailscale.com/install.sh | sh
```
After installed: 

``` bash
sudo systemctl enable tailscaled
sudo systemctl start tailscaled
sudo tailscale up
```

You must authenticate with your Tailscale account.

3. Optional: Rename you local Tailscale Node:

``` bash
sudo tailscale set --hostname n8n-server
```

4. Disable Tailscale on system startup:

``` bash
sudo systemctl disable tailscaled
```

## How to find your Funnel URL

To view the public URL assigned by Tailscale Funnel, run:

``` bash
sudo tailscale funnel 5678
```

Output: 

```bash
Available on the internet:

https://n8n-server.tailXXX.ts.net/
|-- proxy http://XX.X.X.X:5678
```

Use the https URL as the value for WEBHOOK_URL.

## Environment File

A .env file must be created manually. Use .env.example as a template:

``` bash
WEBHOOK_URL=https://XXXX.tailXXXXXX.ts.net/
```

If you rename your Tailscale node, the webhook base URL will also change. In that case, it will follow the format:

``` bash
https://<node-name>.tailXXXXXX.ts.net/
```

For example, if you rename the node as in step 3 of the Requirements, use:

``` bash
https://n8n-server.tailXXXXXX.ts.net/
```

This step is required because n8n uses webhook URLs to receive external requests from many nodes (such as HTTP Trigger, OAuth2 callbacks, Telegram, etc.). If the `WEBHOOK_URL` in the environment is incorrect, n8n will generate invalid callback URLs internally. Because Tailscale Funnel exposes your local n8n instance to the internet using a public URL, n8n must know the exact public address that Funnel assigns.

## How to use

1. You need to create a folder: 

``` bash
mkdir n8n_data
```

2. Script Permissions:

Run: 

``` bash
chmod +x n8n_start.sh n8n_stop.sh
```

3. Start n8n with Tailscale Funnel

``` bash
./n8n_start.sh
```
After launching, the script will print the public Tailscale Funnel URL, such as:

``` bash
https://XXXXXXXXX.ts.net/
```

4. Stop Everything

``` bash
./n8n_stop.sh
```
