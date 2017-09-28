`docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD="mypass" babim/mariadb`

tag:
```
10.1		10.1.ssh		10.1.cron		10.1.cron.ssh
10.2		10.2.ssh		10.2.cron		10.2.cron.ssh
10.3		10.3.ssh		10.3.cron		10.3.cron.ssh
```

### Add VOLUMEs to allow backup of config and databases
`/var/lib/mysql`
```
with crontab -v /crontab:/var/spool/cron
```
root/ set password MYSQL_ROOT_PASSWORD
```
MYSQL_DATABASE
MYSQL_USER
MYSQL_PASSWORD
```
custom config
```
-v /my/custom:/etc/mysql/conf.d
```
