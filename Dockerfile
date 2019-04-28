FROM babim/mariadb:base

# install mysql
ENV OSDEB stretch
ENV MARIADB_MAJOR 10.4
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mariadb

RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306