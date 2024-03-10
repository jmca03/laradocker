FROM redis:alpine3.19

ARG CACHE_PASSWORD

CMD [ "/bin/sh", "-c", "redis-server", "--requirepass", "${CACHE_PASSWORD}" ]