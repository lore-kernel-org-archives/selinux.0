Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4FKo4PP023984
 for <selinux@tycho.nsa.gov>; Mon, 15 May 2017 16:50:04 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v1 6/9] libsepol: Add IB end port handling to CIL
Date: Mon, 15 May 2017 23:42:38 +0300
Message-Id: <1494880961-73481-7-git-send-email-danielj@mellanox.com>
In-Reply-To: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Add IB end port parsing, symbol table management, and policy generation
to CIL.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

---
v1:
James Carter:
- Add cil_resolve_ibendportcon prototype in cil_resolve_ast.h

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 libsepol/cil/src/cil.c             | 18 +++++++++++
 libsepol/cil/src/cil_binary.c      | 29 +++++++++++++++++
 libsepol/cil/src/cil_binary.h      | 12 +++++++
 libsepol/cil/src/cil_build_ast.c   | 65 ++++++++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.h   |  2 ++
 libsepol/cil/src/cil_copy_ast.c    | 25 +++++++++++++++
 libsepol/cil/src/cil_flavor.h      |  1 +
 libsepol/cil/src/cil_internal.h    |  9 ++++++
 libsepol/cil/src/cil_policy.c      | 15 +++++++++
 libsepol/cil/src/cil_post.c        | 42 ++++++++++++++++++++++++
 libsepol/cil/src/cil_post.h        |  1 +
 libsepol/cil/src/cil_reset_ast.c   | 10 ++++++
 libsepol/cil/src/cil_resolve_ast.c | 28 ++++++++++++++++
 libsepol/cil/src/cil_resolve_ast.h |  1 +
 libsepol/cil/src/cil_tree.c        | 13 ++++++++
 libsepol/cil/src/cil_verify.c      | 23 ++++++++++++++
 16 files changed, 294 insertions(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 3df670a..c02a41a 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -189,6 +189,7 @@ static void cil_init_keys(void)
 	CIL_KEY_CONTEXT = cil_strpool_add("context");
 	CIL_KEY_FILECON = cil_strpool_add("filecon");
 	CIL_KEY_IBPKEYCON = cil_strpool_add("ibpkeycon");
+	CIL_KEY_IBENDPORTCON = cil_strpool_add("ibendportcon");
 	CIL_KEY_PORTCON = cil_strpool_add("portcon");
 	CIL_KEY_NODECON = cil_strpool_add("nodecon");
 	CIL_KEY_GENFSCON = cil_strpool_add("genfscon");
@@ -259,6 +260,7 @@ void cil_db_init(struct cil_db **db)
 	cil_sort_init(&(*db)->filecon);
 	cil_sort_init(&(*db)->nodecon);
 	cil_sort_init(&(*db)->ibpkeycon);
+	cil_sort_init(&(*db)->ibendportcon);
 	cil_sort_init(&(*db)->portcon);
 	cil_sort_init(&(*db)->pirqcon);
 	cil_sort_init(&(*db)->iomemcon);
@@ -311,6 +313,7 @@ void cil_db_destroy(struct cil_db **db)
 	cil_sort_destroy(&(*db)->filecon);
 	cil_sort_destroy(&(*db)->nodecon);
 	cil_sort_destroy(&(*db)->ibpkeycon);
+	cil_sort_destroy(&(*db)->ibendportcon);
 	cil_sort_destroy(&(*db)->portcon);
 	cil_sort_destroy(&(*db)->pirqcon);
 	cil_sort_destroy(&(*db)->iomemcon);
@@ -737,6 +740,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_PORTCON:
 		cil_destroy_portcon(*data);
 		break;
+	case CIL_IBENDPORTCON:
+		cil_destroy_ibendportcon(*data);
+		break;
 	case CIL_NODECON:
 		cil_destroy_nodecon(*data);
 		break;
@@ -1105,6 +1111,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_FILECON;
 	case CIL_IBPKEYCON:
 		return CIL_KEY_IBPKEYCON;
+	case CIL_IBENDPORTCON:
+		return CIL_KEY_IBENDPORTCON;
 	case CIL_PORTCON:
 		return CIL_KEY_PORTCON;
 	case CIL_NODECON:
@@ -1838,6 +1846,16 @@ void cil_netifcon_init(struct cil_netifcon **netifcon)
 	(*netifcon)->context_str = NULL;
 }
 
