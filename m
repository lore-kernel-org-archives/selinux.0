From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 21 Jan 2018 22:46:09 +0100
Message-Id: <20180121214617.8975-7-marcus.folkesson@gmail.com>
In-Reply-To: <20180121214617.8975-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
Subject: [PATCH v3 06/14] mcstrans: build: follow standard semantics
 for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 mcstrans/man/Makefile   |  3 ++-
 mcstrans/src/Makefile   | 18 +++++++++++-------
 mcstrans/utils/Makefile | 20 ++++++++++++++------
 3 files changed, 27 insertions(+), 14 deletions(-)

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
index 3f4a89c3..09551d63 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -1,10 +1,14 @@
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
+ifeq ($(LIBSEPOLA),)
+       LDFLAGS += -l:libsepol.a
+endif
 
 PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
 PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
@@ -15,11 +19,11 @@ override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 all: $(PROG)
 
-$(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBSEPOLA)
+$(PROG): $(PROG_OBJS) $(LIBSEPOLA)
+	$(CC) -pie -o $@ $^ -lselinux -lcap -lpcre $(LDFLAGS)
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
+	$(CC) $(CFLAGS) -fPIE -c -o $@ $< $(LDFLAGS)
 
 install: all
 	test -d $(SBINDIR) || install -m 755 -d $(SBINDIR)
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 4d3cbfcb..0a0452a4 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -1,18 +1,26 @@
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
+ifeq ($(LIBSEPOLA),)
+       LDFLAGS += -l:libsepol.a
+endif
 
 all: $(TARGETS)
 
-$(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+transcon: transcon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) -lpcre -lselinux
+
+untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) -lpcre -lselinux
 
 install: all
 	-mkdir -p $(SBINDIR)
-- 
2.15.1
