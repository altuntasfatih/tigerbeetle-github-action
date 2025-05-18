# TigerBeetle GitHub Action

[![GitHub Super-Linter](https://github.com/actions/hello-world-docker-action/actions/workflows/linter.yml/badge.svg)](https://github.com/super-linter/super-linter)
![CI](https://github.com/actions/hello-world-docker-action/actions/workflows/ci.yml/badge.svg)

This action runs a TigerBeetle server instance in your GitHub Actions workflow. TigerBeetle is a distributed financial accounting database designed for mission-critical safety and performance.

## Usage

Here's an example of how to use this action in a workflow file:

```yaml
name: Run TigerBeetle

on:
  workflow_dispatch:
    inputs:
      cluster:
        description: The cluster ID for TigerBeetle
        required: false
        default: '0'
        type: string
      replica:
        description: The replica ID for TigerBeetle
        required: false
        default: '0'
        type: string
      replica-count:
        description: The number of replicas in the cluster
        required: false
        default: '1'
        type: string
      port:
        description: The port to run TigerBeetle on
        required: false
        default: '3000'
        type: string

jobs:
  run-tigerbeetle:
    name: Run TigerBeetle Server
    runs-on: ubuntu-latest

    steps:
      - name: Start TigerBeetle
        id: tigerbeetle
        uses: fatih-altuntas/tigerbeetle-github-action@main
        with:
          cluster: ${{ inputs.cluster }}
          replica: ${{ inputs.replica }}
          replica-count: ${{ inputs.replica-count }}
          port: ${{ inputs.port }}
```

## Inputs

| Input          | Default | Description                     |
| -------------- | ------- | ------------------------------- |
| `cluster`      | `0`     | The cluster ID for TigerBeetle  |
| `replica`      | `0`     | The replica ID for TigerBeetle  |
| `replica-count`| `1`     | Number of replicas in cluster   |
| `port`         | `3000`  | Port to run TigerBeetle on      |

## Outputs

| Output  | Description                    |
| ------- | ------------------------------ |
| `status`| The status of TigerBeetle server |
| `port`  | The port TigerBeetle is running on |

## Test Locally

After you've cloned the repository to your local machine or codespace, you can test the action locally:

1. Build the container:
   ```bash
   docker build -t tigerbeetle-action .
   ```

2. Test the container:
   ```bash
   docker run --env INPUT_CLUSTER="0" \
              --env INPUT_REPLICA="0" \
              --env INPUT_REPLICA_COUNT="1" \
              --env INPUT_PORT="3000" \
              tigerbeetle-action
   ```

   Or using an env file:
   ```bash
   $ echo "INPUT_CLUSTER=0
   INPUT_REPLICA=0
   INPUT_REPLICA_COUNT=1
   INPUT_PORT=3000" > ./.env.test

   $ docker run --env-file ./.env.test tigerbeetle-action
   ```

## Features

- Automatically downloads and installs the latest version of TigerBeetle
- Supports aarch64-linux architecture
- Configurable cluster and replica settings
- Customizable port
- Provides status and port information as outputs

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
