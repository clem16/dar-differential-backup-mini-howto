#!/bin/sh

DIR=/oldg/backup
BASENAME=${DIR}/`date -I`
FILE=${BASENAME}_data
#CATALOG=${BASENAME}_catalog
/usr/local/bin/dar -m 256 -y -s 600M -D -R / -c $FILE -Z "*.gz" -Z "*.bz2" -Z "*.zip" -P home/gregorio -P tmp -P mnt -P dev/pts -P proc -P floppy -P burner -P cdrom > /dev/null
#/usr/local/bin/dar -C $CATALOG -A $FILE
/usr/local/bin/dar -t $FILE
#/usr/local/bin/dar -t $CATALOG
find $DIR -type f -exec chown .gregorio \{\} \;
find $DIR -type f -exec chmod 440 \{\} \;
