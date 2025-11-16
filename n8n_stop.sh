echo "Disabling Funnel"
sudo tailscale funnel reset

echo "Stopping Docker Compose"
docker compose down

echo " Stopping tailscaled"
sudo systemctl stop tailscaled

echo "All services stopped"

