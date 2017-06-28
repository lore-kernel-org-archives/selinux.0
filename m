Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5SLgrDv027330
 for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2017 17:42:54 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C6CCF5607A0
 for <selinux@tycho.nsa.gov>; Wed, 28 Jun 2017 23:42:50 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] Travis-CI: test defining CFLAGS, LDFLAGS,
 etc. on make command line
Date: Wed, 28 Jun 2017 23:42:21 +0200
Message-Id: <20170628214221.9288-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170628214221.9288-1-nicolas.iooss@m4x.org>
References: <20170628214221.9288-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some Makefiles rely on adding values to variables like CFLAGS,
LDFLAGS, etc. For example doing "LDFLAGS += -L../src" does not work fine
when LDFLAGS is defined on the command line of "make".

Commits 297877ab88ee ("libselinux utils: override LD{FLAGS, LIBS} for
libselinux.so in Makefile") and 15f274073322 ("Makefiles: override
*FLAGS and *LIBS") recently fixed such issues, by introducing keyword
"override" in the relevant Makefile statements.

In order to prevent the fixed issues from appearing again, add a test
case in Travis-CI configuration file. This case adds on make's command
line minimal definitions for CFLAGS and LDFLAGS and empty definitions
for CPPFLAGS and LDLIBS.

An example of build failure due to a missing override in a required
CPPFLAGS addition is provided on
https://travis-ci.org/fishilico/selinux/builds/245107609

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 573e73322e28..481ea7dae8bb 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -12,6 +12,7 @@ env:
   matrix:
     # Test the last version of Python and Ruby together, with some linkers
     - PYVER=python3.6 RUBYLIBVER=2.4
+    - PYVER=python3.6 RUBYLIBVER=2.4 TEST_FLAGS_OVERRIDE=1
     - PYVER=python3.6 RUBYLIBVER=2.4 LINKER=gold
     - PYVER=python3.6 RUBYLIBVER=2.4 LINKER=bfd
 
@@ -96,14 +97,17 @@ before_script:
   - echo "$PYTHON" ; $PYTHON --version
   - echo "$RUBY" ; $RUBY --version
 
+  # If TEST_FLAGS_OVERRIDE is defined, test that overriding CFLAGS, LDFLAGS and other variables works fine
+  - if [ -n "$TEST_FLAGS_OVERRIDE" ]; then EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS=" ; fi
+
 script:
   # Start by installing everything into $DESTDIR
-  - make install -k
-  - make install-pywrap -k
-  - make install-rubywrap -k
+  - make install $EXPLICIT_MAKE_VARS -k
+  - make install-pywrap $EXPLICIT_MAKE_VARS -k
+  - make install-rubywrap $EXPLICIT_MAKE_VARS -k
 
   # Now that everything is installed, run "make all" to build everything which may have not been built
-  - make all -k
+  - make all $EXPLICIT_MAKE_VARS -k
 
   # Set up environment variables for the tests
   - export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
@@ -118,7 +122,7 @@ script:
   - echo "$RUBYLIB"
 
   # Run tests
-  - make test
+  - make test $EXPLICIT_MAKE_VARS
 
   # Test Python and Ruby wrappers
   - $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
@@ -132,7 +136,7 @@ script:
     git status --short | sed -n 's/^??/error: missing .gitignore entry for/p' | (! grep '^')
 
   # Clean up everything and show which file would be added to "make clean"
-  - make clean distclean
+  - make clean distclean $EXPLICIT_MAKE_VARS
   - |-
     git ls-files --ignored --others --exclude-standard | sed 's/^/error: "make clean distclean" did not remove /' | (! grep '^')
 
-- 
2.13.1
