# vim:set ft=dockerfile:
FROM babim/debianbase:8

# Download option
RUN apt-get update && \
    apt-get install -y wget bash curl && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

ENV OSDEB jessie
# install repo
RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/repo-debian.sh | bash

# clean
RUN apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*
