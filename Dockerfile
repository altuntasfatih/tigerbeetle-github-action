# Set the base image to use for subsequent instructions
FROM ubuntu:latest

# Add metadata labels
LABEL maintainer="GitHub Actions"
LABEL org.opencontainers.image.source="https://github.com/tigerbeetle/tigerbeetle"
LABEL org.opencontainers.image.description="TigerBeetle GitHub Action"
LABEL org.opencontainers.image.licenses="MIT"

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        unzip \
        ca-certificates \
        jq && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src

# Download and extract latest TigerBeetle
RUN LATEST_VERSION=$(curl -s https://api.github.com/repos/tigerbeetle/tigerbeetle/releases/latest | jq -r '.tag_name' | sed 's/v//') && \
    curl -L "https://github.com/tigerbeetle/tigerbeetle/releases/download/${LATEST_VERSION}/tigerbeetle-aarch64-linux.zip" -o tigerbeetle.zip && \
    unzip tigerbeetle.zip && \
    mv tigerbeetle /usr/local/bin/ && \
    rm tigerbeetle.zip

# Copy any source file(s) required for the action
COPY entrypoint.sh .

# Make the entrypoint script executable
RUN chmod +x entrypoint.sh

# Configure the container to be run as an executable
ENTRYPOINT ["./entrypoint.sh"]