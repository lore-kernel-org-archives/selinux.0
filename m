Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59596C43444
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D6B222FE
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfAETiN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:38:13 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59416 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfAETiN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 14:38:13 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 931315647FE
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 20:38:11 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/5] python/sepolgen: refpolicy installs its Makefile in include/Makefile
Date:   Sat,  5 Jan 2019 20:37:58 +0100
Message-Id: <20190105193759.3333-5-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105193759.3333-1-nicolas.iooss@m4x.org>
References: <20190105193759.3333-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 20:38:11 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running "make install-headers" on refpolicy,
/usr/share/selinux/refpolicy/Makefile does not exist but
/usr/share/selinux/refpolicy/include/Makefile does. Use it when
available.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/defaults.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/defaults.py b/python/sepolgen/src/sepolgen/defaults.py
index 533a90412475..6e800695b60f 100644
--- a/python/sepolgen/src/sepolgen/defaults.py
+++ b/python/sepolgen/src/sepolgen/defaults.py
@@ -70,7 +70,10 @@ def attribute_info():
 
 def refpolicy_makefile():
     chooser = PathChooser("/etc/selinux/sepolgen.conf")
-    return chooser("Makefile")
+    result = chooser("Makefile")
+    if not os.path.exists(result):
+        result = chooser("include/Makefile")
+    return result
 
 def headers():
     chooser = PathChooser("/etc/selinux/sepolgen.conf")
-- 
2.20.1

