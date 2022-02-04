# capture arguments like CLI
RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

# container manager executable
CONTAINER_APP = nerdctl.lima
COMPOSE_APP := $(CONTAINER_APP) compose
COMPOSE_FILE := -f docker-compose.override.yml

all: build up

help:
	@echo "Usage: make <target>"
	@echo
	@echo "    build - force the containers build/re-build"
	@echo "    up - up the containers and builds if not already built"
	@echo "    down - down the containers"
	@echo "    ps - list actie containers"

run:
	$(CONTAINER_APP) exec -it $(RUN_ARGS)

up:
	$(COMPOSE_APP) $(COMPOSE_FILE) up -d

build:
	$(COMPOSE_APP) $(COMPOSE_FILE) build

down:
	$(COMPOSE_APP) $(COMPOSE_FILE) down

ps:
	$(COMPOSE_APP) $(COMPOSE_FILE) ps

.PHONY: \
	help \
	run \
	up \
	down \
	ps
