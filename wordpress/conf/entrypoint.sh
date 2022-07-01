#!/bin/sh

wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
cp -rf wordpress/* .
rm latest.tar.gz
rm -rf wordpress
mkdir -p /run/php
chmod -R 777 .
php-fpm7.3 --nodaemonize