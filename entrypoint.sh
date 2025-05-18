#!/bin/sh -l

set -euo pipefail

# Create data directory with proper permissions
mkdir -p /data

# Set default values if not provided
CLUSTER="${INPUT_CLUSTER:-0}"
REPLICA="${INPUT_REPLICA:-0}"
REPLICA_COUNT="${INPUT_REPLICA_COUNT:-1}"
PORT="${INPUT_PORT:-3000}"

# Initialize TigerBeetle if not already initialized
if [ ! -f "/data/${CLUSTER}_${REPLICA}.tigerbeetle" ]; then
    echo "Initializing TigerBeetle..."
    tigerbeetle format \
        --cluster="${CLUSTER}" \
        --replica="${REPLICA}" \
        --replica-count="${REPLICA_COUNT}" \
        "/data/${CLUSTER}_${REPLICA}.tigerbeetle"
fi

# Start TigerBeetle
echo "Starting TigerBeetle on port ${PORT}..."
tigerbeetle start \
    --addresses="${PORT}" \
    "/data/${CLUSTER}_${REPLICA}.tigerbeetle"

# Output the status and port
echo "status=running" >> "${GITHUB_OUTPUT}"
echo "port=${PORT}" >> "${GITHUB_OUTPUT}"

# Keep the container running
tail -f /dev/null
