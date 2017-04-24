Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OI0Nbr026576
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:00:32 -0400
Received: by mail-pf0-f169.google.com with SMTP id a188so15873243pfa.0
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 11:00:30 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/7] Makefiles: drop -L/-I to system paths
Date: Tue, 25 Apr 2017 01:59:56 +0800
Message-Id: <20170424175959.20998-4-jason@perfinion.com>
In-Reply-To: <20170424175959.20998-1-jason@perfinion.com>
References: <20170424175959.20998-1-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The toolchain automatically handles them and they break cross compiling.

LDFLAGS should also come before object files, some flags (eg,
-Wl,as-needed) can break things if they are in the wrong place)

Gentoo-Bug: https://bugs.gentoo.org/500674

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 checkpolicy/Makefile                     |  2 +-
 checkpolicy/test/Makefile                |  1 -
 libselinux/src/Makefile                  | 10 +++++-----
 libselinux/utils/Makefile                |  5 +++--
 libsemanage/src/Makefile                 |  8 ++++----
 libsemanage/tests/Makefile               |  8 ++++----
 libsepol/utils/Makefile                  |  4 ++--
 mcstrans/src/Makefile                    |  4 ++--
 mcstrans/utils/Makefile                  |  4 ++--
 policycoreutils/hll/pp/Makefile          |  3 +--
 policycoreutils/load_policy/Makefile     |  4 ++--
 policycoreutils/newrole/Makefile         |  4 ++--
 policycoreutils/run_init/Makefile        |  4 ++--
 policycoreutils/secon/Makefile           |  4 ++--
 policycoreutils/semodule/Makefile        |  3 +--
 policycoreutils/sestatus/Makefile        |  4 ++--
 policycoreutils/setfiles/Makefile        |  3 +--
 policycoreutils/setsebool/Makefile       |  3 +--
 python/audit2allow/Makefile              |  1 -
 python/sepolicy/Makefile                 |  2 +-
 restorecond/Makefile                     |  2 +-
 sandbox/Makefile                         |  4 ++--
 secilc/Makefile                          |  8 ++++----
 semodule-utils/semodule_deps/Makefile    |  1 -
 semodule-utils/semodule_expand/Makefile  |  3 +--
 semodule-utils/semodule_link/Makefile    |  3 +--
 semodule-utils/semodule_package/Makefile |  3 +--
 27 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 98fa380..68e11f2 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -14,7 +14,7 @@ YACC = bison -y
 
 CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
-override CFLAGS += -I. -I${INCLUDEDIR}
+override CFLAGS += -I.
 
 CHECKOBJS = y.tab.o lex.yy.o queue.o module_compiler.o parse_util.o \
 	    policy_define.o
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 54d07f8..0a31c5e 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -8,7 +8,6 @@ INCLUDEDIR ?= $(PREFIX)/include
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
-override CFLAGS += -I$(INCLUDEDIR)
 
 all: dispol dismod
 
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c685e66..f1b8bd9 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -93,7 +93,7 @@ endif
 
 PCRE_LDLIBS ?= -lpcre
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
+override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
 		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
@@ -133,17 +133,17 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) -shared -o $@ $< -L. -lselinux $(LDFLAGS) $(PYLIBS) -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lselinux $(PYLIBS)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS) $(RUBYLIBS) -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) -ldl -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ $(PCRE_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
@@ -156,7 +156,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(PYLIBS) -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS)
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 68f7097..995f444 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -44,8 +44,9 @@ override CFLAGS += -I/opt/local/include -I../../libsepol/include
 override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
 endif
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
-LDLIBS += -L../src -lselinux -L$(LIBDIR)
+override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
+LDFLAGS += -L../src
+LDLIBS += -lselinux
 PCRE_LDLIBS ?= -lpcre
 
 ifeq ($(ANDROID_HOST),y)
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 77f6efc..dba50c8 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -61,7 +61,7 @@ CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-
 SWIG_CFLAGS += -Wno-error -Wno-unused-but-set-variable -Wno-unused-variable -Wno-shadow \
 		-Wno-unused-parameter
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
+override CFLAGS += -I../include -D_GNU_SOURCE
 RANLIB ?= ranlib
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
@@ -81,17 +81,17 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage $(PYLIBS) -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lsemanage $(PYLIBS)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage $(RUBYLIBS) -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 885b544..9b27224 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -5,20 +5,20 @@ LIBDIR ?= $(PREFIX)/lib
 SOURCES = $(wildcard *.c)
 
 # Add the required external object files here:
