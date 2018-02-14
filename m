From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:08 +0100
Message-Id: <20180214095717.1050-7-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 06/15] mcstrans: build: follow standard semantics
 for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
    	- Only use $(DESTDIR) in install
    	- Remove CFLAGS from linking rule
    	- Do not override CFLAGS
    
    v3:
    	- keep the possibility to specify LIBSEPOLA to
    	make depending component recompile on change. If not specified, fall back to
    	libsepola in LDFLAGS path.
    
    v2:
    	- Rework all packages (not just selinux/sepol/semanage)

 mcstrans/man/Makefile   |  7 ++++---
 mcstrans/src/Makefile   | 36 ++++++++++++++++++++----------------
 mcstrans/utils/Makefile | 28 ++++++++++++++++++----------
 3 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
index 8e971192..645f6286 100644
--- a/mcstrans/man/Makefile
+++ b/mcstrans/man/Makefile
@@ -1,11 +1,12 @@
 # Installation directories.
-MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
+PREFIX ?= /usr
+MAN8DIR ?= $(PREFIX)/share/man/man8
 
 all:
 
 install: all
-	mkdir -p $(MAN8DIR)
-	install -m 644 man8/*.8 $(MAN8DIR)
+	mkdir -p $(DESTDIR)$(MAN8DIR)
+	install -m 644 man8/*.8 $(DESTDIR)$(MAN8DIR)
 
 clean:
 	-rm -f *~ \#*
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 3f4a89c3..76ef0557 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -1,33 +1,37 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-SBINDIR ?= $(DESTDIR)/sbin
-INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
-SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+PREFIX ?= /usr
+SBINDIR ?= /sbin
+INITDIR ?= /etc/rc.d/init.d
+SYSTEMDDIR ?= $(PREFIX)/lib/systemd
+
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
 
 PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
 PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
 PROG=mcstransd
 INITSCRIPT=mcstrans
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 all: $(PROG)
 
-$(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBSEPOLA)
+$(PROG): $(PROG_OBJS) $(LIBSEPOLA)
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LDLIBS_LIBSEPOLA)
 
 %.o:  %.c 
-	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
+	$(CC) $(CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -fPIE -c -o $@ $<
 
 install: all
-	test -d $(SBINDIR) || install -m 755 -d $(SBINDIR)
-	install -m 755 $(PROG) $(SBINDIR)
-	test -d $(INITDIR) || install -m 755 -d $(INITDIR)
-	install -m 755 $(INITSCRIPT).init $(INITDIR)/$(INITSCRIPT)
-	test -d $(SYSTEMDDIR)/system || install -m 755 -d $(SYSTEMDDIR)/system
-	install -m 644 mcstrans.service $(SYSTEMDDIR)/system/
+	test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d $(DESTDIR)$(SBINDIR)
+	install -m 755 $(PROG) $(DESTDIR)$(SBINDIR)
+	test -d $(DESTDIR)$(INITDIR) || install -m 755 -d $(DESTDIR)$(INITDIR)
+	install -m 755 $(INITSCRIPT).init $(DESTDIR)$(INITDIR)/$(INITSCRIPT)
+	test -d $(DESTDIR)$(SYSTEMDDIR)/system || install -m 755 -d $(DESTDIR)$(SYSTEMDDIR)/system
+	install -m 644 mcstrans.service $(DESTDIR)$(SYSTEMDDIR)/system/
 
 clean: 
 	-rm -f $(OBJS) $(LOBJS) $(TARGET) $(PROG) $(PROG_OBJS) *~ \#*
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 4d3cbfcb..9dfe7723 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -1,22 +1,30 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
-CFLAGS ?= -Wall
-override CFLAGS += -I../src -D_GNU_SOURCE
-override LDLIBS += -lselinux -lpcre
+TARGETS=transcon untranscon
 
-TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
 
 all: $(TARGETS)
 
-$(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+transcon: transcon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
+
+untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
+	$(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
+
+%.o:  %.c 
+	$(CC) $(CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
 
 install: all
-	-mkdir -p $(SBINDIR)
-	install -m 755 $(TARGETS) $(SBINDIR)
+	-mkdir -p $(DESTDIR)$(SBINDIR)
+	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
 
 test:
 	./mlstrans-test-runner.py ../test/*.test
-- 
2.15.1
