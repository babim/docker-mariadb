# vim:set ft=dockerfile:
FROM babim/debianbase:9

# install mysql
ENV OSDEB stretch
ENV MYSQL_MAJOR 5.7

RUN apt-get update && \
    curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/mysql_install.sh | bash

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