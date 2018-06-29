FROM babim/alpinebase

## alpine linux
RUN apk add --no-cache wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh && apk del wget

ENV GOTPL_VER 0.1.5
#ENV MARIADB_VER 10.1.26-r0
ENV GOTPL_URL https://github.com/wodby/gotpl/releases/download/${GOTPL_VER}/gotpl-alpine-linux-amd64-${GOTPL_VER}.tar.gz

RUN set -xe && \
    apk add --no-cache \
        bash \
        ca-certificates \
        make \
        mariadb=${MARIADB_VER} \
        mariadb-client \
        pwgen \
        tzdata \
        wget && \

    wget -qO- ${GOTPL_URL} | tar xz -C /usr/local/bin

RUN mkdir -p /var/run/mysqld && mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /var/run/mysqld && chown -R mysql:mysql /var/lib/mysql

RUN mkdir /docker-entrypoint-initdb.d
COPY actions /usr/local/bin

RUN chown mysql:mysql /usr/local/bin/actions.mk /usr/local/bin/wait-for-mariadb.sh

COPY *.tpl /etc/gotpl/
COPY docker-entrypoint.sh /
RUN chmod 775 /docker-entrypoint.sh

# backup
COPY backup.sh /backup.sh
RUN chmod 755 /backup.sh

WORKDIR /var/lib/mysql
VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["mysqld"]
