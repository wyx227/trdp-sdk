#/*****************************************************************************
# *  COPYRIGHT     : (c) 2021 Bombardier Inc. or its subsidiaries
# *****************************************************************************
# *
# *  PRODUCT       : CONNECTA3 WP4 WLCN SW
# *
# *  MODULE        : LINUX_X86_64_config
# *
# *  ABSTRACT      : Environment Setting Linux X86-64 for WLCN SW
# *
# *  REVISION      : $Id: LINUX_X86_64_config 15 2021-08-30 08:09:28Z yyao $
# *
# ****************************************************************************/


ARCH = linux-x86_64
TARGET_VOS = posix
TARGET_OS = LINUX
TCPREFIX = 
TCPOSTFIX = 
DOXYPATH = /usr/local/bin/

# the _GNU_SOURCE is needed to get the extended poll feature for the POSIX socket

CFLAGS += -Wall -m64 -fstrength-reduce -fno-builtin -fsigned-char -pthread -fPIC -D_GNU_SOURCE -DPOSIX -DL_ENDIAN -I/usr/include/libxml2 -std=c99
LDFLAGS += -m64 -luuid -lpthread

LINT_SYSINCLUDE_DIRECTIVES = -i ./src/vos/posix -wlib 0 -DL_ENDIAN

