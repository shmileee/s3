# Build options
IMAGE_NAME?="custom-mariadb"
IMAGE_TAG?="alpha"
DOCKER_NO_CACHE?="false"

# Tests
TEST_CONTAINER_NAME?="test_mariadb"
TEST_CONTAINER_PORT?="13306"

.PHONY: build
build:
	docker build -f Dockerfile --no-cache=$(DOCKER_NO_CACHE) \
	-t $(IMAGE_NAME):$(IMAGE_TAG) .

.PHONY: clean
clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: test-start-server
test-start-server: test-stop-server
	docker run -d -p $(TEST_CONTAINER_PORT):3306/tcp \
	--name $(TEST_CONTAINER_NAME) $(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: test-stop-server
test-stop-server:
	-docker rm -f $(TEST_CONTAINER_NAME)
