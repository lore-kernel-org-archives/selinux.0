Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4LA4q5Q027698
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 06:04:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id ay10-v6so8534778plb.1
 for <selinux@tycho.nsa.gov>; Mon, 21 May 2018 03:04:03 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Date: Mon, 21 May 2018 18:03:46 +0800
Message-Id: <20180521100346.48699-1-jason@perfinion.com>
Subject: [PATCH] travis.yml: add ruby 2.5 to the test matrix
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ruby 2.5 is not installed by default, force reinstall with rvm

Signed-off-by: Jason Zaman <jason@perfinion.com>
---

This passes on my repo:
https://travis-ci.org/perfinion/selinux/builds/381597252


 .travis.yml | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 63c7a544..823af7ec 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,29 +11,30 @@ compiler:
 env:
   matrix:
     # Test the last version of Python and Ruby together, with some linkers
-    - PYVER=python3.6 RUBYLIBVER=2.4
-    - PYVER=python3.6 RUBYLIBVER=2.4 TEST_FLAGS_OVERRIDE=1
-    - PYVER=python3.6 RUBYLIBVER=2.4 LINKER=gold
-    - PYVER=python3.6 RUBYLIBVER=2.4 LINKER=bfd
+    - PYVER=python3.6 RUBYLIBVER=2.5.1
+    - PYVER=python3.6 RUBYLIBVER=2.5.1 TEST_FLAGS_OVERRIDE=1
+    - PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=gold
+    - PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=bfd
 
     # Test several Python versions
-    - PYVER=python2.7 RUBYLIBVER=2.4
-    - PYVER=python3.3 RUBYLIBVER=2.4
-    - PYVER=python3.4 RUBYLIBVER=2.4
-    - PYVER=python3.5 RUBYLIBVER=2.4
-    - PYVER=pypy RUBYLIBVER=2.4
-    - PYVER=pypy3 RUBYLIBVER=2.4
+    - PYVER=python2.7 RUBYLIBVER=2.5.1
+    - PYVER=python3.3 RUBYLIBVER=2.5.1
+    - PYVER=python3.4 RUBYLIBVER=2.5.1
+    - PYVER=python3.5 RUBYLIBVER=2.5.1
+    - PYVER=pypy RUBYLIBVER=2.5.1
+    - PYVER=pypy3 RUBYLIBVER=2.5.1
 
     # Test several Ruby versions
-    - PYVER=python3.6 RUBYLIBVER=2.2
+    - PYVER=python3.6 RUBYLIBVER=2.4
     - PYVER=python3.6 RUBYLIBVER=2.3
+    - PYVER=python3.6 RUBYLIBVER=2.2
 
 matrix:
   exclude:
     - compiler: clang
-      env: PYVER=python3.6 RUBYLIBVER=2.4 LINKER=gold
+      env: PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=gold
     - compiler: clang
-      env: PYVER=python3.6 RUBYLIBVER=2.4 LINKER=bfd
+      env: PYVER=python3.6 RUBYLIBVER=2.5.1 LINKER=bfd
 
 # Use Travis-CI Ubuntu 14.04 Trusty infrastructure, "full image" variant
 sudo: required
@@ -98,6 +99,7 @@ before_script:
   - if echo "$PYVER" | grep -q pypy ; then export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include PYLIBS= ; fi
 
   # Find the Ruby executable with version $RUBYLIBVER
+  - rvm reinstall ruby-$RUBYLIBVER --binary
   - export RUBY="$(ls -d -1 "$HOME/.rvm/rubies/ruby-$RUBYLIBVER"*/bin/ruby | head -n 1)"
 
   # Set the linker in $CC so that it gets used everywhere
-- 
2.16.1
