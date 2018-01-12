Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0CFI27G030064
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 10:18:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 3zJ5vQ716Sz2tcyJ
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:17:06 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 3zJ5vQ5Q8nz2kyQh
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:17:06 +0000 (UTC)
Received: by mail-lf0-f66.google.com with SMTP id h137so6280679lfe.8
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 07:13:00 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 12 Jan 2018 16:11:34 +0100
Message-Id: <20180112151135.13202-3-marcus.folkesson@gmail.com>
In-Reply-To: <20180112151135.13202-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180112151135.13202-1-marcus.folkesson@gmail.com>
Subject: [PATCH 2/3] libselinux: build: follow standard semantics
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
 libselinux/include/Makefile     |  4 ++--
 libselinux/man/Makefile         |  7 ++++---
 libselinux/src/Makefile         | 28 +++++++++++++---------------
 libselinux/src/libselinux.pc.in |  2 +-
 libselinux/utils/Makefile       |  6 ++----
 5 files changed, 22 insertions(+), 25 deletions(-)

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
index 18df75c8..1728f6bf 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
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
@@ -19,8 +19,6 @@ PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixe
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
-LIBBASE ?= $(shell basename $(LIBDIR))
-LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -148,7 +146,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
@@ -156,8 +154,8 @@ selinuxswig_python_exception.i: ../include/selinux/selinux.h
 $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
-$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS)
+$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
+	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS) -l:libsepol.a
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
@@ -177,13 +175,13 @@ swigify: $(SWIGIF)
 	$(SWIG) $<
 
 install: all 
-	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
-	install -m 644 $(LIBA) $(LIBDIR)
-	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
-	install -m 755 $(LIBSO) $(SHLIBDIR)
-	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
-	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
+	test -d $(LIBINSTALL) || install -m 755 -d $(LIBINSTALL)
+	install -m 644 $(LIBA) $(LIBINSTALL)
+	test -d $(LIBINSTALL) || install -m 755 -d $(LIBINSTALL)
+	install -m 755 $(LIBSO) $(LIBINSTALL)
+	test -d $(LIBINSTALL)/pkgconfig || install -m 755 -d $(LIBINSTALL)/pkgconfig
+	install -m 644 $(LIBPC) $(LIBINSTALL)/pkgconfig
+	ln -sf --relative $(LIBINSTALL)/$(LIBSO) $(LIBINSTALL)/$(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYSITEDIR)/selinux || install -m 755 -d $(PYSITEDIR)/selinux
@@ -196,7 +194,7 @@ install-rubywrap: rubywrap
 	install -m 755 $(SWIGRUBYSO) $(RUBYINSTALL)/selinux.so
 
 relabel:
-	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
+	/sbin/restorecon $(LIBINSTALL)/$(LIBSO)
 
 clean-pywrap:
 	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
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
