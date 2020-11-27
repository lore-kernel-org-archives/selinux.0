Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B29DC2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAADF21D7A
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfcAieqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgK0OR4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 09:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbgK0OR4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 09:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606486674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=62b68+Pa+QssYKyvZPwV42S7c3D13NW59xU+2o6idxY=;
        b=RfcAieqnNTXNy1ppd0m/18ZP3cbOXP/5KTnb1Tf/gt74+MJ5PuAW9yG0S5SImTmC0C4y6C
        en+yPAjkm2nVQpPjf3qLlCCIaEnas/etY74/cfSfQCJXu2AWiB0/kdoompazL3PrkDZl0I
        wvmDsg6QWZQbu3OEIYsZO68mZGLicsc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-mQnpYKS2PHaR46YqxLon-g-1; Fri, 27 Nov 2020 09:17:50 -0500
X-MC-Unique: mQnpYKS2PHaR46YqxLon-g-1
Received: by mail-ej1-f70.google.com with SMTP id a14so2003599ejr.23
        for <selinux@vger.kernel.org>; Fri, 27 Nov 2020 06:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62b68+Pa+QssYKyvZPwV42S7c3D13NW59xU+2o6idxY=;
        b=p7WR4/S1gXuoyJKAjN/dCZiiOIP+cA8P7XwvrAhmbwS6JHVg7unXx7ncwit4DXXPrn
         wFUV6rkrn1wy1VR+gBJLLnqCAbhixWXjQ3nLo3mAAi97mfjx9JyIZaMhAnYXxNupYrnp
         l1v0Lwb3HX1Jc+KAGor7ziW6CAni76ywDxP5pcsB6kmcJ5zsxRa649pKBWk8Yg30QOE5
         q5UT30pDcQB9vUaTeUKCWVhSY9H16PCwwZvZ0aeOfwkW5VSb8HJK+34mKGYIuCTDUCOX
         /y8UDLrCifw77pR3LXkfWTUWi48sXKO8uHt4Npchuxgh1o7Jlz90oGFx07ZkTG6NEbfd
         z/1A==
X-Gm-Message-State: AOAM533yjs60ow+I2NcSbHg1ZF+wLYkEh+YbQDJviMB5rBLxrU57GVLv
        1djIcXRPCz1PGq4r+P01HaZRChj5JQlg2YJJTe9w/ALcDPLlVqi7vrNJcaducF0/O/v/BJDI44w
        3CO0lYCZKtbaGHWbNYQWS2l56/X9gISP2mfOfWDzS815dEFQGne9S5zA31/QeI+WjT4oSXw==
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr952960edw.135.1606486668422;
        Fri, 27 Nov 2020 06:17:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyncpgx4VWpjptaYgnC0tEvt/yqho7IBA4UCfRyNIvkRcMk3ehFOoHF1UPZ9pMQGgDmhlpJFg==
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr952930edw.135.1606486668158;
        Fri, 27 Nov 2020 06:17:48 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id gt11sm2008825ejb.67.2020.11.27.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 06:17:47 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH userspace] travis: run only selinux-testsuite
Date:   Fri, 27 Nov 2020 15:17:45 +0100
Message-Id: <20201127141745.1579498-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that the standard testing is run on GitHub Actions, we can remove it
from .travis.yml, leaving only the selinux-testsuite sanity check, which
can't be migrated. Hopefully this will save some precious minutesfrom
the limited "plan" Travis gave us...

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml                    | 161 +--------------------------------
 scripts/ci/travis-kvm-setup.sh |   1 +
 2 files changed, 2 insertions(+), 160 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6c0f6241..1c2c7f33 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,171 +1,12 @@
 # Define the building environment
 language: c
 
