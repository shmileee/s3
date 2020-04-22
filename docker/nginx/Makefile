# Build options
IMAGE_NAME?="custom-nginx"
IMAGE_TAG?="alpha"
DOCKER_NO_CACHE?="false"

# Tests
TEST_CONTAINER_NAME?="test_nginx"
TEST_CONTAINER_PORT?="27000"

.PHONY: build
build:
	docker build -f Dockerfile --no-cache=$(DOCKER_NO_CACHE) \
	-t $(IMAGE_NAME):$(IMAGE_TAG) .

.PHONY: clean
clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: test-start-server
test-start-server: test-stop-server
	docker run -d -p $(TEST_CONTAINER_PORT):80/tcp \
	--name $(TEST_CONTAINER_NAME) $(IMAGE_NAME):$(IMAGE_TAG)
	curl localhost:$(TEST_CONTAINER_PORT)

.PHONY: test-stop-server
test-stop-server:
	docker rm -f $(TEST_CONTAINER_NAME)
