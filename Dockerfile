FROM babim/mariadb:base

# install mysql
ENV OSDEB stretch
ENV MARIADB_MAJOR 10.1
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mariadb

RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

# clean
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306