#!/bin/sh

DIR=/oldg/backup_gregorio
BASENAME=${DIR}/`/bin/date -I`_diff
FILE=${BASENAME}
PREV=`/bin/ls $DIR|/bin/grep -v catal|/usr/bin/tail -n 1|/usr/bin/awk -F '.' '{print $1;}'`
PREV=${DIR}/${PREV}
/usr/local/bin/dar -w -m 256 -y -s 600M -D -R /home/gregorio -c $FILE -Z "*.gz" -Z "*.bz2" -Z "*.zip" -P .spec -P instalacion_manual -P Mail/mail_pa_leer -A $PREV > /dev/null
/usr/local/bin/dar -w -t $FILE > /dev/null
/usr/bin/find $DIR -type f -exec chmod 400 \{\} \;
