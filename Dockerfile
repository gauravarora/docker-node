# Dockerfile
# The FROM directive sets the Base Image for subsequent instructions
FROM debian:jessie

MAINTAINER "Gaurav Arora <gaurav@custvantage.com>"

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Set environment variables
ENV appDir /var/www/app/current

# Install needed deps and clean up after
RUN apt-get update && apt-get install -y -q --no-install-recommends \
    apt-transport-https gcc g++ build-essential \
    wget curl sudo make python less vim ca-certificates git \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoclean

# set env vars
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.9.5
ENV NVM_VERSION v0.33.0

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set up our PATH correctly so we don't have to long-reference npm, node, &c.
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install yarn
RUN npm install -g yarn && mkdir -p /var/www/app/current

WORKDIR ${appDir}
