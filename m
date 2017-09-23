Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8NDmMIN017801
 for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2017 09:48:22 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id EBC3E56472C
 for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2017 15:46:43 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 23 Sep 2017 15:45:53 +0200
Message-Id: <20170923134553.2098-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] Travis-CI: fix configuration after September's
 update
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The latest update to Travis-CI build environment splitted sugilite
environment into amethyst and garnet and deprecated sugilite. As garnet
provides tools for languages C and Python, and as it is automatically
selected according to
https://travis-ci.org/fishilico/selinux/jobs/278927391 , remove "group:
sugilite" from Travis-CI configuration file.

This update introduced two issues:

- Ruby 2.1 is no longer provided. As it has reached End Of Life
  according to https://www.ruby-lang.org/en/downloads/, remove it from
  the tested versions

- Python 3.3, 3.4 and 3.5 are no longer installed by default. When
  Travis-CI builds Python projects using these versions, it
  automatically download and extract an archive from
  https://s3.amazonaws.com/travis-python-archives/binaries/ubuntu/14.04/x86_64/.
  Implement this process in .travis.yml directly (because Travis-CI does
  not support multi-language projects which use several versions of C
  compilers and Python and Ruby interpreters).

Last but not least, it is now possible to build with PyPy3. Enable this
interpreter in the build environment matrix.

More information about the Travis-CI update is available at
https://docs.travis-ci.com/user/build-environment-updates/2017-09-06/

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1b761496dd12..e21b4d2198e5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -21,11 +21,10 @@ env:
     - PYVER=python3.3 RUBYLIBVER=2.4
     - PYVER=python3.4 RUBYLIBVER=2.4
     - PYVER=python3.5 RUBYLIBVER=2.4
-    - PYVER=pypy2 RUBYLIBVER=2.4
-    #- PYVER=pypy3 RUBYLIBVER=2.3 # PyPy3 5.5.0 provides the Python2 form of some structures, which makes it incompatible with SWIG
+    - PYVER=pypy RUBYLIBVER=2.4
+    - PYVER=pypy3 RUBYLIBVER=2.4
 
     # Test several Ruby versions
-    - PYVER=python3.6 RUBYLIBVER=2.1
     - PYVER=python3.6 RUBYLIBVER=2.2
     - PYVER=python3.6 RUBYLIBVER=2.3
 
@@ -39,7 +38,6 @@ matrix:
 # Use Travis-CI Ubuntu 14.04 Trusty infrastructure, "full image" variant
 sudo: required
 dist: trusty
-group: sugilite
 
 # Install SELinux userspace utilities dependencies
 addons:
@@ -76,6 +74,14 @@ install:
   # Make sepolgen tests work without really installing anything in the real root (doing this would conflict with Ubuntu packages)
   - sed -e "s,\"\(/usr/bin/[cs]\),\"$TRAVIS_BUILD_DIR/installdir\1," -i python/sepolgen/src/sepolgen/module.py
 
+  # Download the required python version if it is not installed
+  - VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
+  - if ! [ -d "$VIRTUAL_ENV" ] ; then
+        curl -o python.tar.bz2 "https://s3.amazonaws.com/travis-python-archives/binaries/ubuntu/14.04/x86_64/${PYVER/python/python-}.tar.bz2" &&
+        sudo tar xjf python.tar.bz2 --directory / &&
+        rm python.tar.bz2 ;
+    fi
+
 before_script:
   # clang on Travis-CI 14.04 environment is too old to support -Wdouble-promotion
   - if "$CC" --version |grep -q clang; then sed 's/ -Wdouble-promotion / /' -i libselinux/src/Makefile libselinux/utils/Makefile ; fi
-- 
2.14.1
