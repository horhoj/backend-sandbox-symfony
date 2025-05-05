init: docker-up composer-install

#all
docker-up: docker-down
	docker compose up -d --build

docker-log: docker-down
	docker compose up --build

docker-down:
	docker compose stop
	docker compose down

clear-nginx-logs:
	-sudo rm -R ./nginx_logs/* ./nginx_logs/.*

clear-db:
	-sudo rm -R ./db/* ./db/.*


permission-755:
	sudo chmod -R 755 ./src/

permission-777:
	sudo chmod -R 777 ./src/

console:
	docker compose exec --user $(shell id -u):$(shell id -g)  php_fpm /bin/bash

console-root:
	docker compose exec  php_fpm /bin/bash

console-node:
	docker compose exec --user $(shell id -u):$(shell id -g)  node /bin/bash

composer-install:
	docker compose exec --user $(shell id -u):$(shell id -g)  php_fpm composer install

test:
	docker compose exec --user $(shell id -u):$(shell id -g)  php_fpm composer test



symfony-check-requirements:
	docker compose exec php_fpm symfony check:requirements

symfony-install:
	docker compose exec --user $(shell id -u):$(shell id -g) php_fpm symfony new ./ --version="7.2.x" --webapp --no-git


symfony-demo:
	docker compose exec php_fpm symfony new my_project_directory --demo --no-git
