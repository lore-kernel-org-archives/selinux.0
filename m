Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7JIoV86023232
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 14:50:31 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id A8286561296
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 20:49:26 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 19 Aug 2018 20:49:00 +0200
Message-Id: <20180819184901.6395-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180819184901.6395-1-nicolas.iooss@m4x.org>
References: <20180819184901.6395-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/3] Travis-CI: upgrade to Ubuntu 16.04 LTS Xenial
 Xerus
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ubuntu 14.04 uses SWIG 2.0.11 which produces Python files which contain
lines ending with a semicolon:

    __del__ = lambda self : None;

Ubuntu 16.04 uses SWIG 3.0.8, which does not put a semicolon. Moreover
Travis CI only support Python 3.7 with Ubuntu 16.04. The reason for this
is clearly stated on
https://docs.travis-ci.com/user/languages/python/#development-releases-support :

    Recent Python branches require OpenSSL 1.0.2+. As this library is
    not available for Trusty, 3.7, 3.7-dev, 3.8-dev, and nightly do not
    work (or use outdated archive).

Enabling Python 3.7 in Travis CI build matrix is therefore another
reason to upgrade .travis.yml to Ubuntu 16.04. As this new template does
not support Python 3.4 nor 3.5, and does not support PyPy2.7 yet, drop
them from the build matrix.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 09dd4749975e..00d0c54a68d7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,34 +11,35 @@ compiler:
 env:
   matrix:
     # Test the last version of Python and Ruby together, with some linkers
-    - PYVER=python3.6 RUBYLIBVER=2.5.1
-    - PYVER=python3.6 RUBYLIBVER=2.5.1 TEST_FLAGS_OVERRIDE=1
-    - PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=gold
-    - PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=bfd
+    - PYVER=python3.7 RUBYLIBVER=2.5.1
+    - PYVER=python3.7 RUBYLIBVER=2.5.1 TEST_FLAGS_OVERRIDE=1
+    - PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=gold
+    - PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=bfd
 
     # Test several Python versions
     - PYVER=python2.7 RUBYLIBVER=2.5.1
-    - PYVER=python3.3 RUBYLIBVER=2.5.1
-    - PYVER=python3.4 RUBYLIBVER=2.5.1
     - PYVER=python3.5 RUBYLIBVER=2.5.1
-    - PYVER=pypy RUBYLIBVER=2.5.1
-    - PYVER=pypy3 RUBYLIBVER=2.5.1
+    - PYVER=python3.6 RUBYLIBVER=2.5.1
+    # pypy2.7 seems not to be available in Travis-CI Xenial template yet.
+    # https://github.com/travis-ci/travis-ci/issues/9542
+    #- PYVER=pypy RUBYLIBVER=2.5.1
+    - PYVER=pypy3.5 RUBYLIBVER=2.5.1
 
     # Test several Ruby versions
-    - PYVER=python3.6 RUBYLIBVER=2.4
-    - PYVER=python3.6 RUBYLIBVER=2.3
-    - PYVER=python3.6 RUBYLIBVER=2.2
+    - PYVER=python3.7 RUBYLIBVER=2.4
+    - PYVER=python3.7 RUBYLIBVER=2.3
+    - PYVER=python3.7 RUBYLIBVER=2.2
 
 matrix:
   exclude:
     - compiler: clang
-      env: PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=gold
+      env: PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=gold
     - compiler: clang
-      env: PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=bfd
+      env: PYVER=python3.7 RUBYLIBVER=2.5.1 LINKER=bfd
 
-# Use Travis-CI Ubuntu 14.04 Trusty infrastructure, "full image" variant
+# Use Travis-CI Ubuntu 16.04 Xenial Xerus infrastructure, "full image" variant
 sudo: required
-dist: trusty
+dist: xenial
 
 # Install SELinux userspace utilities dependencies
 addons:
@@ -78,7 +79,7 @@ install:
   # Download the required python version if it is not installed
   - VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
   - if ! [ -d "$VIRTUAL_ENV" ] ; then
-        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/travis-python-archives/binaries/ubuntu/14.04/x86_64/${PYVER/python/python-}.tar.bz2" &&
+        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/travis-python-archives/binaries/ubuntu/16.04/x86_64/${PYVER/python/python-}.tar.bz2" &&
         sudo tar xjf python.tar.bz2 --directory / &&
         rm python.tar.bz2 ;
     fi
@@ -87,9 +88,6 @@ install:
   - $VIRTUAL_ENV/bin/pip install flake8
 
 before_script:
-  # clang on Travis-CI 14.04 environment is too old to support -Wdouble-promotion
-  - if "$CC" --version |grep -q clang; then sed 's/ -Wdouble-promotion / /' -i libselinux/src/Makefile libselinux/utils/Makefile ; fi
-
   # Build and install in a temporary directory to run tests
   - export DESTDIR="$TRAVIS_BUILD_DIR/installdir"
 
-- 
2.18.0
