Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A8AC433DB
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C85D64FBC
	for <selinux@archiver.kernel.org>; Fri,  5 Feb 2021 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbhBEJxb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:53:31 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38176 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhBEJqz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 04:46:55 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E586856129F
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 10:46:12 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol/cil: introduce intermediate cast to silence -Wvoid-pointer-to-enum-cast
Date:   Fri,  5 Feb 2021 10:45:39 +0100
Message-Id: <20210205094539.388854-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205094539.388854-1-nicolas.iooss@m4x.org>
References: <20210205094539.388854-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Feb  5 10:46:13 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

clang 11.0.0 reports the following warning several times (when building
with "make CC=clang" from libsepol directory, in the default
configuration of the git repository):

    ../cil/src/cil_binary.c:1980:8: error: cast to smaller integer type
    'enum cil_flavor' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
                    op = (enum cil_flavor)curr->data;
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Silence this warning by casting the pointer to an integer the cast to
enum cil_flavor.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c      | 12 ++++++------
 libsepol/cil/src/cil_policy.c      | 12 ++++++------
 libsepol/cil/src/cil_post.c        |  2 +-
 libsepol/cil/src/cil_resolve_ast.c |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 7ba2098b61ea..f80d84679f85 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1977,7 +1977,7 @@ static void __cil_expr_to_string(struct cil_list *expr, enum cil_flavor flavor,
 	curr = expr->head;
 
 	if (curr->flavor == CIL_OP) {
-		op = (enum cil_flavor)curr->data;
+		op = (enum cil_flavor)(uintptr_t)curr->data;
 
 		if (op == CIL_ALL) {
 			*out = cil_strdup(CIL_KEY_ALL);
@@ -2076,7 +2076,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct cil_list
 	if (item == NULL) {
 		goto exit;
 	} else if (item->flavor == CIL_OP) {
-		enum cil_flavor cil_op = (enum cil_flavor)item->data;
+		enum cil_flavor cil_op = (enum cil_flavor)(uintptr_t)item->data;
 
 		op = cil_malloc(sizeof(*op));
 		op->bool = 0;
@@ -2562,7 +2562,7 @@ int __cil_constrain_expr_leaf_to_sepol_expr(policydb_t *pdb, const struct cil_db
 	struct cil_list_item *l_item = op_item->next;
 	struct cil_list_item *r_item = op_item->next->next;
 	
-	enum cil_flavor l_operand = (enum cil_flavor)l_item->data;
+	enum cil_flavor l_operand = (enum cil_flavor)(uintptr_t)l_item->data;
 
 	switch (l_operand) {
 	case CIL_CONS_U1:
@@ -2593,7 +2593,7 @@ int __cil_constrain_expr_leaf_to_sepol_expr(policydb_t *pdb, const struct cil_db
 		expr->attr = CEXPR_TYPE | CEXPR_XTARGET;
 		break;
 	case CIL_CONS_L1: {
-		enum cil_flavor r_operand = (enum cil_flavor)r_item->data;
+		enum cil_flavor r_operand = (enum cil_flavor)(uintptr_t)r_item->data;
 
 		if (r_operand == CIL_CONS_L2) {
 			expr->attr = CEXPR_L1L2;
@@ -2608,7 +2608,7 @@ int __cil_constrain_expr_leaf_to_sepol_expr(policydb_t *pdb, const struct cil_db
 		expr->attr = CEXPR_L2H2;
 		break;
 	case CIL_CONS_H1: {
-		enum cil_flavor r_operand = (enum cil_flavor)r_item->data;
+		enum cil_flavor r_operand = (enum cil_flavor)(uintptr_t)r_item->data;
 		if (r_operand == CIL_CONS_L2) {
 			expr->attr = CEXPR_H1L2;
 		} else {
@@ -2672,7 +2672,7 @@ int __cil_constrain_expr_to_sepol_expr_helper(policydb_t *pdb, const struct cil_
 		goto exit;
 	}
 
-	enum cil_flavor cil_op = (enum cil_flavor)item->data;
+	enum cil_flavor cil_op = (enum cil_flavor)(uintptr_t)item->data;
 	switch (cil_op) {
 	case CIL_NOT:
 		op->expr_type = CEXPR_NOT;
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 74edb34575ea..30d507f12626 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -285,7 +285,7 @@ static void cil_cond_expr_to_policy(FILE *out, struct cil_list *expr, int first)
 	struct cil_list_item *i1 = expr->head;
 
 	if (i1->flavor == CIL_OP) {
-		enum cil_flavor op = (enum cil_flavor)i1->data;
+		enum cil_flavor op = (enum cil_flavor)(uintptr_t)i1->data;
 		fprintf(out, "(");
 		switch (op) {
 		case CIL_NOT:
@@ -385,7 +385,7 @@ static size_t __cil_cons_leaf_operand_len(struct cil_db *db, struct cil_list_ite
 
 static size_t __cil_cons_leaf_op_len(struct cil_list_item *op)
 {
-	enum cil_flavor flavor = (enum cil_flavor)op->data;
+	enum cil_flavor flavor = (enum cil_flavor)(uintptr_t)op->data;
 	size_t len;
 
 	switch (flavor) {
@@ -420,7 +420,7 @@ static size_t cil_cons_expr_len(struct cil_db *db, struct cil_list *cons_expr)
 
 	i1 = cons_expr->head;
 
-	op = (enum cil_flavor)i1->data;
+	op = (enum cil_flavor)(uintptr_t)i1->data;
 	switch (op) {
 	case CIL_NOT:
 		len = 6; /* "(not )" */
@@ -472,7 +472,7 @@ static char *__cil_cons_leaf_operand_to_string(struct cil_db *db, struct cil_lis
 	size_t o_len;
 
 	if (flavor == CIL_CONS_OPERAND) {
-		enum cil_flavor o_flavor = (enum cil_flavor)operand->data;
+		enum cil_flavor o_flavor = (enum cil_flavor)(uintptr_t)operand->data;
 		switch (o_flavor) {
 		case CIL_CONS_U1:
 			o_str = "u1";
@@ -555,7 +555,7 @@ static char *__cil_cons_leaf_operand_to_string(struct cil_db *db, struct cil_lis
 
 static char *__cil_cons_leaf_op_to_string(struct cil_list_item *op, char *new)
 {
-	enum cil_flavor flavor = (enum cil_flavor)op->data;
+	enum cil_flavor flavor = (enum cil_flavor)(uintptr_t)op->data;
 	const char *op_str;
 	size_t len;
 
@@ -599,7 +599,7 @@ static char *__cil_cons_expr_to_string(struct cil_db *db, struct cil_list *cons_
 
 	i1 = cons_expr->head;
 
-	op = (enum cil_flavor)i1->data;
+	op = (enum cil_flavor)(uintptr_t)i1->data;
 	switch (op) {
 	case CIL_NOT:
 		*new++ = '(';
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 37a444157853..a55df1ea5bb0 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1301,7 +1301,7 @@ static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max,
 	flavor = expr->flavor;
 
 	if (curr->flavor == CIL_OP) {
-		enum cil_flavor op = (enum cil_flavor)curr->data;
+		enum cil_flavor op = (enum cil_flavor)(uintptr_t)curr->data;
 
 		if (op == CIL_ALL) {
 			ebitmap_init(&b1); /* all zeros */
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 9300cd2be9be..208bc01a7a2d 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3355,7 +3355,7 @@ static int __cil_evaluate_tunable_expr(struct cil_list_item *curr)
 		return CIL_FALSE;
 	} else if (curr->flavor == CIL_OP) {
 		uint16_t v1, v2;
-		enum cil_flavor op_flavor = (enum cil_flavor)curr->data;
+		enum cil_flavor op_flavor = (enum cil_flavor)(uintptr_t)curr->data;
 
 		v1 = __cil_evaluate_tunable_expr_helper(curr->next);
 
-- 
2.30.0

