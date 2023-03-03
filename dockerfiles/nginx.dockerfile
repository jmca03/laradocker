FROM nginx:stable-alpine

COPY ./service.configurations/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80