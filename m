Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0CFGm7S028594
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 10:16:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3zJ5rB2GGBz25tJp
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:14:18 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3zJ5r93Q1Nz25tJH
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:14:17 +0000 (UTC)
Received: by mail-lf0-f65.google.com with SMTP id m8so6286441lfc.6
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 07:11:58 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 12 Jan 2018 16:11:33 +0100
Message-Id: <20180112151135.13202-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180112151135.13202-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180112151135.13202-1-marcus.folkesson@gmail.com>
Subject: [PATCH 1/3] libsepol: build: follow standard semantics for
 DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch solves the following issues:
- The pkg-config files generates odd paths when using DESTDIR without PREFIX
- DESTDIR is needed during compile time to compute library and header paths which it should not.
- Installing with both DESTDIR and PREFIX set gives us odd paths
- Make usage of DESTDIR and PREFIX more standard

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 README                      |  2 +-
 libsepol/include/Makefile   |  4 ++--
 libsepol/man/Makefile       |  5 +++--
 libsepol/src/Makefile       | 23 +++++++++++------------
 libsepol/src/libsepol.pc.in |  2 +-
 libsepol/utils/Makefile     |  4 ++--
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/README b/README
index 7fc7b17b..174551a1 100644
--- a/README
+++ b/README
@@ -19,6 +19,6 @@ lacks library functions or other dependencies relied upon by your
 distribution.  If it breaks, you get to keep both pieces.
 
 To install libsepol on macOS (mainly for policy analysis):
-cd libsepol; make DESTDIR=/usr/local PREFIX=/usr/local install
+cd libsepol; make PREFIX=/usr/local install
 
 This requires GNU coreutils (brew install coreutils).
diff --git a/libsepol/include/Makefile b/libsepol/include/Makefile
index 56b7a114..ad5c34a4 100644
--- a/libsepol/include/Makefile
+++ b/libsepol/include/Makefile
@@ -1,6 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCDIR ?= $(PREFIX)/include/sepol
+PREFIX ?= /usr
+INCDIR = $(DESTDIR)$(PREFIX)/include/sepol
 CILDIR ?= ../cil
 
 all:
diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
index 11924334..4f3d9fa2 100644
--- a/libsepol/man/Makefile
+++ b/libsepol/man/Makefile
@@ -1,6 +1,7 @@
 # Installation directories.
-MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
-MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
+PREFIX ?= /usr
+MAN8DIR ?= $(DESTDIR)$(PREFIX)/share/man/man8
+MAN3DIR ?= $(DESTDIR)$(PREFIX)/share/man/man3
 
 all:
 
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 819d261b..35b7829d 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -1,11 +1,10 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
 RANLIB ?= ranlib
-LIBBASE ?= $(shell basename $(LIBDIR))
 CILDIR ?= ../cil
+LIBINSTALL = $(DESTDIR)$(LIBDIR)
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -52,7 +51,7 @@ $(LIBSO): $(LOBJS) $(LIBMAP)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 $(LIBMAP): $(LIBMAP).in
 ifneq ($(DISABLE_CIL),y)
@@ -80,16 +79,16 @@ endif
 	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
 install: all
-	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
-	install -m 644 $(LIBA) $(LIBDIR)
-	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
-	install -m 755 $(LIBSO) $(SHLIBDIR)
-	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
-	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	$(LN) -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
+	test -d $(LIBINSTALL) || install -m 755 -d $(LIBINSTALL)
+	install -m 644 $(LIBA) $(LIBINSTALL)
+	test -d $(LIBINSTALL) || install -m 755 -d $(LIBINSTALL)
+	install -m 755 $(LIBSO) $(LIBINSTALL)
+	test -d $(LIBINSTALL)/pkgconfig || install -m 755 -d $(LIBINSTALL)/pkgconfig
+	install -m 644 $(LIBPC) $(LIBINSTALL)/pkgconfig
+	$(LN) -sf --relative $(LIBINSTALL)/$(LIBSO) $(LIBINSTALL)/$(TARGET)
 
 relabel:
-	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+	/sbin/restorecon $(LIBINSTALL)/$(LIBSO)
 
 clean: 
 	-rm -f $(LIBPC) $(LIBMAP) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) $(CIL_GENERATED)
diff --git a/libsepol/src/libsepol.pc.in b/libsepol/src/libsepol.pc.in
index e52f5892..f807fec6 100644
--- a/libsepol/src/libsepol.pc.in
+++ b/libsepol/src/libsepol.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/@libdir@
+libdir=@libdir@
 includedir=@includedir@
 
 Name: libsepol
diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index fba1d8a0..8ce4bf47 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -1,6 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
 
 CFLAGS ?= -Wall -Werror
 override CFLAGS += -I../include
-- 
2.15.1
