FROM mysql:8.0.36-debian

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y openssh-server

ARG UID
ARG GID
ARG CONTAINER_USER
ARG CONTAINER_GROUP
ARG CONTAINER_PASSWORD

WORKDIR /var/lib/mysql

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Create docker group with group id matching with host pc
RUN groupadd -g ${GID} ${CONTAINER_GROUP}
# Create user docker with user id matching with host pc
# RUN adduser --uid 1000 --disabled-password --ingroup docker docker
RUN adduser --uid ${UID} \
    -ingroup ${CONTAINER_GROUP} \
    -home /home/${CONTAINER_USER} \
    -shell /bin/bash ${CONTAINER_USER}

RUN echo "${CONTAINER_USER}:${CONTAINER_PASSWORD}" | chpasswd

RUN mkdir /var/run/sshd

CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 3306

