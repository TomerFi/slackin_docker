FROM node:10.16.0-stretch-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="tomerfi/slackin_docker" \
      org.label-schema.description="Image implementing rauchg's solution for slack badge, https://github.com/rauchg/slackin." \
      org.label-schema.url="https://hub.docker.com/r/tomerfi/slackin_docker" \
      org.label-schema.vcs-url="https://github.com/TomerFi/slackin_docker" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0" \
      org.label-schema.docker.cmd="docker run -d -p 8000:8000 \
                                   -e SLACK_SUBDOMAIN=subdomain.slack.com \
                                   -e SLACK_TOKEN=thisisADUmmytoKe1Nf89orr \
                                   -e SLACK_CHANNELS=my_channel \
                                   --name slackin_server tomerfi/slackin_docker:latest" \
      org.label-schema.docker.params="SLACK_SUBDOMAIN=Your Slack's subdomain (**this**.slack.com). \
                                      SLACK_TOKEN=Your slack API token \
                                      SLACK_CHANNELS=Comma-separated list of single channels to monitor" \
      license="MIT" \
      maintainer="Tomer Figenblat <tomer.figenblat@gmail.com>"

WORKDIR /slackin

RUN wget -q https://github.com/rauchg/slackin/archive/0.14.0.tar.gz \
&& tar -xf 0.14.0.tar.gz

RUN cd slackin-0.14.0 && npm install --unsafe-perm

EXPOSE 8000

ENV SLACK_CHANNELS SLACK_SUBDOMAIN SLACK_API_TOKEN

CMD ["/slackin/slackin-0.14.0/bin/slackin", "--hostname", "0.0.0.0", "--port", "8000", "--channels", "$SLACK_CHANNELS", "$SLACK_SUBDOMAIN", "$SLACK_API_TOKEN"]
