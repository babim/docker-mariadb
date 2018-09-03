# vim:set ft=dockerfile:
FROM babim/mariadb:base

# install mysql
ENV OSDEB jessie
ENV MARIADB_MAJOR 10.3

RUN cd / && wget https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/mariadb_install.sh && \
    chmod +x /mariadb_install.sh && /mariadb_install.sh && rm -f /mariadb_install.sh

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