Return-Path: <SRS0=xSVD=XK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889ECC4CECD
	for <selinux@archiver.kernel.org>; Sun, 15 Sep 2019 19:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5861A214AF
	for <selinux@archiver.kernel.org>; Sun, 15 Sep 2019 19:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfIOTLO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Sep 2019 15:11:14 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43115 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOTLO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Sep 2019 15:11:14 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3AF84560690
        for <selinux@vger.kernel.org>; Sun, 15 Sep 2019 21:11:11 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/1] libsepol: do not dereference a failed allocated pointer
Date:   Sun, 15 Sep 2019 21:10:39 +0200
Message-Id: <20190915191039.107622-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep 15 21:11:11 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When strs_stack_init(&stack) fails to allocate memory and stack is still
NULL, it should not be dereferenced with strs_stack_pop(stack).

This issue has been found using Infer static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/kernel_to_cil.c  | 16 ++++++++++------
 libsepol/src/kernel_to_conf.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 01f5bc5bba75..ca2e4a9b265b 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -108,10 +108,12 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 	return str;
 
 exit:
-	while ((new_val = strs_stack_pop(stack)) != NULL) {
-		free(new_val);
+	if (stack) {
+		while ((new_val = strs_stack_pop(stack)) != NULL) {
+			free(new_val);
+		}
+		strs_stack_destroy(&stack);
 	}
-	strs_stack_destroy(&stack);
 
 	return NULL;
 }
@@ -251,10 +253,12 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 	return str;
 
 exit:
-	while ((new_val = strs_stack_pop(stack)) != NULL) {
-		free(new_val);
+	if (stack) {
+		while ((new_val = strs_stack_pop(stack)) != NULL) {
+			free(new_val);
+		}
+		strs_stack_destroy(&stack);
 	}
-	strs_stack_destroy(&stack);
 
 	return NULL;
 }
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a44ba30a0a44..b49661625e03 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -106,10 +106,12 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 	return str;
 
 exit:
-	while ((new_val = strs_stack_pop(stack)) != NULL) {
-		free(new_val);
+	if (stack) {
+		while ((new_val = strs_stack_pop(stack)) != NULL) {
+			free(new_val);
+		}
+		strs_stack_destroy(&stack);
 	}
-	strs_stack_destroy(&stack);
 
 	return NULL;
 }
@@ -247,10 +249,12 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 	return str;
 
 exit:
-	while ((new_val = strs_stack_pop(stack)) != NULL) {
-		free(new_val);
+	if (stack) {
+		while ((new_val = strs_stack_pop(stack)) != NULL) {
+			free(new_val);
+		}
+		strs_stack_destroy(&stack);
 	}
-	strs_stack_destroy(&stack);
 
 	return NULL;
 }
-- 
2.22.0