-matrix:
-  fast_finish: true
-
-compiler:
-  - clang
-  - gcc
-
-env:
-  matrix:
-    # Test the last version of Python and Ruby together, with some linkers
-    - PYVER=python3.8 RUBYLIBVER=2.7
-    - PYVER=python3.8 RUBYLIBVER=2.7 TEST_FLAGS_OVERRIDE=1
-    - PYVER=python3.8 RUBYLIBVER=2.7 TEST_DEBUG=1
-    - PYVER=python3.8 RUBYLIBVER=2.7 LINKER=gold
-    - PYVER=python3.8 RUBYLIBVER=2.7 LINKER=bfd
-
-    # Test several Python versions (https://docs.travis-ci.com/user/languages/python/#python-versions)
-    - PYVER=python3.5 RUBYLIBVER=2.7
-    - PYVER=python3.6 RUBYLIBVER=2.7
-    - PYVER=python3.7 RUBYLIBVER=2.7
-    - PYVER=pypy3.6-7.2.0 RUBYLIBVER=2.7
-
-    # Test several Ruby versions (http://rubies.travis-ci.org/)
-    - PYVER=python3.8 RUBYLIBVER=2.6
-    - PYVER=python3.8 RUBYLIBVER=2.5.1
-    - PYVER=python3.8 RUBYLIBVER=2.4
-
-matrix:
-  exclude:
-    - compiler: clang
-      env: PYVER=python3.8 RUBYLIBVER=2.7 LINKER=gold
-    - compiler: clang
-      env: PYVER=python3.8 RUBYLIBVER=2.7 LINKER=bfd
-  include:
-    - compiler: gcc
-      env: TRAVIS_RUN_KVM=true FEDORA_MAJOR=33 FEDORA_MINOR=1.2
-      install:
-        - skip
-      before_script:
-        - skip
-      script: scripts/ci/travis-kvm-setup.sh
-
 # Use Travis-CI Ubuntu 18.04 Bionic Beaver, "full image" variant
 sudo: required
 dist: bionic
 
-# Install SELinux userspace utilities dependencies
-addons:
-  apt:
-    packages:
-    - bison
-    - flex
-    - gawk
-    - gettext
-    - libaudit-dev
-    - libbz2-dev
-    - libcap-dev
-    - libcap-ng-dev # This package is not whitelisted for the container infrastructure (https://github.com/travis-ci/apt-package-whitelist/issues/1096)
-    - libcunit1-dev
-    - libglib2.0-dev
-    - libpcre3-dev
-    - patch
-    - python3-dev
-    - python-dev
-    - swig
-    - xmlto
-
-install:
-  # Download and install refpolicy headers for sepolgen tests
-  - curl --location --retry 10 -o "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-2.20180701.tar.bz2
-  - tar -C "$TRAVIS_BUILD_DIR" -xvjf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2"
-  # Make refpolicy Makefile use the new toolchain when building modules
-  - sed -e "s,^PREFIX :=.*,PREFIX := \$(DESTDIR)/usr," -i "$TRAVIS_BUILD_DIR/refpolicy/support/Makefile.devel"
-  - sudo make -j$(nproc) -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
-  - sudo rm -rf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" "$TRAVIS_BUILD_DIR/refpolicy"
-  - sudo mkdir -p /etc/selinux
-  - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
-  - echo 'SELINUX_DEVEL_PATH = /usr/share/selinux/refpolicy' | sudo tee /etc/selinux/sepolgen.conf
-
-  # Make sepolgen tests work without really installing anything in the real root (doing this would conflict with Ubuntu packages)
-  - sed -e "s,\"\(/usr/bin/[cs]\),\"$TRAVIS_BUILD_DIR/installdir\1," -i python/sepolgen/src/sepolgen/module.py
-
-  # Download the required python version if it is not installed
-  - VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
-  - if ! [ -d "$VIRTUAL_ENV" ] ; then
-        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/travis-python-archives/binaries/ubuntu/18.04/x86_64/${PYVER/python/python-}.tar.bz2" &&
-        sudo tar xjf python.tar.bz2 --directory / &&
-        rm python.tar.bz2 ;
-    fi
-
-  # Install flake8 for the given python version
-  - $VIRTUAL_ENV/bin/pip install flake8
-
-before_script:
-  # Build and install in a temporary directory to run tests
-  - export DESTDIR="$TRAVIS_BUILD_DIR/installdir"
-
-  # Configure the variables for Python parts
-  - export VIRTUAL_ENV="$HOME/virtualenv/$PYVER"
-  - export PYTHON="$VIRTUAL_ENV/bin/python"
-  # Use the header files in /opt/python/... for Python because the virtualenvs do not provide Python.h
-  - export PKG_CONFIG_PATH="/opt/python/$($PYTHON -c 'import sys;print("%d.%d.%d" % sys.version_info[:3])')/lib/pkgconfig"
-  # PyPy does not provide a config file for pkg-config
-  # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
-  - if echo "$PYVER" | grep -q pypy ; then
-        export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include ;
-        export PYLIBS="$($PYTHON -c 'import sys;print("-L%s/bin -l%s" % (sys.prefix, "pypy-c" if sys.version_info < (3,) else "pypy3-c"))')" ;
-    fi
-
-  # Find the Ruby executable with version $RUBYLIBVER
-  - rvm reinstall ruby-$RUBYLIBVER --binary
-  - export RUBY="$(ls -d -1 "$HOME/.rvm/rubies/ruby-$RUBYLIBVER"*/bin/ruby | head -n 1)"
-
-  # Set the linker in $CC so that it gets used everywhere
-  - if [ -n "$LINKER" ]; then CC="$CC -fuse-ld=$LINKER" ; fi
-
-  # Show variables and versions (to help debugging)
-  - echo "$CC" ; $CC --version
-  - echo "$PYTHON" ; $PYTHON --version
-  - echo "$RUBY" ; $RUBY --version
-
-  # If TEST_FLAGS_OVERRIDE is defined, test that overriding CFLAGS, LDFLAGS and other variables works fine
-  - if [ -n "$TEST_FLAGS_OVERRIDE" ]; then EXPLICIT_MAKE_VARS="CFLAGS=-I$DESTDIR/usr/include LDFLAGS=-L$DESTDIR/usr/lib LDLIBS= CPPFLAGS=" ; fi
-  # If TEST_DEBUG is defined, test that debug build works fine
-  - if [ -n "$TEST_DEBUG" ]; then EXPLICIT_MAKE_VARS="$EXPLICIT_MAKE_VARS DEBUG=1" ; fi
-
 script:
