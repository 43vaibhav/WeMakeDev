Write-Output "Building and starting Docker Compose stack..."
docker compose -f docker/docker-compose.yml up --build -d
Write-Output "Use 'docker compose ps' to inspect containers, or open http://localhost:8501"