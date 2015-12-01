Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB1FdNK1000769
 for <selinux@tycho.nsa.gov>; Tue, 1 Dec 2015 10:39:24 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] libsepol/cil: Add support for neverallowx
Date: Tue, 1 Dec 2015 10:38:29 -0500
Message-ID: <1448984310-17097-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a new statement, neverallowx, which has the same syntax as allowx:

  (neverallowx foo bar (ioctl file (0x2000 20FF)))
  (allowx foo bar (ioctl file (0x20A0))) ; this fails

Much of the changes just move functions around or split functions up to
ease the sharing of avrule and avrulex comparisons with neverallows.
This refactoring also modifies the avrule struct to include a union of
either class permission information for standard avrules or extended
permission information for extended avrules, also done to support
sharing code.

This also changes assertion.c and avtab.c to allow
check_assertion_avtab_match to work with extended avrules.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsepol/cil/src/cil.c             |  25 +-
 libsepol/cil/src/cil_binary.c      | 603 +++++++++++++++++++++++++------------
 libsepol/cil/src/cil_build_ast.c   |  40 ++-
 libsepol/cil/src/cil_build_ast.h   |   1 -
 libsepol/cil/src/cil_copy_ast.c    |  55 ++--
 libsepol/cil/src/cil_find.c        |  95 +++++-
 libsepol/cil/src/cil_find.h        |   1 +
 libsepol/cil/src/cil_internal.h    |  23 +-
 libsepol/cil/src/cil_list.c        |  16 +
 libsepol/cil/src/cil_list.h        |   1 +
 libsepol/cil/src/cil_mem.c         |  17 ++
 libsepol/cil/src/cil_mem.h         |   1 +
 libsepol/cil/src/cil_policy.c      |   2 +-
 libsepol/cil/src/cil_post.c        |   8 +-
 libsepol/cil/src/cil_reset_ast.c   |   2 +-
 libsepol/cil/src/cil_resolve_ast.c | 102 ++-----
 libsepol/cil/src/cil_tree.c        |   2 +-
 libsepol/src/assertion.c           |   2 +-
 libsepol/src/avtab.c               |   5 +
 19 files changed, 632 insertions(+), 369 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index e6e553b..afdc240 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -228,6 +228,7 @@ static void cil_init_keys(void)
 	CIL_KEY_ALLOWX = cil_strpool_add("allowx");
 	CIL_KEY_AUDITALLOWX = cil_strpool_add("auditallowx");
 	CIL_KEY_DONTAUDITX = cil_strpool_add("dontauditx");
+	CIL_KEY_NEVERALLOWX = cil_strpool_add("neverallowx");
 	CIL_KEY_PERMISSIONX = cil_strpool_add("permissionx");
 	CIL_KEY_IOCTL = cil_strpool_add("ioctl");
 	CIL_KEY_UNORDERED = cil_strpool_add("unordered");
@@ -668,11 +669,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 		cil_destroy_roleallow(*data);
 		break;
 	case CIL_AVRULE:
+	case CIL_AVRULEX:
 		cil_destroy_avrule(*data);
 		break;
-	case CIL_AVRULEX:
-		cil_destroy_avrulex(*data);
-		break;
 	case CIL_PERMISSIONX:
 		cil_destroy_permissionx(*data);
 		break;
@@ -1026,13 +1025,15 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		}
 		break;
 	case CIL_AVRULEX:
-		switch (((struct cil_avrulex *)node->data)->rule_kind) {
+		switch (((struct cil_avrule *)node->data)->rule_kind) {
 		case CIL_AVRULE_ALLOWED:
 			return CIL_KEY_ALLOWX;
 		case CIL_AVRULE_AUDITALLOW:
 			return CIL_KEY_AUDITALLOWX;
 		case CIL_AVRULE_DONTAUDIT:
 			return CIL_KEY_DONTAUDITX;
+		case CIL_AVRULE_NEVERALLOW:
+			return CIL_KEY_NEVERALLOWX;
 		default:
 			break;
 		}
@@ -2116,12 +2117,13 @@ void cil_avrule_init(struct cil_avrule **avrule)
 {
 	*avrule = cil_malloc(sizeof(**avrule));
 
+	(*avrule)->is_extended = 0;
 	(*avrule)->rule_kind = CIL_NONE;
 	(*avrule)->src_str = NULL;
 	(*avrule)->src = NULL;
 	(*avrule)->tgt_str = NULL;
 	(*avrule)->tgt = NULL;
-	(*avrule)->classperms = NULL;
+	memset(&((*avrule)->perms), 0, sizeof((*avrule)->perms));
 }
 
 void cil_permissionx_init(struct cil_permissionx **permx)
@@ -2136,19 +2138,6 @@ void cil_permissionx_init(struct cil_permissionx **permx)
 	(*permx)->perms = NULL;
 }
 
-void cil_avrulex_init(struct cil_avrulex **avrule)
-{
-	*avrule = cil_malloc(sizeof(**avrule));
-
-	(*avrule)->rule_kind = CIL_NONE;
-	(*avrule)->src_str = NULL;
-	(*avrule)->src = NULL;
-	(*avrule)->tgt_str = NULL;
-	(*avrule)->tgt = NULL;
-	(*avrule)->permx_str = NULL;
-	(*avrule)->permx = NULL;
-}
-
 void cil_type_rule_init(struct cil_type_rule **type_rule)
 {
 	*type_rule = cil_malloc(sizeof(**type_rule));
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index db09ec5..42afab3 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -238,55 +238,6 @@ static ocontext_t *cil_add_ocontext(ocontext_t **head, ocontext_t **tail)
 	return new;
 }
 
