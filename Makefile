all: setup
	cd srcs && docker-compose up --build

setup:
	@mkdir -p /home/$(USER)/data/data-db
	@mkdir -p /home/$(USER)/data/www-data
down:
	cd srcs && docker-compose down

clean:
	cd srcs && docker-compose down
	docker system prune -af

fclean: clean
	sudo rm -rf /home/$(USER)/data

re: fclean all

.PHONY: all setup down clean fclean re