Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GFu2aw004133
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:56:02 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GFtwak016087
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 15:55:58 GMT
Received: from localhost.localdomain (tresys-winxppro [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l7GFtvjG028182
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:55:57 -0400
Received: (from mgoldman@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l7GFtv4L028181
	for selinux@tycho.nsa.gov; Thu, 16 Aug 2007 11:55:57 -0400
Message-Id: <20070816155557.254740131@tresys.com>>
References: <20070816155325.881136010@tresys.com>>
Date: Thu, 16 Aug 2007 11:53:29 -0400
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] [Patch 4/5] This patch does all the functional work of removing the module support code.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Various unnecessary structs were removed.

At the end of this patch, libsepol is able to load policies, but does not
know about modules.

dispol operates as expected when using libsepol at the end of this patch.

<< part 2 >>

---
 libsepol/include/sepol/policydb.h              |    7 	1 +	6 -	0 !
 libsepol/include/sepol/policydb/avrule_block.h |   10 	0 +	10 -	0 !
 libsepol/include/sepol/policydb/conditional.h  |    6 	3 +	3 -	0 !
 libsepol/include/sepol/policydb/constraint.h   |    2 	1 +	1 -	0 !
 libsepol/include/sepol/policydb/flask_types.h  |    1 	0 +	1 -	0 !
 libsepol/include/sepol/policydb/policydb.h     |  205 	6 +	199 -	0 !
 libsepol/include/sepol/users.h                 |    6 	0 +	6 -	0 !
 libsepol/src/assertion.c                       |  115 	0 +	115 -	0 !
 libsepol/src/avrule_block.c                    |  173 	0 +	173 -	0 !
 libsepol/src/conditional.c                     |  257 	140 +	117 -	0 !
 libsepol/src/constraint.c                      |    5 	2 +	3 -	0 !
 libsepol/src/genusers.c                        |    8 	4 +	4 -	0 !
 libsepol/src/hierarchy.c                       |   64 	36 +	28 -	0 !
 libsepol/src/libsepol.map                      |    4 	3 +	1 -	0 !
 libsepol/src/policydb_public.c                 |   29 	3 +	26 -	0 !
 libsepol/src/private.h                         |    5 	2 +	3 -	0 !
 libsepol/src/services.c                        |    7 	4 +	3 -	0 !
 libsepol/src/users.c                           |   18 	8 +	10 -	0 !
 libsepol/src/write.c                           |  570 	45 +	525 -	0 !
 19 files changed, 258 insertions(+), 1234 deletions(-)

--- foo.orig/libsepol/src/assertion.c
+++ foo/libsepol/src/assertion.c
@@ -22,121 +22,6 @@
 
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/expand.h>
 #include <sepol/policydb/util.h>
 
 #include "debug.h"
-
-static int check_assertion_helper(sepol_handle_t * handle,
-				  policydb_t * p,
-				  avtab_t * te_avtab, avtab_t * te_cond_avtab,
-				  unsigned int stype, unsigned int ttype,
-				  class_perm_node_t * perm, unsigned long line)
-{
-	avtab_key_t avkey;
-	avtab_ptr_t node;
-	class_perm_node_t *curperm;
-
-	for (curperm = perm; curperm != NULL; curperm = curperm->next) {
-		avkey.source_type = stype + 1;
-		avkey.target_type = ttype + 1;
-		avkey.target_class = curperm->class;
-		avkey.specified = AVTAB_ALLOWED;
-		for (node = avtab_search_node(te_avtab, &avkey);
-		     node != NULL;
-		     node = avtab_search_node_next(node, avkey.specified)) {
-			if (node->datum.data & curperm->data)
-				goto err;
-		}
-		for (node = avtab_search_node(te_cond_avtab, &avkey);
-		     node != NULL;
-		     node = avtab_search_node_next(node, avkey.specified)) {
-			if (node->datum.data & curperm->data)
-				goto err;
-		}
-	}
-
-	return 0;
-
-      err:
-	ERR(handle, "assertion on line %lu violated by allow %s %s:%s {%s };",
-	    line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
-	    p->p_class_val_to_name[curperm->class - 1],
-	    sepol_av_to_string(p, curperm->class,
-			       node->datum.data & curperm->data));
-	return -1;
-}
-
-int check_assertions(sepol_handle_t * handle, policydb_t * p,
-		     avrule_t * avrules)
-{
-	avrule_t *a;
-	avtab_t te_avtab, te_cond_avtab;
-	ebitmap_node_t *snode, *tnode;
-	unsigned int i, j;
-	int errors = 0;
-
-	if (!avrules) {
-		/* Since assertions are stored in avrules, if it is NULL
-		   there won't be any to check. This also prevents an invalid
-		   free if the avtabs are never initialized */
-		return 0;
-	}
-
-	if (avrules) {
-		if (avtab_init(&te_avtab))
-			goto oom;
-		if (avtab_init(&te_cond_avtab)) {
-			avtab_destroy(&te_avtab);
-			goto oom;
-		}
-		if (expand_avtab(p, &p->te_avtab, &te_avtab) ||
-		    expand_avtab(p, &p->te_cond_avtab, &te_cond_avtab)) {
-			avtab_destroy(&te_avtab);
-			avtab_destroy(&te_cond_avtab);
-			goto oom;
-		}
-	}
-
-	for (a = avrules; a != NULL; a = a->next) {
-		ebitmap_t *stypes = &a->stypes.types;
-		ebitmap_t *ttypes = &a->ttypes.types;
-
-		if (!(a->specified & AVRULE_NEVERALLOW))
-			continue;
-
-		ebitmap_for_each_bit(stypes, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
-			if (a->flags & RULE_SELF) {
-				if (check_assertion_helper
-				    (handle, p, &te_avtab, &te_cond_avtab, i, i,
-				     a->perms, a->line))
-					errors++;
-			}
-			ebitmap_for_each_bit(ttypes, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
-				if (check_assertion_helper
-				    (handle, p, &te_avtab, &te_cond_avtab, i, j,
-				     a->perms, a->line))
-					errors++;
-			}
-		}
-	}
-
-	if (errors) {
-		ERR(handle, "%d assertion violations occured", errors);
-		avtab_destroy(&te_avtab);
-		avtab_destroy(&te_cond_avtab);
-		return -1;
-	}
-
-	avtab_destroy(&te_avtab);
-	avtab_destroy(&te_cond_avtab);
-	return 0;
-
-      oom:
-	ERR(handle, "Out of memory - unable to check assertions");
-	return -1;
-}
--- foo.orig/libsepol/src/avrule_block.c
+++ foo/libsepol/src/avrule_block.c
@@ -26,176 +26,3 @@
 
 #include <assert.h>
 #include <stdlib.h>
-
-/* It is anticipated that there be less declarations within an avrule
- * block than the global policy.  Thus the symbol table sizes are
- * smaller than those listed in policydb.c */
-static unsigned int symtab_sizes[SYM_NUM] = {
-	2,
-	4,
-	8,
-	32,
-	16,
-	4,
-	2,
-	2,
-};
-
-avrule_block_t *avrule_block_create(void)
-{
-	avrule_block_t *block;
-	if ((block = calloc(1, sizeof(*block))) == NULL) {
-		return NULL;
-	}
-	return block;
-}
-
-avrule_decl_t *avrule_decl_create(uint32_t decl_id)
-{
-	avrule_decl_t *decl;
-	int i;
-	if ((decl = calloc(1, sizeof(*decl))) == NULL) {
-		return NULL;
-	}
-	decl->decl_id = decl_id;
-	for (i = 0; i < SYM_NUM; i++) {
-		if (symtab_init(&decl->symtab[i], symtab_sizes[i])) {
-			avrule_decl_destroy(decl);
-			free(decl);
-			return NULL;
-		}
-	}
-
-	for (i = 0; i < SYM_NUM; i++) {
-		ebitmap_init(&decl->required.scope[i]);
-		ebitmap_init(&decl->declared.scope[i]);
-	}
-	return decl;
-}
-
-/* note that unlike the other destroy functions, this one does /NOT/
- * destroy the pointer itself */
-static void scope_index_destroy(scope_index_t * scope)
-{
-	unsigned int i;
-	if (scope == NULL) {
-		return;
-	}
-	for (i = 0; i < SYM_NUM; i++) {
-		ebitmap_destroy(scope->scope + i);
-	}
-	for (i = 0; i < scope->class_perms_len; i++) {
-		ebitmap_destroy(scope->class_perms_map + i);
-	}
-	free(scope->class_perms_map);
-}
-
-void avrule_decl_destroy(avrule_decl_t * x)
-{
-	if (x == NULL) {
-		return;
-	}
-	cond_list_destroy(x->cond_list);
-	avrule_list_destroy(x->avrules);
-	role_trans_rule_list_destroy(x->role_tr_rules);
-	role_allow_rule_list_destroy(x->role_allow_rules);
-	range_trans_rule_list_destroy(x->range_tr_rules);
-	scope_index_destroy(&x->required);
-	scope_index_destroy(&x->declared);
-	symtabs_destroy(x->symtab);
-	free(x->module_name);
-	free(x);
-}
-
-void avrule_block_destroy(avrule_block_t * x)
-{
-	avrule_decl_t *decl;
-	if (x == NULL) {
-		return;
-	}
-	decl = x->branch_list;
-	while (decl != NULL) {
-		avrule_decl_t *next_decl = decl->next;
-		avrule_decl_destroy(decl);
-		decl = next_decl;
-	}
-	free(x);
-}
-
-void avrule_block_list_destroy(avrule_block_t * x)
-{
-	while (x != NULL) {
-		avrule_block_t *next = x->next;
-		avrule_block_destroy(x);
-		x = next;
-	}
-}
-
-/* Get a conditional node from a avrule_decl with the same expression.
- * If that expression does not exist then create one. */
-cond_list_t *get_decl_cond_list(policydb_t * p, avrule_decl_t * decl,
-				cond_list_t * cond)
-{
-	cond_list_t *result;
-	int was_created;
-	result = cond_node_find(p, cond, decl->cond_list, &was_created);
-	if (result != NULL && was_created) {
-		result->next = decl->cond_list;
-		decl->cond_list = result;
-	}
-	return result;
-}
-
-/* Look up an identifier in a policy's scoping table.  If it is there,
- * marked as SCOPE_DECL, and any of its declaring block has been enabled,
- * then return 1.  Otherwise return 0. Can only be called after the 
- * decl_val_to_struct index has been created */
-int is_id_enabled(char *id, policydb_t * p, int symbol_table)
-{
-	scope_datum_t *scope =
-	    (scope_datum_t *) hashtab_search(p->scope[symbol_table].table, id);
-	uint32_t i;
-	if (scope == NULL) {
-		return 0;
-	}
-	if (scope->scope != SCOPE_DECL) {
-		return 0;
-	}
-	for (i = 0; i < scope->decl_ids_len; i++) {
-		avrule_decl_t *decl =
-		    p->decl_val_to_struct[scope->decl_ids[i] - 1];
-		if (decl != NULL && decl->enabled) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/* Check if a particular permission is present within the given class,
- * and that the class is enabled.  Returns 1 if both conditions are
- * true, 0 if neither could be found or if the class id disabled. */
-int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p)
-{
-	class_datum_t *cladatum;
-	perm_datum_t *perm;
-	if (!is_id_enabled(class_id, p, SYM_CLASSES)) {
-		return 0;
-	}
-	cladatum =
-	    (class_datum_t *) hashtab_search(p->p_classes.table, class_id);
-	if (cladatum == NULL) {
-		return 0;
-	}
-	perm = hashtab_search(cladatum->permissions.table, perm_id);
-	if (perm == NULL && cladatum->comdatum != 0) {
-		/* permission was not in this class.  before giving
-		 * up, check the class's parent */
-		perm =
-		    hashtab_search(cladatum->comdatum->permissions.table,
-				   perm_id);
-	}
-	if (perm == NULL) {
-		return 0;
-	}
-	return 1;
-}
--- foo.orig/libsepol/src/conditional.c
+++ foo/libsepol/src/conditional.c
@@ -336,109 +336,6 @@ static int evaluate_cond_node(policydb_t
 	return 0;
 }
 
-/* precompute and simplify an expression if possible.  If left with !expression, change 
- * to expression and switch t and f. precompute expression for expressions with limited
- * number of bools.
- */
-int cond_normalize_expr(policydb_t * p, cond_node_t * cn)
-{
-	cond_expr_t *ne, *e;
-	cond_av_list_t *tmp;
-	unsigned int i, j, orig_value[COND_MAX_BOOLS];
-	int k;
-	uint32_t test = 0x0;
-	avrule_t *tmp2;
-
-	cn->nbools = 0;
-
-	memset(cn->bool_ids, 0, sizeof(cn->bool_ids));
-	cn->expr_pre_comp = 0x0;
-
-	/* take care of !expr case */
-	ne = NULL;
-	e = cn->expr;
-
-	/* becuase it's RPN look at last element */
-	while (e->next != NULL) {
-		ne = e;
-		e = e->next;
-	}
-	if (e->expr_type == COND_NOT) {
-		if (ne) {
-			ne->next = NULL;
-		} else {	/* ne should never be NULL */
-			printf
-			    ("Found expr with no bools and only a ! - this should never happen.\n");
-			return -1;
-		}
-		/* swap the true and false lists */
-		tmp = cn->true_list;
-		cn->true_list = cn->false_list;
-		cn->false_list = tmp;
-		tmp2 = cn->avtrue_list;
-		cn->avtrue_list = cn->avfalse_list;
-		cn->avfalse_list = tmp2;
-
-		/* free the "not" node in the list */
-		free(e);
-	}
-
-	/* find all the bools in the expression */
-	for (e = cn->expr; e != NULL; e = e->next) {
-		switch (e->expr_type) {
-		case COND_BOOL:
-			i = 0;
-			/* see if we've already seen this bool */
-			if (!bool_present(e->bool, cn->bool_ids, cn->nbools)) {
-				/* count em all but only record up to COND_MAX_BOOLS */
-				if (cn->nbools < COND_MAX_BOOLS)
-					cn->bool_ids[cn->nbools++] = e->bool;
-				else
-					cn->nbools++;
-			}
-			break;
-		default:
-			break;
-		}
-	}
-
-	/* only precompute for exprs with <= COND_AX_BOOLS */
-	if (cn->nbools <= COND_MAX_BOOLS) {
-		/* save the default values for the bools so we can play with them */
-		for (i = 0; i < cn->nbools; i++) {
-			orig_value[i] =
-			    p->bool_val_to_struct[cn->bool_ids[i] - 1]->state;
-		}
-
-		/* loop through all possible combinations of values for bools in expression */
-		for (test = 0x0; test < (0x1U << cn->nbools); test++) {
-			/* temporarily set the value for all the bools in the
-			 * expression using the corr.  bit in test */
-			for (j = 0; j < cn->nbools; j++) {
-				p->bool_val_to_struct[cn->bool_ids[j] -
-						      1]->state =
-				    (test & (0x1 << j)) ? 1 : 0;
-			}
-			k = cond_evaluate_expr(p, cn->expr);
-			if (k == -1) {
-				printf
-				    ("While testing expression, expression result "
-				     "was undefined - this should never happen.\n");
-				return -1;
-			}
-			/* set the bit if expression evaluates true */
-			if (k)
-				cn->expr_pre_comp |= 0x1 << test;
-		}
-
-		/* restore bool default values */
-		for (i = 0; i < cn->nbools; i++)
-			p->bool_val_to_struct[cn->bool_ids[i] - 1]->state =
-			    orig_value[i];
-	}
-	return 0;
-}
-
 int evaluate_conds(policydb_t * p)
 {
 	int ret;
@@ -491,8 +388,6 @@ void cond_node_destroy(cond_node_t * nod
 		return;
 
 	cond_expr_destroy(node->expr);
-	avrule_list_destroy(node->avtrue_list);
-	avrule_list_destroy(node->avfalse_list);
 	cond_av_list_destroy(node->true_list);
 	cond_av_list_destroy(node->false_list);
 }
@@ -797,18 +692,11 @@ static int cond_read_node(policydb_t * p
 		last = expr;
 	}
 
-	if (p->policy_type == POLICY_KERN) {
-		if (cond_read_av_list(p, fp, &node->true_list, NULL) != 0)
-			goto err;
-		if (cond_read_av_list(p, fp, &node->false_list, node->true_list)
-		    != 0)
-			goto err;
-	} else {
-		if (avrule_read_list(p, &node->avtrue_list, fp))
-			goto err;
-		if (avrule_read_list(p, &node->avfalse_list, fp))
-			goto err;
-	}
+	if (cond_read_av_list(p, fp, &node->true_list, NULL) != 0)
+		goto err;
+	if (cond_read_av_list(p, fp, &node->false_list, node->true_list)
+	    != 0)
+		goto err;
 
 	return 0;
       err:
@@ -899,3 +787,138 @@ avtab_datum_t *cond_av_list_search(avtab
 	return NULL;
 
 }
+
+static int expand_cond_insert(cond_av_list_t ** l,
+			      avtab_t * expa,
+			      avtab_key_t * k, avtab_datum_t * d)
+{
+	avtab_ptr_t node;
+	avtab_datum_t *avd;
+	cond_av_list_t *nl;
+
+	node = avtab_search_node(expa, k);
+	if (!node ||
+	    (k->specified & AVTAB_ENABLED) !=
+	    (node->key.specified & AVTAB_ENABLED)) {
+		node = avtab_insert_nonunique(expa, k, d);
+		if (!node) {
+			fprintf(stderr, "Out of memory!");
+			return -1;
+		}
+		node->parse_context = (void *)1;
+		nl = (cond_av_list_t *) malloc(sizeof(*nl));
+		if (!nl) {
+			fprintf(stderr, "Out of memory!");
+			return -1;
+		}
+		memset(nl, 0, sizeof(*nl));
+		nl->node = node;
+		nl->next = *l;
+		*l = nl;
+		return 0;
+	}
+
+	avd = &node->datum;
+	switch (k->specified & ~AVTAB_ENABLED) {
+	case AVTAB_ALLOWED:
+	case AVTAB_AUDITALLOW:
+		avd->data |= d->data;
+		break;
+	case AVTAB_AUDITDENY:
+		avd->data &= d->data;
+		break;
+	default:
+		fprintf(stderr, "Type conflict!");
+		return -1;
+	}
+
+	return 0;
+}
+
+int expand_cond_av_node(policydb_t * p,
+			avtab_ptr_t node,
+			cond_av_list_t ** newl, avtab_t * expa)
+{
+	avtab_key_t *k = &node->key;
+	avtab_datum_t *d = &node->datum;
+	type_datum_t *stype = p->type_val_to_struct[k->source_type - 1];
+	type_datum_t *ttype = p->type_val_to_struct[k->target_type - 1];
+	ebitmap_t *sattr = &p->attr_type_map[k->source_type - 1];
+	ebitmap_t *tattr = &p->attr_type_map[k->target_type - 1];
+	ebitmap_node_t *snode, *tnode;
+	unsigned int i, j;
+	avtab_key_t newkey;
+	int rc;
+
+	newkey.target_class = k->target_class;
+	newkey.specified = k->specified;
+
+	if (stype && ttype) {
+		/* Both are individual types, no expansion required. */
+		return expand_cond_insert(newl, expa, k, d);
+	}
+
+	if (stype) {
+		/* Source is an individual type, target is an attribute. */
+		newkey.source_type = k->source_type;
+		ebitmap_for_each_bit(tattr, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
+				continue;
+			newkey.target_type = j + 1;
+			rc = expand_cond_insert(newl, expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+		return 0;
+	}
+
+	if (ttype) {
+		/* Target is an individual type, source is an attribute. */
+		newkey.target_type = k->target_type;
+		ebitmap_for_each_bit(sattr, snode, i) {
+			if (!ebitmap_node_get_bit(snode, i))
+				continue;
+			newkey.source_type = i + 1;
+			rc = expand_cond_insert(newl, expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+		return 0;
+	}
+
+	/* Both source and target type are attributes. */
+	ebitmap_for_each_bit(sattr, snode, i) {
+		if (!ebitmap_node_get_bit(snode, i))
+			continue;
+		ebitmap_for_each_bit(tattr, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
+				continue;
+			newkey.source_type = i + 1;
+			newkey.target_type = j + 1;
+			rc = expand_cond_insert(newl, expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+int expand_cond_av_list(policydb_t * p, cond_av_list_t * l,
+			cond_av_list_t ** newl, avtab_t * expa)
+{
+	cond_av_list_t *cur;
+	avtab_ptr_t node;
+	int rc;
+
+	*newl = NULL;
+	for (cur = l; cur; cur = cur->next) {
+		node = cur->node;
+		rc = expand_cond_av_node(p, node, newl, expa);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
--- foo.orig/libsepol/src/constraint.c
+++ foo/libsepol/src/constraint.c
@@ -19,7 +19,6 @@
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/constraint.h>
-#include <sepol/policydb/expand.h>
 #include <sepol/policydb/flask_types.h>
 
 #include <assert.h>
@@ -32,7 +31,7 @@ int constraint_expr_init(constraint_expr
 	if ((expr->type_names = malloc(sizeof(*expr->type_names))) == NULL) {
 		return -1;
 	}
-	type_set_init(expr->type_names);
+	ebitmap_init(expr->type_names);
 	return 0;
 }
 
@@ -40,7 +39,7 @@ void constraint_expr_destroy(constraint_
 {
 	if (expr != NULL) {
 		ebitmap_destroy(&expr->names);
-		type_set_destroy(expr->type_names);
+		ebitmap_destroy(expr->type_names);
 		free(expr->type_names);
 		free(expr);
 	}
--- foo.orig/libsepol/src/genusers.c
+++ foo/libsepol/src/genusers.c
@@ -72,8 +72,8 @@ static int load_users(struct policydb *p
 		usrdatum = hashtab_search(policydb->p_users.table, q);
 		if (usrdatum) {
 			/* Replacing an existing user definition. */
-			ebitmap_destroy(&usrdatum->roles.roles);
-			ebitmap_init(&usrdatum->roles.roles);
+			ebitmap_destroy(&usrdatum->roles);
+			ebitmap_init(&usrdatum->roles);
 		} else {
 			char *id = strdup(q);
 
@@ -88,7 +88,7 @@ static int load_users(struct policydb *p
 			}
 			memset(usrdatum, 0, sizeof(user_datum_t));
 			usrdatum->s.value = ++policydb->p_users.nprim;
-			ebitmap_init(&usrdatum->roles.roles);
+			ebitmap_init(&usrdatum->roles);
 			if (hashtab_insert(policydb->p_users.table,
 					   id, (hashtab_datum_t) usrdatum)) {
 				ERR(NULL, "out of memory");
@@ -145,7 +145,7 @@ static int load_users(struct policydb *p
 			ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
 				if (ebitmap_node_get_bit(rnode, bit))
 					if (ebitmap_set_bit
-					    (&usrdatum->roles.roles, bit, 1)) {
+					    (&usrdatum->roles, bit, 1)) {
 						ERR(NULL, "out of memory");
 						free(buffer);
 						fclose(fp);
--- foo.orig/libsepol/src/hierarchy.c
+++ foo/libsepol/src/hierarchy.c
@@ -27,7 +27,6 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hierarchy.h>
-#include <sepol/policydb/expand.h>
 #include <sepol/policydb/util.h>
 
 #include "debug.h"
@@ -259,6 +258,13 @@ static int check_avtab_hierarchy_callbac
 	return 0;
 }
 
+/* NOTE: the code path that gets here will not get exercised until
+ * we finish with the new policy-representation.  Currently the only
+ * thing in the library that calls this (indirectly) is via the
+ * checkmodule program.  This will probably be overhauled significantly
+ * by the time policyrep is done.
+ * - mgoldman@tresys.com 2007-06-21
+ */
 static int check_cond_avtab_hierarchy(cond_list_t * cond_list,
 				      hierarchy_args_t * args)
 {
@@ -268,14 +274,22 @@ static int check_cond_avtab_hierarchy(co
 	avtab_t expa;
 	hierarchy_args_t *a = (hierarchy_args_t *) args;
 
+	ERR(args->handle, "%s:%d %s This function is broken until policyrep"
+	    " work is finished.\nIt is currently in an unused codepath "
+	    "and this message\nshould not be seen.\n", __FILE__, __LINE__,
+	    __func__);
+	return 1;
+
 	for (cur_node = cond_list; cur_node != NULL; cur_node = cur_node->next) {
 		if (avtab_init(&expa))
 			goto oom;
-		if (expand_cond_av_list
-		    (args->p, cur_node->true_list, &expl, &expa)) {
-			avtab_destroy(&expa);
-			goto oom;
-		}
+		/* FIXME: Broken until policyrep work is finished
+		   if (expand_cond_av_list
+		   (args->p, cur_node->true_list, &expl, &expa)) {
+		   avtab_destroy(&expa);
+		   goto oom;
+		   }
+		 */
 		args->opt_cond_list = expl;
 		for (cur_av = expl; cur_av != NULL; cur_av = cur_av->next) {
 			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
@@ -288,11 +302,13 @@ static int check_cond_avtab_hierarchy(co
 		avtab_destroy(&expa);
 		if (avtab_init(&expa))
 			goto oom;
-		if (expand_cond_av_list
-		    (args->p, cur_node->false_list, &expl, &expa)) {
-			avtab_destroy(&expa);
-			goto oom;
-		}
+		/* FIXME: Broken until policyrep work is finished.
+		   if (expand_cond_av_list
+		   (args->p, cur_node->false_list, &expl, &expa)) {
+		   avtab_destroy(&expa);
+		   goto oom;
+		   }
+		 */
 		args->opt_cond_list = expl;
 		for (cur_av = expl; cur_av != NULL; cur_av = cur_av->next) {
 			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
@@ -346,13 +362,13 @@ static int check_role_hierarchy_callback
 		return 0;
 	}
 
-	if (ebitmap_or(&eb, &r->types.types, &rp->types.types)) {
+	if (ebitmap_or(&eb, &r->types, &rp->types)) {
 		/* Memory error */
 		free(parent);
 		return -1;
 	}
 
-	if (!ebitmap_cmp(&eb, &rp->types.types)) {
+	if (!ebitmap_cmp(&eb, &rp->types)) {
 		/* This is a violation of the hiearchal constraint, return error condition */
 		ERR(a->handle, "Role hierarchy violation, %s exceeds %s",
 		    a->p->p_role_val_to_name[r->s.value - 1], parent);
@@ -368,17 +384,15 @@ static int check_role_hierarchy_callback
 int hierarchy_check_constraints(sepol_handle_t * handle, policydb_t * p)
 {
 	hierarchy_args_t args;
-	avtab_t expa;
 
-	if (avtab_init(&expa))
-		goto oom;
-	if (expand_avtab(p, &p->te_avtab, &expa)) {
-		avtab_destroy(&expa);
-		goto oom;
-	}
+	ERR(handle, "%s:%d %s This function is broken until policyrep"
+	    " work is finished.\nIt is currently in an unused codepath "
+	    "and this message\nshould not be seen.\n", __FILE__, __LINE__,
+	    __func__);
+	return 1;
 
 	args.p = p;
-	args.expa = &expa;
+	args.expa = &p->te_avtab;
 	args.opt_cond_list = NULL;
 	args.handle = handle;
 	args.numerr = 0;
@@ -386,7 +400,7 @@ int hierarchy_check_constraints(sepol_ha
 	if (hashtab_map(p->p_types.table, check_type_hierarchy_callback, &args))
 		goto bad;
 
-	if (avtab_map(&expa, check_avtab_hierarchy_callback, &args))
+	if (avtab_map(&p->te_avtab, check_avtab_hierarchy_callback, &args))
 		goto bad;
 
 	if (check_cond_avtab_hierarchy(p->cond_list, &args))
@@ -401,14 +415,8 @@ int hierarchy_check_constraints(sepol_ha
 		goto bad;
 	}
 
-	avtab_destroy(&expa);
 	return 0;
 
       bad:
-	avtab_destroy(&expa);
-	return -1;
-
-      oom:
-	ERR(handle, "Out of memory");
 	return -1;
 }
--- foo.orig/libsepol/src/policydb_public.c
+++ foo/libsepol/src/policydb_public.c
@@ -95,41 +95,18 @@ int sepol_policy_kern_vers_max(void)
 	return POLICYDB_VERSION_MAX;
 }
 
-int sepol_policydb_set_typevers(sepol_policydb_t * sp, unsigned int type)
+int sepol_policydb_set_typevers(sepol_policydb_t * sp)
 {
 	struct policydb *p = &sp->p;
-	switch (type) {
-	case POLICY_KERN:
-		p->policyvers = POLICYDB_VERSION_MAX;
-		break;
-	case POLICY_BASE:
-	case POLICY_MOD:
-		p->policyvers = MOD_POLICYDB_VERSION_MAX;
-		break;
-	default:
-		return -1;
-	}
-	p->policy_type = type;
+	p->policyvers = POLICYDB_VERSION_MAX;
 	return 0;
 }
 
 int sepol_policydb_set_vers(sepol_policydb_t * sp, unsigned int vers)
 {
 	struct policydb *p = &sp->p;
-	switch (p->policy_type) {
-	case POLICY_KERN:
-		if (vers < POLICYDB_VERSION_MIN || vers > POLICYDB_VERSION_MAX)
-			return -1;
-		break;
-	case POLICY_BASE:
-	case POLICY_MOD:
-		if (vers < MOD_POLICYDB_VERSION_MIN
-		    || vers > MOD_POLICYDB_VERSION_MAX)
-			return -1;
-		break;
-	default:
+	if (vers < POLICYDB_VERSION_MIN || vers > POLICYDB_VERSION_MAX)
 		return -1;
-	}
 	p->policyvers = vers;
 	return 0;
 }
--- foo.orig/libsepol/src/services.c
+++ foo/libsepol/src/services.c
@@ -87,7 +87,8 @@ int sepol_set_policydb_from_file(FILE * 
 	struct policy_file pf;
 	pf.fp = fp;
 	pf.type = PF_USE_STDIO;
-	if (mypolicydb.policy_type)
+	// FIXME: We need to figure out a new test for destroying the db
+	if (0)
 		policydb_destroy(&mypolicydb);
 	if (policydb_init(&mypolicydb)) {
 		ERR(NULL, "Out of memory!");
@@ -1265,12 +1266,12 @@ int hidden sepol_get_user_sids(sepol_sec
 	}
 	memset(mysids, 0, maxnel * sizeof(sepol_security_id_t));
 
-	ebitmap_for_each_bit(&user->roles.roles, rnode, i) {
+	ebitmap_for_each_bit(&user->roles, rnode, i) {
 		if (!ebitmap_node_get_bit(rnode, i))
 			continue;
 		role = policydb->role_val_to_struct[i];
 		usercon.role = i + 1;
-		ebitmap_for_each_bit(&role->types.types, tnode, j) {
+		ebitmap_for_each_bit(&role->types, tnode, j) {
 			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
 			usercon.type = j + 1;
--- foo.orig/libsepol/src/users.c
+++ foo/libsepol/src/users.c
@@ -8,7 +8,6 @@
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/hashtab.h>
-#include <sepol/policydb/expand.h>
 #include "user_internal.h"
 #include "mls.h"
 
@@ -19,7 +18,7 @@ static int user_to_record(sepol_handle_t
 
 	const char *name = policydb->p_user_val_to_name[user_idx];
 	user_datum_t *usrdatum = policydb->user_val_to_struct[user_idx];
-	ebitmap_t *roles = &(usrdatum->roles.roles);
+	ebitmap_t *roles = &(usrdatum->roles);
 	ebitmap_node_t *rnode;
 	unsigned bit;
 
@@ -169,8 +168,7 @@ int sepol_user_modify(sepol_handle_t * h
 		/* Set the role and every role it dominates */
 		ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
 			if (ebitmap_node_get_bit(rnode, bit)) {
-				if (ebitmap_set_bit
-				    (&(usrdatum->roles.roles), bit, 1))
+				if (ebitmap_set_bit(&(usrdatum->roles), bit, 1))
 					goto omem;
 			}
 		}
@@ -259,11 +257,11 @@ int sepol_user_modify(sepol_handle_t * h
 		name = NULL;
 
 		/* Expand roles */
-		if (role_set_expand
-		    (&usrdatum->roles, &usrdatum->cache, policydb)) {
-			ERR(handle, "unable to expand role set");
-			goto err;
-		}
+		/* NOTE: Deleted this section - it is unclear whether or not
+		 * expansion will be required when the policyrep work is
+		 * done. 
+		 *  - mgoldman@tresys.com
+		 */
 	}
 
 	free(roles);
@@ -278,7 +276,7 @@ int sepol_user_modify(sepol_handle_t * h
 	free(name);
 	free(roles);
 	if (new && usrdatum) {
-		role_set_destroy(&usrdatum->roles);
+		ebitmap_destroy(&usrdatum->roles);
 		free(usrdatum);
 	}
 	return STATUS_ERR;
--- foo.orig/libsepol/src/write.c
+++ foo/libsepol/src/write.c
@@ -38,7 +38,6 @@
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
-#include <sepol/policydb/expand.h>
 #include <sepol/policydb/flask.h>
 
 #include "debug.h"
@@ -50,8 +49,6 @@ struct policy_data {
 	struct policydb *p;
 };
 
-static int avrule_write_list(avrule_t * avrules, struct policy_file *fp);
-
 static int ebitmap_write(ebitmap_t * e, struct policy_file *fp)
 {
 	ebitmap_node_t *n;
@@ -105,8 +102,7 @@ static int avtab_write_item(policydb_t *
 	uint32_t buf32[10], lookup, val;
 	size_t items, items2;
 	unsigned set;
-	unsigned int oldvers = (p->policy_type == POLICY_KERN
-				&& p->policyvers < POLICYDB_VERSION_AVTAB);
+	unsigned int oldvers = (p->policyvers < POLICYDB_VERSION_AVTAB);
 	unsigned int i;
 
 	if (oldvers) {
@@ -244,23 +240,13 @@ static int avtab_write(struct policydb *
 	avtab_ptr_t cur;
 	uint32_t nel;
 	size_t items;
-	unsigned int oldvers = (p->policy_type == POLICY_KERN
-				&& p->policyvers < POLICYDB_VERSION_AVTAB);
+	unsigned int oldvers = (p->policyvers < POLICYDB_VERSION_AVTAB);
 
 	if (oldvers) {
-		/* Old avtab format.
-		   First, we need to expand attributes.  Then, we need to
-		   merge similar entries, so we need to track merged nodes 
-		   and compute the final nel. */
-		if (avtab_init(&expa))
-			return POLICYDB_ERROR;
-		if (expand_avtab(p, a, &expa)) {
-			rc = -1;
-			goto out;
-		}
-		a = &expa;
-		avtab_reset_merged(a);
-		nel = a->nel;
+		fprintf(stderr, "%s:%d Error, this branch executed \n"
+			"code that dissappeared.\n", __FILE__, __LINE__);
+		rc = -1;
+		goto out;
 	} else {
 		/* New avtab format.  nel is good to go. */
 		nel = cpu_to_le32(a->nel);
@@ -308,55 +294,6 @@ static int avtab_write(struct policydb *
 }
 
 /*
- * Write a semantic MLS level structure to a policydb binary 
- * representation file.
- */
-static int mls_write_semantic_level_helper(mls_semantic_level_t * l,
-					   struct policy_file *fp)
-{
-	uint32_t buf[2], ncat = 0;
-	size_t items;
-	mls_semantic_cat_t *cat;
-
-	for (cat = l->cat; cat; cat = cat->next)
-		ncat++;
-
-	buf[0] = cpu_to_le32(l->sens);
-	buf[1] = cpu_to_le32(ncat);
-	items = put_entry(buf, sizeof(uint32_t), 2, fp);
-	if (items != 2)
-		return POLICYDB_ERROR;
-
-	for (cat = l->cat; cat; cat = cat->next) {
-		buf[0] = cpu_to_le32(cat->low);
-		buf[1] = cpu_to_le32(cat->high);
-		items = put_entry(buf, sizeof(uint32_t), 2, fp);
-		if (items != 2)
-			return POLICYDB_ERROR;
-	}
-
-	return POLICYDB_SUCCESS;
-}
-
-/*
- * Read a semantic MLS range structure to a policydb binary 
- * representation file.
- */
-static int mls_write_semantic_range_helper(mls_semantic_range_t * r,
-					   struct policy_file *fp)
-{
-	int rc;
-
-	rc = mls_write_semantic_level_helper(&r->level[0], fp);
-	if (rc)
-		return rc;
-
-	rc = mls_write_semantic_level_helper(&r->level[1], fp);
-
-	return rc;
-}
-
-/*
  * Write a MLS level structure to a policydb binary 
  * representation file.
  */
@@ -509,40 +446,6 @@ static int role_allow_write(role_allow_t
 	return POLICYDB_SUCCESS;
 }
 
-static int role_set_write(role_set_t * x, struct policy_file *fp)
-{
-	size_t items;
-	uint32_t buf[1];
-
-	if (ebitmap_write(&x->roles, fp))
-		return POLICYDB_ERROR;
-
-	buf[0] = cpu_to_le32(x->flags);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
-
-	return POLICYDB_SUCCESS;
-}
-
-static int type_set_write(type_set_t * x, struct policy_file *fp)
-{
-	size_t items;
-	uint32_t buf[1];
-
-	if (ebitmap_write(&x->types, fp))
-		return POLICYDB_ERROR;
-	if (ebitmap_write(&x->negset, fp))
-		return POLICYDB_ERROR;
-
-	buf[0] = cpu_to_le32(x->flags);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
-
-	return POLICYDB_SUCCESS;
-}
-
 static int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 {
 	cond_bool_datum_t *booldatum;
@@ -583,16 +486,14 @@ static int cond_write_av_list(policydb_t
 	cond_av_list_t *cur_list, *new_list = NULL;
 	avtab_t expa;
 	uint32_t len, items;
-	unsigned int oldvers = (p->policy_type == POLICY_KERN
-				&& p->policyvers < POLICYDB_VERSION_AVTAB);
+	unsigned int oldvers = (p->policyvers < POLICYDB_VERSION_AVTAB);
 	int rc = -1;
 
 	if (oldvers) {
-		if (avtab_init(&expa))
-			return POLICYDB_ERROR;
-		if (expand_cond_av_list(p, list, &new_list, &expa))
-			goto out;
-		list = new_list;
+		fprintf(stderr, "%s:%d Error, this branch executed \n"
+			"code that dissappeared.\n", __FILE__, __LINE__);
+		rc = -1;
+		goto out;
 	}
 
 	len = 0;
@@ -658,17 +559,10 @@ static int cond_write_node(policydb_t * 
 			return POLICYDB_ERROR;
 	}
 
-	if (p->policy_type == POLICY_KERN) {
-		if (cond_write_av_list(p, node->true_list, fp) != 0)
-			return POLICYDB_ERROR;
-		if (cond_write_av_list(p, node->false_list, fp) != 0)
-			return POLICYDB_ERROR;
-	} else {
-		if (avrule_write_list(node->avtrue_list, fp))
-			return POLICYDB_ERROR;
-		if (avrule_write_list(node->avfalse_list, fp))
-			return POLICYDB_ERROR;
-	}
+	if (cond_write_av_list(p, node->true_list, fp) != 0)
+		return POLICYDB_ERROR;
+	if (cond_write_av_list(p, node->false_list, fp) != 0)
+		return POLICYDB_ERROR;
 
 	return POLICYDB_SUCCESS;
 }
@@ -712,10 +606,8 @@ static int context_write(struct policydb
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items2 != items)
 		return POLICYDB_ERROR;
-	if ((p->policyvers >= POLICYDB_VERSION_MLS
-	     && p->policy_type == POLICY_KERN)
-	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policy_type == POLICY_BASE))
+	if ((p->policyvers >= POLICYDB_VERSION_MLS)
+	    )
 		if (mls_write_range_helper(&c->range, fp))
 			return POLICYDB_ERROR;
 
@@ -783,7 +675,7 @@ static int common_write(hashtab_key_t ke
 	return POLICYDB_SUCCESS;
 }
 
-static int write_cons_helper(policydb_t * p,
+static int write_cons_helper(policydb_t * p __attribute__ ((unused)),
 			     constraint_node_t * node, int allowxtarget,
 			     struct policy_file *fp)
 {
@@ -818,10 +710,6 @@ static int write_cons_helper(policydb_t 
 				if (ebitmap_write(&e->names, fp)) {
 					return POLICYDB_ERROR;
 				}
-				if (p->policy_type != POLICY_KERN &&
-				    type_set_write(e->type_names, fp)) {
-					return POLICYDB_ERROR;
-				}
 				break;
 			default:
 				break;
@@ -884,10 +772,8 @@ static int class_write(hashtab_key_t key
 	if (write_cons_helper(p, cladatum->constraints, 0, fp))
 		return POLICYDB_ERROR;
 
-	if ((p->policy_type == POLICY_KERN
-	     && p->policyvers >= POLICYDB_VERSION_VALIDATETRANS)
-	    || (p->policy_type == POLICY_BASE
-		&& p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
+	if ((p->policyvers >= POLICYDB_VERSION_VALIDATETRANS)
+	    ) {
 		/* write out the validatetrans rule */
 		ncons = 0;
 		for (c = cladatum->validatetrans; c; c = c->next) {
@@ -911,7 +797,6 @@ static int role_write(hashtab_key_t key,
 	size_t items, items2, len;
 	struct policy_data *pd = ptr;
 	struct policy_file *fp = pd->fp;
-	struct policydb *p = pd->p;
 
 	role = (role_datum_t *) datum;
 
@@ -929,13 +814,8 @@ static int role_write(hashtab_key_t key,
 
 	if (ebitmap_write(&role->dominates, fp))
 		return POLICYDB_ERROR;
-	if (p->policy_type == POLICY_KERN) {
-		if (ebitmap_write(&role->types.types, fp))
-			return POLICYDB_ERROR;
-	} else {
-		if (type_set_write(&role->types, fp))
-			return POLICYDB_ERROR;
-	}
+	if (ebitmap_write(&role->types, fp))
+		return POLICYDB_ERROR;
 
 	return POLICYDB_SUCCESS;
 }
@@ -947,7 +827,6 @@ static int type_write(hashtab_key_t key,
 	size_t items, items2, len;
 	struct policy_data *pd = ptr;
 	struct policy_file *fp = pd->fp;
-	struct policydb *p = pd->p;
 
 	typdatum = (type_datum_t *) datum;
 
@@ -956,18 +835,10 @@ static int type_write(hashtab_key_t key,
 	buf[items++] = cpu_to_le32(len);
 	buf[items++] = cpu_to_le32(typdatum->s.value);
 	buf[items++] = cpu_to_le32(typdatum->primary);
-	if (p->policy_type != POLICY_KERN) {
-		buf[items++] = cpu_to_le32(typdatum->flavor);
-	}
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return POLICYDB_ERROR;
 
-	if (p->policy_type != POLICY_KERN) {
-		if (ebitmap_write(&typdatum->types, fp))
-			return POLICYDB_ERROR;
-	}
-
 	items = put_entry(key, 1, len, fp);
 	if (items != len)
 		return POLICYDB_ERROR;
@@ -998,34 +869,15 @@ static int user_write(hashtab_key_t key,
 	if (items != len)
 		return POLICYDB_ERROR;
 
-	if (p->policy_type == POLICY_KERN) {
-		if (ebitmap_write(&usrdatum->roles.roles, fp))
-			return POLICYDB_ERROR;
-	} else {
-		if (role_set_write(&usrdatum->roles, fp))
-			return POLICYDB_ERROR;
-	}
+	if (ebitmap_write(&usrdatum->roles, fp))
+		return POLICYDB_ERROR;
 
-	if ((p->policyvers >= POLICYDB_VERSION_MLS
-	     && p->policy_type == POLICY_KERN)
-	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS
-		&& p->policy_type == POLICY_MOD)
-	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS
-		&& p->policy_type == POLICY_BASE)) {
+	if ((p->policyvers >= POLICYDB_VERSION_MLS)
+	    ) {
 		if (mls_write_range_helper(&usrdatum->exp_range, fp))
 			return POLICYDB_ERROR;
 		if (mls_write_level(&usrdatum->exp_dfltlevel, fp))
 			return POLICYDB_ERROR;
-	} else if ((p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS
-		    && p->policy_type == POLICY_MOD)
-		   || (p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS
-		       && p->policy_type == POLICY_BASE)) {
-		if (mls_write_semantic_range_helper(&usrdatum->range, fp))
-			return -1;
-		if (mls_write_semantic_level_helper(&usrdatum->dfltlevel, fp))
-			return -1;
 	}
 
 	return POLICYDB_SUCCESS;
@@ -1184,8 +1036,7 @@ static int range_write(policydb_t * p, s
 	size_t nel, items;
 	struct range_trans *rt;
 	uint32_t buf[2];
-	int new_rangetr = (p->policy_type == POLICY_KERN &&
-			   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
+	int new_rangetr = (p->policyvers >= POLICYDB_VERSION_RANGETRANS);
 	int warning_issued = 0;
 
 	nel = 0;
@@ -1226,290 +1077,6 @@ static int range_write(policydb_t * p, s
 	return POLICYDB_SUCCESS;
 }
 
-/************** module writing functions below **************/
-
-static int avrule_write(avrule_t * avrule, struct policy_file *fp)
-{
-	size_t items, items2;
-	uint32_t buf[32], len;
-	class_perm_node_t *cur;
-
-	items = 0;
-	buf[items++] = cpu_to_le32(avrule->specified);
-	buf[items++] = cpu_to_le32(avrule->flags);
-	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
-	if (items2 != items)
-		return POLICYDB_ERROR;
-
-	if (type_set_write(&avrule->stypes, fp))
-		return POLICYDB_ERROR;
-
-	if (type_set_write(&avrule->ttypes, fp))
-		return POLICYDB_ERROR;
-
-	cur = avrule->perms;
-	len = 0;
-	while (cur) {
-		len++;
-		cur = cur->next;
-	}
-	items = 0;
-	buf[items++] = cpu_to_le32(len);
-	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
-	if (items2 != items)
-		return POLICYDB_ERROR;
-	cur = avrule->perms;
-	while (cur) {
-		items = 0;
-		buf[items++] = cpu_to_le32(cur->class);
-		buf[items++] = cpu_to_le32(cur->data);
-		items2 = put_entry(buf, sizeof(uint32_t), items, fp);
-		if (items2 != items)
-			return POLICYDB_ERROR;
-
-		cur = cur->next;
-	}
-
-	return POLICYDB_SUCCESS;
-}
-
-static int avrule_write_list(avrule_t * avrules, struct policy_file *fp)
-{
-	uint32_t buf[32], len;
-	avrule_t *avrule;
-
-	avrule = avrules;
-	len = 0;
-	while (avrule) {
-		len++;
-		avrule = avrule->next;
-	}
-
-	buf[0] = cpu_to_le32(len);
-	if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1)
-		return POLICYDB_ERROR;
-
-	avrule = avrules;
-	while (avrule) {
-		avrule_write(avrule, fp);
-		avrule = avrule->next;
-	}
-
-	return POLICYDB_SUCCESS;
-}
-
-static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
-{
-	int nel = 0;
-	size_t items;
-	uint32_t buf[1];
-	role_trans_rule_t *tr;
-
-	for (tr = t; tr; tr = tr->next)
-		nel++;
-	buf[0] = cpu_to_le32(nel);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
-	for (tr = t; tr; tr = tr->next) {
-		if (role_set_write(&tr->roles, fp))
-			return POLICYDB_ERROR;
-		if (type_set_write(&tr->types, fp))
-			return POLICYDB_ERROR;
-		buf[0] = cpu_to_le32(tr->new_role);
-		items = put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return POLICYDB_ERROR;
-	}
-	return POLICYDB_SUCCESS;
-}
-
-static int role_allow_rule_write(role_allow_rule_t * r, struct policy_file *fp)
-{
-	int nel = 0;
-	size_t items;
-	uint32_t buf[1];
-	role_allow_rule_t *ra;
-
-	for (ra = r; ra; ra = ra->next)
-		nel++;
-	buf[0] = cpu_to_le32(nel);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
-	for (ra = r; ra; ra = ra->next) {
-		if (role_set_write(&ra->roles, fp))
-			return POLICYDB_ERROR;
-		if (role_set_write(&ra->new_roles, fp))
-			return POLICYDB_ERROR;
-	}
-	return POLICYDB_SUCCESS;
-}
-
-static int range_trans_rule_write(range_trans_rule_t * t,
-				  struct policy_file *fp)
-{
-	int nel = 0;
-	size_t items;
-	uint32_t buf[1];
-	range_trans_rule_t *rt;
-
-	for (rt = t; rt; rt = rt->next)
-		nel++;
-	buf[0] = cpu_to_le32(nel);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
-	for (rt = t; rt; rt = rt->next) {
-		if (type_set_write(&rt->stypes, fp))
-			return POLICYDB_ERROR;
-		if (type_set_write(&rt->ttypes, fp))
-			return POLICYDB_ERROR;
-		if (ebitmap_write(&rt->tclasses, fp))
-			return POLICYDB_ERROR;
-		if (mls_write_semantic_range_helper(&rt->trange, fp))
-			return POLICYDB_ERROR;
-	}
-	return POLICYDB_SUCCESS;
-}
-
-static int scope_index_write(scope_index_t * scope_index,
-			     unsigned int num_scope_syms,
-			     struct policy_file *fp)
-{
-	unsigned int i;
-	uint32_t buf[1];
-	for (i = 0; i < num_scope_syms; i++) {
-		if (ebitmap_write(scope_index->scope + i, fp) == -1) {
-			return POLICYDB_ERROR;
-		}
-	}
-	buf[0] = cpu_to_le32(scope_index->class_perms_len);
-	if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
-		return POLICYDB_ERROR;
-	}
-	for (i = 0; i < scope_index->class_perms_len; i++) {
-		if (ebitmap_write(scope_index->class_perms_map + i, fp) == -1) {
-			return POLICYDB_ERROR;
-		}
-	}
-	return POLICYDB_SUCCESS;
-}
-
-static int avrule_decl_write(avrule_decl_t * decl, int num_scope_syms,
-			     policydb_t * p, struct policy_file *fp)
-{
-	struct policy_data pd;
-	uint32_t buf[2];
-	int i;
-	buf[0] = cpu_to_le32(decl->decl_id);
-	buf[1] = cpu_to_le32(decl->enabled);
-	if (put_entry(buf, sizeof(uint32_t), 2, fp) != 2) {
-		return POLICYDB_ERROR;
-	}
-	if (cond_write_list(p, decl->cond_list, fp) == -1 ||
-	    avrule_write_list(decl->avrules, fp) == -1 ||
-	    role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
-	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
-		return POLICYDB_ERROR;
-	}
-	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
-	    range_trans_rule_write(decl->range_tr_rules, fp) == -1) {
-		return POLICYDB_ERROR;
-	}
-	if (scope_index_write(&decl->required, num_scope_syms, fp) == -1 ||
-	    scope_index_write(&decl->declared, num_scope_syms, fp) == -1) {
-		return POLICYDB_ERROR;
-	}
-	pd.fp = fp;
-	pd.p = p;
-	for (i = 0; i < num_scope_syms; i++) {
-		buf[0] = cpu_to_le32(decl->symtab[i].nprim);
-		buf[1] = cpu_to_le32(decl->symtab[i].table->nel);
-		if (put_entry(buf, sizeof(uint32_t), 2, fp) != 2) {
-			return POLICYDB_ERROR;
-		}
-		if (hashtab_map(decl->symtab[i].table, write_f[i], &pd)) {
-			return POLICYDB_ERROR;
-		}
-	}
-	return POLICYDB_SUCCESS;
-}
-
-static int avrule_block_write(avrule_block_t * block, int num_scope_syms,
-			      policydb_t * p, struct policy_file *fp)
-{
-	/* first write a count of the total number of blocks */
-	uint32_t buf[1], num_blocks = 0;
-	avrule_block_t *cur;
-	for (cur = block; cur != NULL; cur = cur->next) {
-		num_blocks++;
-	}
-	buf[0] = cpu_to_le32(num_blocks);
-	if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
-		return POLICYDB_ERROR;
-	}
-
-	/* now write each block */
-	for (cur = block; cur != NULL; cur = cur->next) {
-		uint32_t num_decls = 0;
-		avrule_decl_t *decl;
-		/* write a count of number of branches */
-		for (decl = cur->branch_list; decl != NULL; decl = decl->next) {
-			num_decls++;
-		}
-		buf[0] = cpu_to_le32(num_decls);
-		if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
-			return POLICYDB_ERROR;
-		}
-		for (decl = cur->branch_list; decl != NULL; decl = decl->next) {
-			if (avrule_decl_write(decl, num_scope_syms, p, fp) ==
-			    -1) {
-				return POLICYDB_ERROR;
-			}
-		}
-	}
-	return POLICYDB_SUCCESS;
-}
-
-static int scope_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
-{
-	scope_datum_t *scope = (scope_datum_t *) datum;
-	struct policy_data *pd = ptr;
-	struct policy_file *fp = pd->fp;
-	uint32_t static_buf[32], *dyn_buf = NULL, *buf;
-	size_t key_len = strlen(key);
-	unsigned int items = 2 + scope->decl_ids_len, i;
-
-	if (items >= (sizeof(static_buf) / 4)) {
-		/* too many things required, so dynamically create a
-		 * buffer.  this would have been easier with C99's
-		 * dynamic arrays... */
-		if ((dyn_buf = malloc(items * sizeof(*dyn_buf))) == NULL) {
-			return POLICYDB_ERROR;
-		}
-		buf = dyn_buf;
-	} else {
-		buf = static_buf;
-	}
-	buf[0] = cpu_to_le32(key_len);
-	if (put_entry(buf, sizeof(*buf), 1, fp) != 1 ||
-	    put_entry(key, 1, key_len, fp) != key_len) {
-		return POLICYDB_ERROR;
-	}
-	buf[0] = cpu_to_le32(scope->scope);
-	buf[1] = cpu_to_le32(scope->decl_ids_len);
-	for (i = 0; i < scope->decl_ids_len; i++) {
-		buf[2 + i] = cpu_to_le32(scope->decl_ids[i]);
-	}
-	if (put_entry(buf, sizeof(*buf), items, fp) != items) {
-		free(dyn_buf);
-		return POLICYDB_ERROR;
-	}
-	free(dyn_buf);
-	return POLICYDB_SUCCESS;
-}
-
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -1536,15 +1103,9 @@ int policydb_write(policydb_t * p, struc
 
 	/* Write the magic number and string identifiers. */
 	items = 0;
-	if (p->policy_type == POLICY_KERN) {
-		buf[items++] = cpu_to_le32(POLICYDB_MAGIC);
-		len = strlen(POLICYDB_STRING);
-		policydb_str = POLICYDB_STRING;
-	} else {
-		buf[items++] = cpu_to_le32(POLICYDB_MOD_MAGIC);
-		len = strlen(POLICYDB_MOD_STRING);
-		policydb_str = POLICYDB_MOD_STRING;
-	}
+	buf[items++] = cpu_to_le32(POLICYDB_MAGIC);
+	len = strlen(POLICYDB_STRING);
+	policydb_str = POLICYDB_STRING;
 	buf[items++] = cpu_to_le32(len);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
@@ -1555,16 +1116,13 @@ int policydb_write(policydb_t * p, struc
 
 	/* Write the version, config, and table sizes. */
 	items = 0;
-	info = policydb_lookup_compat(p->policyvers, p->policy_type);
+	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		ERR(fp->handle, "compatibility lookup failed for policy "
 		    "version %d", p->policyvers);
 		return POLICYDB_ERROR;
 	}
 
-	if (p->policy_type != POLICY_KERN) {
-		buf[items++] = cpu_to_le32(p->policy_type);
-	}
 	buf[items++] = cpu_to_le32(p->policyvers);
 	buf[items++] = cpu_to_le32(config);
 	buf[items++] = cpu_to_le32(info->sym_num);
@@ -1574,25 +1132,6 @@ int policydb_write(policydb_t * p, struc
 	if (items != items2)
 		return POLICYDB_ERROR;
 
-	if (p->policy_type == POLICY_MOD) {
-		/* Write module name and version */
-		len = strlen(p->name);
-		buf[0] = cpu_to_le32(len);
-		items = put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return POLICYDB_ERROR;
-		items = put_entry(p->name, 1, len, fp);
-		if (items != len)
-			return POLICYDB_ERROR;
-		len = strlen(p->version);
-		buf[0] = cpu_to_le32(len);
-		items = put_entry(buf, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return POLICYDB_ERROR;
-		items = put_entry(p->version, 1, len, fp);
-		if (items != len)
-			return POLICYDB_ERROR;
-	}
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
@@ -1604,52 +1143,33 @@ int policydb_write(policydb_t * p, struc
 			return POLICYDB_ERROR;
 	}
 
-	if (p->policy_type == POLICY_KERN) {
-		if (avtab_write(p, &p->te_avtab, fp))
-			return POLICYDB_ERROR;
-		if (p->policyvers < POLICYDB_VERSION_BOOL) {
-			if (p->p_bools.nprim)
-				WARN(fp->handle, "Discarding "
-				     "booleans and conditional rules");
-		} else {
-			if (cond_write_list(p, p->cond_list, fp))
-				return POLICYDB_ERROR;
-		}
-		if (role_trans_write(p->role_tr, fp))
-			return POLICYDB_ERROR;
-		if (role_allow_write(p->role_allow, fp))
-			return POLICYDB_ERROR;
+	if (avtab_write(p, &p->te_avtab, fp))
+		return POLICYDB_ERROR;
+	if (p->policyvers < POLICYDB_VERSION_BOOL) {
+		if (p->p_bools.nprim)
+			WARN(fp->handle, "Discarding "
+			     "booleans and conditional rules");
 	} else {
-		if (avrule_block_write(p->global, num_syms, p, fp) == -1) {
+		if (cond_write_list(p, p->cond_list, fp))
 			return POLICYDB_ERROR;
-		}
-
-		for (i = 0; i < num_syms; i++) {
-			buf[0] = cpu_to_le32(p->scope[i].table->nel);
-			if (put_entry(buf, sizeof(uint32_t), 1, fp) != 1) {
-				return POLICYDB_ERROR;
-			}
-			if (hashtab_map(p->scope[i].table, scope_write, &pd))
-				return POLICYDB_ERROR;
-		}
 	}
+	if (role_trans_write(p->role_tr, fp))
+		return POLICYDB_ERROR;
+	if (role_allow_write(p->role_allow, fp))
+		return POLICYDB_ERROR;
 
 	if (ocontext_write(info, p, fp) == -1 || genfs_write(p, fp) == -1) {
 		return POLICYDB_ERROR;
 	}
 
-	if ((p->policyvers >= POLICYDB_VERSION_MLS
-	     && p->policy_type == POLICY_KERN)
-	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS
-		&& p->policy_type == POLICY_BASE)) {
+	if ((p->policyvers >= POLICYDB_VERSION_MLS)
+	    ) {
 		if (range_write(p, fp)) {
 			return POLICYDB_ERROR;
 		}
 	}
 
-	if (p->policy_type == POLICY_KERN
-	    && p->policyvers >= POLICYDB_VERSION_AVTAB) {
+	if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
 		for (i = 0; i < p->p_types.nprim; i++) {
 			if (ebitmap_write(&p->type_attr_map[i], fp) == -1)
 				return POLICYDB_ERROR;
--- foo.orig/libsepol/include/sepol/policydb/avrule_block.h
+++ foo/libsepol/include/sepol/policydb/avrule_block.h
@@ -22,16 +22,6 @@
 
 #include <sepol/policydb/policydb.h>
 
-extern avrule_block_t *avrule_block_create(void);
-extern void avrule_block_destroy(avrule_block_t * x);
-extern avrule_decl_t *avrule_decl_create(uint32_t decl_id);
-extern void avrule_decl_destroy(avrule_decl_t * x);
-extern void avrule_block_list_destroy(avrule_block_t * x);
-extern avrule_decl_t *get_avrule_decl(policydb_t * p, uint32_t decl_id);
-extern cond_list_t *get_decl_cond_list(policydb_t * p,
-				       avrule_decl_t * decl,
-				       cond_list_t * cond);
-extern int is_id_enabled(char *id, policydb_t * p, int symbol_table);
 extern int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p);
 
 #endif
--- foo.orig/libsepol/include/sepol/policydb/conditional.h
+++ foo/libsepol/include/sepol/policydb/conditional.h
@@ -77,9 +77,6 @@ typedef struct cond_node {
 	/* these true/false lists point into te_avtab when that is used */
 	cond_av_list_t *true_list;
 	cond_av_list_t *false_list;
-	/* and these are using during parsing and for modules */
-	avrule_t *avtrue_list;
-	avrule_t *avfalse_list;
 	/* these fields are not written to binary policy */
 	unsigned int nbools;
 	uint32_t bool_ids[COND_MAX_BOOLS];
@@ -112,6 +109,9 @@ extern avtab_datum_t *cond_av_list_searc
 
 extern void cond_av_list_destroy(cond_av_list_t * list);
 
+extern int expand_cond_av_list(policydb_t *p, cond_av_list_t *l,
+		cond_av_list_t ** newl, avtab_t * expa);
+
 extern void cond_optimize_lists(cond_list_t * cl);
 
 extern int cond_policydb_init(policydb_t * p);
--- foo.orig/libsepol/include/sepol/policydb/constraint.h
+++ foo/libsepol/include/sepol/policydb/constraint.h
@@ -56,7 +56,7 @@ typedef struct constraint_expr {
 	uint32_t op;		/* operator */
 
 	ebitmap_t names;	/* names */
-	struct type_set *type_names;
+	ebitmap_t *type_names;
 
 	struct constraint_expr *next;	/* next expression */
 } constraint_expr_t;
--- foo.orig/libsepol/include/sepol/policydb/flask_types.h
+++ foo/libsepol/include/sepol/policydb/flask_types.h
@@ -46,7 +46,6 @@ typedef uint16_t sepol_security_class_t;
 #define SEPOL_SECCLASS_NULL			0x0000	/* no class */
 
 #define SELINUX_MAGIC 0xf97cff8c
-#define SELINUX_MOD_MAGIC 0xf97cff8d
 
 typedef uint32_t sepol_security_id_t;
 #define SEPOL_SECSID_NULL 0
--- foo.orig/libsepol/include/sepol/policydb.h
+++ foo/libsepol/include/sepol/policydb.h
@@ -56,11 +56,6 @@ extern void sepol_policy_file_set_handle
 extern int sepol_policydb_create(sepol_policydb_t ** p);
 extern void sepol_policydb_free(sepol_policydb_t * p);
 
-/* Legal types of policies that the policydb can represent. */
-#define SEPOL_POLICY_KERN	0
-#define SEPOL_POLICY_BASE	1
-#define SEPOL_POLICY_MOD	2
-
 /*
  * Range of policy versions for the kernel policy type supported
  * by this library.
@@ -74,7 +69,7 @@ extern int sepol_policy_kern_vers_max(vo
  * policy type.  
  * Returns -1 if the policy type is not legal.
  */
-extern int sepol_policydb_set_typevers(sepol_policydb_t * p, unsigned int type);
+extern int sepol_policydb_set_typevers(sepol_policydb_t * p);
 
 /*
  * Set the policy version to a different value.
--- foo.orig/libsepol/include/sepol/policydb/policydb.h
+++ foo/libsepol/include/sepol/policydb/policydb.h
@@ -76,21 +76,7 @@
  * users, roles, types, sensitivities, categories, etc.
  */
 
-/* type set preserves data needed by modules such as *, ~ and attributes */
-typedef struct type_set {
-	ebitmap_t types;
-	ebitmap_t negset;
-#define TYPE_STAR 1
-#define TYPE_COMP 2
-	uint32_t flags;
-} type_set_t;
-
-typedef struct role_set {
-	ebitmap_t roles;
-#define ROLE_STAR 1
-#define ROLE_COMP 2
-	uint32_t flags;
-} role_set_t;
+
 
 /* Permission attributes */
 typedef struct perm_datum {
@@ -117,7 +103,7 @@ typedef struct class_datum {
 typedef struct role_datum {
 	symtab_datum_t s;
 	ebitmap_t dominates;	/* set of roles dominated by this role */
-	type_set_t types;	/* set of authorized types for role */
+	ebitmap_t types;	/* set of authorized types for role */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
 } role_datum_t;
 
@@ -148,7 +134,7 @@ typedef struct type_datum {
 /* User attributes */
 typedef struct user_datum {
 	symtab_datum_t s;
-	role_set_t roles;	/* set of authorized roles for user */
+	ebitmap_t roles;  /* set of authorized roles for user */
 	mls_semantic_range_t range;	/* MLS range (min. - max.) for user */
 	mls_semantic_level_t dfltlevel;	/* default login MLS level for user */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
@@ -188,57 +174,6 @@ struct cond_node;
 typedef struct cond_node cond_list_t;
 struct cond_av_list;
 
-typedef struct class_perm_node {
-	uint32_t class;
-	uint32_t data;		/* permissions or new type */
-	struct class_perm_node *next;
-} class_perm_node_t;
-
-typedef struct avrule {
-/* these typedefs are almost exactly the same as those in avtab.h - they are
- * here because of the need to include neverallow and dontaudit messages */
-#define AVRULE_ALLOWED     1
-#define AVRULE_AUDITALLOW  2
-#define AVRULE_AUDITDENY   4
-#define AVRULE_DONTAUDIT   8
-#define AVRULE_NEVERALLOW 128
-#define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
-#define AVRULE_TRANSITION 16
-#define AVRULE_MEMBER     32
-#define AVRULE_CHANGE     64
-#define AVRULE_TYPE       (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
-	uint32_t specified;
-#define RULE_SELF 1
-	uint32_t flags;
-	type_set_t stypes;
-	type_set_t ttypes;
-	class_perm_node_t *perms;
-	unsigned long line;	/* line number from policy.conf where
-				 * this rule originated  */
-	struct avrule *next;
-} avrule_t;
-
-typedef struct role_trans_rule {
-	role_set_t roles;	/* current role */
-	type_set_t types;	/* program executable type */
-	uint32_t new_role;	/* new role */
-	struct role_trans_rule *next;
-} role_trans_rule_t;
-
-typedef struct role_allow_rule {
-	role_set_t roles;	/* current role */
-	role_set_t new_roles;	/* new roles */
-	struct role_allow_rule *next;
-} role_allow_rule_t;
-
-typedef struct range_trans_rule {
-	type_set_t stypes;
-	type_set_t ttypes;
-	ebitmap_t tclasses;
-	mls_semantic_range_t trange;
-	struct range_trans_rule *next;
-} range_trans_rule_t;
-
 /*
  * The configuration data includes security contexts for 
  * initial SIDs, unlabeled file systems, TCP and UDP port numbers, 
@@ -301,92 +236,12 @@ typedef struct genfs {
 
 /* section: module information */
 
-/* scope_index_t holds all of the symbols that are in scope in a
- * particular situation.  The bitmaps are indices (and thus must
- * subtract one) into the global policydb->scope array. */
-typedef struct scope_index {
-	ebitmap_t scope[SYM_NUM];
-#define p_classes_scope scope[SYM_CLASSES]
-#define p_roles_scope scope[SYM_ROLES]
-#define p_types_scope scope[SYM_TYPES]
-#define p_users_scope scope[SYM_USERS]
-#define p_bools_scope scope[SYM_BOOLS]
-#define p_sens_scope scope[SYM_LEVELS]
-#define p_cat_scope scope[SYM_CATS]
-
-	/* this array maps from class->value to the permissions within
-	 * scope.  if bit (perm->value - 1) is set in map
-	 * class_perms_map[class->value - 1] then that permission is
-	 * enabled for this class within this decl.  */
-	ebitmap_t *class_perms_map;
-	/* total number of classes in class_perms_map array */
-	uint32_t class_perms_len;
-} scope_index_t;
-
-/* a list of declarations for a particular avrule_decl */
-
-/* These two structs declare a block of policy that has TE and RBAC
- * statements and declarations.  The root block (the global policy)
- * can never have an ELSE branch. */
-typedef struct avrule_decl {
-	uint32_t decl_id;
-	uint32_t enabled;	/* whether this block is enabled */
 
-	cond_list_t *cond_list;
-	avrule_t *avrules;
-	role_trans_rule_t *role_tr_rules;
-	role_allow_rule_t *role_allow_rules;
-	range_trans_rule_t *range_tr_rules;
-	scope_index_t required;	/* symbols needed to activate this block */
-	scope_index_t declared;	/* symbols declared within this block */
 
-	/* for additive statements (type attribute, roles, and users) */
-	symtab_t symtab[SYM_NUM];
 
-	/* In a linked module this will contain the name of the module
-	 * from which this avrule_decl originated. */
-	char *module_name;
-
-	struct avrule_decl *next;
-} avrule_decl_t;
-
-typedef struct avrule_block {
-	avrule_decl_t *branch_list;
-	avrule_decl_t *enabled;	/* pointer to which branch is enabled.  this is
-				   used in linking and never written to disk */
-#define AVRULE_OPTIONAL 1
-	uint32_t flags;		/* any flags for this block, currently just optional */
-	struct avrule_block *next;
-} avrule_block_t;
-
-/* Every identifier has its own scope datum.  The datum describes if
- * the item is to be included into the final policy during
- * expansion. */
-typedef struct scope_datum {
-/* Required for this decl */
-#define SCOPE_REQ  1
-/* Declared in this decl */
-#define SCOPE_DECL 2
-	uint32_t scope;
-	uint32_t *decl_ids;
-	uint32_t decl_ids_len;
-	/* decl_ids is a list of avrule_decl's that declare/require
-	 * this symbol.  If scope==SCOPE_DECL then this is a list of
-	 * declarations.  If the symbol may only be declared once
-	 * (types, bools) then decl_ids_len will be exactly 1.  For
-	 * implicitly declared things (roles, users) then decl_ids_len
-	 * will be at least 1. */
-} scope_datum_t;
 
 /* The policy database */
 typedef struct policydb {
-#define POLICY_KERN SEPOL_POLICY_KERN
-#define POLICY_BASE SEPOL_POLICY_BASE
-#define POLICY_MOD SEPOL_POLICY_MOD
-	uint32_t policy_type;
-	char *name;
-	char *version;
-
 	/* Set when the policydb is modified such that writing is unsupported */
 	int unsupported_format;
 
@@ -421,19 +276,6 @@ typedef struct policydb {
 	user_datum_t **user_val_to_struct;
 	type_datum_t **type_val_to_struct;
 
-	/* module stuff section -- used in parsing and for modules */
-
-	/* keep track of the scope for every identifier.  these are
-	 * hash tables, where the key is the identifier name and value
-	 * a scope_datum_t.  as a convenience, one may use the
-	 * p_*_macros (cf. struct scope_index_t declaration). */
-	symtab_t scope[SYM_NUM];
-
-	/* module rule storage */
-	avrule_block_t *global;
-	/* avrule_decl index used for link/expand */
-	avrule_decl_t **decl_val_to_struct;
-
 	/* compiled storage of rules - use for the kernel policy */
 
 	/* type enforcement access vectors and transitions */
@@ -502,32 +344,12 @@ extern int policydb_context_isvalid(cons
 				    const context_struct_t * c);
 
 extern void symtabs_destroy(symtab_t * symtab);
-extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
 typedef void (*hashtab_destroy_func_t) (hashtab_key_t k, hashtab_datum_t d,
 					void *args);
 extern hashtab_destroy_func_t get_symtab_destroy_func(int sym_num);
 
-extern void class_perm_node_init(class_perm_node_t * x);
-extern void type_set_init(type_set_t * x);
-extern void type_set_destroy(type_set_t * x);
-extern int type_set_cpy(type_set_t * dst, type_set_t * src);
-extern int type_set_or_eq(type_set_t * dst, type_set_t * other);
-extern void role_set_init(role_set_t * x);
-extern void role_set_destroy(role_set_t * x);
-extern void avrule_init(avrule_t * x);
-extern void avrule_destroy(avrule_t * x);
-extern void avrule_list_destroy(avrule_t * x);
-extern void role_trans_rule_init(role_trans_rule_t * x);
-extern void role_trans_rule_list_destroy(role_trans_rule_t * x);
-
 extern void role_datum_init(role_datum_t * x);
 extern void role_datum_destroy(role_datum_t * x);
-extern void role_allow_rule_init(role_allow_rule_t * x);
-extern void role_allow_rule_destroy(role_allow_rule_t * x);
-extern void role_allow_rule_list_destroy(role_allow_rule_t * x);
-extern void range_trans_rule_init(range_trans_rule_t *x);
-extern void range_trans_rule_destroy(range_trans_rule_t *x);
-extern void range_trans_rule_list_destroy(range_trans_rule_t *x);
 extern void type_datum_init(type_datum_t * x);
 extern void type_datum_destroy(type_datum_t * x);
 extern void user_datum_init(user_datum_t * x);
@@ -537,12 +359,9 @@ extern void level_datum_destroy(level_da
 extern void cat_datum_init(cat_datum_t * x);
 extern void cat_datum_destroy(cat_datum_t * x);
 
-extern int check_assertions(sepol_handle_t * handle,
-			    policydb_t * p, avrule_t * avrules);
-
 extern int symtab_insert(policydb_t * x, uint32_t sym,
 			 hashtab_key_t key, hashtab_datum_t datum,
-			 uint32_t scope, uint32_t avrule_decl_id,
+			 uint32_t avrule_decl_id,
 			 uint32_t * value);
 
 /* A policy "file" may be a memory region referenced by a (data, len) pair
@@ -566,11 +385,11 @@ struct sepol_policy_file {
 
 extern int policydb_read(policydb_t * p, struct policy_file *fp,
 			 unsigned int verbose);
-extern int avrule_read_list(policydb_t * p, avrule_t ** avrules,
-			    struct policy_file *fp);
 
 extern int policydb_write(struct policydb *p, struct policy_file *pf);
 
+extern int expand_avtab(policydb_t *p, avtab_t *a, avtab_t *expa);
+
 #define PERM_SYMTAB_SIZE 32
 
 /* Identify specific policy version changes */
@@ -587,16 +406,6 @@ extern int policydb_write(struct policyd
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
 
-/* Module versions and specific changes*/
-#define MOD_POLICYDB_VERSION_BASE	   4
-#define MOD_POLICYDB_VERSION_VALIDATETRANS 5
-#define MOD_POLICYDB_VERSION_MLS	   5
-#define MOD_POLICYDB_VERSION_RANGETRANS	   6
-#define MOD_POLICYDB_VERSION_MLS_USERS	   6
-
-#define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_MLS_USERS
-
 #define POLICYDB_CONFIG_MLS    1
 
 #define OBJECT_R "object_r"
@@ -604,8 +413,6 @@ extern int policydb_write(struct policyd
 
 #define POLICYDB_MAGIC SELINUX_MAGIC
 #define POLICYDB_STRING "SE Linux"
-#define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
-#define POLICYDB_MOD_STRING "SE Linux Module"
 
 #endif				/* _POLICYDB_H_ */
 
--- foo.orig/libsepol/include/sepol/users.h
+++ foo/libsepol/include/sepol/users.h
@@ -23,12 +23,6 @@ extern void sepol_set_delusers(int on);
 
 /*--------end compatibility----------*/
 
-/* Modify the user, or add it, if the key is not found */
-extern int sepol_user_modify(sepol_handle_t * handle,
-			     sepol_policydb_t * policydb,
-			     const sepol_user_key_t * key,
-			     const sepol_user_t * data);
-
 /* Return the number of users */
 extern int sepol_user_count(sepol_handle_t * handle,
 			    const sepol_policydb_t * p, unsigned int *response);
--- foo.orig/libsepol/src/private.h
+++ foo/libsepol/src/private.h
@@ -29,14 +29,13 @@
 
 /* Policy compatibility information. */
 struct policydb_compat_info {
-	unsigned int type;
 	unsigned int version;
 	unsigned int sym_num;
 	unsigned int ocon_num;
 };
 
-extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
-							   unsigned int type);
+extern struct policydb_compat_info *policydb_lookup_compat(unsigned int
+							   version);
 
 /* Reading from a policy "file". */
 static inline void *next_entry(struct policy_file *fp, size_t bytes)
--- foo.orig/libsepol/src/libsepol.map
+++ foo/libsepol/src/libsepol.map
@@ -1,6 +1,6 @@
 {
   global: 
-	sepol_module_package_*; sepol_link_modules; sepol_expand_module; sepol_link_packages;
+	sepol_module_package_*; sepol_link_packages;
 	sepol_bool_*; sepol_genbools*; 
 	sepol_context_*; sepol_mls_*; sepol_check_context;
 	sepol_iface_*; 
@@ -12,5 +12,7 @@
 	sepol_policydb_*; sepol_set_policydb_from_file; 
 	sepol_policy_kern_*;
 	sepol_policy_file_*;
+	expand_avtab;
+	expand_cond_av_list;
   local: *;
 };

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
