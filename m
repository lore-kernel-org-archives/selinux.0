Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2089C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD54421906
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbeLUUnx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:43:53 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49692 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390488AbeLUUnx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:43:53 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D2179561205
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 21:43:50 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] python/audit2allow: allow using audit2why as non-root user
Date:   Fri, 21 Dec 2018 21:43:33 +0100
Message-Id: <20181221204333.27445-4-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221204333.27445-1-nicolas.iooss@m4x.org>
References: <20181221204333.27445-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Dec 21 21:43:51 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Importing sepolicy as non-root on a system with SELinux causes the
following exception to be raised:

    ValueError: No SELinux Policy installed

Ignore this when using audit2why, which allows using it with option
--policy as a non-root user.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/audit2allow/audit2allow | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
index 195f151c6ca1..18fe0a531d02 100644
--- a/python/audit2allow/audit2allow
+++ b/python/audit2allow/audit2allow
@@ -242,7 +242,10 @@ class AuditToPolicy:
 
     def __output_audit2why(self):
         import selinux
-        import sepolicy
+        try:
+            import sepolicy
+        except (ImportError, ValueError):
+            sepolicy = None
         for i in self.__parser.avc_msgs:
             rc = i.type
             data = i.data
@@ -262,11 +265,13 @@ class AuditToPolicy:
                 if len(data) > 1:
                     print("\tOne of the following booleans was set incorrectly.")
                     for b in data:
-                        print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(b[0]))
+                        if sepolicy is not None:
+                            print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(b[0]))
                         print("\tAllow access by executing:\n\t# setsebool -P %s %d" % (b[0], b[1]))
                 else:
                     print("\tThe boolean %s was set incorrectly. " % (data[0][0]))
-                    print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(data[0][0]))
+                    if sepolicy is not None:
+                        print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(data[0][0]))
                     print("\tAllow access by executing:\n\t# setsebool -P %s %d" % (data[0][0], data[0][1]))
                 continue
 
-- 
2.19.1

