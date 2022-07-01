FROM debian:buster

RUN apt update
RUN apt install -y nginx
RUN apt install -y openssl
RUN openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout /etc/ssl/private/private-key.key -out /etc/ssl/certs/certificate.crt -subj "/C=FR/ST=Paris/L=Paris/O=inception/CN=jumaison.42.fr"
RUN chown -R www-data:www-data /var/www/

COPY ./conf/default.conf /etc/nginx/conf.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]