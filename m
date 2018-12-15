Return-Path: <SRS0=8Orh=OY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6EFC43387
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355B52080F
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 18:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeLOSPY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Dec 2018 13:15:24 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36824 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLOSPY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Dec 2018 13:15:24 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id DABA7564785
        for <selinux@vger.kernel.org>; Sat, 15 Dec 2018 19:15:20 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] mcstrans: convert test scripts to Python 3
Date:   Sat, 15 Dec 2018 19:14:54 +0100
Message-Id: <20181215181455.31643-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Dec 15 19:15:21 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/share/util/mlscolor-test |  8 ++++----
 mcstrans/share/util/mlstrans-test | 11 +++++------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/mcstrans/share/util/mlscolor-test b/mcstrans/share/util/mlscolor-test
index 7b8d809b7ac5..447389704beb 100644
--- a/mcstrans/share/util/mlscolor-test
+++ b/mcstrans/share/util/mlscolor-test
@@ -20,17 +20,17 @@ for arg in sys.argv[1:]:
         context, expected = line.split("=")
         rc, raw = selinux_trans_to_raw_context(context)
         if rc < 0:
-            print "Unable to get raw context of '%s'" % (context)
+            print("Unable to get raw context of '%s'" % (context))
             errors += 1
             continue
         rc, colors = selinux_raw_context_to_color(raw)
         if rc < 0:
-            print "Unable to get colors for '%s'" % (context)
+            print("Unable to get colors for '%s'" % (context))
             errors += 1
             continue
         colors = colors.rstrip()
         if colors != expected:
-            print "For '%s' got\n\t'%s' expected\n\t'%s'" % (context, colors, expected)
+            print("For '%s' got\n\t'%s' expected\n\t'%s'" % (context, colors, expected))
             errors += 1
             continue
     f.close()
@@ -38,6 +38,6 @@ for arg in sys.argv[1:]:
 s = "s"
 if errors == 1:
     s = ""
-print "mlscolor-test done with %d error%s" % (errors, s)
+print("mlscolor-test done with %d error%s" % (errors, s))
 
 sys.exit(errors)
diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
index f854f7b3c2d6..3ff4444ab000 100644
--- a/mcstrans/share/util/mlstrans-test
+++ b/mcstrans/share/util/mlstrans-test
@@ -10,22 +10,22 @@ def untrans(trans, val):
     global errors, verbose
     (rc, raw) = selinux_trans_to_raw_context(trans)
     if raw != val:
-        print "untrans: '%s' -> '%s' != '%s' FAILED" % (trans, raw, val)
+        print("untrans: '%s' -> '%s' != '%s' FAILED" % (trans, raw, val))
         errors += 1
     else:
         if verbose:
-            print "untrans: %s -> %s != %s SUCCESS" % (trans, raw, val)
+            print("untrans: %s -> %s != %s SUCCESS" % (trans, raw, val))
 
 
 def trans(raw, val):
     global errors, verbose
     (rc, trans) = selinux_raw_to_trans_context(raw)
     if trans != val:
-        print "trans: '%s' -> '%s' != '%s' FAILED" % (raw, trans, val)
+        print("trans: '%s' -> '%s' != '%s' FAILED" % (raw, trans, val))
         errors += 1
     else:
         if verbose:
-            print "trans: %s -> %s != %s SUCCESS" % (raw, trans, val)
+            print("trans: %s -> %s != %s SUCCESS" % (raw, trans, val))
 
 if len(sys.argv) > 1 and sys.argv[1] == "-v":
     verbose = 1
@@ -38,7 +38,6 @@ for arg in sys.argv[1:]:
         if not line.strip():
             continue
         line = line.rstrip('\n')
-#       print line
         if (line.find("==") != -1):
             t, r = line.split("==")
             untrans("a:b:c:" + t, "a:b:c:" + r)
@@ -51,6 +50,6 @@ for arg in sys.argv[1:]:
 s = "s"
 if errors == 1:
     s = ""
-print "mlstrans-test done with %d error%s" % (errors, s)
+print("mlstrans-test done with %d error%s" % (errors, s))
 
 sys.exit(errors)
-- 
2.19.2

