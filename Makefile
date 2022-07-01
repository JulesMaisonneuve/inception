mkdir -p ~/data/wordpress
mkdir -p ~/data/mariadb
docker-compose up -d --build


cp /app/wp-config.php /var/www/html/wp-config.php
COPY ./conf/wp-config.php /app/wp-config.php