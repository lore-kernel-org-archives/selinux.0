From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: nicolas.iooss@m4x.org, bigon@debian.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux,libsemanage: fix RUBYLIBS definition
Date: Wed, 28 Jun 2017 09:38:23 -0400
Message-Id: <20170628133823.7068-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The RUBYLIBS definition introduced by commit f5b9bc2a06cc165e
("libselinux,libsemanage: link Ruby wrappers with -lruby") did
not work on Debian.  Fix it based on a patch by Nicolas Iooss.

Reported-by: Laurent Bigonville <bigon@debian.org>
Suggested-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/Makefile  | 2 +-
 libsemanage/src/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ea91260..2408fae 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -17,7 +17,7 @@ PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
 PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
-RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
+RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 LIBBASE ?= $(shell basename $(LIBDIR))
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index f01385c..fdb178f 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -17,7 +17,7 @@ PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
 PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
-RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
+RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
 LIBBASE=$(shell basename $(LIBDIR))
-- 
2.9.4
