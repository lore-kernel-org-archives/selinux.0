From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: nicolas.iooss@m4x.org, jason@perfinion.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Fix BINDIR/SBINDIR/... variables in Makefiles
Date: Tue, 20 Jun 2017 11:01:20 -0400
Message-Id: <20170620150120.22292-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As reported by Nicolas Iooss, there are still some inconsistencies
in the definitions and usage of Makefile variables related to bin
and sbin directories. Since we need to still support non-usrmerge
systems, we cannot completely synchronize them, but we can eliminate
unnecessary differences, remove unused variables, and drop the
USRSBINDIR variables.

Before:
$ find . -name Makefile -exec cat {} + |grep '^[A-Z_]*BINDIR' |sort -u
BINDIR=$(PREFIX)/bin
BINDIR ?= $(PREFIX)/bin
BINDIR ?= $(PREFIX)/sbin
SBINDIR ?= $(DESTDIR)/sbin
SBINDIR ?= $(PREFIX)/sbin
USRSBINDIR ?= $(PREFIX)/sbin

After:
$ find . -name Makefile -exec cat {} + | grep '^[A-Z_]*BINDIR' | sort -u
BINDIR ?= $(PREFIX)/bin
SBINDIR ?= $(DESTDIR)/sbin
SBINDIR ?= $(PREFIX)/sbin

This does not change the actual install location of any file.
It does drop the legacy symlink from /usr/sbin/load_policy to
/sbin/load_policy; packagers can create that separately if
needed (load_policy was moved in 2009).

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/test/Makefile            | 2 +-
 libselinux/utils/Makefile            | 6 +++---
 mcstrans/utils/Makefile              | 6 +++---
 policycoreutils/hll/pp/Makefile      | 1 -
 policycoreutils/load_policy/Makefile | 3 ---
 policycoreutils/scripts/Makefile     | 4 +---
 python/chcat/Makefile                | 2 --
 python/sepolicy/Makefile             | 1 -
 8 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 0a31c5e..59fa446 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -2,7 +2,7 @@
 # Makefile for building the dispol program
 #
 PREFIX ?= $(DESTDIR)/usr
-BINDIR=$(PREFIX)/bin
+BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 474ee95..843b0e7 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -1,7 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-USRSBINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 INCLUDEDIR ?= $(PREFIX)/include
 
 OS ?= $(shell uname)
@@ -63,8 +63,8 @@ sefcontext_compile: sefcontext_compile.o ../src/regex.o
 all: $(TARGETS)
 
 install: all
-	-mkdir -p $(USRSBINDIR)
-	install -m 755 $(TARGETS) $(USRSBINDIR)
+	-mkdir -p $(SBINDIR)
+	install -m 755 $(TARGETS) $(SBINDIR)
 
 clean:
 	rm -f $(TARGETS) *.o *~
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 7e59641..83ac343 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -1,7 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-BINDIR ?= $(PREFIX)/sbin
+SBINDIR ?= $(PREFIX)/sbin
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Wall
@@ -15,8 +15,8 @@ all: $(TARGETS)
 $(TARGETS): ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 $(TARGETS) $(BINDIR)
+	-mkdir -p $(SBINDIR)
+	install -m 755 $(TARGETS) $(SBINDIR)
 
 test:
 	./mlstrans-test-runner.py ../test/*.test
diff --git a/policycoreutils/hll/pp/Makefile b/policycoreutils/hll/pp/Makefile
index 813c9c6..9dc2dc5 100644
--- a/policycoreutils/hll/pp/Makefile
+++ b/policycoreutils/hll/pp/Makefile
@@ -1,7 +1,6 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
-SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 LIBEXECDIR ?= $(PREFIX)/libexec
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index 256d95a..0db030b 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -1,7 +1,6 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 SBINDIR ?= $(DESTDIR)/sbin
-USRSBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
@@ -18,8 +17,6 @@ install: all
 	install -m 755 $(TARGETS) $(SBINDIR)
 	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
 	install -m 644 load_policy.8 $(MANDIR)/man8/
-	-mkdir -p $(USRSBINDIR)
-	-ln -sf $(SBINDIR)/load_policy $(USRSBINDIR)/load_policy 
 
 clean:
 	-rm -f $(TARGETS) *.o 
diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index 969e5c0..d9e86ff 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -1,7 +1,5 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-USRSBINDIR ?= $(PREFIX)/sbin
 SBINDIR ?= $(DESTDIR)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= $(PREFIX)/share/locale
@@ -10,7 +8,7 @@ LOCALEDIR ?= $(PREFIX)/share/locale
 all: fixfiles
 
 install: all
-	-mkdir -p $(BINDIR)
+	-mkdir -p $(SBINDIR)
 	install -m 755 fixfiles $(SBINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
diff --git a/python/chcat/Makefile b/python/chcat/Makefile
index 0a52e8f..0fd12d6 100644
--- a/python/chcat/Makefile
+++ b/python/chcat/Makefile
@@ -1,8 +1,6 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
-USRSBINDIR ?= $(PREFIX)/sbin
-SBINDIR ?= $(DESTDIR)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= $(PREFIX)/share/locale
 
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 647c540..0d2bec2 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -5,7 +5,6 @@ PREFIX ?= $(DESTDIR)/usr
 SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
 LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/bin
-SBINDIR ?= $(PREFIX)/sbin
 DATADIR ?= $(PREFIX)/share
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
-- 
2.9.4
