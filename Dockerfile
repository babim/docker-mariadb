FROM babim/debianbase:8

# Download option
RUN apt-get update && \
    apt-get install -y curl bash && \
    curl https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh -o /option.sh && \
    chmod 755 /option.sh

# install mysql
ENV OSDEB stretch
ENV MYSQL_MAJOR 5.5
ENV MYSQL_VERSION 5.5.61
ENV FILEDOWNLOAD mariadb_install.sh
ENV TYPESQL mysql5

RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20Mariadb%20install/$FILEDOWNLOAD | bash

ENTRYPOINT ["/start.sh"]
CMD ["mysqld"]
#CMD ["supervisord", "-nc", "/etc/supervisor/supervisord.conf"]

# Define mountable directories.
VOLUME ["/var/lib/mysql", "/etc/mysql"]

EXPOSE 3306