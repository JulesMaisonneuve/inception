FROM debian:buster

RUN apt update -y
RUN apt install -y mariadb-server

COPY init.sh .

EXPOSE 3306


CMD ["sh", "init.sh"]