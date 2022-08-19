VOLUMES = $(shell docker volume ls | awk '{if(NR > 1) print $2}' | cut -d " " -f6)

start:
	docker-compose --env-file srcs/.env -f srcs/docker-compose.yml up -d --build

stop:
	docker-compose --env-file srcs/.env -f srcs/docker-compose.yml down

clean: stop
	sudo rm -rf /home/jumaison/data/mariadb/*
	sudo rm -rf /home/jumaison/data/wordpress/*
	docker volume rm $(VOLUMES)

re: stop clean start

.PHONY: start stop clean re
