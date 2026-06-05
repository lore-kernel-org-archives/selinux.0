Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E278F29
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679909; cv=none; b=exlggDzhgYHTVL1Xgoa8kE1x2RcuuUKrt2sY4bRbgp0hYpRZCxqTm+oEbZpSxiZ0S1VNRrVMHxz5VcyRsWTkrlB/RIXQLzgyp4vVfWNb1ECKQVBIMfCvXVYABN7GBTqsn/Giq4IgPWPjy+itiWdjYe1ppqVW22E7Y+tDiHLG5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679909; c=relaxed/simple;
	bh=bxoAFeJxhSxPvVtOSOWk/3YXqGmhjVyIWsBP7fPfktY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XwC+Bnn+H4uljf91zISEOwQaod41IlO+N2VqEyhrRTfyVeBlT8ddtGcmyg9cGPy7Ra2+cq6UVPuOSOTGxiCtfUY7O8Tm6Gef2Ne5MRXjbk5YNLULFiiMxjA3Yn7HJXzikGKwev/COrvr0yStPO+6nJjRrgG0R0MsjUIgMr9H0DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aNQBG0f2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aNQBG0f2"
Received: from CPC-chpeb-8M6PS.redmond.corp.microsoft.com (unknown [40.117.66.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id D30CE20B716A
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:18:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D30CE20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780679892;
	bh=OoukpyTuSFuh80d2cWFef9iJru/OrApASCo6Ad48a/I=;
	h=From:To:Subject:Date:From;
	b=aNQBG0f2loq0pzvsoJJU2Cmytl+eLEExvDt1/N4zcabhRVF7MftlY2oqJ+s8QMg9P
	 qg/445JaK+8fGfFJ8z4p2zSNKBEwY3S+IQHfeaO2Z+B9v2kDgvPEtOf4D6wa6XrItW
	 86T5NzVSW+JdbbaDXlVXEHq74l5+6TBI+/dAa1ps=
From: Chris PeBenito <chpebeni@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/3] ci: Refactor build into a custom GH action.
Date: Fri,  5 Jun 2026 17:18:23 +0000
Message-ID: <20260605171825.362853-1-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows other projects (refpolicy, setools, etc.) to reuse these steps in their CI pipelines.

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 .github/actions/build-userspace/action.yml | 139 +++++++++++++++++++++
 .github/workflows/run_tests.yml            | 114 +----------------
 2 files changed, 143 insertions(+), 110 deletions(-)
 create mode 100644 .github/actions/build-userspace/action.yml

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
new file mode 100644
index 00000000..2e4f513a
--- /dev/null
+++ b/.github/actions/build-userspace/action.yml
@@ -0,0 +1,139 @@
+name: Build SELinux userspace
+description: Set up Python, Ruby, install dependencies, and configure the build environment
+
+inputs:
+  python-version:
+    description: Python version to set up
+    required: true
+  ruby-version:
+    description: Ruby version to set up
+    required: true
+  compiler:
+    description: Compiler to use (gcc or clang)
+    required: true
+  other:
+    description: Additional build variant (test-flags-override, test-debug, linker-bfd, linker-gold, sanitizers)
+    required: false
+    default: ''
+
+runs:
+  using: composite
+  steps:
+    - name: Set up Python ${{ inputs.python-version }}
+      uses: actions/setup-python@v5
+      with:
+        python-version: ${{ inputs.python-version }}
+
+    - name: Set up Ruby ${{ inputs.ruby-version }}
+      uses: ruby/setup-ruby@v1
+      with:
+        ruby-version: ${{ inputs.ruby-version }}
+        bundler-cache: true
+
+    - name: Install dependencies
+      run: |
+        sudo apt-get update -q
+        sudo apt-get install -qy --no-install-recommends \
+            bison \
+            flex \
+            gawk \
+            gettext \
+            libaudit-dev \
+            libbz2-dev \
+            libcap-dev \
+            libcap-ng-dev \
+            libcunit1-dev \
+            libdbus-glib-1-dev \
+            libpcre2-dev \
+            ruby-dev \
+            swig \
+            xmlto
+
+        pip install flake8 setuptools build wheel
+
+    - name: Install Clang
+      if: ${{ inputs.compiler == 'clang' }}
+      run: sudo apt-get install -qqy clang
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
+        # https://bugs.ruby-lang.org/issues/18616
+        # https://github.com/llvm/llvm-project/issues/49958
+        if [ "${{ matrix.compiler }}" = "clang" ] && [[ "${{ matrix.python-ruby-version.ruby }}" = 3* ]] ; then
+            CC="$CC -fdeclspec"
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
+        elif [ "${{ matrix.python-ruby-version.other }}" = "sanitizers" ] ; then
+            sanitizers='-fsanitize=address,undefined'
+            EXPLICIT_MAKE_VARS="CFLAGS='-g -I$DESTDIR/usr/include $sanitizers' LDFLAGS='-L$DESTDIR/usr/lib $sanitizers' LDLIBS= CPPFLAGS= OPT_SUBDIRS="
+            echo "ASAN_OPTIONS=strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1" >> $GITHUB_ENV
+            echo "UBSAN_OPTIONS=print_stacktrace=1:print_summary=1:halt_on_error=1" >> $GITHUB_ENV
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
+        if [[ "${{ matrix.python-ruby-version.python }}" == pypy* ]] ; then
+            # PyPy does not provide a config file for pkg-config
+            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
+            echo "PYINC=-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
+            echo "PYLIBS=-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $GITHUB_ENV
+        fi
+
+        # Display the final environment file, for debugging purpose
+        cat $GITHUB_ENV
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
+    - name: Build SELinux userspace
+      run: |
+        echo "::group::make install"
+        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
+        echo "::group::make install"
+        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
+        echo "::group::make install-pywrap"
+        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
+        echo "::group::make install-rubywrap"
+        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
+        echo "::endgroup::"
diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 82c44fcc..f4aa1a4c 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -41,97 +41,13 @@ jobs:
     steps:
     - uses: actions/checkout@v4
 
-    - name: Set up Python ${{ matrix.python-ruby-version.python }}
-      uses: actions/setup-python@v5
+    - name: Build userspace
+      uses: ./.github/actions/build-userspace
       with:
         python-version: ${{ matrix.python-ruby-version.python }}
-
-    - name: Set up Ruby ${{ matrix.python-ruby-version.ruby }}
-      uses: ruby/setup-ruby@v1
-      with:
         ruby-version: ${{ matrix.python-ruby-version.ruby }}
-        bundler-cache: true
-
-    - name: Install dependencies
-      run: |
-        sudo apt-get update -q
-        sudo apt-get install -qy --no-install-recommends \
-            bison \
-            flex \
-            gawk \
-            gettext \
-            libaudit-dev \
-            libbz2-dev \
-            libcap-dev \
-            libcap-ng-dev \
-            libcunit1-dev \
-            libdbus-glib-1-dev \
-            libpcre2-dev \
-            ruby-dev \
-            swig \
-            xmlto
-
-        pip install flake8 setuptools build wheel
-
-    - name: Install Clang
-      if: ${{ matrix.compiler == 'clang' }}
-      run: sudo apt-get install -qqy clang
-
-    - name: Configure the environment
-      run: |
-        DESTDIR=/tmp/destdir
-        echo "PYTHON=python" >> $GITHUB_ENV
-        echo "RUBY=ruby" >> $GITHUB_ENV
-        echo "DESTDIR=$DESTDIR" >> $GITHUB_ENV
-
-        CC=${{ matrix.compiler }}
-        if [ "${{ matrix.python-ruby-version.other }}" = "linker-bfd" ] ; then
-            CC="$CC -fuse-ld=bfd"
-        elif [ "${{ matrix.python-ruby-version.other }}" = "linker-gold" ] ; then
-            CC="$CC -fuse-ld=gold"
-        fi
-        # https://bugs.ruby-lang.org/issues/18616
-        # https://github.com/llvm/llvm-project/issues/49958
-        if [ "${{ matrix.compiler }}" = "clang" ] && [[ "${{ matrix.python-ruby-version.ruby }}" = 3* ]] ; then
-            CC="$CC -fdeclspec"
-        fi
-        echo "CC=$CC" >> $GITHUB_ENV
-
-        EXPLICIT_MAKE_VARS=
-        if [ "${{ matrix.python-ruby-version.other }}" = "test-flags-override" ] ; then
-            # Test that overriding CFLAGS, LDFLAGS and other variables works fine
-            EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS="
-        elif [ "${{ matrix.python-ruby-version.other }}" = "test-debug" ] ; then
-            # Test hat debug build works fine
-            EXPLICIT_MAKE_VARS="DEBUG=1"
-        elif [ "${{ matrix.python-ruby-version.other }}" = "sanitizers" ] ; then
-            sanitizers='-fsanitize=address,undefined'
-            EXPLICIT_MAKE_VARS="CFLAGS='-g -I$DESTDIR/usr/include $sanitizers' LDFLAGS='-L$DESTDIR/usr/lib $sanitizers' LDLIBS= CPPFLAGS= OPT_SUBDIRS="
-            echo "ASAN_OPTIONS=strict_string_checks=1:detect_stack_use_after_return=1:check_initialization_order=1:strict_init_order=1" >> $GITHUB_ENV
-            echo "UBSAN_OPTIONS=print_stacktrace=1:print_summary=1:halt_on_error=1" >> $GITHUB_ENV
-        else
-            EXPLICIT_MAKE_VARS=
-        fi
-        echo "EXPLICIT_MAKE_VARS=${EXPLICIT_MAKE_VARS}" >> $GITHUB_ENV
-
-        # Find files in order of pkgconf to be able to find Python.h
-        # For example with Python 3.5:
-        # * python is located at /opt/hostedtoolcache/Python/3.5.10/x64/bin/python
-        # * sys.prefix is /opt/hostedtoolcache/Python/3.5.10/x64
-        # * Python.h is located at /opt/hostedtoolcache/Python/3.5.10/x64/include/python3.5m/Python.h
-        # * python-3.5.pc is located at /opt/hostedtoolcache/Python/3.5.10/x64/lib/pkgconfig/python-3.5.pc
-        PYTHON_SYS_PREFIX="$(python -c 'import sys;print(sys.prefix)')"
-        echo "PKG_CONFIG_PATH=${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $GITHUB_ENV
-
-        if [[ "${{ matrix.python-ruby-version.python }}" == pypy* ]] ; then
-            # PyPy does not provide a config file for pkg-config
-            # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
-            echo "PYINC=-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
-            echo "PYLIBS=-L${PYTHON_SYS_PREFIX}/bin -lpypy3-c" >> $GITHUB_ENV
-        fi
-
-        # Display the final environment file, for debugging purpose
-        cat $GITHUB_ENV
+        compiler: ${{ matrix.compiler }}
+        other: ${{ matrix.python-ruby-version.other }}
 
     - name: Download and install refpolicy headers for sepolgen tests
       run: |
@@ -145,30 +61,8 @@ jobs:
         sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolgen/src/sepolgen/module.py
         rm -r refpolicy refpolicy.tar.bz2
 
-    - name: Display versions
-      run: |
-        echo "::group::Compiler ($CC):"
-        $CC --version
-        echo "::endgroup::"
-        echo "::group::Python ($(which "$PYTHON")):"
-        $PYTHON --version
-        echo "::endgroup::"
-        echo "::group::Ruby ($(which "$RUBY")):"
-        $RUBY --version
-        echo "::endgroup::"
-
     - name: Run tests
       run: |
-        echo "::group::make install"
-        eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
-        echo "::endgroup::"
-        echo "::group::make install-pywrap"
-        eval make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
-        echo "::endgroup::"
-        echo "::group::make install-rubywrap"
-        eval make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
-        echo "::endgroup::"
-
         # Now that everything is installed, run "make all" to build everything which may have not been built
         echo "::group::make all"
         eval make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
-- 
2.54.0