-static void __add_classes_from_classperms_list(struct cil_list *classperms, struct cil_list *class_list)
-{
-	struct cil_list_item *curr;
-
-	cil_list_for_each(curr, classperms) {
-		if (curr->flavor == CIL_CLASSPERMS) {
-			struct cil_classperms *cp = curr->data;
-			if (FLAVOR(cp->class) == CIL_CLASS) {
-				cil_list_append(class_list, CIL_CLASS, cp->class);
-			} else { /* MAP */
-				struct cil_list_item *i = NULL;
-				cil_list_for_each(i, cp->perms) {
-					struct cil_perm *cmp = i->data;
-					__add_classes_from_classperms_list(cmp->classperms, class_list);
-				}
-			}	
-		} else { /* SET */
-			struct cil_classperms_set *cp_set = curr->data;
-			struct cil_classpermission *cp = cp_set->set;
-			__add_classes_from_classperms_list(cp->classperms, class_list);
-		}
-	}
-}
-
-static int __add_classes_from_map_perms(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
-{
-	struct cil_list *class_list = args;
-	struct cil_perm *cmp = (struct cil_perm *)d;
-
-	__add_classes_from_classperms_list(cmp->classperms, class_list);
-
-	return SEPOL_OK;
-}
-
-static struct cil_list *cil_expand_class(struct cil_class *class)
-{
-	struct cil_list *class_list;
-
-	cil_list_init(&class_list, CIL_CLASS);
-
-	if (FLAVOR(class) == CIL_CLASS) {
-		cil_list_append(class_list, CIL_CLASS, class);
-	} else { /* MAP */
-		cil_symtab_map(&class->perms, __add_classes_from_map_perms, class_list);
-	}
-
-	return class_list;
-}
-
 int cil_common_to_policydb(policydb_t *pdb, struct cil_class *cil_common, common_datum_t **common_out)
 {
 	int rc = SEPOL_ERR;
@@ -1267,6 +1218,30 @@ int cil_typetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, str
 	return  __cil_typetransition_to_avtab(pdb, db, typetrans, NULL, CIL_FALSE, filename_trans_table);
 }
 
+int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint32_t *datum)
+{
+	int rc;
+	perm_datum_t *sepol_perm;
+	common_datum_t *sepol_common;
+
+	sepol_perm = hashtab_search(sepol_class->permissions.table, perm_str);
+	if (sepol_perm == NULL) {
+		sepol_common = sepol_class->comdatum;
+		sepol_perm = hashtab_search(sepol_common->permissions.table, perm_str);
+		if (sepol_perm == NULL) {
+			cil_log(CIL_ERR, "Failed to find datum for perm %s\n", perm_str);
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+	}
+	*datum |= 1 << (sepol_perm->s.value - 1);
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int __cil_perms_to_datum(struct cil_list *perms, class_datum_t *sepol_class, uint32_t *datum)
 {
 	int rc = SEPOL_ERR;
@@ -1276,20 +1251,13 @@ int __cil_perms_to_datum(struct cil_list *perms, class_datum_t *sepol_class, uin
 	uint32_t data = 0;
 
 	cil_list_for_each(curr_perm, perms) {
-		perm_datum_t *sepol_perm;
 		cil_perm = curr_perm->data;
 		key = cil_perm->datum.fqn;
-		sepol_perm = hashtab_search(sepol_class->permissions.table, key);
-		if (sepol_perm == NULL) {
-			common_datum_t *sepol_common = sepol_class->comdatum;
-			sepol_perm = hashtab_search(sepol_common->permissions.table, key);
-			if (sepol_perm == NULL) {
-				cil_log(CIL_ERR, "Failed to find datum for perm %s\n", key);
-				rc = SEPOL_ERR;
-				goto exit;
-			}
+
+		rc = __perm_str_to_datum(key, sepol_class, &data);
+		if (rc != SEPOL_OK) {
+			goto exit;
 		}
-		data |= 1 << (sepol_perm->s.value - 1);
 	}
 
 	*datum = data;
@@ -1433,7 +1401,7 @@ int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct cil_a
 	uint16_t kind = cil_avrule->rule_kind;
 	struct cil_symtab_datum *src = NULL;
 	struct cil_symtab_datum *tgt = NULL;
-	struct cil_list *classperms = cil_avrule->classperms;
+	struct cil_list *classperms = cil_avrule->perms.classperms;
 
 	if (cil_avrule->rule_kind == CIL_AVRULE_DONTAUDIT && db->disable_dontaudit == CIL_TRUE) {
 		// Do not add dontaudit rules to binary
@@ -1514,13 +1482,8 @@ void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, struct avtab_exten
 #define IOC_DRIV(x) (x >> 8)
 #define IOC_FUNC(x) (x & 0xff)
 
-int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
+int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct cil_list **xperms_list)
 {
-	int rc = SEPOL_OK;
-	struct policydb *pdb;
-	avtab_key_t *avtab_key;
-	avtab_datum_t avtab_datum;
-	ebitmap_t *xperms;
 	ebitmap_node_t *node;
 	unsigned int i;
 	uint16_t low = 0, high = 0;
@@ -1528,11 +1491,7 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
 	struct avtab_extended_perms *complete = NULL;
 	int start_new_range;
 
-	avtab_key = (avtab_key_t *)k;
-	xperms = datum;
-	pdb = args;
-
-	avtab_datum.data = 0;
+	cil_list_init(xperms_list, CIL_NONE);
 
 	start_new_range = 1;
 
@@ -1565,12 +1524,7 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
 			__avrule_xperm_setrangebits(IOC_DRIV(low), IOC_DRIV(low), complete);
 		} else {
 			if (partial && partial->driver != IOC_DRIV(low)) {
-				avtab_datum.xperms = partial;
-				rc = avtab_insert(&pdb->te_avtab, avtab_key, &avtab_datum);
-				if (rc != SEPOL_OK) {
-					goto exit;
-				}
-				free(partial);
+				cil_list_append(*xperms_list, CIL_NONE, partial);
 				partial = NULL;
 			}
 
@@ -1585,15 +1539,48 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
 	}
 
 	if (partial) {
-		avtab_datum.xperms = partial;
-		rc = avtab_insert(&pdb->te_avtab, avtab_key, &avtab_datum);
-		if (rc != SEPOL_OK) {
-			goto exit;
-		}
+		cil_list_append(*xperms_list, CIL_NONE, partial);
 	}
 
 	if (complete) {
-		avtab_datum.xperms = complete;
+		cil_list_append(*xperms_list, CIL_NONE, complete);
+	}
+
+	return SEPOL_OK;
+}
+
+int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void *args)
+{
+	int rc = SEPOL_OK;
+	struct policydb *pdb;
+	avtab_key_t *avtab_key;
+	avtab_datum_t avtab_datum;
+	struct cil_list *xperms_list = NULL;
+	struct cil_list_item *item;
+	class_datum_t *sepol_obj;
+	uint32_t data = 0;
+
+	avtab_key = (avtab_key_t *)k;
+	pdb = args;
+
+	sepol_obj = pdb->class_val_to_struct[avtab_key->target_class - 1];
+
+	// setting the data for an extended avtab isn't really neccessary because
+	// it is ignored by the kernel. However, neverallow checking requires that
+	// the data value be set, so set it for that to work.
+	rc = __perm_str_to_datum(CIL_KEY_IOCTL, sepol_obj, &data);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	avtab_datum.data = data;
+
+	rc = __cil_permx_bitmap_to_sepol_xperms_list(datum, &xperms_list);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_list_for_each(item, xperms_list) {
+		avtab_datum.xperms = item->data;
 		rc = avtab_insert(&pdb->te_avtab, avtab_key, &avtab_datum);
 		if (rc != SEPOL_OK) {
 			goto exit;
@@ -1603,15 +1590,19 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
 	rc = SEPOL_OK;
 
 exit:
-	free(partial);
-	free(complete);
+	if (xperms_list != NULL) {
+		cil_list_for_each(item, xperms_list) {
+			free(item->data);
+		}
+		cil_list_destroy(&xperms_list, CIL_FALSE);
+	}
 
 	// hashtab_t does not have a way to free keys or datum since it doesn't
 	// know what they are. We won't need the keys/datum after this function, so
 	// clean them up here.
 	free(avtab_key);
-	ebitmap_destroy(xperms);
-	free(xperms);
+	ebitmap_destroy(datum);
+	free(datum);
 
 	return rc;
 }
@@ -1711,7 +1702,7 @@ exit:
 	return rc;
 }
 
-int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct cil_avrulex *cil_avrulex, struct cil_args_binary *args)
+int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct cil_avrule *cil_avrulex, struct cil_args_binary *args)
 {
 	int rc = SEPOL_ERR;
 	uint16_t kind;
@@ -1741,13 +1732,13 @@ int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, struct ci
 			if (!ebitmap_get_bit(&type_bitmap, i)) continue;
 
 			src = DATUM(db->val_to_type[i]);
-			rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, cil_avrulex->permx, args);
+			rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, src, cil_avrulex->perms.x.permx, args);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
 		}
 	} else {
-		rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->permx, args);
+		rc = __cil_avrulex_to_hashtable_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
 		if (rc != SEPOL_OK) goto exit;
 	}
 
@@ -1820,6 +1811,89 @@ exit:
 	return SEPOL_ERR;
 }
 
