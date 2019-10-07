#tremor integer playback codec Makefile for targetting Nintendo64

CFLAGS = -std=gnu99 -O3 -G0 -Wall -mtune=vr4300 -march=vr4300 -I$(N64_INST)/include -I$(N64_INST)/mips64-elf/include
CFLAGS+= -Iinclude/
ASFLAGS = -mtune=vr4300 -march=vr4300
N64PREFIX = $(N64_INST)/bin/mips64-elf-
INSTALLDIR = $(N64_INST)
CC = $(N64PREFIX)gcc
AS = $(N64PREFIX)as
LD = $(N64PREFIX)ld
AR = $(N64PREFIX)ar

all: libvorbisidec.a

SRCS =  mdct.c block.c window.c \
	synthesis.c info.c floor1.c floor0.c vorbisfile.c \
	res012.c mapping0.c registry.c codebook.c \
	sharedbook.c 

OBJS = $(SRCS:.c=.o)

libvorbisidec.a: $(OBJS)
	$(AR) -rcs -o $@ $(OBJS)


install: all
	install -D --mode=644 libvorbisidec.a $(INSTALLDIR)/lib/libvorbisidec.a
	install -D --mode=644 ivorbiscodec.h $(INSTALLDIR)/include/vorbis/ivorbiscodec.h
	install -D --mode=644 ivorbisfile.h $(INSTALLDIR)/include/vorbis/ivorbisfile.h

.PHONY: clean
clean:
	rm -f $(OBJS) *.a