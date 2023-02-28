CONTAINER_REGISTRY := "${MyRegistry}"
BE_NAME := "cognata-be:${VERSION}"
FE_NAME := "cognata-fe:${VERSION}"

build:
	docker build -t ${CONTAINER_REGISTRY}/${BE_NAME} -f /BE/Dockerfile
	docker build -t ${CONTAINER_REGISTRY}/${FE_NAME} -f /FE/Dockerfile

push: 
	docker push "${CONTAINER_REGISTRY}/${BE_NAME}"
	docker push "${CONTAINER_REGISTRY}/${FE_NAME}"

test:
	docker run ${CONTAINER_REGISTRY}/${BE_NAME} sh -c "nmp run test"
	docker run ${CONTAINER_REGISTRY}/${FE_NAME} sh -c "nmp run test"

