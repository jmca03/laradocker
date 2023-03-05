FROM nginx:stable

COPY ./config/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80