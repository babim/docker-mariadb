# vim:set ft=dockerfile:
FROM debian:wheezy

# Download option
RUN apt-get update && \
    apt-get install -y wget bash curl && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

ENV OSDEB wheezy
# install repo
RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/mariadb-repo-debian.sh | bash

# install mysql
ENV MARIADB_MAJOR 5.5

RUN apt-get update && \
    curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/mariadb_install.sh | bash

# clean
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

ENTRYPOINT ["/start.sh"]

EXPOSE 3306
CMD ["mysqld"]