+static void __cil_expr_to_string(struct cil_list *expr, enum cil_flavor flavor, char **out);
+
+static void __cil_expr_to_string_helper(struct cil_list_item *curr, enum cil_flavor flavor, char **out)
+{
+	char *c;
+
+	if (curr->flavor == CIL_DATUM) {
+		*out = cil_strdup(DATUM(curr->data)->fqn);
+	} else if (curr->flavor == CIL_LIST) {
+		__cil_expr_to_string(curr->data, flavor, &c);
+		cil_asprintf(out, "(%s)", c);
+		free(c);
+	} else if (flavor == CIL_PERMISSIONX) {
+		// permissionx expressions aren't resolved into anything, so curr->flavor
+		// is just a CIL_STRING, not a CIL_DATUM, so just check on flavor for those
+		*out = cil_strdup(curr->data);
+	}
+}
+
+static void __cil_expr_to_string(struct cil_list *expr, enum cil_flavor flavor, char **out)
+{
+	struct cil_list_item *curr;
+	char *s1 = NULL;
+	char *s2 = NULL;
+	enum cil_flavor op;
+
+	if (expr == NULL || expr->head == NULL) {
+		*out = cil_strdup("");
+		return;
+	}
+
+	curr = expr->head;
+
+	if (curr->flavor == CIL_OP) {
+		op = (enum cil_flavor)curr->data;
+
+		if (op == CIL_ALL) {
+			*out = cil_strdup(CIL_KEY_ALL);
+		} else if (op == CIL_RANGE) {
+			__cil_expr_to_string_helper(curr->next, flavor, &s1);
+			__cil_expr_to_string_helper(curr->next->next, flavor, &s2);
+			cil_asprintf(out, "%s %s %s", CIL_KEY_RANGE, s1, s2);
+			free(s1);
+			free(s2);
+		} else {
+			__cil_expr_to_string_helper(curr->next, flavor, &s1);
+
+			if (op == CIL_NOT) {
+				cil_asprintf(out, "%s %s", CIL_KEY_NOT, s1);
+				free(s1);
+			} else {
+				char *opstr = "";
+
+				__cil_expr_to_string_helper(curr->next->next, flavor, &s2);
+
+				if (op == CIL_OR) {
+					opstr = CIL_KEY_OR;
+				} else if (op == CIL_AND) {
+					opstr = CIL_KEY_AND;
+				} else if (op == CIL_XOR) {
+					opstr = CIL_KEY_XOR;
+				}
+
+				cil_asprintf(out, "%s %s %s", opstr, s1, s2);
+				free(s1);
+				free(s2);
+			}
+		}
+	} else {
+		char *c1 = NULL;
+		char *c2 = NULL;
+		__cil_expr_to_string_helper(curr, flavor, &c1);
+		for (curr = curr->next; curr; curr = curr->next) {
+			__cil_expr_to_string_helper(curr, flavor, &s1);
+			cil_asprintf(&c2, "%s %s", c1, s1);
+			free(c1);
+			free(s1);
+			c1 = c2;
+		}
+		*out = c1;
+	}
+}
+
 static int __cil_cond_expr_to_sepol_expr_helper(policydb_t *pdb, struct cil_list *cil_expr, cond_expr_t **head, cond_expr_t **tail);
 
 static int __cil_cond_item_to_sepol_expr(policydb_t *pdb, struct cil_list_item *item, cond_expr_t **head, cond_expr_t **tail)
@@ -3427,7 +3501,8 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 		case CIL_TYPE_RULE:
 			rc = cil_type_rule_to_policydb(pdb, db, node->data);
 			break;
-		case CIL_AVRULE: {
+		case CIL_AVRULE:
+		case CIL_AVRULEX: {
 			struct cil_avrule *rule = node->data;
 			if (db->disable_neverallow != CIL_TRUE && rule->rule_kind == CIL_AVRULE_NEVERALLOW) {
 				struct cil_list *neverallows = args->neverallows;
@@ -3489,8 +3564,12 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
 				}
 			}
 			break;
-		case CIL_AVRULEX:
-			rc = cil_avrulex_to_hashtable(pdb, db, node->data, args);
+		case CIL_AVRULEX: {
+				struct cil_avrule *rule = node->data;
+				if (rule->rule_kind != CIL_AVRULE_NEVERALLOW) {
+					rc = cil_avrulex_to_hashtable(pdb, db, node->data, args);
+				}
+			}
 			break;
 		case CIL_ROLEALLOW:
 			rc = cil_roleallow_to_policydb(pdb, db, node->data);
@@ -4064,6 +4143,51 @@ exit:
 	return rc;
 }
 
+static int __cil_permx_to_sepol_class_perms(policydb_t *pdb, struct cil_permissionx *permx, class_perm_node_t **sepol_class_perms)
+{
+	int rc;
+	struct cil_list *class_list = NULL;
+	struct cil_list_item *c;
+	class_datum_t *sepol_obj = NULL;
+	class_perm_node_t *cpn;
+	uint32_t data = 0;
+	char *perm_str = NULL;
+
+	class_list = cil_expand_class(permx->obj);
+
+	cil_list_for_each(c, class_list) {
+		rc = __cil_get_sepol_class_datum(pdb, DATUM(c->data), &sepol_obj);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		switch (permx->kind) {
+			case CIL_PERMX_KIND_IOCTL:
+				perm_str = CIL_KEY_IOCTL;
+				break;
+			default:
+				rc = SEPOL_ERR;
+				goto exit;
+		}
+
+		rc = __perm_str_to_datum(perm_str, sepol_obj, &data);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		cpn = cil_malloc(sizeof(*cpn));
+		cpn->tclass = sepol_obj->s.value;
+		cpn->data = data;
+		cpn->next = *sepol_class_perms;
+		*sepol_class_perms = cpn;
+	}
+
+exit:
+	cil_list_destroy(&class_list, CIL_FALSE);
+
+	return rc;
+}
+
 static void __cil_init_sepol_type_set(type_set_t *t)
 {
 	ebitmap_init(&t->types);
@@ -4133,62 +4257,6 @@ static void __cil_destroy_sepol_avrules(avrule_t *curr)
 	}
 }
 
-static int __cil_rule_to_expanded_sepol_avrule(const struct cil_db *db, policydb_t *pdb, struct cil_tree_node *node, avrule_t **avrule)
-{
-	int rc = SEPOL_ERR;
-	struct cil_avrule *cil_rule = node->data;
-	struct cil_symtab_datum *tgt = cil_rule->tgt;
-	uint32_t kind;
-	avrule_t *rule;
-
-	*avrule = NULL;
-
-	switch (cil_rule->rule_kind) {
-	case CIL_AVRULE_AUDITALLOW:
-		kind = AVRULE_AUDITALLOW;
-		break;
-	case CIL_AVRULE_DONTAUDIT:
-		kind = AVRULE_AUDITDENY;
-		break;
-	case CIL_AVRULE_NEVERALLOW:
-		kind = AVRULE_NEVERALLOW;
-		break;
-	default:
-		kind = AVRULE_ALLOWED;
-		break;
-	}
-
-	rule = __cil_init_sepol_avrule(kind, node);
-
-	rc = __cil_rule_to_sepol_class_perms(pdb, cil_rule->classperms, &rule->perms);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	rc = __cil_add_sepol_type(pdb, db, cil_rule->src, &rule->stypes.types);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	if (tgt->fqn == CIL_KEY_SELF) {
-		rule->flags = RULE_SELF;
-	} else {
-		rc = __cil_add_sepol_type(pdb, db, cil_rule->tgt, &rule->ttypes.types);
-		if (rc != SEPOL_OK) {
-			goto exit;
-		}
-	}
-
-	rule->next = NULL;
-	*avrule = rule;
-
-	return SEPOL_OK;
-
-exit:
-	__cil_destroy_sepol_avrules(rule);
-	return rc;
-}
-
 static void __cil_print_parents(const char *pad, struct cil_tree_node *n)
 {
 	if (!n) return;
@@ -4202,14 +4270,10 @@ static void __cil_print_parents(const char *pad, struct cil_tree_node *n)
 	}
 }
 
