Return-Path: <SRS0=OlHu=DK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C059FC41604
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 19:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C560206C1
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 19:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgJCTkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Oct 2020 15:40:07 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43413 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgJCTkG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Oct 2020 15:40:06 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EF6015600AD
        for <selinux@vger.kernel.org>; Sat,  3 Oct 2020 21:40:03 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: drop confusing BUG_ON macro
Date:   Sat,  3 Oct 2020 21:39:56 +0200
Message-Id: <20201003193957.1876526-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct  3 21:40:04 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Contrary to Linux kernel, BUG_ON() does not halt the execution, in
libsepol/src/services.c. Instead it displays an error message and
continues the execution.

This means that this code does not prevent an out-of-bound write from
happening:

    case CEXPR_AND:
        BUG_ON(sp < 1);
        sp--;
        s[sp] &= s[sp + 1];

Use if(...){BUG();rc=-EINVAL;goto out;} constructions instead, to make
sure that the array access is always in-bound.

This issue has been found using clang's static analyzer:
https://558-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-10-02-065849-6375-1/report-50a861.html#EndPath

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/services.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 90da1f4efef3..beb0711f6680 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -67,7 +67,6 @@
 #include "flask.h"
 
 #define BUG() do { ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
-#define BUG_ON(x) do { if (x) ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
 
 static int selinux_enforcing = 1;
 
@@ -469,18 +468,30 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 		/* Now process each expression of the constraint */
 		switch (e->expr_type) {
 		case CEXPR_NOT:
-			BUG_ON(sp < 0);
+			if (sp < 0) {
+				BUG();
+				rc = -EINVAL;
+				goto out;
+			}
 			s[sp] = !s[sp];
 			cat_expr_buf(expr_list[expr_counter], "not");
 			break;
 		case CEXPR_AND:
-			BUG_ON(sp < 1);
+			if (sp < 1) {
+				BUG();
+				rc = -EINVAL;
+				goto out;
+			}
 			sp--;
 			s[sp] &= s[sp + 1];
 			cat_expr_buf(expr_list[expr_counter], "and");
 			break;
 		case CEXPR_OR:
-			BUG_ON(sp < 1);
+			if (sp < 1) {
+				BUG();
+				rc = -EINVAL;
+				goto out;
+			}
 			sp--;
 			s[sp] |= s[sp + 1];
 			cat_expr_buf(expr_list[expr_counter], "or");
-- 
2.28.0

