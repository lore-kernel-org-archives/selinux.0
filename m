Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIT/Eijr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA899B
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701708369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSidmWl5apK7Z0yabmIRRKk1nJghnMq9SrstTLHpQBM=;
	b=IIT/EijrE2PIs0CQZZ8B5+Lbas6cGrqw3oLnTsxfNoqnxnUEZcW71Bpdosc8KPVL4LIUlG
	c2WiyD71vhH7qhRnjXQuj+K+pq7llVNsBKc0kqaBgee4jQXytFJcvdtlYLMd+XVmtQpArd
	JfK9lcj+RLGYWyRh9VJ6Unks4IhwOew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-uRtvIwOPPXirfUgGN6HpRQ-1; Mon, 04 Dec 2023 11:46:07 -0500
X-MC-Unique: uRtvIwOPPXirfUgGN6HpRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BADE6812C2C
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 16:46:06 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23A88492BE0;
	Mon,  4 Dec 2023 16:46:06 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/2] Revert "libsepol: rename struct member"
Date: Mon,  4 Dec 2023 17:45:58 +0100
Message-ID: <20231204164558.43667-2-lautrbach@redhat.com>
In-Reply-To: <20231204164558.43667-1-lautrbach@redhat.com>
References: <877cluszxo.fsf@redhat.com>
 <20231204164558.43667-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

This reverts commit 61f213850047c23b0af7c7cafa9245da48120279.

This change broke build of SETools and currently it's not clear how to
change SETools cython code so that it can be built with 3.6 and older
SELinux releases.