-static void __cil_print_rule(const char *pad, const char *kind, struct cil_avrule *avrule)
+static void __cil_print_classperm(struct cil_list *cp_list)
 {
-	struct cil_list *cp_list = avrule->classperms;
 	struct cil_list_item *i1, *i2;
 
-	cil_log(CIL_ERR,"%s(%s ", pad, kind);
-	cil_log(CIL_ERR,"%s %s ", DATUM(avrule->src)->fqn, DATUM(avrule->tgt)->fqn);
-
 	i1 = cp_list->head;
 	if (i1->flavor == CIL_CLASSPERMS) {
 		struct cil_classperms *cp = i1->data;
@@ -4226,63 +4290,210 @@ static void __cil_print_rule(const char *pad, const char *kind, struct cil_avrul
 		struct cil_classperms_set *cp_set = i1->data;
 		cil_log(CIL_ERR,"%s", DATUM(cp_set->set)->fqn);
 	}
+}
+
+static void __cil_print_permissionx(struct cil_permissionx *px)
+{
+	char *kind_str = "";
+	char *expr_str;
+
+	switch (px->kind) {
+		case CIL_PERMX_KIND_IOCTL:
+			kind_str = CIL_KEY_IOCTL;
+			break;
+		default:
+			kind_str = "unknown";
+			break;
+	}
+
+	__cil_expr_to_string(px->expr_str, CIL_PERMISSIONX, &expr_str);
+
+	cil_log(CIL_ERR, "%s %s (%s)", kind_str, DATUM(px->obj)->fqn, expr_str);
+
+	free(expr_str);
+}
+
+static void __cil_print_rule(const char *pad, const char *kind, struct cil_avrule *avrule)
+{
+	cil_log(CIL_ERR,"%s(%s ", pad, kind);
+	cil_log(CIL_ERR,"%s %s ", DATUM(avrule->src)->fqn, DATUM(avrule->tgt)->fqn);
+
+	if (!avrule->is_extended) {
+		__cil_print_classperm(avrule->perms.classperms);
+	} else {
+		cil_log(CIL_ERR, "(");
+		__cil_print_permissionx(avrule->perms.x.permx);
+		cil_log(CIL_ERR, ")");
+	}
 
 	cil_log(CIL_ERR,")\n");
 }
 
-static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct cil_list *neverallows)
+static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tree_node *node)
 {
-	int rc = SEPOL_OK;
-	struct cil_list_item *i1;
+	int rc;
+	struct cil_list_item *i2;
+	struct cil_list *matching;
+	struct cil_avrule *cil_rule = node->data;
+	struct cil_avrule target;
+	struct cil_tree_node *n2;
+	struct cil_avrule *r2;
+	char *neverallow_str;
+	char *allow_str;
+	enum cil_flavor avrule_flavor;
 
-	cil_list_for_each(i1, neverallows) {
-		struct cil_tree_node *node = i1->data;
-		avrule_t *avrule;
-		rc = __cil_rule_to_expanded_sepol_avrule(db, pdb, node, &avrule);
+	target.rule_kind = CIL_AVRULE_ALLOWED;
+	target.is_extended = cil_rule->is_extended;
+	target.src = cil_rule->src;
+	target.tgt = cil_rule->tgt;
+	target.perms = cil_rule->perms;
+
+	if (!cil_rule->is_extended) {
+		neverallow_str = CIL_KEY_NEVERALLOW;
+		allow_str = CIL_KEY_ALLOW;
+		avrule_flavor = CIL_AVRULE;
+	} else {
+		neverallow_str = CIL_KEY_NEVERALLOWX;
+		allow_str = CIL_KEY_ALLOWX;
+		avrule_flavor = CIL_AVRULEX;
+	}
+	cil_log(CIL_ERR, "%s check failed at line %d of %s\n", neverallow_str, node->line, node->path);
+	__cil_print_rule("  ", neverallow_str, cil_rule);
+	cil_list_init(&matching, CIL_NODE);
+	rc = cil_find_matching_avrule_in_ast(db->ast->root, avrule_flavor, &target, matching, CIL_FALSE);
+	if (rc) {
+		cil_log(CIL_ERR, "Error occurred while checking %s rules\n", neverallow_str);
+		cil_list_destroy(&matching, CIL_FALSE);
+		goto exit;
+	}
+
+	cil_list_for_each(i2, matching) {
+		n2 = i2->data;
+		r2 = n2->data;
+		__cil_print_parents("    ", n2);
+		__cil_print_rule("      ", allow_str, r2);
+	}
+	cil_log(CIL_ERR,"\n");
+	cil_list_destroy(&matching, CIL_FALSE);
+
+exit:
+	return rc;
+}
+
+static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct cil_tree_node *node)
+{
+	int rc = SEPOL_ERR;
+	int ret = CIL_FALSE;
+	struct cil_avrule *cil_rule = node->data;
+	struct cil_symtab_datum *tgt = cil_rule->tgt;
+	uint32_t kind;
+	avrule_t *rule;
+	struct cil_list *xperms = NULL;
+	struct cil_list_item *item;
+
+	if (!cil_rule->is_extended) {
+		kind = AVRULE_NEVERALLOW;
+	} else {
+		kind = AVRULE_XPERMS_NEVERALLOW;
+	}
+
+	rule = __cil_init_sepol_avrule(kind, node);
+	rule->next = NULL;
+
+	rc = __cil_add_sepol_type(pdb, db, cil_rule->src, &rule->stypes.types);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	if (tgt->fqn == CIL_KEY_SELF) {
+		rule->flags = RULE_SELF;
+	} else {
+		rc = __cil_add_sepol_type(pdb, db, cil_rule->tgt, &rule->ttypes.types);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to create expanded sepol avrules to check neverallow rules\n");
 			goto exit;
 		}
+	}
 
