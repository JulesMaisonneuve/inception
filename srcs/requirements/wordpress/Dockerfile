FROM debian:buster

WORKDIR /var/www/html

RUN apt update -y
RUN apt install -y php-fpm wget php-mysql

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY conf/entrypoint.sh /var/www

RUN chmod +x /var/www/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/var/www/entrypoint.sh"]