Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAELT8Ap025304
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 16:29:08 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E6244564861
 for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2016 22:29:03 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] libselinux,libsemanage: use Ruby to define RUBYINC
Date: Mon, 14 Nov 2016 22:28:14 +0100
Message-Id: <20161114212817.15781-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This makes building libselinux and libsemanage  more robust on systems
with several versions of Ruby installed: when building, only RUBY needs
to be set, without wondering about PKG_CONFIG_PATH or other environment
variables.

Using RbConfig::CONFIG["rubyarchhdrdir"] only works with Ruby >= 2.0 but
since previous Ruby versions are retired since 2015-02-23 this should
not have any impact
(https://www.ruby-lang.org/en/news/2015/02/23/support-for-ruby-1-9-3-has-ended/).

While at it, in libsemanage, use RbConfig::CONFIG["vendorarchdir"] to
install the Ruby extension, like commit 1cd80faa53b6 ("libselinux:
versioned ruby pkg-config and query vendorarchdir properly") did for
libselinux.

My main motivation with this patch is to make the build configuration
easier to define on Travis-CI or other continuous integration platforms.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/Makefile  | 3 +--
 libsemanage/src/Makefile | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 76efe49586c0..4fe1f7002181 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -14,8 +14,7 @@ SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
-RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
-RUBYINC ?= $(shell $(PKG_CONFIG) --exists ruby-$(RUBYLIBVER) && $(PKG_CONFIG) --cflags ruby-$(RUBYLIBVER) || $(PKG_CONFIG) --cflags ruby)
+RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 LIBBASE ?= $(shell basename $(LIBDIR))
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index cd29a8abf5ab..c646f274cbc1 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -15,10 +15,8 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
-RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
-RUBYPLATFORM ?= $(shell $(RUBY) -e 'print RUBY_PLATFORM')
-RUBYINC ?= $(shell $(PKG_CONFIG) --cflags ruby-$(RUBYLIBVER))
-RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
+RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
+RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
 LIBBASE=$(shell basename $(LIBDIR))
 
-- 
2.10.2
