DOCKERFILE_DIR = $(shell pwd)/docker_image
PROJECT_SRC_DIR = $(shell pwd)/yapi
MONGO_DIR = $(shell pwd)/mongo/db
WORKDIR = /my-yapi

PROJECT_NAME = yapi
IMAGE_NAME = $(PROJECT_NAME)
CONTAINER_NAME = $(PROJECT_NAME)
MONGO_CONTAINER_NAME = $(PROJECT_NAME)_mongo

YAPI_VERSION = v1.3.6

EXPOSE_PORT = 3000
CONTAINER_PORT = 3000

build:
	docker build --tag $(IMAGE_NAME) $(DOCKERFILE_DIR)
install:
	docker run --detach --rm \
		--name $(MONGO_CONTAINER_NAME) \
		--volume $(MONGO_DIR):/data/db \
		mongo:latest
	sleep 3
	-docker run --rm \
		--link $(MONGO_CONTAINER_NAME):db \
		--volume $(PROJECT_SRC_DIR):$(WORKDIR) \
		--entrypoint yapi \
		$(IMAGE_NAME) install -v $(YAPI_VERSION)
	docker stop $(MONGO_CONTAINER_NAME)
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
log: 
	docker logs --follow $(CONTAINER_NAME)
exec:
	docker exec --interactive --tty $(CONTAINER_NAME) sh