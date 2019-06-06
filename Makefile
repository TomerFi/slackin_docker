#########################################################################
# .env_vars file contains following keys, example:                      #
# --------------------------------------------------------------------- #
# SLACK_SUBDOMAIN=subdomain.slack.com                                   #
# SLACK_TOKEN=thisisADUmmytoKe1Nf89orr                                  #
# SLACK_CHANNELS=my_channel                                             #
# GOOGLE_CAPTCHA_SECRET=1AdumMySECRETADUMMysecReta2DUmmYsECR3etA        #
# GOOGLE_CAPTCHA_SITEKEY=1AdummySITEKEY23ADUMM4ysi5keAaDuMMy6si78       #
#																																	      #
# change the source file name by passing env_vars=another_file to make. #
#                                                                       #
# Optional, for running the image as a container (default: 8000):       #
# EXPOSED_PORT=8000                                                     #
#########################################################################

EXPOSED_PORT ?= 8000

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

docker-build: ## build image from Dockerfile.
	docker build \
	--build-arg VCS_REF=$(GIT_COMMIT) \
  --build-arg BUILD_DATE=$(CURRENT_DATE) \
  --build-arg VERSION=$(CODE_VERSION) \
  -t $(FULL_IMAGE_NAME) .

docker-build-no-cache: ## build image from Dockerfile with no caching.
	docker build --no-cache \
	--build-arg VCS_REF=$(GIT_COMMIT) \
  --build-arg BUILD_DATE=$(CURRENT_DATE) \
  --build-arg VERSION=$(CODE_VERSION) \
  -t $(FULL_IMAGE_NAME) .

docker-tag-latest: ## add latest tag before pushing the latest version
	docker tag FULL_IMAGE_NAME IMAGE_NAME:latest

docker-run: ## run the built image as a container (must be built first).
docker-run:	verify-environment-file
	docker run -d -p $(EXPOSED_PORT):8000 \
	-e SLACK_CHANNELS=$(SLACK_CHANNELS) \
  -e SLACK_SUBDOMAIN=$(SLACK_SUBDOMAIN) \
  -e SLACK_API_TOKEN=$(SLACK_API_TOKEN) \
  -e GOOGLE_CAPTCHA_SECRET=$(GOOGLE_CAPTCHA_SECRET) \
  -e GOOGLE_CAPTCHA_SITEKEY=$(GOOGLE_CAPTCHA_SITEKEY) \
  --name $(CONTAINER_NAME) $(FULL_IMAGE_NAME)

docker-build-and-run: ## build image from Dockerfile and run as container.
docker-build-and-run: docker-build docker-run

docker-build-no-cache-and-run: ## build image from Dockerfile with no caching and run as container.
docker-build-no-cache-and-run: docker-build-no-cache docker-run

push-description: ## push the relative README.md file as full description to docker hub, requires username and password arguments
	bash shellscripts/push-docker-description.sh $(strip $(username)) $(strip $(password)) $(strip $(IMAGE_NAME))

verify-environment-file: ## verify the existence of the required environment variables file.
ifndef SLACK_CHANNELS
	$(error Mandatory configuration value SLACK_CHANNELS was not provided, can't run container)
endif
ifndef SLACK_SUBDOMAIN
	$(error Mandatory configuration value SLACK_SUBDOMAIN was not provided, can't run container)
endif
ifndef SLACK_API_TOKEN
	$(error Mandatory configuration value SLACK_API_TOKEN was not provided, can't run container)
endif
ifndef GOOGLE_CAPTCHA_SECRET
	$(error Mandatory configuration value GOOGLE_CAPTCHA_SECRET was not provided, can't run container)
endif
ifndef GOOGLE_CAPTCHA_SITEKEY
	$(error Mandatory configuration value GOOGLE_CAPTCHA_SITEKEY was not provided, can't run container)
endif
	$(info Safe to run image (assuming the provided information is infact correct).)

#######################################################################
#######################################################################