# vim:set ft=dockerfile:
FROM babim/mariadb:base

# install mysql
ENV OSDEB stretch
ENV MYSQL_MAJOR 5.7
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mysql

RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306