-LIBS = ../src/libsemanage.a -L$(LIBDIR) -lselinux -lsepol
+LIBS = ../src/libsemanage.a -lselinux -lsepol
 
 ###########################################################################
 
 EXECUTABLE = libsemanage-tests
 CFLAGS += -g -O0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
-INCLUDE = -I../src -I../include -I$(PREFIX)/include
-LDFLAGS += -lcunit -lbz2 -laudit
+INCLUDE = -I../src -I../include
+LDLIBS += -lcunit -lbz2 -laudit
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
 
 $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
-	$(CC) $(OBJECTS) $(LIBS) $(LDFLAGS) -o $@
+	$(CC) $(OBJECTS) $(LIBS) $(LDFLAGS) -o $@ $(LDLIBS)
 
 %.o: %.c
 	$(CC) $(CFLAGS) $(INCLUDE) -c $*.c -o $*.o
diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index 6864114..a13164e 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -3,8 +3,8 @@ PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 
 CFLAGS ?= -Wall -Werror
-override CFLAGS += -I../include
-LDLIBS += -L../src -lsepol 
+LDFLAGS += -L../src
+LDLIBS += -lsepol
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index ea463bc..709e1e0 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -10,12 +10,12 @@ PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
 PROG=mcstransd
 INITSCRIPT=mcstrans
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I$(PREFIX)/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a -L$(LIBDIR)
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 043d001..e6f329b 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -5,8 +5,8 @@ BINDIR ?= $(PREFIX)/sbin
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Wall
-override CFLAGS += -I../src -I$(PREFIX)/include -D_GNU_SOURCE
-LDLIBS += -L$(LIBDIR) -lselinux -lpcre
+override CFLAGS += -I../src -D_GNU_SOURCE
+LDLIBS += -lselinux -lpcre
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Makefile
index 09168bc..1ca6c9d 100644
--- a/policycoreutils/hll/pp/Makefile
+++ b/policycoreutils/hll/pp/Makefile
@@ -8,8 +8,7 @@ LIBEXECDIR ?= $(PREFIX)/libexec
 HLLDIR ?= $(LIBEXECDIR)/selinux/hll
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -L$(LIBDIR)
+LDLIBS = -lsepol
 
 PP_SRCS = $(wildcard *.c)
 PP_OBJS = $(patsubst %.c,%.o,$(PP_SRCS))
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index 7c5bab0..6ab0f9d 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -6,8 +6,8 @@ MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
+override CFLAGS += $(LDFLAGS) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lsepol -lselinux
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index 8b41428..8bfbd5f 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -22,8 +22,8 @@ VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
 EXTRA_OBJS =
