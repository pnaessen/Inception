all: setup
	cd srcs && docker-compose up --build

setup:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress
down:
	cd srcs && docker-compose down

clean:
	cd srcs && docker-compose down
	docker system prune -af

fclean: clean
	sudo rm -rf /home/$(USER)/data

re: fclean all

.PHONY: all setup down clean fclean re