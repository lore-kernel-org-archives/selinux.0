Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E48C4332F
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 20:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKNULH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiKNUKv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 15:10:51 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE91CB29
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bj12so30980507ejb.13
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=587qEsaR1mpGvlHQmhJbzOygiLuJmaGFsN85HEqniJw=;
        b=ZndzQqc3jFTdEWbKnA3n35fJ1cq7r+3doBt94C0o7hT6xFreHNIv5w5xu12JA2d6Ey
         uk5S7Nl5OIzDwM4lAA0GuVmy1wSd5qOg5wyULBeT4yQD8P+J3FdNm4AePWPCOuqxZG7z
         wPZdnH1vppQnS+F+ym2hzGN18zIDWa/JjRULSbg+0zo7tB1lWXi6k+oBFJjmu/IyvVE4
         HafVd01+NMc3DoijXK128wjqq10ELFQ3pkyR6ho7Nz3j9+c5nc5WAeouasNf1LO2a7KC
         Rrr8EAiXqSnR5Gvo0hiqIzzlDJTaGZjM0ew1a6Lh9Ir+a8yHbTZXXG6dSCIol32d8yhn
         gAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=587qEsaR1mpGvlHQmhJbzOygiLuJmaGFsN85HEqniJw=;
        b=mN/nDJ0J71Wott8u+G8rIs5LesGxL1qvKpAjjGI3Tp4zqGfWYNgzNK/+h4TpbVqV8G
         uzsXeEUlhr4BOyUfa1OSBbjYoWKVP5IztatmmqQXtiKaZRIvhVkceSkEJBUlTLhhmPmu
         lSG2AjbmJhFwUcmei6dudbw3L1oMndHJ8vuD+puAH5vnoQvcU1kA6DOApDDcu1QDQcon
         RG4VP6jYGHHYwAQ9Sn8KI1xRooin/W6QqWdo96i/U52fYgrMoUNAB9DOaSZFotptVS6O
         jZ9vL0gRuypLnCOG4B7xhwl3X1paO50KRQ3do9JBrFH2MT8mehwB43F5G/RvwFnRkMFN
         VWDg==
X-Gm-Message-State: ANoB5pmFv1BwsHL+/vTW3dhxHfbPhX26eWt3IoSr0M92/q3/w+12LFSa
        afyG5DI6zDfw1sZLhP8XFen1Soe8efs=
X-Google-Smtp-Source: AA0mqf6PIekGEMq0bkbZlcnhd+qK7ytbv7i+Bmk2r7SGq6Bd/fVf/jLlok2/TyvQVmskLileI2TRvw==
X-Received: by 2002:a17:906:b45:b0:78d:b65a:aabe with SMTP id v5-20020a1709060b4500b0078db65aaabemr11694609ejg.5.1668456648306;
        Mon, 14 Nov 2022 12:10:48 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm4558377ejb.86.2022.11.14.12.10.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:10:47 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/6] libsepol: rename struct member
Date:   Mon, 14 Nov 2022 21:10:37 +0100
Message-Id: <20221114201042.17773-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Since the struct cond_expr_t is part of the public API it will break
client applications.  A quick code search of the Debian code shows only
usage in checkpolicy and setools.

