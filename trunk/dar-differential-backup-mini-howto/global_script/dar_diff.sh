#!/bin/sh

DIR=/oldg/backup
BASENAME=${DIR}/`/bin/date -I`_diff
FILE=${BASENAME}
PREV=`/bin/ls $DIR|/bin/grep -v catal|/usr/bin/tail -n 1|/usr/bin/awk -F '.' '{print $1;}'`
PREV=${DIR}/${PREV}
/usr/local/bin/dar -w -m 256 -y -s 600M -D -R / -c $FILE -Z "*.gz" -Z "*.bz2" -Z "*.zip" -P home/gregorio -P tmp -P mnt -P dev/pts -P proc -P floppy -P burner -P cdrom -A $PREV > /dev/null
/usr/local/bin/dar -w -t $FILE > /dev/null
/usr/bin/find $DIR -type f -exec chown .gregorio \{\} \;
/usr/bin/find $DIR -type f -exec chmod 400 \{\} \;
