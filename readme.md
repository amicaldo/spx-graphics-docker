# SPX Graphics
... is a free and open-source live graphics control application, designed by Tuomo for graphics enthusiasts in the fields of broadcast, streaming, and events production. It offers a powerful playout solution for managing pixel-perfect HTML graphic templates across various platforms, including Windows, Linux, and Mac. SPX-GC seamlessly integrates with popular tools such as OBS, vMix, Wirecast, Stream Deck, and more, making it an ideal choice for professionals looking to enhance their live production capabilities. Learn more about SPX-GC and its features on the [official website](https://www.spx.graphics/) and explore its [source code](https://github.com/TuomoKu/SPX-GC) and contribution guidelines on GitHub.


## Pre-built Image

You can use a pre-built image from githubs registry:

```bash
docker pull ghcr.io/amicaldo/spx-graphics-docker:v1.2.1
docker run -d -p 5656:5656 --name spx_container ghcr.io/amicaldo/spx-graphics-docker:v1.2.1
```

Use as base image
```bash
FROM ghcr.io/amicaldo/spx-graphics-docker:v1.2.1
```

# SPX Docker Deployment Guide

To build the SPX Docker image, execute the following command in the directory containing the Dockerfile:
```
docker build -t spx:latest .
```

## Simplifying Volume Management

The design of this Docker container for SPX aims to reduce the complexity typically associated with volume management. Traditionally, separate volumes might be required for different aspects of an application (e.g., logs, configuration files, and data storage). However, to streamline deployment and operation, we've structured the SPX Docker setup to make efficient use of a single volume for essential persistent storage needs.

### Strategy and Implementation

1. **Consolidating Storage Paths:** By default, SPX utilizes various directories for its operation, including separate locations for configuration (`CONFIG`), data (`DATAROOT`), templates (`ASSETS`), and logs (`LOG`). We've reconfigured SPX to place `DATAROOT` within the `ASSETS` directory, alongside the `CONFIG` directory, thus centralizing important data in a single location. This adjustment allows for a single volume mount point that covers both configuration and application data.

2. **Optional Logging Volume:** Recognizing that not all deployments require persistent storage for logs, we've configured the logging function to be optional. Users who do not need to retain logs can avoid mounting a separate volume for the `LOG` directory On container upgrade, logs are gone. For environments where log preservation is critical, a separate volume can still be mounted specifically for this purpose.


## Running the Container

Run the SPX container using the following command. This example demonstrates mounting a single volume for `ASSETS`, which includes both configuration and data:

```bash
docker run -d -p 5656:5656 -v /your/host/path/assets:/SPX/ASSETS --name spx_container spx:latest
```

If preserving logs is necessary for your deployment, mount an additional volume for the `LOG` directory:

```bash
docker run -d -p 5656:5656 -v /your/host/path/assets:/SPX/ASSETS -v /your/host/path/logs:/SPX/LOG --name spx_container spx:latest
```

## Config
Configuration of the SPX application within the Docker container is centered around the use of a JSON configuration file, named `config.json`. This file is located in the `/SPX/ASSETS/CONFIG` directory inside the container and should be mounted on your host. To customize the application's behavior, you can modify this file before starting the container.

Upon initial setup, the `config.json` file will be created if it does not already exist.




