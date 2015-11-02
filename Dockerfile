FROM nginx

MAINTAINER Aleksandar Diklic <rastasheep@gmail.com>

COPY build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
