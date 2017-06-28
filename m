Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5SLhCiQ027547
 for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2017 17:43:12 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3CF345607A0
 for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2017 23:42:49 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] Travis-CI: update the list of Ruby's and Python's versions
Date: Wed, 28 Jun 2017 23:42:19 +0200
Message-Id: <20170628214221.9288-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Travis-CI no longer provides Ruby 2.0 in its Trusty environment (it has
been updated according to
https://blog.travis-ci.com/2017-06-21-trusty-updates-2017-Q2-launch).
Remove this version from .travis.yml.

Moreover Python 3.6 and Ruby 3.4 are available. Test building with them.

Last by not least, pypy virtual environment directory has been renamed
pypy2 (/home/travis/virtualenv/pypy2 is a symbolic link to pypy2-5.6.0).

The updated .travis.yml file has been tested on
https://travis-ci.org/fishilico/selinux/builds/248126824

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index fa25d1b336ac..573e73322e28 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,21 +11,22 @@ compiler:
 env:
   matrix:
     # Test the last version of Python and Ruby together, with some linkers
-    - PYVER=python3.5 RUBYLIBVER=2.3
-    - PYVER=python3.5 RUBYLIBVER=2.3 LINKER=gold
-    - PYVER=python3.5 RUBYLIBVER=2.3 LINKER=bfd
+    - PYVER=python3.6 RUBYLIBVER=2.4
+    - PYVER=python3.6 RUBYLIBVER=2.4 LINKER=gold
+    - PYVER=python3.6 RUBYLIBVER=2.4 LINKER=bfd
 
     # Test several Python versions
-    - PYVER=python2.7 RUBYLIBVER=2.3
-    - PYVER=python3.3 RUBYLIBVER=2.3
-    - PYVER=python3.4 RUBYLIBVER=2.3
-    - PYVER=pypy RUBYLIBVER=2.3
+    - PYVER=python2.7 RUBYLIBVER=2.4
+    - PYVER=python3.3 RUBYLIBVER=2.4
+    - PYVER=python3.4 RUBYLIBVER=2.4
+    - PYVER=python3.5 RUBYLIBVER=2.4
+    - PYVER=pypy2 RUBYLIBVER=2.4
     #- PYVER=pypy3 RUBYLIBVER=2.3 # PyPy3 5.5.0 provides the Python2 form of some structures, which makes it incompatible with SWIG
 
     # Test several Ruby versions
-    - PYVER=python3.5 RUBYLIBVER=2.0
-    - PYVER=python3.5 RUBYLIBVER=2.1
-    - PYVER=python3.5 RUBYLIBVER=2.2
+    - PYVER=python3.6 RUBYLIBVER=2.1
+    - PYVER=python3.6 RUBYLIBVER=2.2
+    - PYVER=python3.6 RUBYLIBVER=2.3
 
 # Use Travis-CI Ubuntu 14.04 Trusty infrastructure
 sudo: required
-- 
2.13.1
