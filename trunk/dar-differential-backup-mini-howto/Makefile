NAME=dar-differential-backup-mini-howto

.PHONY: all dist clean

all: $(NAME).en.html

$(NAME).%.html: source.%.txt
	html.py $< > $@

clean:
	rm -f $(NAME).??.html *.bak

VERSION = $(shell grep Revision source.en.txt | awk '{print $$3}')
BASENAME = $(NAME)-$(VERSION)

dist: all
	rm -fR dist
	mkdir dist
	cp source.*.txt dist
	cp Makefile dist
	cvs2cl.pl -t
	cp ChangeLog dist
	mv dist $(BASENAME)
	arcdir -t bz2 $(BASENAME)
	rm -fR $(BASENAME)
