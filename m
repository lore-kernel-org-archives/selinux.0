Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E5C433E6
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD12164E49
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBEJxj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:53:39 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44235 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBEJqy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 04:46:54 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C837156129F
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 10:46:11 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libsepol/cil: be more robust when encountering <src_info>
Date:   Fri,  5 Feb 2021 10:45:38 +0100
Message-Id: <20210205094539.388854-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205094539.388854-1-nicolas.iooss@m4x.org>
References: <20210205094539.388854-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 10:46:12 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
to compile the following policy:

    (<src_info>)

In cil_gen_src_info(), parse_current->next is NULL even though the code
expects that both parse_current->next and parse_current->next->next
exists.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28457
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 5 +++++
 libsepol/cil/src/cil_tree.c      | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 5094d62e2238..726f46cd478d 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6070,6 +6070,11 @@ int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *
 	/* No need to check syntax, because this is auto generated */
 	struct cil_src_info *info = NULL;
 
+	if (parse_current->next == NULL || parse_current->next->next == NULL) {
+		cil_tree_log(parse_current, CIL_ERR, "Bad <src_info>");
+		return SEPOL_ERR;
+	}
+
 	cil_src_info_init(&info);
 
 	info->is_cil = (parse_current->next->data == CIL_KEY_SRC_CIL) ? CIL_TRUE : CIL_FALSE;
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 886412d1b974..3da972e9cf4e 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -69,7 +69,7 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
 
 	while (node) {
 		if (node->flavor == CIL_NODE && node->data == NULL) {
-			if (node->cl_head->data == CIL_KEY_SRC_INFO) {
+			if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
 				/* Parse Tree */
 				*path = node->cl_head->next->next->data;
 				*is_cil = (node->cl_head->next->data == CIL_KEY_SRC_CIL);
-- 
2.30.0

