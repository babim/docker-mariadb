FROM babim/debianbase:9

# Download option
RUN apt-get update && \
    apt-get install -y wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh

# install mysql
ENV OSDEB stretch
ENV MARIADB_MAJOR 10.4
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mariadb

RUN wget --no-check-certificate -O - https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

# clean
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/start.sh"]
CMD ["mysqld"]
#CMD ["supervisord", "-nc", "/etc/supervisor/supervisord.conf"]

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306
