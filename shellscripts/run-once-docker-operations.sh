#!/bin/bash

# run-once-docker-operations.sh
#
# The script verifies the existence of docker (https://docs.docker.com/).
# If exists the script will run various run-once docker operations based on the passed argument.
# The script does not install anything on your behalf, for using it, please manually install docker (https://docs.docker.com/install/).

display_no_docker_engine() {
    echo -e "### !!!SKIPPING TEST!!! ###\n"
    echo -e "docker is not installed.\n"
    echo "please consider installing docker for running run-once docker operations."
}

display_usage() {
    echo -e "please provide the operation you want to execute.\n"
    echo "usage: $0 lint-dockerfile"
    echo "usage: $0 check-shellscripts"
    echo "usage: $0 circleci-validate"
}

if command -v docker > /dev/null
then
    if [ -z "$1" ]
    then
        display_usage
        exit 1
    else
      if [ "$1" = "lint-dockerfile" ]
      then
        docker run --rm -i hadolint/hadolint:v1.16.3 < Dockerfile
      elif [ "$1" = "check-shellscripts" ]
      then
        # shellcheck disable=SC2046
        docker run --rm -it -v "$PWD/shellscripts/:/mnt/:ro" koalaman/shellcheck:v0.6.0 $(ls -A1 shellscripts)
      elif [ "$1" = "circleci-validate" ]
      then
        docker run --rm -it -v "$PWD/.circleci/:/.circleci/:ro" circleci/circleci-cli:alpine config validate
      fi
    fi
else
    display_no_docker_engine
    exit 0
fi
