Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAHLoSEP015324
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 16:50:28 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1220D564766
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 22:50:25 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libselinux, libsemanage: use Python-specific .so extension
Date: Thu, 17 Nov 2016 22:50:18 +0100
Message-Id: <20161117215018.23118-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The Makefiles currently install the Python wrapper libraries using .so
suffix (_selinux.so, audit2why.so and _semanage.so). Even though this
works well with CPython 2 and 3, PyPy fails to find these files because
it is looking for files with a specific version token in the suffix (eg.
_selinux.pypy-41.so).

This suffix is advertised by the imp module. Here is the result of
'import imp;print([s for s, m, t in imp.get_suffixes() if t ==
imp.C_EXTENSION])' for several Python versions:

    Python 2.7.12: ['.so', 'module.so']
    Python 3.5.2: ['.cpython-35m-x86_64-linux-gnu.so', '.abi3.so', '.so']
    PyPy 5.4.1 (Python 2.7.10): ['.pypy-41.so']
    PyPy3 5.5.0-alpha0 (Python 3.3.5): ['.pypy3-55.so', '.pypy3-55.so']

Define the name of the installed Python-C extension using the first
extension of these lists, in order to make the Python extensions
compatible with pypy.

When building the Python wrappers for PyPy and PyPy3 on Linux, the
following environment variables need to be set (PyPy does not provide a
pkg-config file nor a platform-agnostic way to build the string
"-lpypy-c"):

    PYTHON=pypy (or PYTHON=pypy3)
    PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include
    PYLIBS=-lpypy-c (or PYLIBS= if LDFLAGS does not have
        -Wl,-no-undefined)

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/Makefile  | 5 +++--
 libsemanage/src/Makefile | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 928cc049cedb..d17792c13350 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -15,6 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
+PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
@@ -185,8 +186,8 @@ install: all
 
 install-pywrap: pywrap
 	test -d $(PYSITEDIR)/selinux || install -m 755 -d $(PYSITEDIR)/selinux
-	install -m 755 $(SWIGSO) $(PYSITEDIR)/_selinux.so
-	install -m 755 $(AUDIT2WHYSO) $(PYSITEDIR)/selinux/audit2why.so
+	install -m 755 $(SWIGSO) $(PYSITEDIR)/_selinux$(PYCEXT)
+	install -m 755 $(AUDIT2WHYSO) $(PYSITEDIR)/selinux/audit2why$(PYCEXT)
 	install -m 644 $(SWIGPYOUT) $(PYSITEDIR)/selinux/__init__.py
 
 install-rubywrap: rubywrap
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 5176582f654d..ef25902bb019 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -15,6 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
+PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
@@ -145,7 +146,7 @@ install: all
 
 install-pywrap: pywrap 
 	test -d $(PYSITEDIR) || install -m 755 -d $(PYSITEDIR)
-	install -m 755 $(SWIGSO) $(PYSITEDIR)/_semanage.so
+	install -m 755 $(SWIGSO) $(PYSITEDIR)/_semanage$(PYCEXT)
 	install -m 644 semanage.py $(PYSITEDIR)
 
 
-- 
2.10.2
