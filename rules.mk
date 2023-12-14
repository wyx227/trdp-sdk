

ECHO    = echo


AS	= $(TCPATH)$(TCPREFIX)as
LD	= $(TCPATH)$(TCPREFIX)ld
CC	= $(TCPATH)$(TCPREFIX)gcc
CPP	= $(TCPATH)$(CC) -E
AR	= $(TCPATH)$(TCPREFIX)ar
NM	= $(TCPATH)$(TCPREFIX)nm
STRIP	= $(TCPATH)$(TCPREFIX)strip
OBJCOPY = $(TCPATH)$(TCPREFIX)objcopy
OBJDUMP = $(TCPATH)$(TCPREFIX)objdump
RANLIB	= $(TCPATH)$(TCPREFIX)RANLIB
LN	= ln -s
SVN = svn
PATCH = patch


ifeq ($(DEBUG), TRUE)
ifneq ($(TARGET_OS), INTEGRITY)
DBGFLAGS= -g
else
DBGFLAGS= -G
endif
else
ifneq ($(TARGET_OS), INTEGRITY)
OPTFLAGS= -O2
ifneq ($(TARGET_OS), ARM_TI)
WARNFLAGS= -Wall
endif
else
OPTFLAGS= -Ospeed -OI
WARNFLAGS= -Wall
endif
endif

       

