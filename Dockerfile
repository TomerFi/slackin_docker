FROM node:10.16.0-stretch-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ARG SOURCE_VERSION="0.14.0"

LABEL org.label-schema.build-date=$BUILD_DATE \
org.label-schema.name="tomerfi/slackin_docker" \
org.label-schema.description="Image implementing rauchg's solution for slack badge, https://github.com/rauchg/slackin." \
org.label-schema.url="https://hub.docker.com/r/tomerfi/slackin_docker" \
org.label-schema.vcs-url="https://github.com/TomerFi/slackin_docker" \
org.label-schema.vcs-ref=$VCS_REF \
org.label-schema.version=$VERSION \
org.label-schema.schema-version="1.0" \
org.label-schema.docker.cmd="\
docker run -d -p 8000:8000 \
-e SLACK_SUBDOMAIN=subdomain.slack.com \
-e SLACK_API_TOKEN=thisisADUmmytoKe1Nf89orr \
-e SLACK_CHANNELS=my_channel \
-e GOOGLE_CAPTCHA_SECRET=1AdumMySECRETADUMMysecReta2DUmmYsECR3etA \
-e GOOGLE_CAPTCHA_SITEKEY=1AdummySITEKEY23ADUMM4ysi5keAaDuMMy6si78 \
--name slackin_server tomerfi/slackin_docker:latest" \
org.label-schema.docker.params="\
SLACK_SUBDOMAIN=Your Slack's subdomain | \
SLACK_API_TOKEN=Your slack API token | \
SLACK_CHANNELS=Comma-separated list of single channels to monitor | \
GOOGLE_CAPTCHA_SECRET=Goggle reCAPTCHA secret key | \
GOOGLE_CAPTCHA_SITEKEY=Goggle reCAPTCHA site key" \
license="MIT" \
maintainer="Tomer Figenblat <tomer.figenblat@gmail.com>"

WORKDIR /slackin

# hadolint ignore=DL3016
RUN wget -q https://github.com/rauchg/slackin/archive/$SOURCE_VERSION.tar.gz \
&& tar -xf $SOURCE_VERSION.tar.gz \
&& rm -f $SOURCE_VERSION.tar.gz \
&& mv slackin-$SOURCE_VERSION slackin-src \
&& npm install --unsafe-perm slackin-src

COPY LICENSE README.md VERSION ./

EXPOSE 8000

ENV SLACK_CHANNELS SLACK_SUBDOMAIN SLACK_API_TOKEN GOOGLE_CAPTCHA_SECRET GOOGLE_CAPTCHA_SITEKEY

CMD ["/bin/sh", "-c", "/slackin/slackin-src/bin/slackin --hostname '0.0.0.0' --port '8000' --channels $SLACK_CHANNELS $SLACK_SUBDOMAIN $SLACK_API_TOKEN $GOOGLE_CAPTCHA_SECRET $GOOGLE_CAPTCHA_SITEKEY"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=40s --retries=3 \
CMD ["/bin/sh", "-c", "wget --quiet --tries=1 --spider http://localhost:8000 || exit 1"]
