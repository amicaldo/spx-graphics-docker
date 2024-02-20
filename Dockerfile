# Use Ubuntu 20.04 as the base image
FROM --platform=linux/amd64 ubuntu:20.04

# Set the working directory in the container
WORKDIR /SPX

# Install necessary packages: wget to download the file and unzip to extract it
RUN apt-get update && \
    apt-get install -y wget unzip


# Download and unzip the SPX ZIP file
RUN wget -O SPX.zip https://storage.googleapis.com/spx-gc-bucket-fi/installers/1.2/SPX_1_2_1_linux64.zip && \
    unzip SPX.zip && \
    rm SPX.zip

# Create directories for logs and configuration
RUN mkdir /SPX/LOG /SPX/ASSETS/CONFIG

COPY start-spx.sh /SPX/start-spx.sh
COPY default-config.json /SPX/ASSETS/CONFIG/default-config.json

# Ensure SPX_linux64 and start-spx.sh is executable
RUN chmod +x SPX_linux64
RUN chmod +x /SPX/start-spx.sh

EXPOSE 5656

# Define volumes for logs and configuration
VOLUME ["/SPX/LOG", "/SPX/ASSETS"]

# Run SPX, using start script with custom config file
CMD ["/SPX/start-spx.sh"]


