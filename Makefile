all:
	cd srcs && docker-compose up --build

down:
	cd srcs && docker-compose down

clean:
	cd srcs && docker-compose down -v
	docker system prune -af

.PHONY: all down clean