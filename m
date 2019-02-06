Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640B4C169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30375218B0
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 21:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfBFVIR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:08:17 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:39426 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfBFVIR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 16:08:17 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 421975647BE
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 22:08:15 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol/cil: silence static analyser's use-after-free warning
Date:   Wed,  6 Feb 2019 22:07:52 +0100
Message-Id: <20190206210752.11828-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  6 22:08:16 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

clang's static analyze reports a use-after-free in
__cil_expr_to_string(), when __cil_expr_to_string_helper() does not
modify its third parameter (variable s1 here) in this loop:

    for (curr = curr->next; curr; curr = curr->next) {
        __cil_expr_to_string_helper(curr, flavor, &s1);
        cil_asprintf(&c2, "%s %s", c1, s1);
        free(c1);
        free(s1);
        c1 = c2;
    }

Silence this warning by making sure s1 is always NULL at the beginning
of every iteration of the loop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index a10c3763bea4..e2eb3ebe8ff3 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2075,6 +2075,7 @@ static void __cil_expr_to_string(struct cil_list *expr, enum cil_flavor flavor,
 		char *c2 = NULL;
 		__cil_expr_to_string_helper(curr, flavor, &c1);
 		for (curr = curr->next; curr; curr = curr->next) {
+			s1 = NULL;
 			__cil_expr_to_string_helper(curr, flavor, &s1);
 			cil_asprintf(&c2, "%s %s", c1, s1);
 			free(c1);
-- 
2.20.1