-  # Start by installing everything into $DESTDIR
-  - make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
-  - make -j$(nproc) install-pywrap $EXPLICIT_MAKE_VARS -k
-  - make -j$(nproc) install-rubywrap $EXPLICIT_MAKE_VARS -k
-
-  # Now that everything is installed, run "make all" to build everything which may have not been built
-  - make -j$(nproc) all $EXPLICIT_MAKE_VARS -k
-
-  # Set up environment variables for the tests
-  - . ./scripts/env_use_destdir
-
-  # Show variables (to help debugging issues)
-  - echo "$LD_LIBRARY_PATH"
-  - echo "$PATH"
-  - echo "$PYTHONPATH"
-  - echo "$RUBYLIB"
-
-  # Run tests
-  - make test $EXPLICIT_MAKE_VARS
-
-  # Test Python and Ruby wrappers
-  - $PYTHON -c 'import selinux;import selinux.audit2why;import semanage;print(selinux.is_selinux_enabled())'
-  - $RUBY -e 'require "selinux";require "semanage";puts Selinux::is_selinux_enabled()'
-
-  # Run Python linter
-  - PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
-
-  # Remove every installed files
-  - rm -rf "$DESTDIR"
-
-  # Test that "git status" looks clean, or print a clear error message
-  - |-
-    git status --short | sed -n 's/^??/error: missing .gitignore entry for/p' | (! grep '^')
-
-  # Clean up everything and show which file would be added to "make clean"
-  - make clean distclean $EXPLICIT_MAKE_VARS
-  - |-
-    git ls-files --ignored --others --exclude-standard | sed 's/^/error: "make clean distclean" did not remove /' | (! grep '^')
+  - FEDORA_MAJOR=33 FEDORA_MINOR=1.2 scripts/ci/travis-kvm-setup.sh
 
 # Do not spam by email so long as the build succeeds
 notifications:
diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
index 756fab82..997ef73f 100755
--- a/scripts/ci/travis-kvm-setup.sh
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -26,6 +26,7 @@ MEMORY=4096
 VCPUS="$(nproc)"
 
 # Install these here so other builds don't have to wait on these deps to download and install
+sudo apt-get update
 sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker libguestfs-tools
 
 sudo usermod -a -G kvm,libvirt,libvirt-qemu "$USER"
-- 
2.26.2

