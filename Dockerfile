# vim:set ft=dockerfile:
FROM babim/ubuntubase:14.04
ENV OSDEB trusty

# Download option
RUN apt-get update && \
    apt-get install -y bash curl && \
    curl https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh -o /option.sh && \
    chmod 755 /option.sh

# install mysql
ENV MARIADB_MAJOR 5.5
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mariadb

RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306

ENTRYPOINT ["/start.sh"]
CMD ["mysqld"]
#CMD ["supervisord", "-nc", "/etc/supervisor/supervisord.conf"]