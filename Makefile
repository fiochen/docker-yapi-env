DOCKERFILE_DIR = $(shell pwd)/docker_image
PROJECT_SRC_DIR = $(shell pwd)/yapi
MONGO_DIR = $(shell pwd)/mongo/db
WORKDIR = /my-yapi

PROJECT_NAME = yapi
IMAGE_NAME = $(PROJECT_NAME)
CONTAINER_NAME = $(PROJECT_NAME)
MONGO_CONTAINER_NAME = $(PROJECT_NAME)_mongo

EXPOSE_PORT = 3000
CONTAINER_PORT = 3000

INSTALL_EXPOSE_PORT = 9090
INSTALL_CONTAINER_PORT = 9090

build:
	docker build --tag $(IMAGE_NAME) $(DOCKERFILE_DIR)
install:
	docker run --detach --rm \
		--name $(MONGO_CONTAINER_NAME) \
		--volume $(MONGO_DIR):/data/db \
		mongo:latest
	docker run --detach --rm \
		--name $(CONTAINER_NAME)_install \
		--link $(MONGO_CONTAINER_NAME):db \
		--publish $(INSTALL_EXPOSE_PORT):$(INSTALL_CONTAINER_PORT) \
		--volume $(PROJECT_SRC_DIR):$(WORKDIR) \
		--workdir / \
		--entrypoint yapi \
		$(IMAGE_NAME) server
run:
	docker run --detach --rm \
		--name $(MONGO_CONTAINER_NAME) \
		--volume $(MONGO_DIR):/data/db \
		mongo:latest
	docker run --detach --rm \
		--name $(CONTAINER_NAME) \
		--link $(MONGO_CONTAINER_NAME):db \
		--publish $(EXPOSE_PORT):$(CONTAINER_PORT) \
		--volume $(PROJECT_SRC_DIR):$(WORKDIR) \
		$(IMAGE_NAME)
stop:
	docker stop $(MONGO_CONTAINER_NAME)
	docker stop $(CONTAINER_NAME)
stopins:
	docker stop $(MONGO_CONTAINER_NAME)	
	docker stop $(CONTAINER_NAME)_install
log: 
	docker logs --follow $(CONTAINER_NAME)
exec:
	docker exec --interactive --tty $(CONTAINER_NAME) sh