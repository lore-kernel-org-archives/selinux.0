Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CAAC00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiHHRhG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHHRhD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:37:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBAF13E91
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:37:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m4so17906877ejr.3
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=zZ1SfGtJgmwMBhmPKnIvfw8X6bxjX7HYMd96E5iOjO8=;
        b=JT/ZmnyJrXmVNFjGLSXWW4pU9Ajgw5t9eticA1BeZh2UywsFPrSYu8q75VbgP53kMd
         ieSr8ePX1LNs5tfqLs3tqAauUx7bWiMOMLtJiaWVOn3nAF7NuAoYUlhM+HHe7Eqzrnd5
         e6w28HDG+10nV0HaY0/r5ZbYBTP6a9OYK7rN0mVnMGxZ9d6lABeOrUwNE0W5lvG2mBva
         2U3lG2+qaCYFSKg6hetFAMM71ETSS/Fk1ETYxKEKe/TM+Z5zTDnOY/68/4BNDU4ZojB+
         GtWBpuJFPus8ssk+m9QPmun1p0Va3R3t47B3j9dUNvS2+EnUWZHLLO1G6FvxS/eI+wAR
         5Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=zZ1SfGtJgmwMBhmPKnIvfw8X6bxjX7HYMd96E5iOjO8=;
        b=ma4ctUkOd20dzV5i9WZC3KOpKQn62e5X480TrjQfL/mptrj/KzlDD1osMcMGnvLJK3
         3XESOI9p2N3q3FKED1skJjjQMQg/jh5ITnoaMlHfnaigJtx/edyMZn5MY+yi+xZmZsI/
         3PA/KebA0LNI/XdG//a778VdTMHGG83WgzePlxi450jvMOoMTOxfx4DJg8d9pTAreU38
         VqcGwt51Q5CGjZ79yUnMv1A0LFXp9/9njmt7T9naaG9/6uhqwKSPhjnHSVGQZasHrro7
         CcvEo67c8iMbL0OPrGZog6iY1iVcUxWVmTWG7AGNpB1FtxtnkSpfkpWU8gmImbYWRTva
         pC5w==
X-Gm-Message-State: ACgBeo1fcZIfT34yQk3AgxJsetDxhS7qqPps7ays/fagD0Cz3cpRA8d4
        HDD9yKyM1v4TYRbe7KGvEzwMCa9ouDY=
X-Google-Smtp-Source: AA6agR4mtiKhWT05SONwcP47jsWi7sWhaawX3rVHLrUNB5GL1qtrmn3SnPiYQPs+rAsDeT1xS81rcA==
X-Received: by 2002:a17:907:3ea7:b0:730:9a8b:b8f1 with SMTP id hs39-20020a1709073ea700b007309a8bb8f1mr14927875ejc.168.1659980219722;
        Mon, 08 Aug 2022 10:36:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id es25-20020a056402381900b0043a61f6c389sm4851900edb.4.2022.08.08.10.36.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:36:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] ci: bump versions in GitHub Actions
Date:   Mon,  8 Aug 2022 19:36:52 +0200
Message-Id: <20220808173655.16867-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Move from deprecated actions/setup-ruby to ruby/setup-ruby.
* Bump python and ruby upper versions.
* Bump Reference Policy version
* Do not install recommend packages and output package resolution
* Bump to macOS 12

  macOS 10 is deprecated since 5/31/22 [1].
  VirtualBox and Vagrant seems to be supported [2][3].

[1]: https://github.com/actions/virtual-environments/issues/5583
[2]: https://github.com/actions/virtual-environments/pull/5594
[3]: https://github.com/actions/virtual-environments/pull/5854

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .github/workflows/run_tests.yml    | 62 +++++++++++++++++-------------
 .github/workflows/vm_testsuite.yml |  5 +--
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 8b7cb720..db0e1af5 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -10,48 +10,51 @@ jobs:
       matrix:
         compiler: [gcc, clang]
         python-ruby-version:
-          - {python: 3.9, ruby: 2.7}
-          - {python: 3.9, ruby: 2.7, other: test-flags-override}
-          - {python: 3.9, ruby: 2.7, other: test-debug}
-          - {python: 3.9, ruby: 2.7, other: linker-bfd}
-          - {python: 3.9, ruby: 2.7, other: linker-gold}
+          - {python: '3.10', ruby: '3.1'}
+          - {python: '3.10', ruby: '3.1', other: test-flags-override}
+          - {python: '3.10', ruby: '3.1', other: test-debug}
+          - {python: '3.10', ruby: '3.1', other: linker-bfd}
+          - {python: '3.10', ruby: '3.1', other: linker-gold}
           # Test several Python versions with the latest Ruby version
-          - {python: 3.8, ruby: 2.7}
-          - {python: 3.7, ruby: 2.7}
-          - {python: 3.6, ruby: 2.7}
-          - {python: 3.5, ruby: 2.7}
-          - {python: pypy3, ruby: 2.7}
+          - {python: '3.9', ruby: '3.1'}
+          - {python: '3.8', ruby: '3.1'}
+          - {python: '3.7', ruby: '3.1'}
+          - {python: '3.6', ruby: '3.1'}
+          - {python: '3.5', ruby: '3.1'}
+          - {python: 'pypy3.7', ruby: '3.1'}
           # Test several Ruby versions with the latest Python version
