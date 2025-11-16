echo "Starting Tailscale"
sudo systemctl start tailscaled

echo "Bringing Tailscale up"
sudo tailscale up

echo "Starting Docker Compose"
docker compose up -d

echo "Activating Tailscale Funnel (Port 5678)"
sudo tailscale funnel 5678

echo "n8n is available in: "
tailscale status | grep ts.net