-		rc = check_assertion(pdb, avrule);
+	if (!cil_rule->is_extended) {
+		rc = __cil_rule_to_sepol_class_perms(pdb, cil_rule->perms.classperms, &rule->perms);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
 
+		rc = check_assertion(pdb, rule);
 		if (rc == CIL_TRUE) {
-			struct cil_list_item *i2;
-			struct cil_list *matching;
-			struct cil_avrule *cil_rule = node->data;
-			struct cil_avrule target;
-			struct cil_tree_node *n2;
-			struct cil_avrule *r2;
-			target.rule_kind = CIL_AVRULE_ALLOWED;
-			target.src = cil_rule->src;
-			target.tgt = cil_rule->tgt;
-			target.classperms = cil_rule->classperms;
-			cil_log(CIL_ERR, "Neverallow check failed at line %d of %s\n", node->line, node->path);
-			__cil_print_rule("  ", "neverallow", cil_rule);
-			cil_list_init(&matching, CIL_NODE);
-			rc = cil_find_matching_avrule_in_ast(db->ast->root, CIL_AVRULE, &target, matching, CIL_FALSE);
-			if (rc) {
-				cil_log(CIL_ERR, "Error occurred while checking neverallow rules\n");
-				cil_list_destroy(&matching, CIL_FALSE);
-				__cil_destroy_sepol_avrules(avrule);
+			rc = __cil_print_neverallow_failure(db, node);
+			if (rc != SEPOL_OK) {
 				goto exit;
 			}
+			ret = CIL_TRUE;
+		}
+
+	} else {
+		rc = __cil_permx_to_sepol_class_perms(pdb, cil_rule->perms.x.permx, &rule->perms);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		rc = __cil_permx_bitmap_to_sepol_xperms_list(cil_rule->perms.x.permx->perms, &xperms);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
 
-			cil_list_for_each(i2, matching) {
-				n2 = i2->data;
-				r2 = n2->data;
-				__cil_print_parents("    ", n2);
-				__cil_print_rule("      ", "allow", r2);
+		cil_list_for_each(item, xperms) {
+			rule->xperms = item->data;
+			rc = check_assertion(pdb, rule);
+			if (rc == CIL_TRUE) {
+				rc = __cil_print_neverallow_failure(db, node);
+				if (rc != SEPOL_OK) {
+					goto exit;
+				}
+				ret = CIL_TRUE;
+				goto exit;
 			}
-			cil_log(CIL_ERR,"\n");
-			cil_list_destroy(&matching, CIL_FALSE);
 		}
-		__cil_destroy_sepol_avrules(avrule);
-		avrule = NULL;
 	}
 
 exit:
-	return rc;
+	if (xperms != NULL) {
+		cil_list_for_each(item, xperms) {
+			free(item->data);
+			item->data = NULL;
+		}
+		cil_list_destroy(&xperms, CIL_FALSE);
+	}
+
+	rule->xperms = NULL;
+	__cil_destroy_sepol_avrules(rule);
+
+	if (rc) {
+		return rc;
+	} else {
+		return ret;
+	}
+}
+
+static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct cil_list *neverallows)
+{
+	int rc = SEPOL_OK;
+	int ret = CIL_FALSE;
+	struct cil_list_item *item;
+
+	cil_list_for_each(item, neverallows) {
+		rc = cil_check_neverallow(db, pdb, item->data);
+		if (rc < 0) {
+			goto exit;
+		} else if (rc > 0) {
+			ret = CIL_TRUE;
+		}
+	}
+
+exit:
+	if (rc || ret) {
+		return SEPOL_ERR;
+	} else {
+		return SEPOL_OK;
+	}
 }
 
 static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
@@ -4327,8 +4538,8 @@ static int cil_avrule_from_sepol(policydb_t *pdb, avtab_ptr_t sepol_rule, struct
 	cil_rule->tgt = type_value_to_cil[k->target_type];
 	if (!cil_rule->tgt) goto exit;
 
-	cil_rule->classperms = cil_classperms_from_sepol(pdb, k->target_class, d->data, class_value_to_cil, perm_value_to_cil);
-	if (!cil_rule->classperms) goto exit;
+	cil_rule->perms.classperms = cil_classperms_from_sepol(pdb, k->target_class, d->data, class_value_to_cil, perm_value_to_cil);
+	if (!cil_rule->perms.classperms) goto exit;
 
 	return SEPOL_OK;
 
@@ -4386,7 +4597,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 				if (rc) {
 					cil_log(CIL_ERR, "Error occurred while checking type bounds\n");
 					cil_list_destroy(&matching, CIL_FALSE);
-					cil_list_destroy(&target.classperms, CIL_TRUE);
+					cil_list_destroy(&target.perms.classperms, CIL_TRUE);
 					bounds_destroy_bad(bad);
 					goto exit;
 				}
@@ -4399,7 +4610,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 				__cil_print_rule("      ", "allow", n->data);
 				cil_log(CIL_ERR,"\n");
 				cil_list_destroy(&matching, CIL_FALSE);
-				cil_list_destroy(&target.classperms, CIL_TRUE);
+				cil_list_destroy(&target.perms.classperms, CIL_TRUE);
 			}
 			bounds_destroy_bad(bad);
 		}
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 0407d20..f29d0c6 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2025,12 +2025,13 @@ int cil_gen_avrule(struct cil_tree_node *parse_current, struct cil_tree_node *as
 
 	cil_avrule_init(&rule);
 
+	rule->is_extended = 0;
 	rule->rule_kind = rule_kind;
 
 	rule->src_str = parse_current->next->data;
 	rule->tgt_str = parse_current->next->next->data;
 
-	rc = cil_fill_classperms_list(parse_current->next->next->next, &rule->classperms);
+	rc = cil_fill_classperms_list(parse_current->next->next->next, &rule->perms.classperms);
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
@@ -2053,7 +2054,13 @@ void cil_destroy_avrule(struct cil_avrule *rule)
 		return;
 	}
 
-	cil_destroy_classperms_list(&rule->classperms);
+	if (!rule->is_extended) {
+		cil_destroy_classperms_list(&rule->perms.classperms);
+	} else {
+		if (rule->perms.x.permx_str == NULL && rule->perms.x.permx != NULL) {
+			cil_destroy_permissionx(rule->perms.x.permx);
+		}
+	}
 
 	free(rule);
 }
@@ -2167,7 +2174,7 @@ int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *a
 		CIL_SYN_END
 	};
 	int syntax_len = sizeof(syntax)/sizeof(*syntax);
-	struct cil_avrulex *rule = NULL;
+	struct cil_avrule *rule = NULL;
 	int rc = SEPOL_ERR;
 
 	if (parse_current == NULL || ast_node == NULL) {
@@ -2179,18 +2186,19 @@ int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *a
 		goto exit;
 	}
 
-	cil_avrulex_init(&rule);
+	cil_avrule_init(&rule);
 
+	rule->is_extended = 1;
 	rule->rule_kind = rule_kind;
 	rule->src_str = parse_current->next->data;
 	rule->tgt_str = parse_current->next->next->data;
 
 	if (parse_current->next->next->next->cl_head == NULL) {
-		rule->permx_str = parse_current->next->next->next->data;
+		rule->perms.x.permx_str = parse_current->next->next->next->data;
 	} else {
-		cil_permissionx_init(&rule->permx);
+		cil_permissionx_init(&rule->perms.x.permx);
 
-		rc = cil_fill_permissionx(parse_current->next->next->next->cl_head, rule->permx);
+		rc = cil_fill_permissionx(parse_current->next->next->next->cl_head, rule->perms.x.permx);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
@@ -2204,23 +2212,10 @@ int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *a
 exit:
 	cil_log(CIL_ERR, "Bad allowx rule at line %d of %s\n",
 		parse_current->line, parse_current->path);
-	cil_destroy_avrulex(rule);
+	cil_destroy_avrule(rule);
 	return rc;
 }
 
