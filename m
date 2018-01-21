From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 21 Jan 2018 22:46:04 +0100
Message-Id: <20180121214617.8975-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180121214617.8975-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
Subject: [PATCH v3 01/14] libsepol: build: follow standard semantics
 for DESTDIR and PREFIX
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
 README                      | 2 +-
 libsepol/include/Makefile   | 4 ++--
 libsepol/man/Makefile       | 5 +++--
 libsepol/src/Makefile       | 7 +++----
 libsepol/src/libsepol.pc.in | 2 +-
 libsepol/utils/Makefile     | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

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
index 819d261b..d158398f 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -1,10 +1,9 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 INCLUDEDIR ?= $(PREFIX)/include
-LIBDIR ?= $(PREFIX)/lib
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 RANLIB ?= ranlib
-LIBBASE ?= $(shell basename $(LIBDIR))
 CILDIR ?= ../cil
 
 VERSION = $(shell cat ../VERSION)
@@ -52,7 +51,7 @@ $(LIBSO): $(LOBJS) $(LIBMAP)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 $(LIBMAP): $(LIBMAP).in
 ifneq ($(DISABLE_CIL),y)
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
