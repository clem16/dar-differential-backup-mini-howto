#!/bin/sh

DIR=/oldg/backup_gregorio
BASENAME=${DIR}/`/bin/date -I`
FILE=${BASENAME}_data
#CATALOG=${BASENAME}_catalog
/usr/local/bin/dar -m 256 -y -s 600M -D -R /home/gregorio -c $FILE -Z "*.gz" -Z "*.bz2" -Z "*.zip" -P .spec -P instalacion_manual -P Mail/mail_pa_leer > /dev/null
#/usr/local/bin/dar -C $CATALOG -A $FILE
/usr/local/bin/dar -t $FILE > /dev/null
#/usr/local/bin/dar -t $CATALOG > /dev/null
/usr/bin/find $DIR -type f -exec chmod 400 \{\} \;
