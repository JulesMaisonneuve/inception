start:
	docker-compose up -d --build

stop:
	docker-compose down

clean:
	sudo rm -rf ./mariadb/data/*
	sudo rm -rf ./wordpress/data/*
	docker volume rm inception_mariadb_volume
	docker volume rm inception_wordpress_volume

re: stop clean start

.PHONY: start stop clean re