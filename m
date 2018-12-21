Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205B6C43387
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63C921906
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbeLUUnu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:43:50 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49760 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbeLUUnu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:43:50 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6322D561205
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 21:43:48 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] python/audit2allow/sepolgen-ifgen: add missing \n to error message
Date:   Fri, 21 Dec 2018 21:43:31 +0100
Message-Id: <20181221204333.27445-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221204333.27445-1-nicolas.iooss@m4x.org>
References: <20181221204333.27445-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Dec 21 21:43:48 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/audit2allow/sepolgen-ifgen | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
index acf96384ee16..aa1ae8dc21d2 100644
--- a/python/audit2allow/sepolgen-ifgen
+++ b/python/audit2allow/sepolgen-ifgen
@@ -96,7 +96,7 @@ def get_attrs(policy_path):
     ret = subprocess.Popen([ATTR_HELPER, policy_path, outfile.name], stdout=fd).wait()
     fd.close()
     if ret != 0:
-        sys.stderr.write("could not run attribute helper")
+        sys.stderr.write("could not run attribute helper\n")
         return None
 
     attrs = interfaces.AttributeSet()
-- 
2.19.1

