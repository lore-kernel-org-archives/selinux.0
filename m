From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:27 +0100
Message-Id: <20180124092736.8432-7-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 06/15] mcstrans: build: follow standard semantics
 for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 mcstrans/man/Makefile   |  3 ++-
 mcstrans/src/Makefile   | 18 ++++++++++++------
 mcstrans/utils/Makefile | 22 ++++++++++++++++------
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
index 8e971192..5030fa81 100644
--- a/mcstrans/man/Makefile
+++ b/mcstrans/man/Makefile
@@ -1,5 +1,6 @@
 # Installation directories.
-MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
+PREFIX ?= /usr
+MAN8DIR ?= $(DESTDIR)$(PREFIX)/share/man/man8
 
 all:
 
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 3f4a89c3..8a8743f1 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -1,10 +1,16 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 SBINDIR ?= $(DESTDIR)/sbin
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
-SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+SYSTEMDDIR ?= $(DESTDIR)$(PREFIX)/lib/systemd
+
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
 
 PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
 PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
@@ -15,8 +21,8 @@ override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 all: $(PROG)
 
-$(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBSEPOLA)
+$(PROG): $(PROG_OBJS) $(LIBSEPOLA)
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LDLIBS_LIBSEPOLA)
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 4d3cbfcb..9d740617 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -1,18 +1,28 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-SBINDIR ?= $(PREFIX)/sbin
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+PREFIX ?= /usr
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../src -D_GNU_SOURCE
 override LDLIBS += -lselinux -lpcre
 
-TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
+TARGETS=transcon untranscon
+
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
 
 all: $(TARGETS)
 
-$(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+transcon: transcon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
+
+untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
 
 install: all
 	-mkdir -p $(SBINDIR)
-- 
2.15.1
