Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1JLuMCB009225
 for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2017 16:56:24 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 8893E564A4B
 for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2017 22:53:59 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libselinux,
 libsemanage: make PYPREFIX computation more robust
Date: Sun, 19 Feb 2017 22:53:29 +0100
Message-Id: <20170219215329.3143-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On systems where $PYTHON is python3.5 (instead of python2 or python3),
pkg-config fails to find the Python package because it is named with a
dash (e.g. python-3.5).

Moreover the build system may have been using the pkg-config
configuration files for the wrong Python version when several Python
with the same major version number are installed (e.g. using python-3.5
on a system with both python-3.4 and python-3.5 and where
/usr/lib/pkgconfig/python3.pc is a symlink to python-3.5.pc).

In order to fix these two issues, compute $PYPREFIX from $PYTHON by
using the full major.minor version.

Moreover update Travis-Ci configuration to grab the relevant
configuration files for pkg-config from /opt/python (for example
/opt/python/3.5.2/lib/pkgconfig/python-3.5.pc) instead of using
system-provided files (/usr/lib/x86_64-linux-gnu/pkgconfig/python3.pc
and /usr/lib/x86_64-linux-gnu/pkgconfig/python2.pc).

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml              | 3 ++-
 libselinux/src/Makefile  | 2 +-
 libsemanage/src/Makefile | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6dce35165bd3..7d7424459344 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -76,7 +76,8 @@ before_script:
   # Configure the variables for Python parts
   - export VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
   - export PYTHON="$VIRTUAL_ENV/bin/python"
-  - export PYPREFIX="$($PYTHON -c 'import sys;print("python%d" % sys.version_info[0])')"
+  # Use the header files in /opt/python/... for Python because the virtualenvs do not provide Python.h
+  - export PKG_CONFIG_PATH="/opt/python/$($PYTHON -c 'import sys;print("%d.%d.%d" % sys.version_info[:3])')/lib/pkgconfig"
   # PyPy does not provide a config file for pkg-config nor a pypy-c.so
   - if echo "$PYVER" | grep -q pypy ; then export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include PYLIBS= ; fi
   # Python virtualenvs do not support "import site; print(site.getsitepackages()[0]"
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 5640a57d2768..a277b8715819 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -2,7 +2,7 @@
 # runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
 # targets with "PYPREFIX":
 PYTHON ?= python
-PYPREFIX ?= $(notdir $(PYTHON))
+PYPREFIX ?= $(shell $(PYTHON) -c 'import sys;print("python-%d.%d" % sys.version_info[:2])')
 RUBY ?= ruby
 RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 92c829be234d..77f6efc86d2d 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -2,7 +2,7 @@
 # runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
 # targets with "PYPREFIX":
 PYTHON ?= python
-PYPREFIX ?= $(notdir $(PYTHON))
+PYPREFIX ?= $(shell $(PYTHON) -c 'import sys;print("python-%d.%d" % sys.version_info[:2])')
 RUBY ?= ruby
 RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
-- 
2.11.1
