Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAELT8Aq025304
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 16:29:10 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 65EE3564861
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 22:29:07 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] libselinux,libsemanage: link Ruby wrapper with -lruby
Date: Mon, 14 Nov 2016 22:28:15 +0100
Message-Id: <20161114212817.15781-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161114212817.15781-1-nicolas.iooss@m4x.org>
References: <20161114212817.15781-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When linking with -Wl,-no-undefined in LDFLAGS (in order to find
possible link-time errors), the Ruby wrapper module needs to be linked
with the libruby.so which is used by $(RUBY). Introduce a new RUBYLIBS
variable to find this library.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/Makefile  | 3 ++-
 libsemanage/src/Makefile | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 4fe1f7002181..82a1010af2d8 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -15,6 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
+RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 LIBBASE ?= $(shell basename $(LIBDIR))
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
@@ -133,7 +134,7 @@ $(SWIGSO): $(SWIGLOBJ)
 	$(CC) $(CFLAGS) -shared -o $@ $< -L. -lselinux $(LDFLAGS) -L$(LIBDIR)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS) -L$(LIBDIR)
+	$(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS) $(RUBYLIBS) -L$(LIBDIR)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index c646f274cbc1..37d6eabbdae8 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -16,6 +16,7 @@ PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_i
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
+RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
 LIBBASE=$(shell basename $(LIBDIR))
@@ -82,7 +83,7 @@ $(SWIGSO): $(SWIGLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -L$(LIBDIR)
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage -L$(LIBDIR)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage $(RUBYLIBS) -L$(LIBDIR)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
-- 
2.10.2
