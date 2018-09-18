# vim:set ft=dockerfile:
FROM babim/debianbase:7
ENV OSDEB wheezy

# Download option
RUN apt-get update && \
    apt-get install -y wget bash curl && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

# install mysql
ENV MARIADB_MAJOR 5.5
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mariadb

RUN wget -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306
