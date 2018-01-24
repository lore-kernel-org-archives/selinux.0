From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:24 +0100
Message-Id: <20180124092736.8432-4-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 03/15] libsemanage: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch solves the following issues:
- DESTDIR is needed during compile time to compute library and header paths which it should not.
- Installing with both DESTDIR and PREFIX set gives us odd paths
- Make usage of DESTDIR and PREFIX more standard

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 libsemanage/include/Makefile      | 4 ++--
 libsemanage/man/Makefile          | 5 +++--
 libsemanage/src/Makefile          | 9 +++------
 libsemanage/src/libsemanage.pc.in | 2 +-
 libsemanage/tests/Makefile        | 3 ---
 libsemanage/utils/Makefile        | 4 ++--
 6 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/libsemanage/include/Makefile b/libsemanage/include/Makefile
index b660660e..f4234b9e 100644
--- a/libsemanage/include/Makefile
+++ b/libsemanage/include/Makefile
@@ -1,6 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCDIR ?= $(PREFIX)/include/semanage
+PREFIX ?= /usr
+INCDIR ?= $(DESTDIR)$(PREFIX)/include/semanage
 
 all:
 
diff --git a/libsemanage/man/Makefile b/libsemanage/man/Makefile
index 852043d4..43c2b3f6 100644
--- a/libsemanage/man/Makefile
+++ b/libsemanage/man/Makefile
@@ -1,6 +1,7 @@
 # Installation directories.
-MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
-MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
+PREFIX ?= /usr
+MAN3DIR ?= $(DESTDIR)$(PREFIX)/share/man/man3
+MAN5DIR ?= $(DESTDIR)$(PREFIX)/share/man/man5
 
 all:
 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index fdb178f5..f66d1b73 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -8,9 +8,8 @@ RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
+PREFIX ?= /usr
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
@@ -20,8 +19,6 @@ RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] +
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
-LIBBASE=$(shell basename $(LIBDIR))
-
 DEFAULT_SEMANAGE_CONF_LOCATION=$(DESTDIR)/etc/selinux/semanage.conf
 
 ifeq ($(DEBUG),1)
@@ -95,7 +92,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 semanageswig_python_exception.i: ../include/semanage/semanage.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libsemanage.pc.in
index d3eaa062..43681ddb 100644
--- a/libsemanage/src/libsemanage.pc.in
+++ b/libsemanage/src/libsemanage.pc.in
@@ -1,6 +1,6 @@
 prefix=@prefix@
 exec_prefix=${prefix}
-libdir=${exec_prefix}/@libdir@
+libdir=@libdir@
 includedir=@includedir@
 
 Name: libsemanage
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 2ef8d30d..324766a0 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -1,6 +1,3 @@
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-
 # Add your test source files here:
 SOURCES = $(sort $(wildcard *.c))
 
diff --git a/libsemanage/utils/Makefile b/libsemanage/utils/Makefile
index 725f0eec..f527ad07 100644
--- a/libsemanage/utils/Makefile
+++ b/libsemanage/utils/Makefile
@@ -1,6 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBEXECDIR ?= $(PREFIX)/libexec
+PREFIX ?= /usr
+LIBEXECDIR ?= $(DESTDIR)$(PREFIX)/libexec
 SELINUXEXECDIR ?= $(LIBEXECDIR)/selinux/
 
 all:
-- 
2.15.1
