Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6872C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 16:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FAE2146E
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 16:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfBTQE7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:04:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25693 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTQE6 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 20 Feb 2019 11:04:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46DD331E7BD
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 16:04:58 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92E8F183C3;
        Wed, 20 Feb 2019 16:04:57 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/3] Switch to python3 by default
Date:   Wed, 20 Feb 2019 17:04:45 +0100
Message-Id: <20190220160446.23150-3-plautrba@redhat.com>
In-Reply-To: <20190220160446.23150-1-plautrba@redhat.com>
References: <20190220160446.23150-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 20 Feb 2019 16:04:58 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Python 2.7 is planned to be the last of the 2.x releases
- It's generally advised to use Python 3
- Majority of python/ scripts are already switched python3
- Users with python 2 only can still use:

$ make PYTHON=/usr/bin/python ....

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/Makefile               | 2 +-
 libsemanage/src/Makefile              | 2 +-
 python/audit2allow/Makefile           | 2 +-
 python/semanage/Makefile              | 2 +-
 python/sepolgen/src/sepolgen/Makefile | 2 +-
 python/sepolgen/tests/Makefile        | 2 +-
 python/sepolicy/Makefile              | 2 +-
 sandbox/Makefile                      | 2 +-
 scripts/env_use_destdir               | 2 +-
 scripts/run-scan-build                | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 92e30738..e9ed0383 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -1,7 +1,7 @@
 # Support building the Python bindings multiple times, against various Python
 # runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
 # targets with "PYPREFIX":
-PYTHON ?= python
+PYTHON ?= python3
 PYPREFIX ?= $(shell $(PYTHON) -c 'import sys;print("python-%d.%d" % sys.version_info[:2])')
 RUBY ?= ruby
 RUBYPREFIX ?= $(notdir $(RUBY))
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index dea751e5..e029f098 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -1,7 +1,7 @@
 # Support building the Python bindings multiple times, against various Python
 # runtimes (e.g. Python 2 vs Python 3) by optionally prefixing the build
 # targets with "PYPREFIX":
-PYTHON ?= python
+PYTHON ?= python3
 PYPREFIX ?= $(shell $(PYTHON) -c 'import sys;print("python-%d.%d" % sys.version_info[:2])')
 RUBY ?= ruby
 RUBYPREFIX ?= $(notdir $(RUBY))
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 18d740d3..15db5490 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -1,4 +1,4 @@
-PYTHON ?= python
+PYTHON ?= python3
 SECILC ?= secilc
 
 # Installation directories.
diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index 37065268..024e9640 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -1,4 +1,4 @@
-PYTHON ?= python
+PYTHON ?= python3
 
 # Installation directories.
 LINGUAS ?= ru
diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
index c75809ad..cac8def7 100644
--- a/python/sepolgen/src/sepolgen/Makefile
+++ b/python/sepolgen/src/sepolgen/Makefile
@@ -1,5 +1,5 @@
 PREFIX ?= /usr
-PYTHON ?= python
+PYTHON ?= python3
 PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
 PACKAGEDIR ?= /$(PYTHONLIBDIR)/sepolgen
 
diff --git a/python/sepolgen/tests/Makefile b/python/sepolgen/tests/Makefile
index e17eef22..83d072f4 100644
--- a/python/sepolgen/tests/Makefile
+++ b/python/sepolgen/tests/Makefile
@@ -1,4 +1,4 @@
-PYTHON ?= python
+PYTHON ?= python3
 
 clean:
 	rm -f *~ *.pyc
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 7ed039bc..69f29fa9 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -1,4 +1,4 @@
-PYTHON ?= python
+PYTHON ?= python3
 
 # Installation directories.
 LINGUAS ?= ru
diff --git a/sandbox/Makefile b/sandbox/Makefile
index 862bffbe..9da5e58d 100644
--- a/sandbox/Makefile
+++ b/sandbox/Makefile
@@ -1,4 +1,4 @@
-PYTHON ?= python
+PYTHON ?= python3
 
 # Installation directories.
 LINGUAS ?= ru
diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
index 4fbfb8de..251987c2 100755
--- a/scripts/env_use_destdir
+++ b/scripts/env_use_destdir
@@ -25,7 +25,7 @@ export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
 export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
 
 # shellcheck disable=SC2155
-export PYTHONPATH="$DESTDIR$(${PYTHON:-python} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
+export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
 
 # shellcheck disable=SC2155
 export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index 8b24a4d0..88fe551c 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -17,7 +17,7 @@ fi
 # Make sure to use the newly-installed libraries when running tests
 export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
 export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
-export PYTHONPATH="$DESTDIR$(${PYTHON:-python} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
+export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
 export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
 # Build and analyze
-- 
2.20.1

