FROM debian:buster

EXPOSE 3306

RUN apt update -y
RUN apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/init.sql /tmp

RUN service mysql start && mysql < /tmp/init.sql

CMD ["mysqld"]