Define a new macro signaling the renaming to simplify support of client
applications for new and older versions of libsepol.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c                 |  6 +++---
 libsepol/include/sepol/policydb/conditional.h |  4 +++-
 libsepol/src/conditional.c                    | 14 +++++++-------
 libsepol/src/expand.c                         |  6 +++---
 libsepol/src/kernel_to_cil.c                  |  2 +-
 libsepol/src/kernel_to_conf.c                 |  2 +-
 libsepol/src/link.c                           |  6 +++---
 libsepol/src/module_to_cil.c                  |  2 +-
 libsepol/src/policydb_validate.c              |  2 +-
 libsepol/src/write.c                          |  2 +-
 libsepol/tests/debug.c                        |  2 +-
 libsepol/tests/test-linker-cond-map.c         |  2 +-
 12 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 40615db2..ef7f4d70 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2123,7 +2123,7 @@ static int __cil_cond_item_to_sepol_expr(policydb_t *pdb, struct cil_list_item *
 		*head = cil_malloc(sizeof(cond_expr_t));
 		(*head)->next = NULL;
 		(*head)->expr_type = COND_BOOL;
-		(*head)->bool = sepol_bool->s.value;
+		(*head)->boolean = sepol_bool->s.value;
 		*tail = *head;
 	} else if (item->flavor == CIL_LIST) {
 		struct cil_list *l = item->data;
@@ -2159,7 +2159,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct cil_list
 		enum cil_flavor cil_op = (enum cil_flavor)(uintptr_t)item->data;
 
 		op = cil_malloc(sizeof(*op));
-		op->bool = 0;
+		op->boolean = 0;
 		op->next = NULL;
 
 		switch (cil_op) {
@@ -2226,7 +2226,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct cil_list
 				goto exit;
 			}
 			op = cil_malloc(sizeof(*op));
-			op->bool = 0;
+			op->boolean = 0;
 			op->next = NULL;
 			op->expr_type = COND_OR;
 			t1->next = h2;
diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
index 49c0d766..8d4741d3 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -54,7 +54,9 @@ typedef struct cond_expr {
 #define COND_NEQ	7	/* bool != bool */
 #define COND_LAST	COND_NEQ
 	uint32_t expr_type;
-	uint32_t bool;
+	/* The member `boolean` was renamed from `bool` in version 3.5 */
+#define COND_EXPR_T_RENAME_BOOL_BOOLEAN
+	uint32_t boolean;
 	struct cond_expr *next;
 } cond_expr_t;
 
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index a620451d..24380ea0 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -125,7 +125,7 @@ int cond_expr_equal(cond_node_t * a, cond_node_t * b)
 		if (cur_a->expr_type != cur_b->expr_type)
 			return 0;
 		if (cur_a->expr_type == COND_BOOL) {
-			if (cur_a->bool != cur_b->bool)
+			if (cur_a->boolean != cur_b->boolean)
 				return 0;
 		}
 		cur_a = cur_a->next;
@@ -223,7 +223,7 @@ int cond_evaluate_expr(policydb_t * p, cond_expr_t * expr)
 			if (sp == (COND_EXPR_MAXDEPTH - 1))
 				return -1;
 			sp++;
-			s[sp] = p->bool_val_to_struct[cur->bool - 1]->state;
+			s[sp] = p->bool_val_to_struct[cur->boolean - 1]->state;
 			break;
 		case COND_NOT:
 			if (sp < 0)
@@ -279,7 +279,7 @@ cond_expr_t *cond_copy_expr(cond_expr_t * expr)
 		memset(new_expr, 0, sizeof(cond_expr_t));
 
 		new_expr->expr_type = cur->expr_type;
-		new_expr->bool = cur->bool;
+		new_expr->boolean = cur->boolean;
 
 		if (!head)
 			head = new_expr;
@@ -388,10 +388,10 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 		switch (e->expr_type) {
 		case COND_BOOL:
 			/* see if we've already seen this bool */
-			if (!bool_present(e->bool, cn->bool_ids, cn->nbools)) {
+			if (!bool_present(e->boolean, cn->bool_ids, cn->nbools)) {
 				/* count em all but only record up to COND_MAX_BOOLS */
 				if (cn->nbools < COND_MAX_BOOLS)
-					cn->bool_ids[cn->nbools++] = e->bool;
+					cn->bool_ids[cn->nbools++] = e->boolean;
 				else
 					cn->nbools++;
 			}
@@ -737,7 +737,7 @@ static int expr_isvalid(policydb_t * p, cond_expr_t * expr)
 		return 0;
 	}
 
-	if (expr->bool > p->p_bools.nprim) {
+	if (expr->boolean > p->p_bools.nprim) {
 		WARN(NULL, "security: conditional expressions uses unknown bool.");
 		return 0;
 	}
@@ -775,7 +775,7 @@ static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
 		memset(expr, 0, sizeof(cond_expr_t));
 
 		expr->expr_type = le32_to_cpu(buf[0]);
-		expr->bool = le32_to_cpu(buf[1]);
+		expr->boolean = le32_to_cpu(buf[1]);
 
 		if (!expr_isvalid(p, expr)) {
 			free(expr);
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8d19850e..1337c32f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2025,8 +2025,8 @@ static int cond_node_map_bools(expand_state_t * state, cond_node_t * cn)
 
 	cur = cn->expr;
 	while (cur) {
-		if (cur->bool)
-			cur->bool = state->boolmap[cur->bool - 1];
+		if (cur->boolean)
+			cur->boolean = state->boolmap[cur->boolean - 1];
 		cur = cur->next;
 	}
 
@@ -2899,7 +2899,7 @@ static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 			     cur_expr = cur_expr->next) {
 				if (cur_expr->expr_type != COND_BOOL)
 					continue;
-				booldatum = pol->bool_val_to_struct[cur_expr->bool - 1];
+				booldatum = pol->bool_val_to_struct[cur_expr->boolean - 1];
 				if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE)
 					tmp[tunables++] = booldatum;
 				else
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ad4121d5..e9cd89c2 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -43,7 +43,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 
 	for (curr = expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
-			char *val1 = pdb->p_bool_val_to_name[curr->bool - 1];
+			char *val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
 			new_val = create_str("%s", 1, val1);
 		} else {
 			const char *op;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 63dffd9b..59083479 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -42,7 +42,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 
 	for (curr = expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
-			char *val1 = pdb->p_bool_val_to_name[curr->bool - 1];
+			char *val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
 			new_val = create_str("%s", 1, val1);
 		} else {
 			const char *op;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index cbe4cea4..3b7742bc 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1524,9 +1524,9 @@ static int copy_cond_list(cond_node_t * list, cond_node_t ** dst,
 			/* expression nodes don't have a bool value of 0 - don't map them */
 			if (cur_expr->expr_type != COND_BOOL)
 				continue;
-			assert(module->map[SYM_BOOLS][cur_expr->bool - 1] != 0);
-			cur_expr->bool =
-			    module->map[SYM_BOOLS][cur_expr->bool - 1];
+			assert(module->map[SYM_BOOLS][cur_expr->boolean - 1] != 0);
+			cur_expr->boolean =
+			    module->map[SYM_BOOLS][cur_expr->boolean - 1];
 		}
 		new_node->nbools = cur->nbools;
 		/* FIXME should COND_MAX_BOOLS be used here? */
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b900290a..4e15f8e4 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1272,7 +1272,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 
 	for (curr = cond_expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
-			val1 = pdb->p_bool_val_to_name[curr->bool - 1];
+			val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
 			// length of boolean + 2 parens + null terminator
 			len = strlen(val1) + 2 + 1;
 			new_val = malloc(len);
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 521ea4ff..d1bc7f03 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -957,7 +957,7 @@ static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *ex
 	for (; expr; expr = expr->next) {
 		switch(expr->expr_type) {
 		case COND_BOOL:
-			if (validate_value(expr->bool, boolean))
+			if (validate_value(expr->boolean, boolean))
 				goto bad;
 			if (depth == (COND_EXPR_MAXDEPTH - 1))
 				goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index a9fdf93a..024fe628 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -834,7 +834,7 @@ static int cond_write_node(policydb_t * p,
 	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
 		items = 0;
 		buf[items++] = cpu_to_le32(cur_expr->expr_type);
-		buf[items++] = cpu_to_le32(cur_expr->bool);
+		buf[items++] = cpu_to_le32(cur_expr->boolean);
 		items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 		if (items2 != items)
 			return POLICYDB_ERROR;
diff --git a/libsepol/tests/debug.c b/libsepol/tests/debug.c
index 90aa6e0a..8494dd25 100644
--- a/libsepol/tests/debug.c
+++ b/libsepol/tests/debug.c
@@ -41,7 +41,7 @@ void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 	for (cur = exp; cur != NULL; cur = cur->next) {
 		switch (cur->expr_type) {
 		case COND_BOOL:
-			fprintf(fp, "%s ", p->p_bool_val_to_name[cur->bool - 1]);
+			fprintf(fp, "%s ", p->p_bool_val_to_name[cur->boolean - 1]);
 			break;
 		case COND_NOT:
 			fprintf(fp, "! ");
diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-linker-cond-map.c
index 694a7346..6ea0e4c2 100644
--- a/libsepol/tests/test-linker-cond-map.c
+++ b/libsepol/tests/test-linker-cond-map.c
@@ -70,7 +70,7 @@ static void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_
 
 		CU_ASSERT(expr->expr_type == bools[i].expr_type);
 		if (bools[i].bool) {
-			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->bool - 1], bools[i].bool) == 0);
+			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->boolean - 1], bools[i].bool) == 0);
 		}
 		expr = expr->next;
 	}
-- 
2.38.1

