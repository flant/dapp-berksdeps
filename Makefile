DOCKER_IMAGE_VERSION=0.1.0
DOCKER_IMAGE_NAME=dappdeps/berksdeps:$(DOCKER_IMAGE_VERSION)
IMAGE_FILE_PATH=build/image_$(DOCKER_IMAGE_VERSION)
HUB_IMAGE_FILE_PATH=build/hub_image_$(DOCKER_IMAGE_VERSION)

all: $(HUB_IMAGE_FILE_PATH)

build/Dockerfile_$(DOCKER_IMAGE_VERSION):
	@mkdir -p build
	@echo "FROM ubuntu:14.04" > build/Dockerfile_$(DOCKER_IMAGE_VERSION)
	@echo "RUN apt-get update -qq && apt-get install -qq git" >> build/Dockerfile_$(DOCKER_IMAGE_VERSION)

$(IMAGE_FILE_PATH): build/Dockerfile_$(DOCKER_IMAGE_VERSION)
	docker build -t $(DOCKER_IMAGE_NAME) -f build/Dockerfile_$(DOCKER_IMAGE_VERSION) build
	@echo $(DOCKER_IMAGE_NAME) > $(IMAGE_FILE_PATH)

$(HUB_IMAGE_FILE_PATH): $(IMAGE_FILE_PATH)
	docker push $(DOCKER_IMAGE_NAME)
	@echo $(DOCKER_IMAGE_NAME) > $(HUB_IMAGE_FILE_PATH)

clean:
	@rm -rf build

.PHONY: all clean
