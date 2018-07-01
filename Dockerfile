# vim:set ft=dockerfile:
FROM babim/debianbase:8

# Download option
RUN apt-get update && \
    apt-get install -y wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh && apt-get install -y --no-install-recommends apt-transport-https ca-certificates

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

# add gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -ex; \
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -q --no-check-certificate -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu nobody true

# add repo Mariadb
ENV GPG_KEYS \
	199369E5404BD5FC7D2FE43BCBCB082A1BB943DB \
	430BDF5C56E7C94E848EE60C1C4CBDCDCD2EFD2A \
	4D1BB29D63D98E422B2113B19334A25F8507EFA5
RUN set -ex; \
	export GNUPGHOME="$(mktemp -d)"; \
	for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done; \
	gpg --export $GPG_KEYS > /etc/apt/trusted.gpg.d/mariadb.gpg; \
	rm -r "$GNUPGHOME"; \
	apt-key list

# add Percona's repo for xtrabackup (which is useful for Galera)
RUN echo "deb https://repo.percona.com/apt jessie main" > /etc/apt/sources.list.d/percona.list \
	&& { \
		echo 'Package: *'; \
		echo 'Pin: release o=Percona Development Team'; \
		echo 'Pin-Priority: 998'; \
	} > /etc/apt/preferences.d/percona

# add repo Mysql
RUN set -ex; \
# gpg: key 5072E1F5: public key "MySQL Release Engineering <mysql-build@oss.oracle.com>" imported
	key='A4A9406876FCBD3C456770C88C718D3B5072E1F5'; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	gpg --export "$key" > /etc/apt/trusted.gpg.d/mysql.gpg; \
	rm -rf "$GNUPGHOME"; \
apt-key list > /dev/null

RUN mkdir /docker-entrypoint-initdb.d

# install "pwgen" for randomizing passwords
RUN apt-get update && apt-get install -y --no-install-recommends \
		pwgen \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -sf /usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards
RUN chmod 775 /usr/local/bin/docker-entrypoint.sh

# backup
COPY backup.sh /backup.sh
RUN chmod 755 /backup.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
