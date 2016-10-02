Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u924FLHm011646
 for <selinux@tycho.nsa.gov>; Sun, 2 Oct 2016 00:15:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id t25so1521717pfg.2
 for <selinux@tycho.nsa.gov>; Sat, 01 Oct 2016 21:15:19 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: versioned ruby pkg-config and query
 vendorarchdir properly
Date: Sun,  2 Oct 2016 12:15:13 +0800
Message-Id: <1475381714-9906-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Gentoo and Arch have pkg-config entries for "ruby-$(RUBYLIBVER)" but not
for "ruby". Check if that exists first then fall back to plain ruby if
it does not.

The ruby install paths were incorrect. Fedora 20 installed to
/usr/lib64/ruby/vendor_ruby/, Arch needs it to be vendor_ruby as well,
site_ruby does not work. Thanks to Nicolas Iooss for the correct way to
query for the path.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 libselinux/src/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 7169230..f9e3de1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -16,9 +16,8 @@ PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_i
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
 RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
-RUBYPLATFORM ?= $(shell $(RUBY) -e 'print RUBY_PLATFORM')
-RUBYINC ?= $(shell $(PKG_CONFIG) --cflags ruby)
-RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
+RUBYINC ?= $(shell $(PKG_CONFIG) --exists ruby-$(RUBYLIBVER) && $(PKG_CONFIG) --cflags ruby-$(RUBYLIBVER) || $(PKG_CONFIG) --cflags ruby)
+RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 LIBBASE ?= $(shell basename $(LIBDIR))
 
 VERSION = $(shell cat ../VERSION)
-- 
2.7.3
