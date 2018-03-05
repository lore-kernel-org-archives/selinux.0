Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w25MP2cB027557
 for <selinux@tycho.nsa.gov>; Mon, 5 Mar 2018 17:25:02 -0500
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5E23F5646EB
 for <selinux@tycho.nsa.gov>; Mon,  5 Mar 2018 23:22:51 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Mon,  5 Mar 2018 23:16:11 +0100
Message-Id: <20180305221611.19964-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] libselinux,
 libsemanage: Replace PYSITEDIR with PYTHONLIBDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libselinux and libsemanage Makefiles invoke site.getsitepackages() in
order to get the path to the directory /usr/lib/pythonX.Y/site-packages
that matches the Python interpreter chosen with $(PYTHON). This method
is incompatible with Python virtual environments, as described in
https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452 .
This issue has been opened for more than 5 years.

On the contrary python/semanage/ and python/sepolgen/ Makefiles use
distutils.sysconfig.get_python_lib() in order to get the site-packages
path into a variable named PYTHONLIBDIR. This way of computing
PYTHONLIBDIR is compatible with virtual environments and gives the same
result as PYSITEDIR.

As PYTHONLIBDIR works in more cases than PYSITEDIR, make libselinux and
libsemanage Makefiles use it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml              |  5 +----
 libselinux/src/Makefile  | 10 +++++-----
 libsemanage/src/Makefile |  8 ++++----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 0312e996e333..63c7a544aa45 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -96,9 +96,6 @@ before_script:
   - export PKG_CONFIG_PATH="/opt/python/$($PYTHON -c 'import sys;print("%d.%d.%d" % sys.version_info[:3])')/lib/pkgconfig"
   # PyPy does not provide a config file for pkg-config nor a pypy-c.so
   - if echo "$PYVER" | grep -q pypy ; then export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include PYLIBS= ; fi
-  # Python virtualenvs do not support "import site; print(site.getsitepackages()[0]"
-  # cf. https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452
-  - export PYSITEDIR="/usr/lib/$($PYTHON -c 'import sys;print("python%d.%d" % sys.version_info[:2])')/site-packages"
 
   # Find the Ruby executable with version $RUBYLIBVER
   - export RUBY="$(ls -d -1 "$HOME/.rvm/rubies/ruby-$RUBYLIBVER"*/bin/ruby | head -n 1)"
@@ -126,7 +123,7 @@ script:
   # Set up environment variables for the tests
   - export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
   - export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
-  - export PYTHONPATH="$DESTDIR$PYSITEDIR"
+  - export PYTHONPATH="$DESTDIR$($PYTHON -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
   - export RUBYLIB="$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
   # Show variables (to help debugging issues)
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 18588da586bf..ff55680e384a 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -14,7 +14,7 @@ SHLIBDIR ?= /lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
-PYSITEDIR ?= $(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
 PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
@@ -191,10 +191,10 @@ install: all
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
-	test -d $(DESTDIR)$(PYSITEDIR)/selinux || install -m 755 -d $(DESTDIR)$(PYSITEDIR)/selinux
-	install -m 755 $(SWIGSO) $(DESTDIR)$(PYSITEDIR)/_selinux$(PYCEXT)
-	install -m 755 $(AUDIT2WHYSO) $(DESTDIR)$(PYSITEDIR)/selinux/audit2why$(PYCEXT)
-	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYSITEDIR)/selinux/__init__.py
+	test -d $(DESTDIR)$(PYTHONLIBDIR)/selinux || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)/selinux
+	install -m 755 $(SWIGSO) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
+	install -m 755 $(AUDIT2WHYSO) $(DESTDIR)$(PYTHONLIBDIR)/selinux/audit2why$(PYCEXT)
+	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 
 install-rubywrap: rubywrap
 	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index e98d8760acb7..bcee93b36977 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -13,7 +13,7 @@ LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
-PYSITEDIR ?= $(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
+PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
 PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
 RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
@@ -142,9 +142,9 @@ install: all
 	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 install-pywrap: pywrap 
-	test -d $(DESTDIR)$(PYSITEDIR) || install -m 755 -d $(DESTDIR)$(PYSITEDIR)
-	install -m 755 $(SWIGSO) $(DESTDIR)$(PYSITEDIR)/_semanage$(PYCEXT)
-	install -m 644 semanage.py $(DESTDIR)$(PYSITEDIR)
+	test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)
+	install -m 755 $(SWIGSO) $(DESTDIR)$(PYTHONLIBDIR)/_semanage$(PYCEXT)
+	install -m 644 semanage.py $(DESTDIR)$(PYTHONLIBDIR)
 
 
 install-rubywrap: rubywrap
-- 
2.16.0
