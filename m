Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w03LEsed021473
 for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2018 16:14:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 3zBkGJ1CQ9z4KRgF
 for <selinux@tycho.nsa.gov>; Wed,  3 Jan 2018 21:14:48 +0000 (UTC)
Received: from UPDC3CPA05.eemsg.mil (unknown [192.168.18.12])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 3zBkGH6nljz4KRgC
 for <selinux@tycho.nsa.gov>; Wed,  3 Jan 2018 21:14:47 +0000 (UTC)
Received: by mail-wr0-f195.google.com with SMTP id p6so694147wrd.0
 for <selinux@tycho.nsa.gov>; Wed, 03 Jan 2018 13:14:47 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed,  3 Jan 2018 22:13:46 +0100
Message-Id: <20180103211346.27213-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180103162955.22677-1-marcus.folkesson@gmail.com>
References: <20180103162955.22677-1-marcus.folkesson@gmail.com>
Subject: [PATCH v2] libselinux: introduce PCPREFIX substitute
 variable for .pc files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

`prefix` in the .pc file may be messed up when using a buildsystem
that has specified a sysroot as DESTDIR.
We need to make it possible to override the default `libdir`
and `includedir`.

`includedir` may be overridden by `INCLUDEDIR` but `libdir` is using
`PREFIX` to setup the path.

Therefore, introduce PCPREFIX to make it possible to generate a more
customized .pc file.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

v2:
	- Reword commit message to be easier to understand...

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
