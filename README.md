# docker-node
Dockerfile for a base nodejs image with nvm

# How to use this image
Sample Dockerfile for your project

```
FROM gauravarora/docker-node

MAINTAINER "Gaurav Arora <gaurav@custvantage.com>"

#install pm2 globally
RUN npm -g i pm2

# Add our package.json and install *before* adding our application files
ADD package.json ./
RUN npm i --production && npm cache clean && \
    rm -rf ~/.node-gyp /tmp/*

# Add application files
ADD . /var/www/app/current

# Dockerfile
#Expose the port
#EXPOSE 80

# set app specific env vars

#CMD ["pm2", "start", "src/index.js"]
CMD pm2 start --no-daemon -l /tmp/pm2.log src/index.js
```