-void cil_destroy_avrulex(struct cil_avrulex *rule)
-{
-	if (rule == NULL) {
-		return;
-	}
-
-	if (rule->permx_str == NULL && rule->permx != NULL) {
-		cil_destroy_permissionx(rule->permx);
-	}
-
-	free(rule);
-}
-
 int cil_gen_type_rule(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind)
 {
 	enum cil_syntax syntax[] = {
@@ -6127,6 +6122,9 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_DONTAUDITX) {
 		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_DONTAUDIT);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_NEVERALLOWX) {
+		rc = cil_gen_avrulex(parse_current, ast_node, CIL_AVRULE_NEVERALLOW);
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_PERMISSIONX) {
 		rc = cil_gen_permissionx(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 11f51f5..f428394 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -112,7 +112,6 @@ int cil_gen_rolebounds(struct cil_db *db, struct cil_tree_node *parse_current, s
 int cil_gen_avrule(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind);
 void cil_destroy_avrule(struct cil_avrule *rule);
 int cil_gen_avrulex(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind);
-void cil_destroy_avrulex(struct cil_avrulex *rule);
 int cil_gen_permissionx(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_permissionx(struct cil_permissionx *permx);
 int cil_gen_type_rule(struct cil_tree_node *parse_current, struct cil_tree_node *ast_node, uint32_t rule_kind);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 8c50ff0..f49364c 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -782,6 +782,13 @@ int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, void *data, void
 	return SEPOL_OK;
 }
 
+void cil_copy_fill_permissionx(struct cil_db *db, struct cil_permissionx *orig, struct cil_permissionx *new)
+{
+	new->kind = orig->kind;
+	new->obj_str = orig->obj_str;
+	cil_copy_expr(db, orig->expr_str, &new->expr_str);
+}
+
 int cil_copy_avrule(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_avrule *orig = data;
@@ -789,23 +796,27 @@ int cil_copy_avrule(__attribute__((unused)) struct cil_db *db, void *data, void
 
 	cil_avrule_init(&new);
 
+	new->is_extended = orig->is_extended;
 	new->rule_kind = orig->rule_kind;
 	new->src_str = orig->src_str;
 	new->tgt_str = orig->tgt_str;
-	cil_copy_classperms_list(orig->classperms, &new->classperms);
+
+	if (!new->is_extended) {
+		cil_copy_classperms_list(orig->perms.classperms, &new->perms.classperms);
+	} else {
+		if (new->perms.x.permx_str != NULL) {
+			new->perms.x.permx_str = orig->perms.x.permx_str;
+		} else {
+			cil_permissionx_init(&new->perms.x.permx);
+			cil_copy_fill_permissionx(db, orig->perms.x.permx, new->perms.x.permx);
+		}
+	}
 
 	*copy = new;
 
 	return SEPOL_OK;
 }
 
-void cil_copy_fill_permissionx(struct cil_db *db, struct cil_permissionx *orig, struct cil_permissionx *new)
-{
-	new->kind = orig->kind;
-	new->obj_str = orig->obj_str;
-	cil_copy_expr(db, orig->expr_str, &new->expr_str);
-}
-
 int cil_copy_permissionx(struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_permissionx *orig = data;
@@ -828,30 +839,6 @@ int cil_copy_permissionx(struct cil_db *db, void *data, void **copy, symtab_t *s
 	return SEPOL_OK;
 }
 
-
-int cil_copy_avrulex(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
-{
-	struct cil_avrulex *orig = data;
-	struct cil_avrulex *new = NULL;
-
-	cil_avrulex_init(&new);
-
-	new->rule_kind = orig->rule_kind;
-	new->src_str = orig->src_str;
-	new->tgt_str = orig->tgt_str;
-
-	if (new->permx_str != NULL) {
-		new->permx_str = orig->permx_str;
-	} else {
-		cil_permissionx_init(&new->permx);
-		cil_copy_fill_permissionx(db, orig->permx, new->permx);
-	}
-
-	*copy = new;
-
-	return SEPOL_OK;
-}
-
 int cil_copy_type_rule(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_type_rule  *orig = data;
@@ -1828,10 +1815,8 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 		copy_func = &cil_copy_bool;
 		break;
 	case CIL_AVRULE:
-		copy_func = &cil_copy_avrule;
-		break;
 	case CIL_AVRULEX:
-		copy_func = &cil_copy_avrulex;
+		copy_func = &cil_copy_avrule;
 		break;
 	case CIL_PERMISSIONX:
 		copy_func = &cil_copy_permissionx;
diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
index a76dc37..b80e1ef 100644
--- a/libsepol/cil/src/cil_find.c
+++ b/libsepol/cil/src/cil_find.c
@@ -214,20 +214,93 @@ static int cil_classperms_list_match_any(struct cil_list *cpl1, struct cil_list
 	return CIL_FALSE;
 }
 
+static void __add_classes_from_classperms_list(struct cil_list *classperms, struct cil_list *class_list)
+{
+	struct cil_list_item *curr;
+
+	cil_list_for_each(curr, classperms) {
+		if (curr->flavor == CIL_CLASSPERMS) {
+			struct cil_classperms *cp = curr->data;
+			if (FLAVOR(cp->class) == CIL_CLASS) {
+				cil_list_append(class_list, CIL_CLASS, cp->class);
+			} else { /* MAP */
+				struct cil_list_item *i = NULL;
+				cil_list_for_each(i, cp->perms) {
+					struct cil_perm *cmp = i->data;
+					__add_classes_from_classperms_list(cmp->classperms, class_list);
+				}
+			}	
+		} else { /* SET */
+			struct cil_classperms_set *cp_set = curr->data;
+			struct cil_classpermission *cp = cp_set->set;
+			__add_classes_from_classperms_list(cp->classperms, class_list);
+		}
+	}
+}
+
+static int __add_classes_from_map_perms(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	struct cil_list *class_list = args;
+	struct cil_perm *cmp = (struct cil_perm *)d;
+
+	__add_classes_from_classperms_list(cmp->classperms, class_list);
+
+	return SEPOL_OK;
+}
+
+struct cil_list *cil_expand_class(struct cil_class *class)
+{
+	struct cil_list *class_list;
+
+	cil_list_init(&class_list, CIL_CLASS);
+
+	if (FLAVOR(class) == CIL_CLASS) {
+		cil_list_append(class_list, CIL_CLASS, class);
+	} else { /* MAP */
+		cil_symtab_map(&class->perms, __add_classes_from_map_perms, class_list);
+	}
+
+	return class_list;
+}
+
+static int cil_permissionx_match_any(struct cil_permissionx *px1, struct cil_permissionx *px2)
+{
+	int rc = CIL_FALSE;
+	struct cil_list *cl1 = NULL;
+	struct cil_list *cl2 = NULL;
+
+	if (px1->kind != px2->kind) goto exit;
+
+	if (!ebitmap_match_any(px1->perms, px2->perms)) goto exit;
+
+	cl1 = cil_expand_class(px1->obj);
+	cl2 = cil_expand_class(px2->obj);
+
+	if (!cil_list_match_any(cl1, cl2)) goto exit;
+
+	rc = CIL_TRUE;
+
+exit:
+	cil_list_destroy(&cl1, CIL_FALSE);
+	cil_list_destroy(&cl2, CIL_FALSE);
+
+	return rc;
+}
+
 int cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avrule *avrule, struct cil_avrule *target, struct cil_list *matching, int match_self)
 {
 	int rc = SEPOL_OK;
 	struct cil_symtab_datum *s1 = avrule->src;
 	struct cil_symtab_datum *t1 = avrule->tgt;
-	struct cil_list *cp1 = avrule->classperms;
 	struct cil_symtab_datum *s2 = target->src;
 	struct cil_symtab_datum *t2 = target->tgt;
-	struct cil_list *cp2 = target->classperms;
 
 	if (match_self != CIL_TRUE && avrule == target) goto exit;
 
 	if (avrule->rule_kind != target->rule_kind) goto exit;
 
+	if (avrule->is_extended != target->is_extended) goto exit;
+
 	if (!cil_type_match_any(s1, s2)) goto exit;
 
 	if (t1->fqn != CIL_KEY_SELF && t2->fqn != CIL_KEY_SELF) {
@@ -254,8 +327,14 @@ int cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avrule *avru
 		}
 	}
 
-	if (cil_classperms_list_match_any(cp1, cp2)) {
-		cil_list_append(matching, CIL_NODE, node);
+	if (!target->is_extended) {
+		if (cil_classperms_list_match_any(avrule->perms.classperms, target->perms.classperms)) {
+			cil_list_append(matching, CIL_NODE, node);
+		}
+	} else {
+		if (cil_permissionx_match_any(avrule->perms.x.permx, target->perms.x.permx)) {
+			cil_list_append(matching, CIL_NODE, node);
+		}
 	}
 
 	rc = SEPOL_OK;
@@ -264,7 +343,7 @@ exit:
 	return rc;
 }
 
-static int __cil_find_matching_avrule_in_ast(struct cil_tree_node *node,  __attribute__((unused)) uint32_t *finished, void *extra_args)
+static int __cil_find_matching_avrule_in_ast(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
 {
 	int rc = SEPOL_OK;
 	struct cil_args_find *args = extra_args;
@@ -278,8 +357,10 @@ static int __cil_find_matching_avrule_in_ast(struct cil_tree_node *node,  __attr
 	} else if (node->flavor == CIL_MACRO) {
 		*finished = CIL_TREE_SKIP_HEAD;
 		goto exit;
-	} else if (node->flavor == CIL_AVRULE) {
-		rc = cil_find_matching_avrule(node, node->data, args->target, args->matching, args->match_self);
+	} else if (node->flavor == CIL_AVRULE || node->flavor == CIL_AVRULEX) {
+		if (node->flavor == args->flavor) {
+			rc = cil_find_matching_avrule(node, node->data, args->target, args->matching, args->match_self);
+		}
 	}
 
 exit:
diff --git a/libsepol/cil/src/cil_find.h b/libsepol/cil/src/cil_find.h
index c8ca2d2..463ef34 100644
--- a/libsepol/cil/src/cil_find.h
+++ b/libsepol/cil/src/cil_find.h
@@ -35,5 +35,6 @@
 #define CIL_FIND_H_
 
 int cil_find_matching_avrule_in_ast(struct cil_tree_node *current, enum cil_flavor flavor, void *target, struct cil_list *matching, int match_self);
+struct cil_list *cil_expand_class(struct cil_class *class);
 
 #endif
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 7f718d0..a0a5480 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -221,6 +221,7 @@ char *CIL_KEY_PERM;
 char *CIL_KEY_ALLOWX;
 char *CIL_KEY_AUDITALLOWX;
 char *CIL_KEY_DONTAUDITX;
+char *CIL_KEY_NEVERALLOWX;
 char *CIL_KEY_PERMISSIONX;
 char *CIL_KEY_IOCTL;
 char *CIL_KEY_UNORDERED;
@@ -570,12 +571,19 @@ struct cil_tunable {
 #define CIL_AVRULE_NEVERALLOW 128
 #define CIL_AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
 struct cil_avrule {
+	int is_extended;
 	uint32_t rule_kind;
 	char *src_str;
 	void *src; /* type, alias, or attribute */
 	char *tgt_str;	
 	void *tgt; /* type, alias, or attribute */
-	struct cil_list *classperms;
+	union {
+		struct cil_list *classperms;
+		struct {
+			char *permx_str;
+			struct cil_permissionx *permx;
+		} x;
+	} perms;
 };
 
 #define CIL_PERMX_KIND_IOCTL 1
@@ -583,21 +591,11 @@ struct cil_permissionx {
 	struct cil_symtab_datum datum;
 	uint32_t kind;
 	char *obj_str;
-	void *obj;
+	struct cil_class *obj;
 	struct cil_list *expr_str;
 	ebitmap_t *perms;
 };
 
-struct cil_avrulex {
-	uint32_t rule_kind;
-	char *src_str;
-	void *src; /* type, alias, or attribute */
-	char *tgt_str;
-	void *tgt; /* type, alias, or attribute */
-	char *permx_str;
-	struct cil_permissionx *permx;
-};
-
 #define CIL_TYPE_TRANSITION 16
 #define CIL_TYPE_MEMBER     32
 #define CIL_TYPE_CHANGE     64
@@ -974,7 +972,6 @@ void cil_condblock_init(struct cil_condblock **cb);
 void cil_tunable_init(struct cil_tunable **ciltun);
 void cil_tunif_init(struct cil_tunableif **tif);
 void cil_avrule_init(struct cil_avrule **avrule);
-void cil_avrulex_init(struct cil_avrulex **avrulex);
 void cil_permissionx_init(struct cil_permissionx **permx);
 void cil_type_rule_init(struct cil_type_rule **type_rule);
 void cil_roletransition_init(struct cil_roletransition **roletrans);
diff --git a/libsepol/cil/src/cil_list.c b/libsepol/cil/src/cil_list.c
index dbd554c..4e7843c 100644
--- a/libsepol/cil/src/cil_list.c
+++ b/libsepol/cil/src/cil_list.c
@@ -259,3 +259,19 @@ int cil_list_contains(struct cil_list *list, void *data)
 
 	return CIL_FALSE;
 }
+
+int cil_list_match_any(struct cil_list *l1, struct cil_list *l2)
+{
+	struct cil_list_item *i1;
+	struct cil_list_item *i2;
+
+	cil_list_for_each(i1, l1) {
+		cil_list_for_each(i2, l2) {
+			if (i1->data == i2->data && i1->flavor == i2->flavor) {
+				return CIL_TRUE;
+			}
+		}
+	}
+
+	return CIL_FALSE;
+}
diff --git a/libsepol/cil/src/cil_list.h b/libsepol/cil/src/cil_list.h
index a028036..6b4708a 100644
--- a/libsepol/cil/src/cil_list.h
+++ b/libsepol/cil/src/cil_list.h
@@ -59,5 +59,6 @@ struct cil_list_item *cil_list_insert(struct cil_list *list, struct cil_list_ite
 void cil_list_append_item(struct cil_list *list, struct cil_list_item *item);
 void cil_list_prepend_item(struct cil_list *list, struct cil_list_item *item);
 int cil_list_contains(struct cil_list *list, void *data);
+int cil_list_match_any(struct cil_list *l1, struct cil_list *l2);
 
 #endif
diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
index e19bc35..12c59be 100644
--- a/libsepol/cil/src/cil_mem.c
+++ b/libsepol/cil/src/cil_mem.c
@@ -29,6 +29,7 @@
 
 #include <stdlib.h>
 #include <stdio.h>
+#include <stdarg.h>
 #include <string.h>
 
 #include "cil_log.h"
@@ -98,3 +99,19 @@ char *cil_strdup(const char *str)
 
 	return mem;
 }
+
+__attribute__ ((format (printf, 2, 3))) int cil_asprintf(char **strp, const char *fmt, ...)
+{
+	int rc;
+	va_list ap;
+
+	va_start(ap, fmt);
+	rc = vasprintf(strp, fmt, ap);
+	va_end(ap);
+
+	if (rc == -1) {
+		(*cil_mem_error_handler)();
+	}
+
+	return rc;
+}
diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
index 3e4263c..902ce13 100644
--- a/libsepol/cil/src/cil_mem.h
+++ b/libsepol/cil/src/cil_mem.h
@@ -35,6 +35,7 @@ void *cil_malloc(size_t size);
 void *cil_calloc(size_t num_elements, size_t element_size);
 void *cil_realloc(void *ptr, size_t size);
 char *cil_strdup(const char *str);
+int cil_asprintf(char **strp, const char *fmt, ...);
 void (*cil_mem_error_handler)(void);
 
 #endif /* CIL_MEM_H_ */
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index a9e2426..2c9b158 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -598,7 +598,7 @@ int cil_avrule_to_policy(FILE **file_arr, uint32_t file_index, struct cil_avrule
 		return SEPOL_ERR;
 	}
 
-	cil_avrule_to_policy_helper(file_arr, file_index, kind_str, src_str, tgt_str, rule->classperms);
+	cil_avrule_to_policy_helper(file_arr, file_index, kind_str, src_str, tgt_str, rule->perms.classperms);
 
 	return SEPOL_OK;
 }
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 8050bbb..547397c 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1220,9 +1220,9 @@ static int __cil_post_db_attr_helper(struct cil_tree_node *node, __attribute__((
 		break;
 	}
 	case CIL_AVRULEX: {
-		struct cil_avrulex *rule = node->data;
-		if (rule->permx_str == NULL) {
-			rc = __evaluate_permissionx_expression(rule->permx, db);
+		struct cil_avrule *rule = node->data;
+		if (rule->perms.x.permx_str == NULL) {
+			rc = __evaluate_permissionx_expression(rule->perms.x.permx, db);
 			if (rc != SEPOL_OK) goto exit;
 		}
 		break;
@@ -1862,7 +1862,7 @@ static int __cil_post_db_classperms_helper(struct cil_tree_node *node, uint32_t
 	}
 	case CIL_AVRULE: {
 		struct cil_avrule *avrule = node->data;
-		rc = __evaluate_classperms_list(avrule->classperms, db);
+		rc = __evaluate_classperms_list(avrule->perms.classperms, db);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 09cff05..06146ca 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -195,7 +195,7 @@ static void cil_reset_typeattributeset(struct cil_typeattributeset *tas)
 
 static void cil_reset_avrule(struct cil_avrule *rule)
 {
-	cil_reset_classperms_list(rule->classperms);
+	cil_reset_classperms_list(rule->perms.classperms);
 }
 
 static void cil_reset_rangetransition(struct cil_rangetransition *rangetrans)
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 1d3fb5a..14a9c75 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -273,6 +273,23 @@ int cil_type_used(struct cil_symtab_datum *datum)
 	return 0;
 }
 
+int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
+{
+	struct cil_symtab_datum *obj_datum = NULL;
+	int rc = SEPOL_ERR;
+
+	rc = cil_resolve_name(current, permx->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+	permx->obj = (struct cil_class*)obj_datum;
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_args_resolve *args = extra_args;
@@ -281,6 +298,7 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 	struct cil_avrule *rule = current->data;
 	struct cil_symtab_datum *src_datum = NULL;
 	struct cil_symtab_datum *tgt_datum = NULL;
+	struct cil_symtab_datum *permx_datum = NULL;
 	int rc = SEPOL_ERR;
 
 	if (args != NULL) {
@@ -309,77 +327,23 @@ int cil_resolve_avrule(struct cil_tree_node *current, void *extra_args)
 		}
 	}
 
-	rc = cil_resolve_classperms_list(current, rule->classperms, extra_args);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
-	return SEPOL_OK;
-
-exit:
-	return rc;
-}
-
-int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
-{
-	struct cil_symtab_datum *obj_datum = NULL;
-	int rc = SEPOL_ERR;
-
-	rc = cil_resolve_name(current, permx->obj_str, CIL_SYM_CLASSES, extra_args, &obj_datum);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-	permx->obj = (struct cil_class*)obj_datum;
-
-	return SEPOL_OK;
-
-exit:
-	return rc;
-}
-
-int cil_resolve_avrulex(struct cil_tree_node *current, void *extra_args)
-{
-	struct cil_args_resolve *args = extra_args;
-	struct cil_db *db = NULL;
-
-	struct cil_avrulex *rule = current->data;
-	struct cil_symtab_datum *src_datum = NULL;
-	struct cil_symtab_datum *tgt_datum = NULL;
-	struct cil_symtab_datum *permx_datum = NULL;
-	int rc = SEPOL_ERR;
-
-	if (args != NULL) {
-		db = args->db;
-	}
-
-	rc = cil_resolve_name(current, rule->src_str, CIL_SYM_TYPES, args, &src_datum);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-	rule->src = src_datum;
-	cil_type_used(src_datum);
-
-	if (rule->tgt_str == CIL_KEY_SELF) {
-		rule->tgt = db->selftype;
-	} else {
-		rc = cil_resolve_name(current, rule->tgt_str, CIL_SYM_TYPES, args, &tgt_datum);
-		if (rc != SEPOL_OK) {
-			goto exit;
-		}
-		rule->tgt = tgt_datum;
-		cil_type_used(tgt_datum);
-	}
-
-	if (rule->permx_str != NULL) {
-		rc = cil_resolve_name(current, rule->permx_str, CIL_SYM_PERMX, args, &permx_datum);
+	if (!rule->is_extended) {
+		rc = cil_resolve_classperms_list(current, rule->perms.classperms, extra_args);
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
-		rule->permx = (struct cil_permissionx*)permx_datum;
 	} else {
-		rc = cil_resolve_permissionx(current, rule->permx, extra_args);
-		if (rc != SEPOL_OK) {
-			goto exit;
+		if (rule->perms.x.permx_str != NULL) {
+			rc = cil_resolve_name(current, rule->perms.x.permx_str, CIL_SYM_PERMX, args, &permx_datum);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
+			rule->perms.x.permx = (struct cil_permissionx*)permx_datum;
+		} else {
+			rc = cil_resolve_permissionx(current, rule->perms.x.permx, extra_args);
+			if (rc != SEPOL_OK) {
+				goto exit;
+			}
 		}
 	}
 
@@ -3489,10 +3453,8 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 			rc = cil_resolve_classmapping(node, args);
 			break;
 		case CIL_AVRULE:
-			rc = cil_resolve_avrule(node, args);
-			break;
 		case CIL_AVRULEX:
-			rc = cil_resolve_avrulex(node, args);
+			rc = cil_resolve_avrule(node, args);
 			break;
 		case CIL_PERMISSIONX:
 			rc = cil_resolve_permissionx(node, (struct cil_permissionx*)node->data, args);
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index f641baa..c1f3327 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1091,7 +1091,7 @@ void cil_tree_print_node(struct cil_tree_node *node)
 				cil_log(CIL_INFO, " %s", rule->tgt_str);
 			}
 
-			cil_tree_print_classperms_list(rule->classperms);
+			cil_tree_print_classperms_list(rule->perms.classperms);
 
 			cil_log(CIL_INFO, "\n");
 
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 5aec658..fbf397f 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -355,7 +355,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	avrule_t *avrule = a->avrule;
 	avtab_t *avtab = a->avtab;
 
-	if (k->specified != AVTAB_ALLOWED)
+	if (k->specified != AVTAB_ALLOWED && k->specified != AVTAB_XPERMS_ALLOWED)
 		goto exit;
 
 	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index c32fda1..3854d6f 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -111,6 +111,11 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
 			*xperms = *(datum->xperms);
 
 		newnode->datum.xperms = xperms;
+		/* data is usually ignored with xperms, except in the case of
+		 * neverallow checking, which requires permission bits to be set.
+		 * So copy data so it is set in the avtab
+		 */
+		newnode->datum.data = datum->data;
 	} else {
 		newnode->datum = *datum;
 	}
-- 
2.4.3
