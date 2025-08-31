#!/bin/bash

echo "⚠️  WARNING: This will delete ALL Docker and Minikube data."
echo "    - All Docker containers, images, networks, and volumes"
echo "    - All Minikube clusters, profiles, cache, and configs"
echo "    This action is IRREVERSIBLE."
echo

read -p "Are you sure you want to continue? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "❌ Operation cancelled."
    exit 1
fi
# --- Minikube cleanup ---
echo "Stopping Minikube..."
minikube stop 2>/dev/null

echo "Deleting all Minikube clusters and profiles..."
minikube delete --all --purge 2>/dev/null

echo "Removing Minikube cache and config..."
rm -rf ~/.minikube
rm -rf ~/.kube
rm -rf ~/.minikube/cache

echo "✅ Proceeding with wipe..."

# --- Docker cleanup ---
echo "Stopping all running Docker containers..."
docker stop $(docker ps -aq) 2>/dev/null

echo "Removing all Docker containers..."
docker rm -f $(docker ps -aq) 2>/dev/null

echo "Removing all Docker images..."
docker rmi -f $(docker images -aq) 2>/dev/null

echo "Removing all Docker networks..."
docker network rm $(docker network ls -q) 2>/dev/null

echo "Removing all Docker volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null

echo "Running Docker system prune..."
docker system prune -af --volumes


echo "✅ Docker and Minikube have been completely wiped."

