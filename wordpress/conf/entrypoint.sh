#!/bin/sh

wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
cp -rf wordpress/* .
rm latest.tar.gz
rm -rf wordpress

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

mkdir -p /run/php
chmod -R 777 .
php-fpm7.3 --nodaemonize