#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

test: SetGame.sats SetGame.dats test.dats
	$(PATSCC) -D_GNU_SOURCE -O2 -DATS_MEMALLOC_LIBC -o $@ $^ -latslib
cleanall:: ; rm -f test

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
