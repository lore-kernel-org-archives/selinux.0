Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAELT8As025304
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 16:29:12 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5E122564861
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 22:29:10 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] libselinux,libsemanage: link Python wrapper with Python
Date: Mon, 14 Nov 2016 22:28:17 +0100
Message-Id: <20161114212817.15781-4-nicolas.iooss@m4x.org>
In-Reply-To: <20161114212817.15781-1-nicolas.iooss@m4x.org>
References: <20161114212817.15781-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When linking with -Wl,-no-undefined in LDFLAGS (in order to find
possible link-time errors), the Python wrapper module needs to be
linked with the right libpython.so. This library is found using
pkg-config in a new PYLIBS variable.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/Makefile  | 5 +++--
 libsemanage/src/Makefile | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 82a1010af2d8..928cc049cedb 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -13,6 +13,7 @@ LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
+PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
@@ -131,7 +132,7 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) -shared -o $@ $< -L. -lselinux $(LDFLAGS) -L$(LIBDIR)
+	$(CC) $(CFLAGS) -shared -o $@ $< -L. -lselinux $(LDFLAGS) $(PYLIBS) -L$(LIBDIR)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS) $(RUBYLIBS) -L$(LIBDIR)
@@ -154,7 +155,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBSEPOLA) -L$(LIBDIR)
+	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBSEPOLA) $(PYLIBS) -L$(LIBDIR)
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 5c7bc6c6ea65..5176582f654d 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -13,6 +13,7 @@ LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
+PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
@@ -79,7 +80,7 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
 	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGSO): $(SWIGLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage $(PYLIBS) -L$(LIBDIR)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage $(RUBYLIBS) -L$(LIBDIR)
-- 
2.10.2
