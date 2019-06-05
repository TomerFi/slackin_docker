########################################################################
# .env_vars file contains following keys, example:                     #
# -------------------------------------------------------------------- #
# SLACK_SUBDOMAIN=subdomain.slack.com                                  #
# SLACK_TOKEN=thisisADUmmytoKe1Nf89orr                                 #
# SLACK_CHANNELS=my_channel                                            #
#																																	     #
# change the source file name by passing env_vars=another_file to make #
########################################################################

env_vars ?= .env_vars
include $(env_vars)
export $(shell sed 's/=.*//' $(env_vars))

default: help

help: ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

IMAGE_NAME = tomerfi/slackin_docker

CONTAINER_NAME = slackin_docker

GIT_COMMIT = $(strip $(shell git rev-parse --short HEAD))

CURRENT_DATE = $(strip $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))

CODE_VERSION = $(strip $(shell cat VERSION))

ifndef CODE_VERSION
$(error You need to create a VERSION file to build the image.)
endif

FULL_IMAGE_NAME = $(strip $(IMAGE_NAME):$(CODE_VERSION))

docker_build: ## build image from Dockerfile.
	docker build \
	--build-arg VCS_REF=$(GIT_COMMIT) \
  --build-arg BUILD_DATE=$(CURRENT_DATE) \
  --build-arg VERSION=$(CODE_VERSION) \
  -t $(FULL_IMAGE_NAME) .

docker_build_no_cache: ## build image from Dockerfile with no caching.
	docker build --no-cache \
	--build-arg VCS_REF=$(GIT_COMMIT) \
  --build-arg BUILD_DATE=$(CURRENT_DATE) \
  --build-arg VERSION=$(CODE_VERSION) \
  -t $(FULL_IMAGE_NAME) .

docker_tag_latest: ## add latest tag before pushing the latest version
	docker tag FULL_IMAGE_NAME IMAGE_NAME:latest

docker_run: ## run the built image as a container (must be built first).
docker_run:	verify-environment-file
	docker run -d -p $(EXPOSED_PORT):8000 \
	-e SLACK_CHANNELS=$(SLACK_CHANNELS) \
  -e SLACK_SUBDOMAIN=$(SLACK_SUBDOMAIN) \
  -e SLACK_API_TOKEN=$(SLACK_API_TOKEN) \
  --name $(CONTAINER_NAME) $(FULL_IMAGE_NAME)

docker_build_and_run: ## build image from Dockerfile and run as container.
docker_build_and_run: docker_build docker_run

docker_build_no_cache_and_run: ## build image from Dockerfile with no caching and run as container.
docker_build_no_cache_and_run: docker_build_no_cache docker_run

push_description: ## push the relative README.md file as full description to docker hub, requires username and password arguments
	bash shellscripts/push-docker-description.sh $(strip $(username)) $(strip $(password)) $(strip $(IMAGE_NAME))

verify-environment-file: ## verify the existence of the required environment variables file.
ifndef CONF_DEVICE_IP_ADDR
	$(error Mandatory configuration value CONF_DEVICE_IP_ADDR was not provided, can't run container.)
endif
ifndef CONF_PHONE_ID
	$(error Mandatory configuration value CONF_PHONE_ID was not provided, can't run container.)
endif
ifndef CONF_DEVICE_ID
	$(error Mandatory configuration value CONF_DEVICE_ID was not provided, can't run container.)
endif
ifndef CONF_DEVICE_PASSWORD
	$(error Mandatory configuration value CONF_DEVICE_PASSWORD was not provided, can't run container.)
endif
	$(info Safe to run image (assuming the provided information is infact correct).)

verify-release-tag: ## verify the current commit reference with the version tag commit reference.
	VERSION_COMMIT = $(strip $(shell git rev-list $(CODE_VERSION) -n 1 | cut -c1-7))
ifneq ($(VERSION_COMMIT), $(GIT_COMMIT))
	$(error You are trying to push a build based on commit $(GIT_COMMIT) but the tagged release version is $(VERSION_COMMIT).)
else
	$(info Release tag verified current commit $(GIT_COMMIT) is equals to the version commit $(VERSION_COMMIT).)
endif

######################################################################
######################################################################