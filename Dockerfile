# vim:set ft=dockerfile:
FROM babim/debianbase:8
ENV OSDEB jessie

# Download option
RUN apt-get update && \
    apt-get install -y wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

# install "apt-transport-https" for Percona's repo (switched to https-only)
# install "pwgen" for randomizing passwords
# install "tzdata" for /usr/share/zoneinfo/
RUN apt-get update && apt-get install -y --no-install-recommends \
		apt-transport-https ca-certificates \
		pwgen \
		tzdata

# clean
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
