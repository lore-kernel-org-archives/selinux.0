Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D079C77B72
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjDTPgH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjDTPgG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:36:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E511988
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-505035e3368so1083465a12.0
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682004963; x=1684596963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vVTqoA8tLllLhNDCsQ7R311q9QlsNbY9IhKa6WAZtDE=;
        b=PmO7Zd+SblHo4vbENb1mVjrBsOQxKACacsoZM97cFpywVHE3ClXlWh1dMtzOk49YgQ
         Rv5LGDym5hQYAONwOo2Eq8j+gFPOrNP7MGDkWPHzmkDcNWeRzy5qDThMSmTGYWkqE0ts
         NZjeWxIk3nDOSXSreN6Lu6QNCnQUJP8OaohFHycyaGuZoo1hCLCnY9t4N+WzRRphW0xq
         /cGgscNnNQ5J27y6j/QBMKAQDcVpfrr+uq2BmLckxbUWQyUs1J/oT+7xJZVPBW0sKDLz
         Vwj2ljAEYaPbXaxFsbSVGCeHOEP04vVIJfowv7TOYuZVpiy3krD5Ja/cRDhwc3asCdym
         GHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004963; x=1684596963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVTqoA8tLllLhNDCsQ7R311q9QlsNbY9IhKa6WAZtDE=;
        b=hoYggvaaD9hv6iwP2Wvw4lftwEAbVUH0UaAO0FnPs3mDY3CviPViEIXvycaLFqGm1e
         IXZMEjnGUDipaLnQCkm2l81L+DNoEfCUkvxUjihpWh3jK+Y53fJJLhZ9IW6+ekxJ6wQF
         mWJ+BzR5BrHa8gz25mSl7MxSqAugkgcJRZG9MysDQQqbgEs4Itmrc+FZZ6wZ7fIqHT3/
         90fYNXfetKdDyP+nyOkRc3ko0KMy/2209VpNfxURPHJs/ZsKgKd4wTnGiVcnOOAhtgE1
         /hOez89SgtC4/enOAVmMIGHlZsh3SvyOFxA5qp3CXvmvHNnp6Ul3iSIjHzaijbFZh+Qc
         //Bg==
X-Gm-Message-State: AAQBX9c0jeJ1Fe+A9RsDmfyaQ65xHZAKthpc/EoP3xeVlFKW3kFPI6Tq
        dK52l7F5JnCVf1dvwW0pCsEfpWTPyVg=
X-Google-Smtp-Source: AKy350ZVXtfvRNrMCNL+cG2Dd/RFp8ij2MTcTnjid44WYupy4RinHPAZQSIcXyiGFru39nFEVIFv6A==
X-Received: by 2002:aa7:dc1a:0:b0:504:8173:6240 with SMTP id b26-20020aa7dc1a000000b0050481736240mr2097276edu.37.1682004962985;
        Thu, 20 Apr 2023 08:36:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cb96000000b0050696c2d2f6sm853013edt.88.2023.04.20.08.36.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:36:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/6] libsepol: rename struct member
Date:   Thu, 20 Apr 2023 17:35:51 +0200
Message-Id: <20230420153556.32115-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Since the type `cond_expr_t` is part of the public API it will break
client applications.  A quick search of the code in Debian shows only
usages in checkpolicy and setools.

Define a new macro signaling the renaming to simplify support of client
applications for new and older versions of libsepol.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   update version identifier in header to 3.6
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
index 49c0d766..5318ea19 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -54,7 +54,9 @@ typedef struct cond_expr {
 #define COND_NEQ	7	/* bool != bool */
 #define COND_LAST	COND_NEQ
 	uint32_t expr_type;
-	uint32_t bool;
+	/* The member `boolean` was renamed from `bool` in version 3.6 */
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
index 73b72b5d..c48a7114 100644
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
index 2b24d33e..e7bc6ee6 100644
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
index 9a9ec40b..301aa200 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -974,7 +974,7 @@ static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *ex
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
2.40.0

