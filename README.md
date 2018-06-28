`docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD="mypass" babim/mariadb`

tag:
```
10.0		10.1			10.1.alpine
10.2		5.5			mysql5.6		mysql5.7
10.3		mysql5.5		mysql5.8
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

## Environment ssh, cron option
```
SSH=false
SSHPASS=root (or you set)

CRON=false
NFS=false
SYNOLOGY=false
UPGRADE=false
WWWUSER=www-data
MYSQLUSER=mysql
FULLOPTION=true
```

## NFS option
Writing back to the host:
```
docker run -itd \
    --privileged=true \
    --net=host \
    --name nfs-movies \
    -v /media/nfs-movies:/mnt/nfs-1:shared \
    -e SERVER=192.168.0.9 \
    -e SHARE=movies \
    babim/........
```
```
default:
FSTYPE nfs4
MOUNT_OPTIONS nfsvers=4
MOUNTPOINT /mnt/nfs-1
---
max FSTYPE, MOUNT_OPTIONS, MOUNTPOINT
FSTYPE2
FSTYPE3
FSTYPE4
```