-          - {python: 3.9, ruby: 2.6}
-          - {python: 3.9, ruby: 2.5}
+          - {python: '3.10', ruby: '3.0'}
+          - {python: '3.10', ruby: '2.7'}
+          - {python: '3.10', ruby: '2.6'}
+          - {python: '3.10', ruby: '2.5'}
         exclude:
           - compiler: clang
-            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-bfd}
+            python-ruby-version: {python: '3.10', ruby: '3.1', other: linker-bfd}
           - compiler: clang
-            python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-gold}
+            python-ruby-version: {python: '3.10', ruby: '3.1', other: linker-gold}
         include:
           - compiler: gcc
-            python-ruby-version: {python: 3.9, ruby: 2.7, other: sanitizers}
+            python-ruby-version: {python: '3.10', ruby: '3.1', other: sanitizers}
 
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
 
     - name: Set up Python ${{ matrix.python-ruby-version.python }}
-      uses: actions/setup-python@v2
+      uses: actions/setup-python@v4
       with:
         python-version: ${{ matrix.python-ruby-version.python }}
 
     - name: Set up Ruby ${{ matrix.python-ruby-version.ruby }}
-      uses: actions/setup-ruby@v1
+      uses: ruby/setup-ruby@v1
       with:
         ruby-version: ${{ matrix.python-ruby-version.ruby }}
+        bundler-cache: true
 
     - name: Install dependencies
       run: |
-        sudo apt-get update -qq
-        sudo apt-get install -qqy \
+        sudo apt-get update -q
+        sudo apt-get install -qy --no-install-recommends \
             bison \
-            clang \
             flex \
             gawk \
             gettext \
@@ -61,14 +64,16 @@ jobs:
             libcunit1-dev \
             libdbus-glib-1-dev \
             libpcre2-dev \
-            python3-dev \
-            python-dev \
             ruby-dev \
             swig \
             xmlto
 
         pip install flake8
 
+    - name: Install Clang
+      if: ${{ matrix.compiler == 'clang' }}
+      run: sudo apt-get install -qqy clang
+
     - name: Configure the environment
       run: |
         DESTDIR=/tmp/destdir
@@ -82,6 +87,11 @@ jobs:
         elif [ "${{ matrix.python-ruby-version.other }}" = "linker-gold" ] ; then
             CC="$CC -fuse-ld=gold"
         fi
+        # https://bugs.ruby-lang.org/issues/18616
+        # https://github.com/llvm/llvm-project/issues/49958
+        if [ "${{ matrix.compiler }}" = "clang" ] && [[ "${{ matrix.python-ruby-version.ruby }}" = 3* ]] ; then
+            CC="$CC -fdeclspec"
+        fi
         echo "CC=$CC" >> $GITHUB_ENV
 
         EXPLICIT_MAKE_VARS=
@@ -110,7 +120,7 @@ jobs:
         PYTHON_SYS_PREFIX="$(python -c 'import sys;print(sys.prefix)')"
         echo "PKG_CONFIG_PATH=${PYTHON_SYS_PREFIX}/lib/pkgconfig" >> $GITHUB_ENV
 
-        if [ "${{ matrix.python-ruby-version.python }}" = "pypy3" ] ; then
+        if [[ "${{ matrix.python-ruby-version.python }}" = pypy* ]] ; then
             # PyPy does not provide a config file for pkg-config
             # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
             echo "PYINC=-I${PYTHON_SYS_PREFIX}/include" >> $GITHUB_ENV
@@ -122,10 +132,10 @@ jobs:
 
     - name: Download and install refpolicy headers for sepolgen tests
       run: |
-        curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-2.20180701.tar.bz2
+        curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20220520/refpolicy-2.20220520.tar.bz2
         tar -xvjf refpolicy.tar.bz2
         sed -e "s,^PREFIX :=.*,PREFIX := $DESTDIR/usr," -i refpolicy/support/Makefile.devel
-        sudo make -C refpolicy install-headers clean
+        sudo make -C refpolicy install-headers bare
         sudo mkdir -p /etc/selinux
         echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
         echo 'SELINUX_DEVEL_PATH = /usr/share/selinux/refpolicy' | sudo tee /etc/selinux/sepolgen.conf
diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
index 601276dd..92155da2 100644
--- a/.github/workflows/vm_testsuite.yml
+++ b/.github/workflows/vm_testsuite.yml
@@ -6,11 +6,10 @@ jobs:
   vm_testsuite:
 
     # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
-    # Use an old version of macOS until https://github.com/actions/virtual-environments/pull/4010 is merged.
-    runs-on: macos-10.15
+    runs-on: macos-12
 
     steps:
-    - uses: actions/checkout@v2
+    - uses: actions/checkout@v3
 
     - name: Create Vagrant VM
       run: |
-- 
2.36.1

