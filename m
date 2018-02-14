From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:03 +0100
Message-Id: <20180214095717.1050-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 01/15] libsepol: build: follow standard semantics
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

Notes:
    v5:
    	- Only use $(DESTDIR) in install
    v4:
    	- Introduce LDLIBS_LIBSEPOLA if LIBSEPOLA is not defined.
    v2:
    	- Use separate directories for shared libraries as before( Comment from Stephen Smalley)
    	- Rework all packages (not just selinux/sepol/semanage)

 README                      |  2 +-
 libsepol/include/Makefile   | 16 ++++++++--------
 libsepol/man/Makefile       | 13 +++++++------
 libsepol/src/Makefile       | 23 +++++++++++------------
 libsepol/src/libsepol.pc.in |  2 +-
 libsepol/utils/Makefile     |  6 +++---
 6 files changed, 31 insertions(+), 31 deletions(-)

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
index 56b7a114..1ad4ecab 100644
--- a/libsepol/include/Makefile
+++ b/libsepol/include/Makefile
@@ -1,17 +1,17 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCDIR ?= $(PREFIX)/include/sepol
+PREFIX ?= /usr
+INCDIR = $(PREFIX)/include/sepol
 CILDIR ?= ../cil
 
 all:
 
 install: all
-	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
-	test -d $(INCDIR)/policydb || install -m 755 -d $(INCDIR)/policydb
-	test -d $(INCDIR)/cil || install -m 755 -d $(INCDIR)/cil
-	install -m 644 $(wildcard sepol/*.h) $(INCDIR)
-	install -m 644 $(wildcard sepol/policydb/*.h) $(INCDIR)/policydb
-	install -m 644 $(wildcard $(CILDIR)/include/cil/*.h) $(INCDIR)/cil
+	test -d $(DESTDIR)$(INCDIR) || install -m 755 -d $(DESTDIR)$(INCDIR)
+	test -d $(DESTDIR)$(INCDIR)/policydb || install -m 755 -d $(DESTDIR)$(INCDIR)/policydb
+	test -d $(DESTDIR)$(INCDIR)/cil || install -m 755 -d $(DESTDIR)$(INCDIR)/cil
+	install -m 644 $(wildcard sepol/*.h) $(DESTDIR)$(INCDIR)
+	install -m 644 $(wildcard sepol/policydb/*.h) $(DESTDIR)$(INCDIR)/policydb
+	install -m 644 $(wildcard $(CILDIR)/include/cil/*.h) $(DESTDIR)$(INCDIR)/cil
 
 indent:
 	../../scripts/Lindent $(wildcard sepol/*.h)
diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
index 11924334..9b754548 100644
--- a/libsepol/man/Makefile
+++ b/libsepol/man/Makefile
@@ -1,12 +1,13 @@
 # Installation directories.
-MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
-MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
+PREFIX ?= /usr
+MAN8DIR ?= $(PREFIX)/share/man/man8
+MAN3DIR ?= $(PREFIX)/share/man/man3
 
 all:
 
 install: all
-	mkdir -p $(MAN3DIR)
-	mkdir -p $(MAN8DIR)
-	install -m 644 man3/*.3 $(MAN3DIR)
-	install -m 644 man8/*.8 $(MAN8DIR)
+	mkdir -p $(DESTDIR)$(MAN3DIR)
+	mkdir -p $(DESTDIR)$(MAN8DIR)
+	install -m 644 man3/*.3 $(DESTDIR)$(MAN3DIR)
+	install -m 644 man8/*.8 $(DESTDIR)$(MAN8DIR)
 
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 819d261b..ccb70233 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -1,10 +1,9 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
+SHLIBDIR ?= /lib
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
+	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
+	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
+	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
+	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
+	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
+	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
+	$(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 relabel:
-	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+	/sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
 
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
index fba1d8a0..31932c11 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 
 CFLAGS ?= -Wall -Werror
@@ -12,8 +12,8 @@ TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 all: $(TARGETS)
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 $(TARGETS) $(BINDIR)
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 $(TARGETS) $(DESTDIR)$(BINDIR)
 
 clean:
 	-rm -f $(TARGETS) *.o 
-- 
2.15.1
