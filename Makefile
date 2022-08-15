VOLUMES = $(shell docker volume ls | awk '{if(NR > 1) print $2}' | cut -d " " -f6)

start:
	docker-compose up -d --build

stop:
	docker-compose down

clean: stop
	sudo rm -rf ./mariadb/data/*
	sudo rm -rf ./wordpress/data/*
	if $(VOLUMES)[0] != "\0"; then echo $(VOLUMES); fi
	docker volume rm $(VOLUMES)

re: stop clean start

.PHONY: start stop clean re
