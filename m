From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:23 +0100
Message-Id: <20180124092736.8432-3-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 02/15] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
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
 libselinux/include/Makefile     |  4 ++--
 libselinux/man/Makefile         |  7 ++++---
 libselinux/src/Makefile         | 17 +++++++++++------
 libselinux/src/libselinux.pc.in |  2 +-
 libselinux/utils/Makefile       |  6 ++----
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/libselinux/include/Makefile b/libselinux/include/Makefile
index 757a6c9c..3b51f5ce 100644
--- a/libselinux/include/Makefile
+++ b/libselinux/include/Makefile
@@ -1,6 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCDIR ?= $(PREFIX)/include/selinux
+PREFIX ?= /usr
+INCDIR = $(DESTDIR)$(PREFIX)/include/selinux
 
 all:
 
diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
index 0643e6af..233bfaa9 100644
--- a/libselinux/man/Makefile
+++ b/libselinux/man/Makefile
@@ -1,7 +1,8 @@
 # Installation directories.
-MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
-MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
-MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
+PREFIX	?= /usr
+MAN8DIR ?= $(DESTDIR)$(PREFIX)/share/man/man8
+MAN5DIR ?= $(DESTDIR)$(PREFIX)/share/man/man5
+MAN3DIR ?= $(DESTDIR)$(PREFIX)/share/man/man3
 
 all:
 
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 18df75c8..bd9980db 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -8,8 +8,8 @@ RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
@@ -19,8 +19,6 @@ PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixe
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
-LIBBASE ?= $(shell basename $(LIBDIR))
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -50,6 +48,13 @@ LIBSO=$(TARGET).$(LIBVERSION)
 AUDIT2WHYLOBJ=$(PYPREFIX)audit2why.lo
 AUDIT2WHYSO=$(PYPREFIX)audit2why.so
 
+# If no specific libsepol.a is specified, fall back on LDFLAGS search path
+# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
+# is no need to define a value for LDLIBS_LIBSEPOLA
+ifeq ($(LIBSEPOLA),)
+        LDLIBS_LIBSEPOLA := -l:libsepol.a
+endif
+
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
 SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 
@@ -148,7 +153,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
@@ -157,7 +162,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS)
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 2e90a844..7c66b1fa 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/@libdir@
+libdir=@libdir@
 includedir=@includedir@
 
 Name: libselinux
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index eb4851a9..9adce6d3 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -1,8 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-SBINDIR ?= $(PREFIX)/sbin
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
 
 OS ?= $(shell uname)
 
-- 
2.15.1
