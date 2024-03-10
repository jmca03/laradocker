# syntax=docker/dockerfile:1
FROM nginx:mainline-alpine3.18

ARG UID
ARG GID
ARG CONTAINER_USER
ARG CONTAINER_GROUP

WORKDIR /var/www

RUN apk update

# Install vim for easier editing
# of files
RUN apk add vim

COPY ../../config/nginx.conf /etc/nginx/conf.d/default.conf

# Create docker group with group id matching with host pc
# RUN addgroup -g ${GID} ${CONTAINER_GROUP}
# Create user docker with user id matching with host pc
# RUN adduser --uid ${UID} --disabled-password --ingroup ${CONTAINER_GROUP} ${CONTAINER_USER}
# Add docker to docker group
# RUN usermod -a -G docker docker 

# USER ${CONTAINER_USER}

EXPOSE 80
EXPOSE 443