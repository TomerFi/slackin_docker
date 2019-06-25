# Contributing to `slackin_docker`

:clap: First off, thank you for taking the time to contribute. :clap:

Contributing is pretty straight-forward:
-   Fork the repository
-   Commit your changes
-   Create a pull request against the `dev` branch
  
Please feel free to contribute, even to this contributing guideline file, if you see fit.

**Content**
-   [Items description](#items-description)
    -   [Configuration files](#configuration-files)
    -   [Docker](#docker)
    -   [Shell](#shell)
    -   [Ignore files](#ignore-files)
    -   [Package management](#package-management)

-   [Continuous Integration](#continuous-integration)
    -   [CircleCi](#circleci)
    -   [Requires-io](#requires-io)
    -   [David-DM](#david-dm)
    -   [Snyk](#snyk)

-   [Continuous Deployment](#continuous-deployment)
    -   [Docker Hub](#docker-hub)
    -   [Metadata](#metadata)

-   [Environments and Tools](#environments-and-tools)

-   [Testing](#testing)

-   [Guidelines](#guidelines)
    -   [NPM Scripts](#npm-scripts)
    -   [Shell Scripts](#shell-scripts)
    -   [Makefile](#makefile)

-   [Chat](#chat)

-   [Code of Conduct](#code-of-conduct)

## Items description
### Configuration files
-   `.circle/config.yml` is the configuration file for [CircleCi Continuous Integration and Deployment Services](https://circleci.com/gh/TomerFi/slackin_docker/tree/dev).

-   `.yamllint` is the configuration for [yamllint A Linter for YAML Files](https://yamllint.readthedocs.io/en/stable/index.html)
    linting yml files.

-   `.remarkrc` is the configuration file for [remark-lint](https://github.com/remarkjs/remark-lint)
    plugin for [Remark](https://remark.js.org/) linting *markdown* files.

-   `container_structure.yml` is the configuration file for [GoogleContainerTools container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
    validating the container content.

-   `package.json` is npm's [package manager file](https://docs.npmjs.com/files/package.json)
    for managing dependencies, scripts and etc.

-   `.spelling` is the dictionary file used by [markdown-spellcheck](https://www.npmjs.com/package/markdown-spellcheck).
    Case-insensitive words in this file will not raise a spelling mistake error.

-   `requirements.txt` is a list of python requirements needed for [Tox](https://tox.readthedocs.io/en/latest/) testing.

-   `tox.ini` is the configuration file for [Tox Testing Automation](https://tox.readthedocs.io/en/latest/)
    automating tests.

### Docker
-   `Dockerfile` is the instruction file for building the *docker image*.

### Shell
-   `shellscripts` is where *shell* scripts are stored.

### Ignore files
-   `.dockerignore` used for controlling what goes in the *docker image*.
-   `.gitignore` used for controlling what will not be pushed to *github*.

### Package management
The [package.json](package.json) file specified by [npm](https://docs.npmjs.com/files/package.json)
manages our dependencies, scripts and some metadata.

## Continuous Integration
### CircleCi
By hook configuration, for every pull request, [CircleCi](https://circleci.com/gh/TomerFi/slackin_docker/tree/dev)
will execute the workflows described in [.circleci/config.yml](.circleci/config.yml)
and update the PR conversation with the results.

Some of the steps are considered required and may prevent the PR from being merged.
But no worries, everything is fixable.

### Requires-io
[Requires.io](https://requires.io/github/TomerFi/slackin_docker/requirements/?branch=dev)
is keeping an eye for versions updates upon the python requirements listed in the
[requirements.txt](requirements.txt) file.

### David-DM
[David-DM](https://david-dm.org/TomerFi/slackin_docker) is keeping an eye for versions updates upon
the npm requirements listed in the *package.json* file.

### Snyk
[Snyk](https://snyk.io) is keeping an eye out for vulnerabilities in our
[npm dependencies](https://snyk.io/test/github/TomerFi/slackin_docker?targetFile=package.json),
our [pypi requirements](https://snyk.io/test/github/TomerFi/slackin_docker?targetFile=requirements.txt)
and our **docker image dependencies**.

## Continuous Deployment
### Docker Hub
By hook configuration, when a **git-tag** with the regex of `/^[0-9.]+$/` is set,
[Docker Hub Cloud](https://hub.docker.com/r/tomerfi/slackin_docker/builds) will build the image
based on the Dockerfile instructions file and tag it twice:
-   `<git-tag>`
-   latest

### Metadata
By hook configuration, for every *docker image* build by [Docker Hub](https://hub.docker.com/r/tomerfi/slackin_docker)
[MicroBadger](https://microbadger.com/images/tomerfi/slackin_docker)
will receive a notification and will publish the image metadata.

## Environments and Tools
-   Python's [virtualenv](https://pypi.org/project/virtualenv/), a tool for segregating Python
    environments. Please install [virtualenv](https://pypi.org/project/virtualenv/).

-   Python's [nodeenv](https://pypi.org/project/nodeenv/), a tool that enables us to create a
    Node.js virtual environment in resemblance to [virtualenv](https://pypi.org/project/virtualenv/),
    the tool also allows combining [nodeenv](https://pypi.org/project/nodeenv/) within
    [virtualenv](https://pypi.org/project/virtualenv/), which is exactly what we're doing with
    `tox`.

-   [Docker](https://www.docker.com/), as some of the testing automation are
    performed within a run-once docker containers.

-   [Tox](https://tox.readthedocs.io/en/latest/) for automating unit testing in your
    local environment.
    -   Please install [Tox](https://tox.readthedocs.io/en/latest/) if you want to perform
        local testing automation.

    -   Tox utilizes Python's [virtualenv](https://pypi.org/project/virtualenv/).

    -   Tox is configured with [tox.ini](tox.ini).

    -   To run tox, simply execute `tox` from the [tox.ini](tox.ini)'s path. It is recommended
        that you also run `tox --help` to get familiar with the various options such as
        `-e` and `-r` that will help you perform faster and better tests.)

-   *NPM Package*: [package-json-validator](https://www.npmjs.com/package/package-json-validator)
    for validating the [package.json](package.json) file.

-   *NPM Package*: [remark-lint](https://www.npmjs.com/package/remark-lint) which is a plugin for
    [remark](https://www.npmjs.com/package/remark) and the [remark-cli](https://www.npmjs.com/package/remark-cli)
    command line tool for linting *markdown* files.
    -   [remark-lint](https://www.npmjs.com/package/remark-lint) uses a couple of presets and tools,
        all can be found under the dependencies key in [package.json](package.json).

    -   [remark-lint](https://www.npmjs.com/package/remark-lint) is configured with [.remarkrc](.remarkrc).

-   *NPM Package*: [markdown-spellcheck](https://www.npmjs.com/package/markdown-spellcheck)
    for checking the project *markdown* files for spelling errors.
    -   [markdown-spellcheck](https://www.npmjs.com/package/markdown-spellcheck) dictionary file
        is [.spelling](.spelling).

-   *Python Package*: [yamllint](https://pypi.org/project/yamllint/) for linting yml files.
    -   [yamllint](https://pypi.org/project/yamllint/) is configured with [.yamllint](.yamllint.yml).

-   *Docker Image*: [koalaman/shellcheck](https://hub.docker.com/r/koalaman/shellcheck) is used
    for checking the [shellscripts](shellscripts).

-   *Docker Image*: [hadolint/hadolint](https://hub.docker.com/r/hadolint/hadolint) is used for
    linting the instruction file [Dockerfile](Dockerfile).

-   *Linux Tool*: [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
    for verifying the docker image content.
    -   The tool runs with the helper script [shellscripts/container-structure-test-verify.sh](shellscripts/container-structure-test-verify.sh)
        so it will not fail if the tool is not present when running `tox` locally. But this will
        probably come up with [CircleCi](https://circleci.com/gh/TomerFi/slackin_docker/tree/dev).
        so please consider installing the tool manually.

    -   [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
        is configured with [container_structure.yml](container_structure.yml).

-   *Docker Image*: [circleci/circleci-cli](https://hub.docker.com/r/circleci/circleci-cli)
    for validating the [.circleci/config.yml](.circleci/config.yml) file.

## Testing
Use `tox` for automated local tests.

## Guidelines
> **Please Note**: the project [semvar](https://semver.org/) is being handled in both [VERSION](VERSION)
> file for creating the docker image with [Makefile](Makefile) and [package.json](package.json)
> for packaging handling.

Here are some guidelines (recommendations) for contributing to the `slackin_docker` project:
-   If you add a new file, please consider if it should be listed within any or all of
    the [ignore files](#ignore-files).

-   If you change something inside the `docker image` it is strongly recommended trying to verify
    it with the [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test).

-   While not all the test steps in [CircleCi](.circleci/config.yml) and in [Tox](tox.ini)
    are parallel to each other, most of them are, so tests failing with `Tox` will probably
    also fail with `CircleCi`.

-   You can run npm's script `spell-md-interactive` for handling all spelling mistakes before
    testing.
    You can also choose to run `spell-md-report` to print a full report instead of handling the
    spelling mistakes one-by-one.
    -   [markdown-spellcheck](https://www.npmjs.com/package/markdown-spellcheck) dictionary is the
        file [.spelling](.spelling).

### NPM Scripts
Before using the scrips, you need to install the dependencies,
From the [package.json](package.json) file path, run `npm install`.

Then you can execute the scripts from the same path.
-   `npm run lint-md` will run [remark](https://remark.js.org/) against *markdown* files.

-   `npm run validate-pkg` will run [package-json-validator](https://www.npmjs.com/package/package-json-validator)
    against the [package.json](package.json) file.

-   `npm run spell-md-interactive` will run [markdown-spellcheck](https://www.npmjs.com/package/markdown-spellcheck)
    against *markdown* files in an interactive manner allowing us to select the appropriate action.

-   `npm run spell-md-report` will run [markdown-spellcheck](https://www.npmjs.com/package/markdown-spellcheck)
    against *markdown* files and print the report to stdout.

### Shell Scripts
The shell scripts in `shellscripts` were written for `bash` and not for `sh`.
-   `shellscripts/container-structure-test-verify.sh` will verify the existence of
    [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
    and execute it. The script will `exit 0` if the tool doesn't exists so it will not fail `tox`.

-   `shellscripts/push-docker-description.sh` allows the deployment of the local
    [README.md](README.md) file as a docker image description in
    [Docker Hub](https://cloud.docker.com/repository/docker/tomerfi/slackin_docker).
    Please use it with [Makefile](#makefile) as arguments are required

-   `shellscripts/run-once-docker-operations.sh <add-argument-here>` will verify the
    existence of [Docker](https://www.docker.com/) before executing various run-once docker
    operations based on the following arguments, if the script finds that
    [Docker](https://www.docker.com/) is not installed, it will `exit 0` so it will not fail `tox`:
    -   argument `lint-dockerfile` will execute the docker image
        [hadolint/hadolint](https://hub.docker.com/r/hadolint/hadolint) linting the local
        [Dockerfile](Dockerfile).

    -   argument `check-shellscripts` will execute the docker image
        [koalaman/shellcheck](https://hub.docker.com/r/koalaman/shellcheck) for checking
        the shell scripts residing in [shellscripts](shellscripts/).

    -   argument `circleci-validate` will execute the docker image
        [circleci/circleci-cli](https://hub.docker.com/r/circleci/circleci-cli)
        for validating the [.circleci/config.yml](.circleci/config.yml) file.

### Makefile
Using the [Makefile](Makefile) is highly recommended,
especially in regards to docker operations, try `make help` to list all the available tasks:
-   `make docker-build` will build image from Dockerfile.

-   `make docker-build-testing-image` will build image from Dockerfile using a testing tag.

-   `make docker-remove-testing-image` will remove the testing image (must be build first).

-   `make docker-build-no-cache` will build image from Dockerfile with no caching.

-   `make structure-test` will run the container-structure-test tool against the built image
    (must be build first) using the relative container_structure.yml file.

-   `make docker-build-structure-test` will build the image and test the container structure.

-   `make docker-build-no-cache-structure-test` will build the image and test the container
    structure.

-   `make docker-full-structure-testing` will build the image with the testing tag and
    remove after structure test.

-   `make docker-tag-latest` will add latest tag before pushing the latest version.

-   `make docker-run` will run the built image as a container (must be built first).

-   `make docker-build-and-run` will build image from Dockerfile and run as container.

-   `make docker-build-no-cache-and-run` will build image from Dockerfile with no caching and
    run as container.

-   `make push-description` will push the relative README.md file as full description to docker
    hub, requires username and password arguments.

-   `make verify-environment-file` will verify the existence of the required
    environment variables file and its content.

## Chat
Feel free to join the project's public
[Slack Channel](https://tomfi.slack.com/messages/CKBC77Q5B)</br>
GitHub is integrated with this channel and will keep its members updated.

## Code of Conduct
The code of conduct can be found [here](CODE_OF_CONDUCT.md).
