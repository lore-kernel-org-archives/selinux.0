Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81350C3A5A8
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588A822CF7
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfIASG4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:06:56 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:45210 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfIASGz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 14:06:55 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BF6B9564884
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 20:06:53 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/9] libsepol: do not dereference a failed allocated pointer
Date:   Sun,  1 Sep 2019 20:06:30 +0200
Message-Id: <20190901180636.31586-4-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901180636.31586-1-nicolas.iooss@m4x.org>
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 20:06:53 2019 +0200 (CEST))
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
 libsepol/src/kernel_to_cil.c  | 8 +++++---
 libsepol/src/kernel_to_conf.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 320af37b2bc8..9fcc254707ba 100644
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
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 930bafabdd4b..2c8da49a11ab 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -106,10 +106,12 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 	return str;
 
 exit:
-	while ((new_val = strs_stack_pop(stack)) != NULL) {
-		free(new_val);
+	if (stack != NULL) {
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

