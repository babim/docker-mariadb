# vim:set ft=dockerfile:
FROM babim/mariadb:base

# install mysql
ENV OSDEB stretch
ENV MYSQL_MAJOR 5.6
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mysql

RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

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
CMD ["supervisord", "-nc", "/etc/supervisor/supervisord.conf"]