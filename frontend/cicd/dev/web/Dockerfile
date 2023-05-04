# https://hub.docker.com/
FROM node:18.16.0

# Disable npm analytics questions when npn install
ENV NG_CLI_ANALYTICS flase

# Create Working diretory
RUN mkdir -p /home/node/app && \
    chown node:node /home/node/app


# Script entrypoint
COPY entrypoint-dev /usr/local/bin/
RUN chmod a+x  /usr/local/bin/entrypoint-dev

#WORKDIR /home/node/app
#USER node:node

ENTRYPOINT ["/usr/local/bin/entrypoint-dev"]