-override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -DVERSION=\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux
 ifeq ($(PAMH), /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	EXTRA_OBJS += hashtab.o
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index 5815a08..a3beef7 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -9,8 +9,8 @@ PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -L$(PREFIX)/lib
+override CFLAGS += -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -lselinux
 ifeq ($(PAMH), /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
 	LDLIBS += -lpam -lpam_misc
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index a2d9ca6..1f074ff 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -8,8 +8,8 @@ LIBDIR ?= $(PREFIX)/lib
 WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION = $(shell cat ../VERSION)
 CFLAGS ?= $(WARNS) -O1
-override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(INCLUDEDIR) 
-LDLIBS = -lselinux -L$(LIBDIR)
+override CFLAGS += -DVERSION=\"$(VERSION)\"
+LDLIBS = -lselinux
 
 all: secon
 
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 5b1c026..39ff6a9 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -6,8 +6,7 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -lsepol -lselinux -lsemanage
 SEMODULE_OBJS = semodule.o
 
 all: semodule genhomedircon
diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index c04ff00..8dbbc01 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -6,8 +6,8 @@ ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
-LDLIBS = -lselinux -L$(LIBDIR)
+override CFLAGS += -D_FILE_OFFSET_BITS=64
+LDLIBS = -lselinux
 
 all: sestatus
 
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index 92300c9..f7089f9 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -8,8 +8,7 @@ AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c | awk -S '{ print $$3 }')
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
-LDLIBS = -lselinux -lsepol -L$(LIBDIR)
+LDLIBS = -lselinux -lsepol
 
 ifeq ($(AUDITH), /usr/include/libaudit.h)
 	override CFLAGS += -DUSE_AUDIT
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 45d6538..3295963 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -7,8 +7,7 @@ LIBDIR ?= $(PREFIX)/lib
 BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
+LDLIBS = -lsepol -lselinux -lsemanage
 SETSEBOOL_OBJS = setsebool.o
 
 BASHCOMPLETIONS=setsebool-bash-completion.sh 
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 4f03e95..8db8075 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -10,7 +10,6 @@ INCLUDEDIR ?= $(PREFIX)/include
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
 
 all: audit2why sepolgen-ifgen-attr-helper
 
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index bff8acc..647c540 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -12,7 +12,7 @@ LOCALEDIR ?= /usr/share/locale
 BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
 SHAREDIR ?= $(PREFIX)/share/sandbox
 CFLAGS ?= -Wall -Werror -Wextra -W
-override CFLAGS += -I$(PREFIX)/include -DPACKAGE="policycoreutils" -DSHARED -shared
+override CFLAGS += -DPACKAGE="policycoreutils" -DSHARED -shared
 
 BASHCOMPLETIONS=sepolicy-bash-completion.sh
 
diff --git a/restorecond/Makefile b/restorecond/Makefile
index 9f163f5..5016753 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -17,7 +17,7 @@ DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
 DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
 
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS)
+override CFLAGS += $(DBUSFLAGS)
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
diff --git a/sandbox/Makefile b/sandbox/Makefile
index 2716d69..b12fb77 100644
--- a/sandbox/Makefile
+++ b/sandbox/Makefile
@@ -9,8 +9,8 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
-LDLIBS += -lselinux -lcap-ng -L$(LIBDIR)
+override CFLAGS += -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
+LDLIBS += -lselinux -lcap-ng
 SEUNSHARE_OBJS = seunshare.o
 
 all: sandbox seunshare sandboxX.sh start
diff --git a/secilc/Makefile b/secilc/Makefile
index e714a84..1e36c6e 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -4,7 +4,7 @@ MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 
-LDLIBS = -lsepol -L$(LIBDIR)
+LDLIBS = -lsepol
 
 SECILC = secilc
 SECILC_SRCS := secilc.c
@@ -20,18 +20,18 @@ XMLTO = xmlto
 
 CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
 
-override CFLAGS += -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 all: $(SECILC) $(SECIL2CONF) man
 
 $(SECILC): $(SECILC_OBJS)
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 test: $(SECILC)
 	./$(SECILC) test/policy.cil
 
 $(SECIL2CONF): $(SECIL2CONF_OBJS)
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LDLIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
 
 man: $(SECILC_MANPAGE) $(SECIL2CONF_MANPAGE)
 
diff --git a/semodule-utils/semodule_deps/Makefile b/semodule-utils/semodule_deps/Makefile
index 7d8490f..328a503 100644
--- a/semodule-utils/semodule_deps/Makefile
+++ b/semodule-utils/semodule_deps/Makefile
@@ -7,7 +7,6 @@ MANDIR ?= $(PREFIX)/share/man
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
 
 all: semodule_deps
 
diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semodule_expand/Makefile
index dcbd6d6..22e3579 100644
--- a/semodule-utils/semodule_expand/Makefile
+++ b/semodule-utils/semodule_expand/Makefile
@@ -6,8 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -L$(LIBDIR)
+LDLIBS = -lsepol
 
 all: semodule_expand
 
diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodule_link/Makefile
index 4e8e828..1e4e278 100644
--- a/semodule-utils/semodule_link/Makefile
+++ b/semodule-utils/semodule_link/Makefile
@@ -6,8 +6,7 @@ MANDIR ?= $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -L$(LIBDIR)
+LDLIBS = -lsepol
 
 all: semodule_link
 
diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/semodule_package/Makefile
index ca08bc4..5b0d2cc 100644
--- a/semodule-utils/semodule_package/Makefile
+++ b/semodule-utils/semodule_package/Makefile
@@ -6,8 +6,7 @@ LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = -lsepol -L$(LIBDIR)
+LDLIBS = -lsepol
 
 all: semodule_package semodule_unpackage
 
-- 
2.10.2
