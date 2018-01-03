Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w03GU6h1002429
 for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2018 11:30:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3zBbxj4wKVz633f
 for <selinux@tycho.nsa.gov>; Wed,  3 Jan 2018 16:30:01 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3zBbxj3yMQz633c
 for <selinux@tycho.nsa.gov>; Wed,  3 Jan 2018 16:30:01 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id h140so2248618lfg.1
 for <selinux@tycho.nsa.gov>; Wed, 03 Jan 2018 08:30:00 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed,  3 Jan 2018 17:29:55 +0100
Message-Id: <20180103162955.22677-1-marcus.folkesson@gmail.com>
Subject: [PATCH] libselinux: introduce PCPREFIX substitute variables
 for .pc files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some environments (e.g. Buildroot [1] ) when using specified sysroot does
not expect `prefix` (or `exec_prefix`) to be an absolute paths including
sysroot directory.

`includedir` may be overridden by `INCLUDEDIR` but `libdir` is using
`PREFIX` that is used in other places than .pc-files.

Therefor, introduce PCPREFIX to make it possible to generate a more
customized .pc file.

[1] https://buildroot.org/

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 libselinux/src/Makefile  | 5 +++--
 libsemanage/src/Makefile | 5 +++--
 libsepol/src/Makefile    | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 18df75c8..baa2ba0f 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -9,9 +9,10 @@ PKG_CONFIG ?= pkg-config
 
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
+PCPREFIX ?= $(PREFIX)
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
-INCLUDEDIR ?= $(PREFIX)/include
+INCLUDEDIR ?= $(PCPREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
@@ -148,7 +149,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PCPREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
 
 selinuxswig_python_exception.i: ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index fdb178f5..8fe2f6dd 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -9,9 +9,10 @@ PKG_CONFIG ?= pkg-config
 
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
+PCPREFIX ?= $(PREFIX)
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
-INCLUDEDIR ?= $(PREFIX)/include
+INCLUDEDIR ?= $(PCPREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
@@ -95,7 +96,7 @@ $(LIBSO): $(LOBJS)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PCPREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 semanageswig_python_exception.i: ../include/semanage/semanage.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 819d261b..59c287aa 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -1,6 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
+PCPREFIX ?= $(PREFIX)
+INCLUDEDIR ?= $(PCPREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 RANLIB ?= ranlib
@@ -52,7 +53,7 @@ $(LIBSO): $(LOBJS) $(LIBMAP)
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
+	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PCPREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
 
 $(LIBMAP): $(LIBMAP).in
 ifneq ($(DISABLE_CIL),y)
-- 
2.15.1
