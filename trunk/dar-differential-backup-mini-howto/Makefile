NAME=dar-differential-backup-mini-howto
CP=cp
RM=rm
FORMATTER=rest2html
FORMATTER_OPTIONS=--embed-stylesheet --stylesheet-path style.css

.PHONY: all dist clean

all: $(NAME).en.html

$(NAME).%.html: source.%.txt
	$(FORMATTER) $(FORMATTER_OPTIONS) $< > $@

clean:
	$(RM) -f $(NAME).??.html *.bak *.bz2

VERSION = $(shell grep Revision source.en.txt | awk '{print $$3}')
BASENAME = $(NAME)-$(VERSION)

dist: all
	$(RM) -fR dist
	mkdir dist
	$(CP) source.*.txt dist
	$(CP) Makefile dist
	cvs2cl.pl -t
	$(CP) ChangeLog dist
	$(RM) -fR $(BASENAME) $(BASENAME).tar.bz2
	mv dist $(BASENAME)
	arcdir -t tar.bz2 $(BASENAME)
	$(RM) -fR $(BASENAME)
	mv $(NAME).??.html $(BASENAME).tar.bz2 ~/web/sdf/textos/
