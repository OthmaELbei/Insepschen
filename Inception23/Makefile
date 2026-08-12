NAME		= inception

COMPOSE		= docker compose -f srcs/docker-compose.yml
LOGIN		= oelbied
DATA_DIR	= /home/$(LOGIN)/data

all: up

up: setup
	$(COMPOSE) up --build -d

setup:
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

start:
	$(COMPOSE) start

restart: down up

clean: down
	docker system prune -af

fclean: clean
	sudo rm -rf $(DATA_DIR)/mariadb/*
	sudo rm -rf $(DATA_DIR)/wordpress/*

re: fclean all

.PHONY: all up setup down stop start restart clean fclean re