+void cil_ibendportcon_init(struct cil_ibendportcon **ibendportcon)
+{
+	*ibendportcon = cil_malloc(sizeof(**ibendportcon));
+
+	(*ibendportcon)->dev_name_str = NULL;
+	(*ibendportcon)->port = 0;
+	(*ibendportcon)->context_str = NULL;
+	(*ibendportcon)->context = NULL;
+}
+
 void cil_context_init(struct cil_context **context)
 {
 	*context = cil_malloc(sizeof(**context));
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 75398ff..fb65698 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3323,6 +3323,30 @@ exit:
 	return rc;
 }
 
+int cil_ibendportcon_to_policydb(policydb_t *pdb, struct cil_sort *ibendportcons)
+{
+	int rc = SEPOL_ERR;
+	uint32_t i;
+	ocontext_t *tail = NULL;
+
+	for (i = 0; i < ibendportcons->count; i++) {
+		ocontext_t *new_ocon = cil_add_ocontext(&pdb->ocontexts[OCON_IBENDPORT], &tail);
+		struct cil_ibendportcon *cil_ibendportcon = ibendportcons->array[i];
+
+		new_ocon->u.ibendport.dev_name = cil_strdup(cil_ibendportcon->dev_name_str);
+		new_ocon->u.ibendport.port = cil_ibendportcon->port;
+
+		rc = __cil_context_to_sepol_context(pdb, cil_ibendportcon->context, &new_ocon->context[0]);
+		if (rc != SEPOL_OK)
+			goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int cil_nodecon_to_policydb(policydb_t *pdb, struct cil_sort *nodecons)
 {
 	int rc = SEPOL_ERR;
@@ -3887,6 +3911,11 @@ int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_db *db)
 		goto exit;
 	}
 
+	rc = cil_ibendportcon_to_policydb(pdb, db->ibendportcon);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	if (db->target_platform == SEPOL_TARGET_XEN) {
 		rc = cil_pirqcon_to_policydb(pdb, db->pirqcon);
 		if (rc != SEPOL_OK) {
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index a03d250..5367feb 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -342,6 +342,18 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 int cil_ibpkeycon_to_policydb(policydb_t *pdb, struct cil_sort *ibpkeycons);
 
 /**
+ * Insert cil idbev structure into sepol policydb.
+ * The function is given a structure containing the sorted ibendportcons and
+ * loops over this structure inserting them into the policy database.
+ *
+ * @param[in] pdb The policy database to insert the pkeycon into.
+ * @param[in] node The cil_sort structure that contains the sorted ibendportcons.
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_ibendportcon_to_policydb(policydb_t *pdb, struct cil_sort *pkeycons);
+
+/**
  * Insert cil portcon structure into sepol policydb.
  * The function is given a structure containing the sorted portcons and
  * loops over this structure inserting them into the policy database.
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 1121574..0a9a5e5 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4667,6 +4667,68 @@ void cil_destroy_netifcon(struct cil_netifcon *netifcon)
 	free(netifcon);
 }
 
+int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_STRING | CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	int syntax_len = sizeof(syntax) / sizeof(*syntax);
+	int rc = SEPOL_ERR;
+	struct cil_ibendportcon *ibendportcon = NULL;
+
+	if (!db || !parse_current || !ast_node)
+		goto exit;
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK)
+		goto exit;
+
+	cil_ibendportcon_init(&ibendportcon);
+
+	ibendportcon->dev_name_str = parse_current->next->data;
+
+	rc = cil_fill_integer(parse_current->next->next, &ibendportcon->port, 10);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Improper ibendport port specified\n");
+		goto exit;
+	}
+
+	if (!parse_current->next->next->next->cl_head) {
+		ibendportcon->context_str = parse_current->next->next->data;
+	} else {
+		cil_context_init(&ibendportcon->context);
+
+		rc = cil_fill_context(parse_current->next->next->next->cl_head, ibendportcon->context);
+		if (rc != SEPOL_OK)
+			goto exit;
+	}
+
+	ast_node->data = ibendportcon;
+	ast_node->flavor = CIL_IBENDPORTCON;
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(parse_current, CIL_ERR, "Bad ibendportcon declaration");
+	cil_destroy_ibendportcon(ibendportcon);
+	return SEPOL_ERR;
+}
+
+void cil_destroy_ibendportcon(struct cil_ibendportcon *ibendportcon)
+{
+	if (!ibendportcon)
+		return;
+
+	if (!ibendportcon->context_str && ibendportcon->context)
+		cil_destroy_context(ibendportcon->context);
+
+	free(ibendportcon);
+}
+
 int cil_gen_pirqcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
@@ -6301,6 +6363,9 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_IBPKEYCON) {
 		rc = cil_gen_ibpkeycon(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_IBENDPORTCON) {
+		rc = cil_gen_ibendportcon(db, parse_current, ast_node);
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_PORTCON) {
 		rc = cil_gen_portcon(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index c2d7b31..8153e51 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -177,6 +177,8 @@ int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, stru
 void cil_destroy_filecon(struct cil_filecon *filecon);
 int cil_gen_ibpkeycon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_ibpkeycon(struct cil_ibpkeycon *ibpkeycon);
+int cil_gen_ibendportcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+void cil_destroy_ibendportcon(struct cil_ibendportcon *ibendportcon);
 int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_portcon(struct cil_portcon *portcon);
 int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 7307b08..7af00aa 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1227,6 +1227,28 @@ int cil_copy_ibpkeycon(struct cil_db *db, void *data, void **copy, __attribute__
 	return SEPOL_OK;
 }
 
+int cil_copy_ibendportcon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_ibendportcon *orig = data;
+	struct cil_ibendportcon *new = NULL;
+
+	cil_ibendportcon_init(&new);
+
+	new->dev_name_str = orig->dev_name_str;
+	new->port = orig->port;
+
+	if (orig->context_str) {
+		new->context_str = orig->context_str;
+	} else {
+		cil_context_init(&new->context);
+		cil_copy_fill_context(db, orig->context, new->context);
+	}
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
 int cil_copy_portcon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_portcon *orig = data;
@@ -1942,6 +1964,9 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 	case CIL_IBPKEYCON:
 		copy_func = &cil_copy_ibpkeycon;
 		break;
+	case CIL_IBENDPORTCON:
+		copy_func = &cil_copy_ibendportcon;
+		break;
 	case CIL_PORTCON:
 		copy_func = &cil_copy_portcon;
 		break;
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index 4505b8b..c2f0cee 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -114,6 +114,7 @@ enum cil_flavor {
 	CIL_MLS,
 	CIL_SRC_INFO,
 	CIL_IBPKEYCON,
+	CIL_IBENDPORTCON,
 
 /*
  *          boolean  constraint  set  catset
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 2add97b..6d6a7d9 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -204,6 +204,7 @@ char *CIL_KEY_MLSVALIDATETRANS;
 char *CIL_KEY_CONTEXT;
 char *CIL_KEY_FILECON;
 char *CIL_KEY_IBPKEYCON;
+char *CIL_KEY_IBENDPORTCON;
 char *CIL_KEY_PORTCON;
 char *CIL_KEY_NODECON;
 char *CIL_KEY_GENFSCON;
@@ -288,6 +289,7 @@ struct cil_db {
 	struct cil_sort *filecon;
 	struct cil_sort *nodecon;
 	struct cil_sort *ibpkeycon;
+	struct cil_sort *ibendportcon;
 	struct cil_sort *portcon;
 	struct cil_sort *pirqcon;
 	struct cil_sort *iomemcon;
@@ -789,6 +791,12 @@ struct cil_netifcon {
 	char *context_str;
 };
 
+struct cil_ibendportcon {
+	char *dev_name_str;
+	uint32_t port;
+	char *context_str;
+	struct cil_context *context;
+};
 struct cil_pirqcon {
 	uint32_t pirq;
 	char *context_str;
@@ -974,6 +982,7 @@ int cil_get_symtab(struct cil_tree_node *ast_node, symtab_t **symtab, enum cil_s
 void cil_sort_init(struct cil_sort **sort);
 void cil_sort_destroy(struct cil_sort **sort);
 void cil_netifcon_init(struct cil_netifcon **netifcon);
+void cil_ibendportcon_init(struct cil_ibendportcon **ibendportcon);
 void cil_context_init(struct cil_context **context);
 void cil_level_init(struct cil_level **level);
 void cil_levelrange_init(struct cil_levelrange **lvlrange);
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 35a0a29..2196ae8 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1729,6 +1729,20 @@ static void cil_ibpkeycons_to_policy(FILE *out, struct cil_sort *ibpkeycons, int
 	}
 }
 
+static void cil_ibendportcons_to_policy(FILE *out, struct cil_sort *ibendportcons, int mls)
+{
+	uint32_t i;
+
+	for (i = 0; i < ibendportcons->count; i++) {
+		struct cil_ibendportcon *ibendportcon = (struct cil_ibendportcon *)ibendportcons->array[i];
+
+		fprintf(out, "ibendportcon %s ", ibendportcon->dev_name_str);
+		fprintf(out, "%u ", ibendportcon->port);
+		cil_context_to_policy(out, ibendportcon->context, mls);
+		fprintf(out, "\n");
+	}
+}
+
 static void cil_portcons_to_policy(FILE *out, struct cil_sort *portcons, int mls)
 {
 	unsigned i;
@@ -1958,6 +1972,7 @@ void cil_gen_policy(FILE *out, struct cil_db *db)
 	cil_portcons_to_policy(out, db->portcon, db->mls);
 	cil_netifcons_to_policy(out, db->netifcon, db->mls);
 	cil_ibpkeycons_to_policy(out, db->ibpkeycon, db->mls);
+	cil_ibendportcons_to_policy(out, db->ibendportcon, db->mls);
 	cil_nodecons_to_policy(out, db->nodecon, db->mls);
 	cil_pirqcons_to_policy(out, db->pirqcon, db->mls);
 	cil_iomemcons_to_policy(out, db->iomemcon, db->mls);
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 893860d..0d494ea 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -217,6 +217,25 @@ int cil_post_netifcon_compare(const void *a, const void *b)
 	return  strcmp(anetifcon->interface_str, bnetifcon->interface_str);
 }
 
+int cil_post_ibendportcon_compare(const void *a, const void *b)
+{
+	int rc = SEPOL_ERR;
+
+	struct cil_ibendportcon *aibendportcon = *(struct cil_ibendportcon **)a;
+	struct cil_ibendportcon *bibendportcon = *(struct cil_ibendportcon **)b;
+
+	rc = strcmp(aibendportcon->dev_name_str, bibendportcon->dev_name_str);
+	if (rc)
+		return rc;
+
+	if (aibendportcon->port < bibendportcon->port)
+		return -1;
+	else if (bibendportcon->port < aibendportcon->port)
+		return 1;
+
+	return rc;
+}
+
 int cil_post_nodecon_compare(const void *a, const void *b)
 {
 	struct cil_nodecon *anodecon;
@@ -426,6 +445,9 @@ static int __cil_post_db_count_helper(struct cil_tree_node *node, uint32_t *fini
 	case CIL_IBPKEYCON:
 		db->ibpkeycon->count++;
 		break;
+	case CIL_IBENDPORTCON:
+		db->ibendportcon->count++;
+		break;
 	case CIL_PORTCON:
 		db->portcon->count++;
 		break;
@@ -516,6 +538,17 @@ static int __cil_post_db_array_helper(struct cil_tree_node *node, uint32_t *fini
 		sort->index++;
 		break;
 	}
+	case CIL_IBENDPORTCON: {
+		struct cil_sort *sort = db->ibendportcon;
+		uint32_t count = sort->count;
+		uint32_t i = sort->index;
+
+		if (!sort->array)
+			sort->array = cil_malloc(sizeof(*sort->array) * count);
+		sort->array[i] = node->data;
+		sort->index++;
+		break;
+	}
 	case CIL_FSUSE: {
 		struct cil_sort *sort = db->fsuse;
 		uint32_t count = sort->count;
@@ -1662,6 +1695,14 @@ static int __cil_post_db_cat_helper(struct cil_tree_node *node, uint32_t *finish
 			goto exit;
 		break;
 	}
+	case CIL_IBENDPORTCON: {
+		struct cil_ibendportcon *ibendportcon = node->data;
+
+		rc = __evaluate_levelrange_expression(ibendportcon->context->range, db);
+		if (rc != SEPOL_OK)
+			goto exit;
+		break;
+	}
 	case CIL_PORTCON: {
 		struct cil_portcon *portcon = node->data;
 		rc = __evaluate_levelrange_expression(portcon->context->range, db);
@@ -2022,6 +2063,7 @@ static int cil_post_db(struct cil_db *db)
 	qsort(db->netifcon->array, db->netifcon->count, sizeof(db->netifcon->array), cil_post_netifcon_compare);
 	qsort(db->genfscon->array, db->genfscon->count, sizeof(db->genfscon->array), cil_post_genfscon_compare);
 	qsort(db->ibpkeycon->array, db->ibpkeycon->count, sizeof(db->ibpkeycon->array), cil_post_ibpkeycon_compare);
+	qsort(db->ibendportcon->array, db->ibendportcon->count, sizeof(db->ibendportcon->array), cil_post_ibendportcon_compare);
 	qsort(db->portcon->array, db->portcon->count, sizeof(db->portcon->array), cil_post_portcon_compare);
 	qsort(db->nodecon->array, db->nodecon->count, sizeof(db->nodecon->array), cil_post_nodecon_compare);
 	qsort(db->fsuse->array, db->fsuse->count, sizeof(db->fsuse->array), cil_post_fsuse_compare);
diff --git a/libsepol/cil/src/cil_post.h b/libsepol/cil/src/cil_post.h
index fe7f3a5..3d54154 100644
--- a/libsepol/cil/src/cil_post.h
+++ b/libsepol/cil/src/cil_post.h
@@ -40,6 +40,7 @@ void cil_post_fc_fill_data(struct fc_data *fc, char *path);
 int cil_post_filecon_compare(const void *a, const void *b);
 int cil_post_ibpkeycon_compare(const void *a, const void *b);
 int cil_post_portcon_compare(const void *a, const void *b);
+int cil_post_ibendportcon_compare(const void *a, const void *b);
 int cil_post_genfscon_compare(const void *a, const void *b);
 int cil_post_netifcon_compare(const void *a, const void *b);
 int cil_post_nodecon_compare(const void *a, const void *b);
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index fc23a2c..73034a9 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -326,6 +326,13 @@ static void cil_reset_netifcon(struct cil_netifcon *netifcon)
 	}
 }
 
+static void cil_reset_ibendportcon(struct cil_ibendportcon *ibendportcon)
+{
+	if (!ibendportcon->context_str) {
+		cil_reset_context(ibendportcon->context);
+	}
+}
+
 static void cil_reset_pirqcon(struct cil_pirqcon *pirqcon)
 {
 	if (pirqcon->context_str == NULL) {
@@ -498,6 +505,9 @@ int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32
 	case CIL_IBPKEYCON:
 		cil_reset_ibpkeycon(node->data);
 		break;
+	case CIL_IBENDPORTCON:
+		cil_reset_ibendportcon(node->data);
+		break;
 	case CIL_PORTCON:
 		cil_reset_portcon(node->data);
 		break;
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 9e3cb2b..a671068 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2086,6 +2086,31 @@ exit:
 	return rc;
 }
 
+int cil_resolve_ibendportcon(struct cil_tree_node *current, void *extra_args)
+{
+	struct cil_ibendportcon *ibendportcon = current->data;
+	struct cil_symtab_datum *con_datum = NULL;
+
+	int rc = SEPOL_ERR;
+
+	if (ibendportcon->context_str) {
+		rc = cil_resolve_name(current, ibendportcon->context_str, CIL_SYM_CONTEXTS, extra_args, &con_datum);
+		if (rc != SEPOL_OK)
+			goto exit;
+
+		ibendportcon->context = (struct cil_context *)con_datum;
+	} else {
+		rc = cil_resolve_context(current, ibendportcon->context, extra_args);
+		if (rc != SEPOL_OK)
+			goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int cil_resolve_pirqcon(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_pirqcon *pirqcon = current->data;
@@ -3606,6 +3631,9 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		case CIL_NETIFCON:
 			rc = cil_resolve_netifcon(node, args);
 			break;
+		case CIL_IBENDPORTCON:
+			rc = cil_resolve_ibendportcon(node, args);
+			break;
 		case CIL_PIRQCON:
 			rc = cil_resolve_pirqcon(node, args);
 			break;
diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_resolve_ast.h
index 0506a3d..82c8ea3 100644
--- a/libsepol/cil/src/cil_resolve_ast.h
+++ b/libsepol/cil/src/cil_resolve_ast.h
@@ -75,6 +75,7 @@ int cil_resolve_validatetrans(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_context(struct cil_tree_node *current, struct cil_context *context, void *extra_args);
 int cil_resolve_filecon(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_ibpkeycon(struct cil_tree_node *current, void *extra_args);
+int cil_resolve_ibendportcon(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_portcon(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_genfscon(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_nodecon(struct cil_tree_node *current, void *extra_args);
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 89706d0..d36401b 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1506,6 +1506,19 @@ void cil_tree_print_node(struct cil_tree_node *node)
 			cil_log(CIL_INFO, "\n");
 			return;
 		}
+		case CIL_IBENDPORTCON: {
+			struct cil_ibendportcon *ibendportcon = node->data;
+
+			cil_log(CIL_INFO, "IBENDPORTCON: %s %u ", ibendportcon->dev_name_str, ibendportcon->port);
+
+			if (ibendportcon->context)
+				cil_tree_print_context(ibendportcon->context);
+			else if (ibendportcon->context_str)
+				cil_log(CIL_INFO, " %s", ibendportcon->context_str);
+
+			cil_log(CIL_INFO, "\n");
+			return;
+		}
 		case CIL_PIRQCON: {
 			struct cil_pirqcon *pirqcon = node->data;
 
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 108da33..1036d73 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1012,6 +1012,26 @@ exit:
 	return rc;
 }
 
+int __cil_verify_ibendportcon(struct cil_db *db, struct cil_tree_node *node)
+{
+	int rc = SEPOL_ERR;
+	struct cil_ibendportcon *ib_end_port = node->data;
+	struct cil_context *ctx = ib_end_port->context;
+
+	/* Verify only when anonymous */
+	if (!ctx->datum.name) {
+		rc = __cil_verify_context(db, ctx);
+		if (rc != SEPOL_OK)
+			goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(node, CIL_ERR, "Invalid ibendportcon");
+	return rc;
+}
+
 int __cil_verify_genfscon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
@@ -1475,6 +1495,9 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *ex
 		case CIL_IBPKEYCON:
 			rc = __cil_verify_ibpkeycon(db, node);
 			break;
+		case CIL_IBENDPORTCON:
+			rc = __cil_verify_ibendportcon(db, node);
+			break;
 		case CIL_PORTCON:
 			rc = __cil_verify_portcon(db, node);
 			break;
-- 
2.7.4
