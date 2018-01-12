Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0CFFnmV027882
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 10:15:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 3zJ5rP3vkDz4KRlV
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:14:29 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 3zJ5rP211mz4KRlQ
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:14:29 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id o89so2169653lfg.10
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 07:12:01 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 12 Jan 2018 16:11:35 +0100
Message-Id: <20180112151135.13202-4-marcus.folkesson@gmail.com>
In-Reply-To: <20180112151135.13202-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180112151135.13202-1-marcus.folkesson@gmail.com>
Subject: [PATCH 3/3] libsemanage: build: follow standard semantics
 for DESTDIR and PREFIX
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
 libsemanage/include/Makefile      |  4 ++--
 libsemanage/man/Makefile          |  5 +++--
 libsemanage/src/Makefile          | 22 ++++++++++------------
 libsemanage/src/libsemanage.pc.in |  2 +-
 libsemanage/tests/Makefile        |  3 ---
 5 files changed, 16 insertions(+), 20 deletions(-)

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
index fdb178f5..e47518ba 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -8,10 +8,10 @@ RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
+PREFIX ?= /usr
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
+LIBINSTALL = $(DESTDIR)$(LIBDIR)
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
@@ -20,8 +20,6 @@ RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] +
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
-LIBBASE=$(shell basename $(LIBDIR))
-
 DEFAULT_SEMANAGE_CONF_LOCATION=$(DESTDIR)/etc/selinux/semanage.conf
 
 ifeq ($(DEBUG),1)
@@ -95,7 +93,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 semanageswig_python_exception.i: ../include/semanage/semanage.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
@@ -136,13 +134,13 @@ swigify: $(SWIGIF)
 	$(SWIG) $<
 
 install: all 
-	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
-	install -m 644 $(LIBA) $(LIBDIR)
-	install -m 755 $(LIBSO) $(LIBDIR)
-	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
-	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
+	test -d $(LIBINSTALL) || install -m 755 -d $(LIBINSTALL)
+	install -m 644 $(LIBA) $(LIBINSTALL)
+	install -m 755 $(LIBSO) $(LIBINSTALL)
+	test -d $(LIBINSTALL)/pkgconfig || install -m 755 -d $(LIBINSTALL)/pkgconfig
+	install -m 644 $(LIBPC) $(LIBINSTALL)/pkgconfig
 	test -f $(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)
-	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+	cd $(LIBINSTALL) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap 
 	test -d $(PYSITEDIR) || install -m 755 -d $(PYSITEDIR)
@@ -155,7 +153,7 @@ install-rubywrap: rubywrap
 	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/semanage.so
 
 relabel:
-	/sbin/restorecon $(LIBDIR)/$(LIBSO)
+	/sbin/restorecon $(LIBINSTALL)/$(LIBSO)
 
 clean: 
 	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
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
 
-- 
2.15.1
