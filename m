Message-Id: <20080103184516.399115672@tresys.com>
References: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:38 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 7/7] Use -Werror
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add -Werror to Makefiles

---
 checkpolicy/Makefile                      |    2 +-
 libselinux/src/Makefile                   |    2 +-
 libsemanage/src/Makefile                  |    2 +-
 libsepol/src/Makefile                     |    2 +-
 policycoreutils/audit2why/Makefile        |    2 +-
 policycoreutils/load_policy/Makefile      |    2 +-
 policycoreutils/newrole/Makefile          |    2 +-
 policycoreutils/restorecond/Makefile      |    2 +-
 policycoreutils/run_init/Makefile         |    2 +-
 policycoreutils/secon/Makefile            |    2 +-
 policycoreutils/semodule/Makefile         |    2 +-
 policycoreutils/semodule_deps/Makefile    |    2 +-
 policycoreutils/semodule_expand/Makefile  |    2 +-
 policycoreutils/semodule_link/Makefile    |    2 +-
 policycoreutils/semodule_package/Makefile |    2 +-
 policycoreutils/sestatus/Makefile         |    2 +-
 policycoreutils/setfiles/Makefile         |    2 +-
 policycoreutils/setsebool/Makefile        |    2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

Index: trunk/checkpolicy/Makefile
===================================================================
--- trunk.orig/checkpolicy/Makefile
+++ trunk/checkpolicy/Makefile
@@ -10,7 +10,7 @@ TARGETS = checkpolicy checkmodule
 
 YACC = bison -y
 
-CFLAGS ?= -g -Wall -O2 -pipe -fno-strict-aliasing
+CFLAGS ?= -g -Wall -Werror -O2 -pipe -fno-strict-aliasing
 
 override CFLAGS += -I. -I${INCLUDEDIR}
 
Index: trunk/libselinux/src/Makefile
===================================================================
--- trunk.orig/libselinux/src/Makefile
+++ trunk/libselinux/src/Makefile
@@ -32,7 +32,7 @@ SRCS= $(filter-out $(UNUSED_SRCS), $(fil
 
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
-CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
+CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Werror
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 RANLIB=ranlib
 
Index: trunk/libsemanage/src/Makefile
===================================================================
--- trunk.orig/libsemanage/src/Makefile
+++ trunk/libsemanage/src/Makefile
@@ -31,7 +31,7 @@ SWIGFILES=$(SWIGSO) semanage.py 
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) conf-scan.o conf-parse.o
 LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c))) conf-scan.lo conf-parse.lo
-CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
+CFLAGS ?= -Wall -W Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
 
Index: trunk/libsepol/src/Makefile
===================================================================
--- trunk.orig/libsepol/src/Makefile
+++ trunk/libsepol/src/Makefile
@@ -10,7 +10,7 @@ TARGET=libsepol.so
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
+CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Werror
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
 all: $(LIBA) $(LIBSO)
Index: trunk/policycoreutils/audit2why/Makefile
===================================================================
--- trunk.orig/policycoreutils/audit2why/Makefile
+++ trunk/policycoreutils/audit2why/Makefile
@@ -7,7 +7,7 @@ LOCALEDIR ?= /usr/share/locale
 INCLUDEDIR ?= ${PREFIX}/include
 
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = ${LIBDIR}/libsepol.a -lselinux -L$(LIBDIR)
 
Index: trunk/policycoreutils/load_policy/Makefile
===================================================================
--- trunk.orig/policycoreutils/load_policy/Makefile
+++ trunk/policycoreutils/load_policy/Makefile
@@ -4,7 +4,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
 
Index: trunk/policycoreutils/newrole/Makefile
===================================================================
--- trunk.orig/policycoreutils/newrole/Makefile
+++ trunk/policycoreutils/newrole/Makefile
@@ -20,7 +20,7 @@ NAMESPACE_PRIV ?= n
 LSPP_PRIV ?= n
 VERSION = $(shell cat ../VERSION)
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 EXTRA_OBJS =
 override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
Index: trunk/policycoreutils/restorecond/Makefile
===================================================================
--- trunk.orig/policycoreutils/restorecond/Makefile
+++ trunk/policycoreutils/restorecond/Makefile
@@ -5,7 +5,7 @@ MANDIR = $(PREFIX)/share/man
 INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
-CFLAGS ?= -g -Werror -Wall -W
+CFLAGS ?= -g -Werror -Wall -W -Werror
 override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS += -lselinux -L$(PREFIX)/lib
 
Index: trunk/policycoreutils/run_init/Makefile
===================================================================
--- trunk.orig/policycoreutils/run_init/Makefile
+++ trunk/policycoreutils/run_init/Makefile
@@ -8,7 +8,7 @@ LOCALEDIR ?= /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
Index: trunk/policycoreutils/secon/Makefile
===================================================================
--- trunk.orig/policycoreutils/secon/Makefile
+++ trunk/policycoreutils/secon/Makefile
@@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
-WARNS=-W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
+WARNS=-W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal -Werror
 VERSION = $(shell cat ../VERSION)
 CFLAGS ?= $(WARNS) -O1
 override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
Index: trunk/policycoreutils/semodule/Makefile
===================================================================
--- trunk.orig/policycoreutils/semodule/Makefile
+++ trunk/policycoreutils/semodule/Makefile
@@ -5,7 +5,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
Index: trunk/policycoreutils/semodule_deps/Makefile
===================================================================
--- trunk.orig/policycoreutils/semodule_deps/Makefile
+++ trunk/policycoreutils/semodule_deps/Makefile
@@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = $(LIBDIR)/libsepol.a
 
Index: trunk/policycoreutils/semodule_expand/Makefile
===================================================================
--- trunk.orig/policycoreutils/semodule_expand/Makefile
+++ trunk/policycoreutils/semodule_expand/Makefile
@@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
Index: trunk/policycoreutils/semodule_link/Makefile
===================================================================
--- trunk.orig/policycoreutils/semodule_link/Makefile
+++ trunk/policycoreutils/semodule_link/Makefile
@@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
Index: trunk/policycoreutils/semodule_package/Makefile
===================================================================
--- trunk.orig/policycoreutils/semodule_package/Makefile
+++ trunk/policycoreutils/semodule_package/Makefile
@@ -5,7 +5,7 @@ BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
Index: trunk/policycoreutils/sestatus/Makefile
===================================================================
--- trunk.orig/policycoreutils/sestatus/Makefile
+++ trunk/policycoreutils/sestatus/Makefile
@@ -5,7 +5,7 @@ MANDIR = $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= ${PREFIX}/lib
 
-CFLAGS = -Werror -Wall -W
+CFLAGS = -Werror -Wall -W -Werror
 override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
Index: trunk/policycoreutils/setfiles/Makefile
===================================================================
--- trunk.orig/policycoreutils/setfiles/Makefile
+++ trunk/policycoreutils/setfiles/Makefile
@@ -6,7 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
 
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
-CFLAGS = -Werror -Wall -W 
+CFLAGS = -Werror -Wall -W  -Werror
 override CFLAGS += -D_FILE_OFFSET_BITS=64 -I$(PREFIX)/include
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
Index: trunk/policycoreutils/setsebool/Makefile
===================================================================
--- trunk.orig/policycoreutils/setsebool/Makefile
+++ trunk/policycoreutils/setsebool/Makefile
@@ -5,7 +5,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
-CFLAGS ?= -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W -Werror
 override CFLAGS += -I$(INCLUDEDIR)
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
