# vim:set ft=dockerfile:
FROM babim/mariadb:base

# install mysql
ENV OSDEB jessie
ENV MARIADB_MAJOR 10.2
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mariadb

RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306
