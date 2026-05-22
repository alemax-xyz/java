override TARGETS = \
    openjdk-21-jre \
    openjdk-25-jre \
    openjdk-26-jre

TAG ?= clover/java
PLATFORM ?= linux/amd64,linux/386,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x

all: ${TARGETS} latest

.PHONY: all ${TARGETS} latest

${TARGETS}:
	docker buildx build --progress plain --platform ${PLATFORM} --tag ${TAG}:$@ $@ --push

latest:
	docker buildx build --progress plain --platform ${PLATFORM} --tag ${TAG}:$@ $^ --push

latest: openjdk-26-jre
