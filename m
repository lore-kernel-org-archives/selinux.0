Return-Path: <SRS0=W3AJ=P4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD797C26641
	for <selinux@archiver.kernel.org>; Sun, 20 Jan 2019 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA712084F
	for <selinux@archiver.kernel.org>; Sun, 20 Jan 2019 19:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfATTUA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:20:00 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:52126 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfATTUA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 20 Jan 2019 14:20:00 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1D6E85611EB
        for <selinux@vger.kernel.org>; Sun, 20 Jan 2019 20:19:56 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] Travis-CI: upgrade PyPy to 6.0
Date:   Sun, 20 Jan 2019 20:19:31 +0100
Message-Id: <20190120191933.21343-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jan 20 20:19:56 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

PyPy 6.0 was released in April 2018 but became available on Travis-CI
only recently. Now that it is available, use it.

While at it, compile Python modules with libpypy-c.so, now that PyPy
provides this library. This would enable linking Python modules with
-Wl,-no-undefined (or -Wl,-z,defs) and help fixing issues with
https://github.com/SELinuxProject/selinux/pull/130.

Tracking issues:
* https://github.com/travis-ci/travis-ci/issues/9542
* https://travis-ci.community/t/pypy-2-7-on-xenial/889

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 08a29b2f5adc..b8e97f83bbcd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -20,10 +20,8 @@ env:
     - PYVER=python2.7 RUBYLIBVER=2.5.1
     - PYVER=python3.5 RUBYLIBVER=2.5.1
     - PYVER=python3.6 RUBYLIBVER=2.5.1
-    # pypy2.7 seems not to be available in Travis-CI Xenial template yet.
-    # https://github.com/travis-ci/travis-ci/issues/9542
-    #- PYVER=pypy RUBYLIBVER=2.5.1
-    - PYVER=pypy3.5 RUBYLIBVER=2.5.1
+    - PYVER=pypy2.7-6.0 RUBYLIBVER=2.5.1
+    - PYVER=pypy3.5-6.0 RUBYLIBVER=2.5.1
 
     # Test several Ruby versions
     - PYVER=python3.7 RUBYLIBVER=2.4
@@ -98,8 +96,12 @@ before_script:
   - export PYTHON="$VIRTUAL_ENV/bin/python"
   # Use the header files in /opt/python/... for Python because the virtualenvs do not provide Python.h
   - export PKG_CONFIG_PATH="/opt/python/$($PYTHON -c 'import sys;print("%d.%d.%d" % sys.version_info[:3])')/lib/pkgconfig"
-  # PyPy does not provide a config file for pkg-config nor a pypy-c.so
-  - if echo "$PYVER" | grep -q pypy ; then export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include PYLIBS= ; fi
+  # PyPy does not provide a config file for pkg-config
+  # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and bin/libpypy3-c.so for PyPy3
+  - if echo "$PYVER" | grep -q pypy ; then
+        export PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include ;
+        export PYLIBS="$($PYTHON -c 'import sys;print("-L%s/bin -l%s" % (sys.prefix, "pypy-c" if sys.version_info < (3,) else "pypy3-c"))')" ;
+    fi
 
   # Find the Ruby executable with version $RUBYLIBVER
   - rvm reinstall ruby-$RUBYLIBVER --binary
-- 
2.20.1

