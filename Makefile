all: setup
	cd srcs && docker-compose up --build -d

setup:
	@mkdir -p /home/$(USER)/data/data-db
	@mkdir -p /home/$(USER)/data/www-data
	@mkdir -p /home/$(USER)/data/ftp-data

up: setup
	cd srcs && docker-compose up

down:
	cd srcs && docker-compose down

stop:
	cd srcs && docker-compose stop

restart: down up

clean: down
	docker system prune -af

fclean: clean
	sudo rm -rf /home/$(USER)/data

re: fclean all

.PHONY: all setup up down stop restart clean fclean re