FROM nginx:stable

COPY ./config/nginx/nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

COPY ./config/nginx/build.sh .

RUN chmod 755 build.sh

EXPOSE 80

# CMD [ "/bin/bash", "-c", "/var/www/html/build.sh" ]