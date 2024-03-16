# syntax=docker/dockerfile:1
FROM nginx:stable-alpine3.17-slim

ARG UID
ARG GID
ARG CONTAINER_USER
ARG CONTAINER_GROUP

WORKDIR /var/www/html

RUN apk update

# Install vim for easier editing
# of files
RUN apk add vim openssl

COPY ../../config/nginx.conf /etc/nginx/conf.d/default.conf

# Create docker group with group id matching with host pc
RUN addgroup -g ${GID} ${CONTAINER_GROUP}

RUN adduser -D --uid ${UID} \ 
    --ingroup ${CONTAINER_GROUP} \ 
    --shell /bin/sh ${CONTAINER_USER} \
    --home /home/${CONTAINER_USER}

# RUN adduser nginx ${CONTAINER_GROUP}

# USER ${CONTAINER_USER}

COPY ../config/entrypoint.sh /var/www/build.sh

RUN chmod +x /var/www/build.sh

EXPOSE 80
EXPOSE 443

CMD [ "/bin/sh", "-c", "/var/www/build.sh" ]

