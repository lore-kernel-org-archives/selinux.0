Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15BfOXp019345
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 06:41:25 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9E812560786
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 12:41:17 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Introduce Travis-CI tests
Date: Sun,  5 Feb 2017 12:40:01 +0100
Message-Id: <20170205114001.6480-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a configuration file for https://travis-ci.org/. This continuous
integration platform can build the project for several configurations on
Linux, using different compilers, linkers, Python versions and Ruby
versions. An example of build results is available on
https://travis-ci.org/fishilico/selinux/builds/185912863

Even if the SELinux userland libraries and tools project does not enable
Travis-CI integration, the .travis.yml file may be helpful for
contributors who wish to run tests in several configurations.

Current limitations:

- It does not run an OS X build. Travis-CI provides free OS X
  environments but it is quite difficult to configure a single
  .travis.yml file which defines many Linux environments and some OS X
  ones.
- It only runs Ubuntu 14.04 with an x86-64 CPU. This does not test
  Android, ARM nor 32-bit x86 configurations.
- It only builds with glibc, not musl or other light C library.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 000000000000..6dce35165bd3
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,142 @@
+# Define the building environment
+language: c
+
+matrix:
+  fast_finish: true
+
+compiler:
+  - clang
+  - gcc
+
+env:
+  matrix:
+    # Test the last version of Python and Ruby together, with some linkers
+    - PYVER=python3.5 RUBYLIBVER=2.3
+    - PYVER=python3.5 RUBYLIBVER=2.3 LINKER=gold
+    - PYVER=python3.5 RUBYLIBVER=2.3 LINKER=bfd
+
+    # Test several Python versions
+    - PYVER=python2.7 RUBYLIBVER=2.3
+    - PYVER=python3.3 RUBYLIBVER=2.3
+    - PYVER=python3.4 RUBYLIBVER=2.3
+    - PYVER=pypy RUBYLIBVER=2.3
+    #- PYVER=pypy3 RUBYLIBVER=2.3 # PyPy3 5.5.0 provides the Python2 form of some structures, which makes it incompatible with SWIG
+
+    # Test several Ruby versions
+    - PYVER=python3.5 RUBYLIBVER=2.0
+    - PYVER=python3.5 RUBYLIBVER=2.1
+    - PYVER=python3.5 RUBYLIBVER=2.2
+
+# Use Travis-CI Ubuntu 14.04 Trusty infrastructure
+sudo: required
+dist: trusty
+
+# Install SELinux userspace utilities dependencies
+addons:
+  apt:
+    packages:
+    - bison
+    - flex
+    - gawk
+    - gettext
+    - libaudit-dev
+    - libbz2-dev
+    - libcap-dev
+    - libcap-ng-dev # This package is not whitelisted for the container infrastructure (https://github.com/travis-ci/apt-package-whitelist/issues/1096)
+    - libcunit1-dev
+    - libdbus-glib-1-dev
+    - libncurses5-dev
+    - libpcre3-dev
+    - patch
+    - python3-dev
+    - python-dev
+    - swig
+    - xmlto
+
+install:
+  # Download refpolicy Makefile for sepolgen tests
+  - sudo mkdir -p /usr/share/selinux/default
+  - sudo curl -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/support/Makefile.devel'
+  - sudo sed "s,^PREFIX :=.*,PREFIX := $TRAVIS_BUILD_DIR/installdir/usr," -i /usr/share/selinux/default/Makefile
+  - sudo mkdir -p /usr/share/selinux/refpolicy/include
+  - sudo curl -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/TresysTechnology/refpolicy/RELEASE_2_20170204/build.conf'
+  - sudo mkdir -p /etc/selinux
+  - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
+
+  # Make sepolgen tests work without really installing anything in the real root (doing this would conflict with Ubuntu packages)
+  - sed -e "s,\"\(/usr/bin/[cs]\),\"$TRAVIS_BUILD_DIR/installdir\1," -i python/sepolgen/src/sepolgen/module.py
+
+before_script:
+  # clang on Travis-CI 14.04 environment is too old to support -Wdouble-promotion
+  - if "$CC" --version |grep -q clang; then sed 's/ -Wdouble-promotion / /' -i libselinux/src/Makefile libselinux/utils/Makefile ; fi
+
+  # Build and install in a temporary directory to run tests
+  - export DESTDIR="$TRAVIS_BUILD_DIR/installdir"
+
+  # Configure the variables for Python parts
+  - export VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
+  - export PYTHON="$VIRTUAL_ENV/bin/python"
+  - export PYPREFIX="$($PYTHON -c 'import sys;print("python%d" % sys.version_info[0])')"
+  # PyPy does not provide a config file for pkg-config nor a pypy-c.so
+  - if echo "$PYVER" | grep -q pypy ; then export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include PYLIBS= ; fi
+  # Python virtualenvs do not support "import site; print(site.getsitepackages()[0]"
+  # cf. https://github.com/pypa/virtualenv/issues/355#issuecomment-10250452
+  - export PYSITEDIR="$DESTDIR/usr/lib/$($PYTHON -c 'import sys;print("python%d.%d" % sys.version_info[:2])')/site-packages"
+
+  # Find the Ruby executable with version $RUBYLIBVER
+  - export RUBY="$(ls -d -1 "$HOME/.rvm/rubies/ruby-$RUBYLIBVER"*/bin/ruby | head -n 1)"
+
+  # Set the linker in $CC so that it gets used everywhere
+  - if [ -n "$LINKER" ]; then CC="$CC -fuse-ld=$LINKER" ; fi
+
+  # Show variables and versions (to help debugging)
+  - echo "$CC" ; $CC --version
+  - echo "$PYTHON" ; $PYTHON --version
+  - echo "$RUBY" ; $RUBY --version
+
+script:
+  # Start by installing everything into $DESTDIR
+  - make install -k
+  - make install-pywrap -k
+  - make install-rubywrap -k
+
+  # Now that everything is installed, run "make all" to build everything which may have not been built
+  - make all -k
+
+  # Set up environment variables for the tests
+  - export CFLAGS="-I$DESTDIR/usr/include"
+  - export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
+  - export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
+  - export PYTHONPATH="$PYSITEDIR"
+  - export RUBYLIB="$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
+
+  # Show variables (to help debugging issues)
+  - echo "$CFLAGS"
+  - echo "$LD_LIBRARY_PATH"
+  - echo "$PATH"
+  - echo "$PYTHONPATH"
+  - echo "$RUBYLIB"
+
+  # Run tests
+  - make test
+
+  # Test Python and Ruby wrappers
+  - $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
+  - $RUBY -e 'require "selinux";require "semanage";puts Selinux::is_selinux_enabled()'
+
+  # Remove every installed files
+  - rm -rf "$DESTDIR"
+
+  # Test that "git status" looks clean, or print a clear error message
+  - |-
+    git status --short | sed -n 's/^??/error: missing .gitignore entry for/p' | (! grep '^')
+
+  # Clean up everything and show which file would be added to "make clean"
+  - make clean distclean
+  - |-
+    git ls-files --ignored --others --exclude-standard | sed 's/^/error: "make clean distclean" did not remove /' | (! grep '^')
+
+# Do not spam by email so long as the build succeeds
+notifications:
+  email:
+    on_success: never
-- 
2.11.0
