<!--lint disable maximum-heading-length-->
# Slackin Docker</br>[![microbadger-docker-version]][7] [![microbadger-docker-license]][8] [![shields-io-docker-pulls]][9]</br>[![shields-io-maintenance]][0]

> Docker image for hosting [rauchg's solution](https://github.com/rauchg/slackin) for slack channel
> badge.

## Who, What and Why

### Who

You, if you use a [Slack](https://slack.com) workspace to coordinate with your team.

### What

A badge (like the one above - below the heading :point_up:) that demonstrates `online/connected`
team mates in a [Slack](https://slack.com) channel.

### Why

It can be used as a landing page or redirect to the channel itself. Your team mates can quickly jump
into the correct channel directly from the code repository.

And if nothing else... It's another shining badge for your repository. :sunglasses:

## Pre-requirements

-   Generate a [Slack Legacy Token](https://api.slack.com/custom-integrations/legacy-tokens).
    This will allow you to query slack.

-   Generate a site key and a private key from the admin console in [Google reCAPTCHA](https://www.google.com/recaptcha/intro/v3.html).
    This will allow you to prevent abuse to your new page.

-   Unless you plan on working locally only, which you probably aren't.
    You'll need to select and open a designated port on your router.

    Also, It will probably be wise to get a proper dns name for your server
    and not rely on your public ip address.

## Run

Prepare your environment variables:

```text
SLACK_SUBDOMAIN=Your Slack's subdomain
SLACK_API_TOKEN=Your slack API token
SLACK_CHANNELS=Comma-separated list of single channels to monitor
GOOGLE_CAPTCHA_SECRET=Goggle reCAPTCHA secret key
GOOGLE_CAPTCHA_SITEKEY=Goggle reCAPTCHA site key
```

Simple `docker run` command, replacing the `8000` port (the left one) with your selected port,
Of course updating the environment variables with the "not-dummy" information:

```shell
docker run -d -p 8000:8000 \
-e SLACK_SUBDOMAIN=subdomain.slack.com \
-e SLACK_API_TOKEN=thisisADUmmytoKe1Nf89orr \
-e SLACK_CHANNELS=my_channel \
-e GOOGLE_CAPTCHA_SECRET=1AdumMySECRETADUMMysecReta2DUmmYsECR3etA \
-e GOOGLE_CAPTCHA_SITEKEY=1AdummySITEKEY23ADUMM4ysi5keAaDuMMy6si78 \
--name slackin_server tomerfi/slackin_docker:latest
```

That's it, Have Fun! :smile:

**Contributors** (:thumbsup:), please check out the [CONTRIBUTING.md](CONTRIBUTING.md) file.

<!-- Real Links -->
[0]: https://github.com/TomerFi/slackin_docker
[7]: https://microbadger.com/images/tomerfi/slackin_docker
[8]: https://github.com/TomerFi/slackin_docker/blob/dev/LICENSE
[9]: https://hub.docker.com/r/tomerfi/slackin_docker
[10]: https://hub.docker.com/r/tomerfi/switcher_webapi/builds

<!-- Badges Links -->
[microbadger-docker-license]: https://images.microbadger.com/badges/license/tomerfi/slackin_docker.svg
[microbadger-docker-version]: https://images.microbadger.com/badges/version/tomerfi/slackin_docker.svg
[shields-io-docker-pulls]: https://img.shields.io/docker/pulls/tomerfi/slackin_docker.svg
[shields-io-maintenance]: https://img.shields.io/maintenance/no/2020
