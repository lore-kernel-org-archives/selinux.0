Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6BC2D0E4
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 07:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3575D20715
	for <selinux@archiver.kernel.org>; Tue, 24 Nov 2020 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgKXHut (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Nov 2020 02:50:49 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37119 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgKXHut (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Nov 2020 02:50:49 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DA512564686
        for <selinux@vger.kernel.org>; Tue, 24 Nov 2020 08:50:45 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] Add configuration to build and run tests in GitHub Actions
Date:   Tue, 24 Nov 2020 08:50:22 +0100
Message-Id: <20201124075022.37033-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Nov 24 08:50:46 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Copy the tests that are currently run on Travis CI, in order to no
longer depends on Travis CI.

For more context: Travis-CI is changing its offer, as documented in
https://docs.travis-ci.com/user/migrate/open-source-repository-migration
and SELinuxProject moved to https://travis-ci.com
https://lore.kernel.org/selinux/CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com/T/#t

Unfortunately the credits for opensource projects are quite limited, and
require interaction with Travis CI support (which was quite unresponsive
when I contacted them for other opensource projects I am maintaining).

Create a configuration for Github Actions that duplicates most Travis CI
checks.

* macOS check has not yet been converted, but GitHub Actions support
  this platform so this can be done in another patch (and in another
  configuration in .github/workflows ?).

* KVM support is not available on GitHub Actions so running SELinux
  testsuite in a Fedora VM is not possible. This is a known issue
  (https://github.com/actions/virtual-environments/issues/183) and other
  projects seem to face the same issue (for example
  https://github.com/opencontainers/runc/issues/2670).

This configuration has been tested on
https://github.com/fishilico/selinux/actions/runs/380579153

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .github/workflows/run_tests.yml | 189 ++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100644 .github/workflows/run_tests.yml

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
new file mode 100644
index 000000000000..6f280de8ff4d
--- /dev/null
+++ b/.github/workflows/run_tests.yml
@@ -0,0 +1,189 @@
+name: Run tests
+
+on: [push, pull_request]
+
+jobs:
+  build:
+
+    runs-on: ubuntu-latest
+    strategy:
+      matrix:
+        compiler: [gcc, clang]
+        python-ruby-version:
+          - {python: 3.8, ruby: 2.7}
+          - {python: 3.8, ruby: 2.7, other: test-flags-override}
+          - {python: 3.8, ruby: 2.7, other: test-debug}
+          - {python: 3.8, ruby: 2.7, other: linker-bfd}
+          - {python: 3.8, ruby: 2.7, other: linker-gold}
+          # Test several Python versions with the latest Ruby version
+          - {python: 3.7, ruby: 2.7}
+          - {python: 3.6, ruby: 2.7}
+          - {python: 3.5, ruby: 2.7}
+          - {python: pypy3, ruby: 2.7}
+          # Test several Ruby versions with the latest Python version
+          - {python: 3.8, ruby: 2.6}
+          - {python: 3.8, ruby: 2.5}
+          - {python: 3.8, ruby: 2.4}
+        exclude:
+          - compiler: clang
+            python-ruby-version: {python: 3.8, ruby: 2.7, other: linker-bfd}
+          - compiler: clang
+            python-ruby-version: {python: 3.8, ruby: 2.7, other: linker-gold}
+
+    steps:
+    - uses: actions/checkout@v2
+
+    - name: Set up Python ${{ matrix.python-ruby-version.python }}
+      uses: actions/setup-python@v2
+      with:
+        python-version: ${{ matrix.python-ruby-version.python }}
+
+    - name: Set up Ruby ${{ matrix.python-ruby-version.ruby }}
+      uses: actions/setup-ruby@v1
+      with:
+        ruby-version: ${{ matrix.python-ruby-version.ruby }}
+
+    - name: Install dependencies
+      run: |
+        sudo apt-get update -qq
+        sudo apt-get install -qqy \
+            bison \
+            clang \
+            flex \
+            gawk \
+            gettext \
+            libaudit-dev \
+            libcap-dev \
+            libcap-ng-dev \
+            libcunit1-dev \
+            libdbus-glib-1-dev \
+            libpcre3-dev \
+            python3-dev \
+            python-dev \
+            ruby-dev \
+            swig \
+            xmlto
+
+        pip install flake8
+
+    - name: Configure the environment
+      run: |
+        DESTDIR=/tmp/destdir
+        echo "PYTHON=python" >> $GITHUB_ENV
+        echo "RUBY=ruby" >> $GITHUB_ENV
+        echo "DESTDIR=$DESTDIR" >> $GITHUB_ENV
+
+        CC=${{ matrix.compiler }}
+        if [ "${{ matrix.python-ruby-version.other }}" = "linker-bfd" ] ; then
+            CC="$CC -fuse-ld=bfd"
+        elif [ "${{ matrix.python-ruby-version.other }}" = "linker-gold" ] ; then
+            CC="$CC -fuse-ld=gold"
+        fi
+        echo "CC=$CC" >> $GITHUB_ENV
+
+        EXPLICIT_MAKE_VARS=
+        if [ "${{ matrix.python-ruby-version.other }}" = "test-flags-override" ] ; then
+            # Test that overriding CFLAGS, LDFLAGS and other variables works fine
+            EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS="
+        elif [ "${{ matrix.python-ruby-version.other }}" = "test-debug" ] ; then
+            # Test hat debug build works fine
+            EXPLICIT_MAKE_VARS="DEBUG=1"
+        else
+            EXPLICIT_MAKE_VARS=
+        fi
+        echo "EXPLICIT_MAKE_VARS=${EXPLICIT_MAKE_VARS}" >> $GITHUB_ENV
+
+        # Find files in order of pkgconf to be able to find Python.h
+        # For example with Python 3.5:
+        # * python is located at /opt/hostedtoolcache/Python/3.5.10/x64/bin/python
+        # * sys.prefix is /opt/hostedtoolcache/Python/3.5.10/x64
+        # * Python.h is located at /opt/hostedtoolcache/Python/3.5.10/x64/include/python3.5m/Python.h
+        # * python-3.5.pc is located at /opt/hostedtoolcache/Python/3.5.10/x64/lib/pkgconfig/python-3.5.pc
+        PYTHON_SYS_PREFIX="$(python -c 'import sys;print(sys.prefix)')"
+        echo "PKG_CONFIG_PATH=${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $GITHUB_ENV
+
+        if [ "${{ matrix.python-ruby-version.python }}" = "pypy3" ] ; then
+            # PyPy does not provide a config file for pkg-config
+            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
+            echo "PYINC=-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
+            echo "PYLIBS=-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $GITHUB_ENV
+        fi
+
+        # Display the final environment file, for debugging purpose
+        cat $GITHUB_ENV
+
+    - name: Download and install refpolicy headers for sepolgen tests
+      run: |
+        curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-2.20180701.tar.bz2
+        tar -xvjf refpolicy.tar.bz2
+        sed -e "s,^PREFIX :=.*,PREFIX := $DESTDIR/usr," -i refpolicy/support/Makefile.devel
+        sudo make -C refpolicy install-headers clean
+        sudo mkdir -p /etc/selinux
+        echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
+        echo 'SELINUX_DEVEL_PATH = /usr/share/selinux/refpolicy' | sudo tee /etc/selinux/sepolgen.conf
+        sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolgen/src/sepolgen/module.py
+        rm -r refpolicy refpolicy.tar.bz2
+
+    - name: Display versions
+      run: |
+        echo "::group::Compiler ($CC):"
+        $CC --version
+        echo "::endgroup::"
+        echo "::group::Python ($(which "$PYTHON")):"
+        $PYTHON --version
+        echo "::endgroup::"
+        echo "::group::Ruby ($(which "$RUBY")):"
+        $RUBY --version
+        echo "::endgroup::"
+
+    - name: Run tests
+      run: |
+        echo "::group::make install"
+        make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
+        echo "::group::make install-pywrap"
+        make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
+        echo "::group::make install-rubywrap"
+        make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
+
+        # Now that everything is installed, run "make all" to build everything which may have not been built
+        echo "::group::make all"
+        make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
+
+        # Set up environment variables for the tests and show variables (to help debugging issues)
+        echo "::group::Environment variables"
+        . ./scripts/env_use_destdir
+        echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
+        echo "PATH=$PATH"
+        echo "PYTHONPATH=$PYTHONPATH"
+        echo "RUBYLIB=$RUBYLIB"
+        echo "::endgroup::"
+
+        # Run tests
+        echo "::group::make test"
+        make test $EXPLICIT_MAKE_VARS
+        echo "::endgroup::"
+
+        # Test Python and Ruby wrappers
+        echo "::group::Test Python and Ruby wrappers"
+        $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
+        $RUBY -e 'require "selinux";require "semanage";puts Selinux::is_selinux_enabled()'
+        echo "::endgroup::"
+
+        # Run Python linter, but not on the downloaded refpolicy
+        echo "::group::scripts/run-flake8"
+        ./scripts/run-flake8
+        echo "::endgroup::"
+
+        echo "::group::Test .gitignore and make clean distclean"
+        # Remove every installed files
+        rm -rf "$DESTDIR"
+        # Test that "git status" looks clean, or print a clear error message
+        git status --short | sed -n 's/^??/error: missing .gitignore entry for/p' | (! grep '^')
+        # Clean up everything and show which file needs to be added to "make clean"
+        make clean distclean $EXPLICIT_MAKE_VARS
+        git ls-files --ignored --others --exclude-standard | sed 's/^/error: "make clean distclean" did not remove /' | (! grep '^')
+        echo "::endgroup::"
-- 
2.29.2

