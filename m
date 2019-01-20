Return-Path: <SRS0=W3AJ=P4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42BEC26640
	for <selinux@archiver.kernel.org>; Sun, 20 Jan 2019 19:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E21D2084F
	for <selinux@archiver.kernel.org>; Sun, 20 Jan 2019 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfATTUC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:20:02 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58006 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfATTUC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 20 Jan 2019 14:20:02 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B805B56120C
        for <selinux@vger.kernel.org>; Sun, 20 Jan 2019 20:19:59 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] scripts: introduce env_use_destdir.sh helper
Date:   Sun, 20 Jan 2019 20:19:33 +0100
Message-Id: <20190120191933.21343-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120191933.21343-1-nicolas.iooss@m4x.org>
References: <20190120191933.21343-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jan 20 20:20:00 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Set-up environment variables in order to use DESTDIR in Python, Ruby,
etc. This makes testing Python scripts easier.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml             |  5 +----
 scripts/env_use_destdir | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 4 deletions(-)
 create mode 100755 scripts/env_use_destdir

diff --git a/.travis.yml b/.travis.yml
index 19914f4c2823..7a9e73ce55db 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -129,10 +129,7 @@ script:
   - make all $EXPLICIT_MAKE_VARS -k
 
   # Set up environment variables for the tests
-  - export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
-  - export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
-  - export PYTHONPATH="$DESTDIR$($PYTHON -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
-  - export RUBYLIB="$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$($RUBY -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
+  - . ./scripts/env_use_destdir
 
   # Show variables (to help debugging issues)
   - echo "$LD_LIBRARY_PATH"
diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
new file mode 100755
index 000000000000..4fbfb8dec44f
--- /dev/null
+++ b/scripts/env_use_destdir
@@ -0,0 +1,36 @@
+#!/bin/sh
+# Set-up environment variables to run programs which are built in DESTDIR folder
+#
+# Usage example to use variables in the current shell:
+#   $ export DESTDIR=$HOME/selinux-destdir
+#   $ make install install-pywrap install-rubywrap
+#   $ . ./scripts/env_use_destdir
+#   $ make test
+#
+# Or to use variables in a subcommand, for example to run tests:
+#   $ export DESTDIR=$HOME/selinux-destdir
+#   $ make install install-pywrap install-rubywrap
+#   $ ./scripts/env_use_destdir secilc ...
+#   $ ./scripts/env_use_destdir make test
+
+if [ -z "${DESTDIR:-}" ] ; then
+    echo >&2 "Error: variable DESTDIR needs to be defined in order to use this script."
+    echo >&2 "Example:"
+    # shellcheck disable=SC2164
+    echo >&2 "    DESTDIR=$(cd "$(dirname -- "$0")/.." ; pwd)/DESTDIR . $0"
+    exit 1
+fi
+
+export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
+export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
+
+# shellcheck disable=SC2155
+export PYTHONPATH="$DESTDIR$(${PYTHON:-python} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
+
+# shellcheck disable=SC2155
+export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
+
+# Run the command given on the command line
+if [ $# -gt 0 ] ; then
+    exec "$@"
+fi
-- 
2.20.1

