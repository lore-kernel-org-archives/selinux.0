Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0FC433DB
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587262222A
	for <selinux@archiver.kernel.org>; Wed, 30 Dec 2020 20:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgL3UMb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:12:31 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58287 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3UMa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Dec 2020 15:12:30 -0500
Received: from localhost.localdomain (174.17.206.77.rev.sfr.net [77.206.17.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C2A12560618
        for <selinux@vger.kernel.org>; Wed, 30 Dec 2020 21:11:48 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] libsepol/cil: remove useless print statement
Date:   Wed, 30 Dec 2020 21:11:38 +0100
Message-Id: <20201230201141.3455302-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Dec 30 21:11:49 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

cil_copy_expandtypeattribute prints "cil_copy_expandtypeattribute 656"
which is quite annoying. Remove the fprintf statement responsible for
this.

While at it, remove another one in cil_tree_print_node()

Fixes: https://lore.kernel.org/selinux/3c2ab876-b0b7-42eb-573d-e5b450a7125a@gmail.com/T/#u
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_copy_ast.c | 1 -
 libsepol/cil/src/cil_tree.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 67dd8528f526..c9aada9db348 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -653,7 +653,6 @@ int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db *db, void
 	struct cil_expandtypeattribute *orig = data;
 	struct cil_expandtypeattribute *new = NULL;
 
-	fprintf(stderr, "%s %u\n", __func__, __LINE__);
 	cil_expandtypeattribute_init(&new);
 
 	if (orig->attr_strs != NULL) {
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 3ab5e868d15e..886412d1b974 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -710,7 +710,6 @@ void cil_tree_print_node(struct cil_tree_node *node)
 		case CIL_EXPANDTYPEATTRIBUTE: {
 			struct cil_expandtypeattribute *attr = node->data;
 
-			fprintf(stderr, "%s %u\n", __func__, __LINE__);
 			cil_log(CIL_INFO, "(EXPANDTYPEATTRIBUTE ");
 			cil_tree_print_expr(attr->attr_datums, attr->attr_strs);
 			cil_log(CIL_INFO, "%s)\n",attr->expand ?
-- 
2.29.2

