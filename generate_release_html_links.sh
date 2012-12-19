#!/bin/sh

#echo "<p><ul><li>Source code:"
#for f in release/*bz2; do
#	BASE="${f##*/}"
#	eval `/usr/bin/stat -s "${f}"`
#	echo "<a href=\"$f\">$BASE</a> $st_size bytes."
#done
#echo "</ul></p>"

echo "<p><ul><li>Generated HTML files:<ul>"
for f in release/*html; do
	BASE="${f##*/}"
	eval `/usr/bin/stat -s "${f}"`
	echo "<li><a href=\"$f\">$BASE</a> $st_size bytes."
done
echo "</ul></ul></p>"

echo "<p><ul><li>Generated PDF files:<ul>"
for f in release/*pdf; do
	BASE="${f##*/}"
	eval `/usr/bin/stat -s "${f}"`
	echo "<li><a href=\"$f\">$BASE</a> $st_size bytes."
done
echo "</ul></ul></p>"

