TARGET = bgd2_homebrew
OBJS = src/main.o

INCDIR =
CFLAGS = -O2 -G0 -Wall
CXXFLAGS = $(CFLAGS)
ASFLAGS = $(CFLAGS)

LIBDIR =
LIBS = -lpspdebug -lpspdisplay -lpspge -lpspctrl -lpspsdk
LDFLAGS =

PSPSDK = $(shell psp-config --pspsdk-path)
include $(PSPSDK)/lib/build.mak

# Generate EBOOT.PBP
EBOOT = EBOOT.PBP

$(EBOOT): $(TARGET).elf
	mksfo "BennuGD2 Homebrew" PARAM.SFO
	psp-fixup-imports $<
	pack-pbp $(EBOOT) PARAM.SFO NULL NULL NULL NULL NULL $< NULL