https://github.com/SELinuxProject/setools/issues/110

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsepol/cil/src/cil_binary.c                 |  6 +++---
 libsepol/include/sepol/policydb/conditional.h |  4 +---
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
 12 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index a8e3616a32d0..5fb1109848ea 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2204,7 +2204,7 @@ static int __cil_cond_item_to_sepol_expr(policydb_t *pdb, struct cil_list_item *
 		*head = cil_malloc(sizeof(cond_expr_t));
 		(*head)->next = NULL;
 		(*head)->expr_type = COND_BOOL;
-		(*head)->boolean = sepol_bool->s.value;
+		(*head)->bool = sepol_bool->s.value;
 		*tail = *head;
 	} else if (item->flavor == CIL_LIST) {
 		struct cil_list *l = item->data;
@@ -2240,7 +2240,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct cil_list
 		enum cil_flavor cil_op = (enum cil_flavor)(uintptr_t)item->data;
 
 		op = cil_malloc(sizeof(*op));
-		op->boolean = 0;
+		op->bool = 0;
 		op->next = NULL;
 
 		switch (cil_op) {
@@ -2307,7 +2307,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct cil_list
 				goto exit;
 			}
 			op = cil_malloc(sizeof(*op));
-			op->boolean = 0;
+			op->bool = 0;
 			op->next = NULL;
 			op->expr_type = COND_OR;
 			t1->next = h2;
diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
index 5318ea194a62..49c0d76631c4 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -54,9 +54,7 @@ typedef struct cond_expr {
 #define COND_NEQ	7	/* bool != bool */
 #define COND_LAST	COND_NEQ
 	uint32_t expr_type;
-	/* The member `boolean` was renamed from `bool` in version 3.6 */
-#define COND_EXPR_T_RENAME_BOOL_BOOLEAN
-	uint32_t boolean;
+	uint32_t bool;
 	struct cond_expr *next;
 } cond_expr_t;
 
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 24380ea03d76..a620451d8bc5 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -125,7 +125,7 @@ int cond_expr_equal(cond_node_t * a, cond_node_t * b)
 		if (cur_a->expr_type != cur_b->expr_type)
 			return 0;
 		if (cur_a->expr_type == COND_BOOL) {
-			if (cur_a->boolean != cur_b->boolean)
+			if (cur_a->bool != cur_b->bool)
 				return 0;
 		}
 		cur_a = cur_a->next;
@@ -223,7 +223,7 @@ int cond_evaluate_expr(policydb_t * p, cond_expr_t * expr)
 			if (sp == (COND_EXPR_MAXDEPTH - 1))
 				return -1;
 			sp++;
-			s[sp] = p->bool_val_to_struct[cur->boolean - 1]->state;
+			s[sp] = p->bool_val_to_struct[cur->bool - 1]->state;
 			break;
 		case COND_NOT:
 			if (sp < 0)
@@ -279,7 +279,7 @@ cond_expr_t *cond_copy_expr(cond_expr_t * expr)
 		memset(new_expr, 0, sizeof(cond_expr_t));
 
 		new_expr->expr_type = cur->expr_type;
-		new_expr->boolean = cur->boolean;
+		new_expr->bool = cur->bool;
 
 		if (!head)
 			head = new_expr;
@@ -388,10 +388,10 @@ int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
 		switch (e->expr_type) {
 		case COND_BOOL:
 			/* see if we've already seen this bool */
-			if (!bool_present(e->boolean, cn->bool_ids, cn->nbools)) {
+			if (!bool_present(e->bool, cn->bool_ids, cn->nbools)) {
 				/* count em all but only record up to COND_MAX_BOOLS */
 				if (cn->nbools < COND_MAX_BOOLS)
-					cn->bool_ids[cn->nbools++] = e->boolean;
+					cn->bool_ids[cn->nbools++] = e->bool;
 				else
 					cn->nbools++;
 			}
@@ -737,7 +737,7 @@ static int expr_isvalid(policydb_t * p, cond_expr_t * expr)
 		return 0;
 	}
 
-	if (expr->boolean > p->p_bools.nprim) {
+	if (expr->bool > p->p_bools.nprim) {
 		WARN(NULL, "security: conditional expressions uses unknown bool.");
 		return 0;
 	}
@@ -775,7 +775,7 @@ static int cond_read_node(policydb_t * p, cond_node_t * node, void *fp)
 		memset(expr, 0, sizeof(cond_expr_t));
 
 		expr->expr_type = le32_to_cpu(buf[0]);
-		expr->boolean = le32_to_cpu(buf[1]);
+		expr->bool = le32_to_cpu(buf[1]);
 
 		if (!expr_isvalid(p, expr)) {
 			free(expr);
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index e63414b1497b..ea6492b75da9 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2025,8 +2025,8 @@ static int cond_node_map_bools(expand_state_t * state, cond_node_t * cn)
 
 	cur = cn->expr;
 	while (cur) {
-		if (cur->boolean)
-			cur->boolean = state->boolmap[cur->boolean - 1];
+		if (cur->bool)
+			cur->bool = state->boolmap[cur->bool - 1];
 		cur = cur->next;
 	}
 
@@ -2899,7 +2899,7 @@ static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 			     cur_expr = cur_expr->next) {
 				if (cur_expr->expr_type != COND_BOOL)
 					continue;
-				booldatum = pol->bool_val_to_struct[cur_expr->boolean - 1];
+				booldatum = pol->bool_val_to_struct[cur_expr->bool - 1];
 				if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE)
 					tmp[tunables++] = booldatum;
 				else
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 8ec7974995cc..74cd0e4dd234 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -44,7 +44,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 
 	for (curr = expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
-			char *val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
+			char *val1 = pdb->p_bool_val_to_name[curr->bool - 1];
 			new_val = create_str("%s", 1, val1);
 		} else {
 			const char *op;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b5b530d6e6a1..853c0561040b 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -43,7 +43,7 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
 
 	for (curr = expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
-			char *val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
+			char *val1 = pdb->p_bool_val_to_name[curr->bool - 1];
 			new_val = create_str("%s", 1, val1);
 		} else {
 			const char *op;
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 3b7742bccac5..cbe4cea40123 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1524,9 +1524,9 @@ static int copy_cond_list(cond_node_t * list, cond_node_t ** dst,
 			/* expression nodes don't have a bool value of 0 - don't map them */
 			if (cur_expr->expr_type != COND_BOOL)
 				continue;
-			assert(module->map[SYM_BOOLS][cur_expr->boolean - 1] != 0);
-			cur_expr->boolean =
-			    module->map[SYM_BOOLS][cur_expr->boolean - 1];
+			assert(module->map[SYM_BOOLS][cur_expr->bool - 1] != 0);
+			cur_expr->bool =
+			    module->map[SYM_BOOLS][cur_expr->bool - 1];
 		}
 		new_node->nbools = cur->nbools;
 		/* FIXME should COND_MAX_BOOLS be used here? */
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ee22dbbdb3b7..f43aa7decac8 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1283,7 +1283,7 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 
 	for (curr = cond_expr; curr != NULL; curr = curr->next) {
 		if (curr->expr_type == COND_BOOL) {
-			val1 = pdb->p_bool_val_to_name[curr->boolean - 1];
+			val1 = pdb->p_bool_val_to_name[curr->bool - 1];
 			// length of boolean + 2 parens + null terminator
 			len = strlen(val1) + 2 + 1;
 			new_val = malloc(len);
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 8b87675ff7b0..7d9a153fb830 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1002,7 +1002,7 @@ static int validate_cond_expr(sepol_handle_t *handle, const struct cond_expr *ex
 	for (; expr; expr = expr->next) {
 		switch(expr->expr_type) {
 		case COND_BOOL:
-			if (validate_value(expr->boolean, boolean))
+			if (validate_value(expr->bool, boolean))
 				goto bad;
 			if (depth >= (COND_EXPR_MAXDEPTH - 1))
 				goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 283d11c8a6bb..a7584a78d3c7 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -834,7 +834,7 @@ static int cond_write_node(policydb_t * p,
 	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
 		items = 0;
 		buf[items++] = cpu_to_le32(cur_expr->expr_type);
-		buf[items++] = cpu_to_le32(cur_expr->boolean);
+		buf[items++] = cpu_to_le32(cur_expr->bool);
 		items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 		if (items2 != items)
 			return POLICYDB_ERROR;
diff --git a/libsepol/tests/debug.c b/libsepol/tests/debug.c
index 8494dd258e5c..90aa6e0a953a 100644
--- a/libsepol/tests/debug.c
+++ b/libsepol/tests/debug.c
@@ -41,7 +41,7 @@ void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 	for (cur = exp; cur != NULL; cur = cur->next) {
 		switch (cur->expr_type) {
 		case COND_BOOL:
-			fprintf(fp, "%s ", p->p_bool_val_to_name[cur->boolean - 1]);
+			fprintf(fp, "%s ", p->p_bool_val_to_name[cur->bool - 1]);
 			break;
 		case COND_NOT:
 			fprintf(fp, "! ");
diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-linker-cond-map.c
index 6ea0e4c2ac6b..694a73469c46 100644
--- a/libsepol/tests/test-linker-cond-map.c
+++ b/libsepol/tests/test-linker-cond-map.c
@@ -70,7 +70,7 @@ static void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_
 
 		CU_ASSERT(expr->expr_type == bools[i].expr_type);
 		if (bools[i].bool) {
-			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->boolean - 1], bools[i].bool) == 0);
+			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->bool - 1], bools[i].bool) == 0);
 		}
 		expr = expr->next;
 	}
-- 
2.41.0

