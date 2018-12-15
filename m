Return-Path: <SRS0=8Orh=OY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E2EC43612
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713252171F
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 18:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeLOSPZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Dec 2018 13:15:25 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:32885 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeLOSPZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Dec 2018 13:15:25 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 66A65564785
        for <selinux@vger.kernel.org>; Sat, 15 Dec 2018 19:15:22 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] mcstrans: fix Python linter warnings on test scripts
Date:   Sat, 15 Dec 2018 19:14:55 +0100
Message-Id: <20181215181455.31643-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181215181455.31643-1-nicolas.iooss@m4x.org>
References: <20181215181455.31643-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Dec 15 19:15:22 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/share/util/mlscolor-test |  9 +++++----
 mcstrans/share/util/mlstrans-test | 12 +++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/mcstrans/share/util/mlscolor-test b/mcstrans/share/util/mlscolor-test
index 447389704beb..03fc4be40375 100644
--- a/mcstrans/share/util/mlscolor-test
+++ b/mcstrans/share/util/mlscolor-test
@@ -1,7 +1,8 @@
 #!/usr/bin/python -E
 import sys
-import re
-from selinux import *
+import selinux
+
+
 verbose = 0
 errors = 0
 
@@ -18,12 +19,12 @@ for arg in sys.argv[1:]:
         line = line.rstrip('\n')
 #       print line
         context, expected = line.split("=")
-        rc, raw = selinux_trans_to_raw_context(context)
+        rc, raw = selinux.selinux_trans_to_raw_context(context)
         if rc < 0:
             print("Unable to get raw context of '%s'" % (context))
             errors += 1
             continue
-        rc, colors = selinux_raw_context_to_color(raw)
+        rc, colors = selinux.selinux_raw_context_to_color(raw)
         if rc < 0:
             print("Unable to get colors for '%s'" % (context))
             errors += 1
diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
index 3ff4444ab000..c026d00ef9c7 100644
--- a/mcstrans/share/util/mlstrans-test
+++ b/mcstrans/share/util/mlstrans-test
@@ -1,14 +1,15 @@
 #!/usr/bin/python -E
 import sys
-import re
-from selinux import *
+import selinux
+
+
 verbose = 0
 errors = 0
 
 
 def untrans(trans, val):
     global errors, verbose
-    (rc, raw) = selinux_trans_to_raw_context(trans)
+    (rc, raw) = selinux.selinux_trans_to_raw_context(trans)
     if raw != val:
         print("untrans: '%s' -> '%s' != '%s' FAILED" % (trans, raw, val))
         errors += 1
@@ -19,7 +20,7 @@ def untrans(trans, val):
 
 def trans(raw, val):
     global errors, verbose
-    (rc, trans) = selinux_raw_to_trans_context(raw)
+    (rc, trans) = selinux.selinux_raw_to_trans_context(raw)
     if trans != val:
         print("trans: '%s' -> '%s' != '%s' FAILED" % (raw, trans, val))
         errors += 1
@@ -27,6 +28,7 @@ def trans(raw, val):
         if verbose:
             print("trans: %s -> %s != %s SUCCESS" % (raw, trans, val))
 
+
 if len(sys.argv) > 1 and sys.argv[1] == "-v":
     verbose = 1
 
@@ -38,7 +40,7 @@ for arg in sys.argv[1:]:
         if not line.strip():
             continue
         line = line.rstrip('\n')
-        if (line.find("==") != -1):
+        if line.find("==") != -1:
             t, r = line.split("==")
             untrans("a:b:c:" + t, "a:b:c:" + r)
             trans("a:b:c:" + r, "a:b:c:" + t)
-- 
2.19.2

