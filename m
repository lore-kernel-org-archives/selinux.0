Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1EJTrei016102
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 14:29:54 -0500
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 20:27:47 +0100
Message-Id: <20180214192747.26511-1-nicolas.iooss@m4x.org>
Subject: [PATCH Rework of makefiles v5 16/15] Travis-CI: do not
 duplicate $DESTDIR in $PYSITEDIR
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Recent commits removed $DESTDIR from $PYSITEDIR in libselinux and
libsemanage:

    -PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site;
    print(site.getsitepackages()[0])')
    +PYSITEDIR ?= $(shell $(PYTHON) -c 'import site;
    print(site.getsitepackages()[0])')

As "site.getsitepackages()" does not work within virtualenvs,
.travis.yml defines PYSITEDIR's value in it and this definition needs to
be updated too.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 88f6297e63bc..0312e996e333 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -98,7 +98,7 @@ before_script:
   - if echo "$PYVER" | grep -q pypy ; then export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include PYLIBS= ; fi
   # Python virtualenvs do not support "import site; print(site.getsitepackages()[0]"
   # cf. https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452
-  - export PYSITEDIR="$DESTDIR/usr/lib/$($PYTHON -c 'import sys;print("python%d.%d" % sys.version_info[:2])')/site-packages"
+  - export PYSITEDIR="/usr/lib/$($PYTHON -c 'import sys;print("python%d.%d" % sys.version_info[:2])')/site-packages"
 
   # Find the Ruby executable with version $RUBYLIBVER
   - export RUBY="$(ls -d -1 "$HOME/.rvm/rubies/ruby-$RUBYLIBVER"*/bin/ruby | head -n 1)"
@@ -126,7 +126,7 @@ script:
   # Set up environment variables for the tests
   - export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
   - export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
-  - export PYTHONPATH="$PYSITEDIR"
+  - export PYTHONPATH="$DESTDIR$PYSITEDIR"
   - export RUBYLIB="$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
   # Show variables (to help debugging issues)
-- 
2.16.0
