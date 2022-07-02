mkdir -p ~/data/wordpress
mkdir -p ~/data/mariadb
docker-compose up -d --build


cp /app/wp-config.php /var/www/html/wp-config.php
COPY ./conf/wp-config.php /app/wp-config.php

#create wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$DB_NAME/g" wp-config.php
perl -pi -e "s/username_here/$DB_USER/g" wp-config.php
perl -pi -e "s/password_here/$DB_PASSWORD/g" wp-config.php
perl -pi -e "s/localhost/$DB_HOST/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php


MYSQL_ROOT_PASSWORD: $DB_ROOT_PASSWORD
MYSQL_DATABASE: $DB_NAME
MYSQL_USER: $DB_USER
MYSQL_PASSWORD: $DB_PASSWORD
