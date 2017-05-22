Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MDFWnw014688
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 09:15:32 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v3 3/9] libsepol: Add Infiniband Pkey handling to CIL
Date: Mon, 22 May 2017 16:08:25 +0300
Message-Id: <1495458511-46724-4-git-send-email-danielj@mellanox.com>
In-Reply-To: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
References: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Add Infiniband pkey parsing, symbol table management, and policy
generation to CIL.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 libsepol/cil/src/cil.c             | 19 +++++++++
 libsepol/cil/src/cil_binary.c      | 39 +++++++++++++++++
 libsepol/cil/src/cil_binary.h      | 12 ++++++
 libsepol/cil/src/cil_build_ast.c   | 86 ++++++++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.h   |  2 +
 libsepol/cil/src/cil_copy_ast.c    | 26 ++++++++++++
 libsepol/cil/src/cil_copy_ast.h    |  1 +
 libsepol/cil/src/cil_flavor.h      |  1 +
 libsepol/cil/src/cil_internal.h    | 11 +++++
 libsepol/cil/src/cil_policy.c      | 16 +++++++
 libsepol/cil/src/cil_post.c        | 45 ++++++++++++++++++++
 libsepol/cil/src/cil_post.h        |  1 +
 libsepol/cil/src/cil_reset_ast.c   |  9 ++++
 libsepol/cil/src/cil_resolve_ast.c | 27 ++++++++++++
 libsepol/cil/src/cil_resolve_ast.h |  1 +
 libsepol/cil/src/cil_tree.c        | 16 ++++++-
 libsepol/cil/src/cil_verify.c      | 23 ++++++++++
 17 files changed, 334 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 9b9ccc36..3df670a7 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -188,6 +188,7 @@ static void cil_init_keys(void)
 	CIL_KEY_MLSVALIDATETRANS = cil_strpool_add("mlsvalidatetrans");
 	CIL_KEY_CONTEXT = cil_strpool_add("context");
 	CIL_KEY_FILECON = cil_strpool_add("filecon");
+	CIL_KEY_IBPKEYCON = cil_strpool_add("ibpkeycon");
 	CIL_KEY_PORTCON = cil_strpool_add("portcon");
 	CIL_KEY_NODECON = cil_strpool_add("nodecon");
 	CIL_KEY_GENFSCON = cil_strpool_add("genfscon");
@@ -257,6 +258,7 @@ void cil_db_init(struct cil_db **db)
 	cil_sort_init(&(*db)->genfscon);
 	cil_sort_init(&(*db)->filecon);
 	cil_sort_init(&(*db)->nodecon);
+	cil_sort_init(&(*db)->ibpkeycon);
 	cil_sort_init(&(*db)->portcon);
 	cil_sort_init(&(*db)->pirqcon);
 	cil_sort_init(&(*db)->iomemcon);
@@ -308,6 +310,7 @@ void cil_db_destroy(struct cil_db **db)
 	cil_sort_destroy(&(*db)->genfscon);
 	cil_sort_destroy(&(*db)->filecon);
 	cil_sort_destroy(&(*db)->nodecon);
+	cil_sort_destroy(&(*db)->ibpkeycon);
 	cil_sort_destroy(&(*db)->portcon);
 	cil_sort_destroy(&(*db)->pirqcon);
 	cil_sort_destroy(&(*db)->iomemcon);
@@ -728,6 +731,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_FILECON:
 		cil_destroy_filecon(*data);
 		break;
+	case CIL_IBPKEYCON:
+		cil_destroy_ibpkeycon(*data);
+		break;
 	case CIL_PORTCON:
 		cil_destroy_portcon(*data);
 		break;
@@ -1097,6 +1103,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_FSUSE;
 	case CIL_FILECON:
 		return CIL_KEY_FILECON;
+	case CIL_IBPKEYCON:
+		return CIL_KEY_IBPKEYCON;
 	case CIL_PORTCON:
 		return CIL_KEY_PORTCON;
 	case CIL_NODECON:
@@ -2255,6 +2263,17 @@ void cil_filecon_init(struct cil_filecon **filecon)
 	(*filecon)->context = NULL;
 }
 
+void cil_ibpkeycon_init(struct cil_ibpkeycon **ibpkeycon)
+{
+	*ibpkeycon = cil_malloc(sizeof(**ibpkeycon));
+
+	(*ibpkeycon)->subnet_prefix_str = NULL;
+	(*ibpkeycon)->pkey_low = 0;
+	(*ibpkeycon)->pkey_high = 0;
+	(*ibpkeycon)->context_str = NULL;
+	(*ibpkeycon)->context = NULL;
+}
+
 void cil_portcon_init(struct cil_portcon **portcon)
 {
 	*portcon = cil_malloc(sizeof(**portcon));
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index e1481a43..1ddbf21f 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3218,6 +3218,40 @@ exit:
 	return rc;
 }
 
+int cil_ibpkeycon_to_policydb(policydb_t *pdb, struct cil_sort *ibpkeycons)
+{
+	int rc = SEPOL_ERR;
+	uint32_t i = 0;
+	ocontext_t *tail = NULL;
+	struct in6_addr subnet_prefix;
+
+	for (i = 0; i < ibpkeycons->count; i++) {
+		struct cil_ibpkeycon *cil_ibpkeycon = ibpkeycons->array[i];
+		ocontext_t *new_ocon = cil_add_ocontext(&pdb->ocontexts[OCON_IBPKEY], &tail);
+
+		rc = inet_pton(AF_INET6, cil_ibpkeycon->subnet_prefix_str, &subnet_prefix);
+		if (rc != 1) {
+			cil_log(CIL_ERR, "ibpkeycon subnet prefix not in valid IPV6 format\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+
+		memcpy(&new_ocon->u.ibpkey.subnet_prefix, &subnet_prefix.s6_addr[0],
+		       sizeof(new_ocon->u.ibpkey.subnet_prefix));
+		new_ocon->u.ibpkey.low_pkey = cil_ibpkeycon->pkey_low;
+		new_ocon->u.ibpkey.high_pkey = cil_ibpkeycon->pkey_high;
+
+		rc = __cil_context_to_sepol_context(pdb, cil_ibpkeycon->context, &new_ocon->context[0]);
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
 int cil_portcon_to_policydb(policydb_t *pdb, struct cil_sort *portcons)
 {
 	int rc = SEPOL_ERR;
@@ -3848,6 +3882,11 @@ int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_db *db)
 		goto exit;
 	}
 
+	rc = cil_ibpkeycon_to_policydb(pdb, db->ibpkeycon);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
 	if (db->target_platform == SEPOL_TARGET_XEN) {
 		rc = cil_pirqcon_to_policydb(pdb, db->pirqcon);
 		if (rc != SEPOL_OK) {
diff --git a/libsepol/cil/src/cil_binary.h b/libsepol/cil/src/cil_binary.h
index c59b1e3c..a03d250d 100644
--- a/libsepol/cil/src/cil_binary.h
+++ b/libsepol/cil/src/cil_binary.h
@@ -330,6 +330,18 @@ int cil_sepol_level_define(policydb_t *pdb, struct cil_sens *cil_sens);
 int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_rangetransition *rangetrans, hashtab_t range_trans_table);
 
 /**
+ * Insert cil ibpkeycon structure into sepol policydb.
+ * The function is given a structure containing the sorted ibpkeycons and
+ * loops over this structure inserting them into the policy database.
+ *
+ * @param[in] pdb The policy database to insert the ibpkeycon into.
+ * @param[in] node The cil_sort structure that contains the sorted ibpkeycons.
+ *
+ * @return SEPOL_OK upon success or an error otherwise.
+ */
+int cil_ibpkeycon_to_policydb(policydb_t *pdb, struct cil_sort *ibpkeycons);
+
+/**
  * Insert cil portcon structure into sepol policydb.
  * The function is given a structure containing the sorted portcons and
  * loops over this structure inserting them into the policy database.
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 36cc6735..11215744 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4256,6 +4256,89 @@ void cil_destroy_filecon(struct cil_filecon *filecon)
 	free(filecon);
 }
 
+int cil_gen_ibpkeycon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_STRING | CIL_SYN_LIST,
+		CIL_SYN_STRING | CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	int syntax_len = sizeof(syntax) / sizeof(*syntax);
+	int rc = SEPOL_ERR;
+	struct cil_ibpkeycon *ibpkeycon = NULL;
+
+	if (!db || !parse_current || !ast_node)
+		goto exit;
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK)
+		goto exit;
+
+	cil_ibpkeycon_init(&ibpkeycon);
+
+	ibpkeycon->subnet_prefix_str = parse_current->next->data;
+
+	if (parse_current->next->next->cl_head) {
+		if (parse_current->next->next->cl_head->next &&
+		    !parse_current->next->next->cl_head->next->next) {
+			rc = cil_fill_integer(parse_current->next->next->cl_head, &ibpkeycon->pkey_low, 0);
+			if (rc != SEPOL_OK) {
+				cil_log(CIL_ERR, "Improper ibpkey specified\n");
+				goto exit;
+			}
+			rc = cil_fill_integer(parse_current->next->next->cl_head->next, &ibpkeycon->pkey_high, 0);
+			if (rc != SEPOL_OK) {
+				cil_log(CIL_ERR, "Improper ibpkey specified\n");
+				goto exit;
+			}
+		} else {
+			cil_log(CIL_ERR, "Improper ibpkey range specified\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+	} else {
+		rc = cil_fill_integer(parse_current->next->next, &ibpkeycon->pkey_low, 0);
+		if (rc != SEPOL_OK) {
+			cil_log(CIL_ERR, "Improper ibpkey specified\n");
+			goto exit;
+		}
+		ibpkeycon->pkey_high = ibpkeycon->pkey_low;
+	}
+
+	if (!parse_current->next->next->next->cl_head) {
+		ibpkeycon->context_str = parse_current->next->next->next->data;
+	} else {
+		cil_context_init(&ibpkeycon->context);
+
+		rc = cil_fill_context(parse_current->next->next->next->cl_head, ibpkeycon->context);
+		if (rc != SEPOL_OK)
+			goto exit;
+	}
+
+	ast_node->data = ibpkeycon;
+	ast_node->flavor = CIL_IBPKEYCON;
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(parse_current, CIL_ERR, "Bad ibpkeycon declaration");
+	cil_destroy_ibpkeycon(ibpkeycon);
+
+	return rc;
+}
+
+void cil_destroy_ibpkeycon(struct cil_ibpkeycon *ibpkeycon)
+{
+	if (!ibpkeycon)
+		return;
+
+	if (!ibpkeycon->context_str && ibpkeycon->context)
+		cil_destroy_context(ibpkeycon->context);
+
+	free(ibpkeycon);
+}
+
 int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
@@ -6215,6 +6298,9 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_FILECON) {
 		rc = cil_gen_filecon(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_IBPKEYCON) {
+		rc = cil_gen_ibpkeycon(db, parse_current, ast_node);
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_PORTCON) {
 		rc = cil_gen_portcon(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 33bae997..c2d7b31e 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -175,6 +175,8 @@ int cil_gen_context(struct cil_db *db, struct cil_tree_node *parse_current, stru
 void cil_destroy_context(struct cil_context *context);
 int cil_gen_filecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_filecon(struct cil_filecon *filecon);
+int cil_gen_ibpkeycon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+void cil_destroy_ibpkeycon(struct cil_ibpkeycon *ibpkeycon);
 int cil_gen_portcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_portcon(struct cil_portcon *portcon);
 int cil_gen_nodecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index d6685050..7307b08b 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1204,6 +1204,29 @@ int cil_copy_nodecon(struct cil_db *db, void *data, void **copy, __attribute__((
 	return SEPOL_OK;
 }
 
+int cil_copy_ibpkeycon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_ibpkeycon *orig = data;
+	struct cil_ibpkeycon *new = NULL;
+
+	cil_ibpkeycon_init(&new);
+
+	new->subnet_prefix_str = orig->subnet_prefix_str;
+	new->pkey_low = orig->pkey_low;
+	new->pkey_high = orig->pkey_high;
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
@@ -1916,6 +1939,9 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 	case CIL_NODECON:
 		copy_func = &cil_copy_nodecon;
 		break;
+	case CIL_IBPKEYCON:
+		copy_func = &cil_copy_ibpkeycon;
+		break;
 	case CIL_PORTCON:
 		copy_func = &cil_copy_portcon;
 		break;
diff --git a/libsepol/cil/src/cil_copy_ast.h b/libsepol/cil/src/cil_copy_ast.h
index 78c34b87..a50c3708 100644
--- a/libsepol/cil/src/cil_copy_ast.h
+++ b/libsepol/cil/src/cil_copy_ast.h
@@ -99,6 +99,7 @@ int cil_copy_netifcon(struct cil_db *db, void *data, void **copy, symtab_t *symt
 int cil_copy_genfscon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_filecon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_nodecon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
+int cil_copy_ibpkeycon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_portcon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_pirqcon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
 int cil_copy_iomemcon(struct cil_db *db, void *data, void **copy, symtab_t *symtab);
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index c01f967a..4505b8bb 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -113,6 +113,7 @@ enum cil_flavor {
 	CIL_HANDLEUNKNOWN,
 	CIL_MLS,
 	CIL_SRC_INFO,
+	CIL_IBPKEYCON,
 
 /*
  *          boolean  constraint  set  catset
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index aee3f00c..2add97bb 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -203,6 +203,7 @@ char *CIL_KEY_VALIDATETRANS;
 char *CIL_KEY_MLSVALIDATETRANS;
 char *CIL_KEY_CONTEXT;
 char *CIL_KEY_FILECON;
+char *CIL_KEY_IBPKEYCON;
 char *CIL_KEY_PORTCON;
 char *CIL_KEY_NODECON;
 char *CIL_KEY_GENFSCON;
@@ -286,6 +287,7 @@ struct cil_db {
 	struct cil_sort *genfscon;
 	struct cil_sort *filecon;
 	struct cil_sort *nodecon;
+	struct cil_sort *ibpkeycon;
 	struct cil_sort *portcon;
 	struct cil_sort *pirqcon;
 	struct cil_sort *iomemcon;
@@ -737,6 +739,14 @@ enum cil_protocol {
 	CIL_PROTOCOL_DCCP
 };
 
+struct cil_ibpkeycon {
+	char *subnet_prefix_str;
+	uint32_t pkey_low;
+	uint32_t pkey_high;
+	char *context_str;
+	struct cil_context *context;
+};
+
 struct cil_portcon {
 	enum cil_protocol proto;
 	uint32_t port_low;
@@ -1007,6 +1017,7 @@ void cil_catset_init(struct cil_catset **catset);
 void cil_cats_init(struct cil_cats **cats);
 void cil_senscat_init(struct cil_senscat **senscat);
 void cil_filecon_init(struct cil_filecon **filecon);
+void cil_ibpkeycon_init(struct cil_ibpkeycon **ibpkeycon);
 void cil_portcon_init(struct cil_portcon **portcon);
 void cil_nodecon_init(struct cil_nodecon **nodecon);
 void cil_genfscon_init(struct cil_genfscon **genfscon);
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 77179e63..35a0a29e 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1714,6 +1714,21 @@ static void cil_genfscons_to_policy(FILE *out, struct cil_sort *genfscons, int m
 	}
 }
 
+static void cil_ibpkeycons_to_policy(FILE *out, struct cil_sort *ibpkeycons, int mls)
+{
+	uint32_t i = 0;
+
+	for (i = 0; i < ibpkeycons->count; i++) {
+		struct cil_ibpkeycon *ibpkeycon = (struct cil_ibpkeycon *)ibpkeycons->array[i];
+
+		fprintf(out, "ibpkeycon %s ", ibpkeycon->subnet_prefix_str);
+		fprintf(out, "%d ", ibpkeycon->pkey_low);
+		fprintf(out, "%d ", ibpkeycon->pkey_high);
+		cil_context_to_policy(out, ibpkeycon->context, mls);
+		fprintf(out, "\n");
+	}
+}
+
 static void cil_portcons_to_policy(FILE *out, struct cil_sort *portcons, int mls)
 {
 	unsigned i;
@@ -1942,6 +1957,7 @@ void cil_gen_policy(FILE *out, struct cil_db *db)
 	cil_genfscons_to_policy(out, db->genfscon, db->mls);
 	cil_portcons_to_policy(out, db->portcon, db->mls);
 	cil_netifcons_to_policy(out, db->netifcon, db->mls);
+	cil_ibpkeycons_to_policy(out, db->ibpkeycon, db->mls);
 	cil_nodecons_to_policy(out, db->nodecon, db->mls);
 	cil_pirqcons_to_policy(out, db->pirqcon, db->mls);
 	cil_iomemcons_to_policy(out, db->iomemcon, db->mls);
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 1941fab3..893860d5 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -154,6 +154,28 @@ int cil_post_filecon_compare(const void *a, const void *b)
 	return rc;
 }
 
+int cil_post_ibpkeycon_compare(const void *a, const void *b)
+{
+	int rc = SEPOL_ERR;
+	struct cil_ibpkeycon *aibpkeycon = *(struct cil_ibpkeycon **)a;
+	struct cil_ibpkeycon *bibpkeycon = *(struct cil_ibpkeycon **)b;
+
+	rc = strcmp(aibpkeycon->subnet_prefix_str, bibpkeycon->subnet_prefix_str);
+	if (rc)
+		return rc;
+
+	rc = (aibpkeycon->pkey_high - aibpkeycon->pkey_low)
+		- (bibpkeycon->pkey_high - bibpkeycon->pkey_low);
+	if (rc == 0) {
+		if (aibpkeycon->pkey_low < bibpkeycon->pkey_low)
+			rc = -1;
+		else if (bibpkeycon->pkey_low < aibpkeycon->pkey_low)
+			rc = 1;
+	}
+
+	return rc;
+}
+
 int cil_post_portcon_compare(const void *a, const void *b)
 {
 	int rc = SEPOL_ERR;
@@ -401,6 +423,9 @@ static int __cil_post_db_count_helper(struct cil_tree_node *node, uint32_t *fini
 	case CIL_NODECON:
 		db->nodecon->count++;
 		break;
+	case CIL_IBPKEYCON:
+		db->ibpkeycon->count++;
+		break;
 	case CIL_PORTCON:
 		db->portcon->count++;
 		break;
@@ -535,6 +560,17 @@ static int __cil_post_db_array_helper(struct cil_tree_node *node, uint32_t *fini
 		sort->index++;
 		break;
 	}
+	case CIL_IBPKEYCON: {
+		struct cil_sort *sort = db->ibpkeycon;
+		uint32_t count = sort->count;
+		uint32_t i = sort->index;
+
+		if (!sort->array)
+			sort->array = cil_malloc(sizeof(*sort->array) * count);
+		sort->array[i] = node->data;
+		sort->index++;
+		break;
+	}
 	case CIL_PORTCON: {
 		struct cil_sort *sort = db->portcon;
 		uint32_t count = sort->count;
@@ -1618,6 +1654,14 @@ static int __cil_post_db_cat_helper(struct cil_tree_node *node, uint32_t *finish
 		}
 		break;
 	}
+	case CIL_IBPKEYCON: {
+		struct cil_ibpkeycon *ibpkeycon = node->data;
+
+		rc = __evaluate_levelrange_expression(ibpkeycon->context->range, db);
+		if (rc != SEPOL_OK)
+			goto exit;
+		break;
+	}
 	case CIL_PORTCON: {
 		struct cil_portcon *portcon = node->data;
 		rc = __evaluate_levelrange_expression(portcon->context->range, db);
@@ -1977,6 +2021,7 @@ static int cil_post_db(struct cil_db *db)
 
 	qsort(db->netifcon->array, db->netifcon->count, sizeof(db->netifcon->array), cil_post_netifcon_compare);
 	qsort(db->genfscon->array, db->genfscon->count, sizeof(db->genfscon->array), cil_post_genfscon_compare);
+	qsort(db->ibpkeycon->array, db->ibpkeycon->count, sizeof(db->ibpkeycon->array), cil_post_ibpkeycon_compare);
 	qsort(db->portcon->array, db->portcon->count, sizeof(db->portcon->array), cil_post_portcon_compare);
 	qsort(db->nodecon->array, db->nodecon->count, sizeof(db->nodecon->array), cil_post_nodecon_compare);
 	qsort(db->fsuse->array, db->fsuse->count, sizeof(db->fsuse->array), cil_post_fsuse_compare);
diff --git a/libsepol/cil/src/cil_post.h b/libsepol/cil/src/cil_post.h
index 74393ccf..fe7f3a58 100644
--- a/libsepol/cil/src/cil_post.h
+++ b/libsepol/cil/src/cil_post.h
@@ -38,6 +38,7 @@ struct fc_data {
 
 void cil_post_fc_fill_data(struct fc_data *fc, char *path);
 int cil_post_filecon_compare(const void *a, const void *b);
+int cil_post_ibpkeycon_compare(const void *a, const void *b);
 int cil_post_portcon_compare(const void *a, const void *b);
 int cil_post_genfscon_compare(const void *a, const void *b);
 int cil_post_netifcon_compare(const void *a, const void *b);
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 676e156e..fc23a2c8 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -288,6 +288,12 @@ static void cil_reset_filecon(struct cil_filecon *filecon)
 	}
 }
 
+static void cil_reset_ibpkeycon(struct cil_ibpkeycon *ibpkeycon)
+{
+	if (!ibpkeycon->context)
+		cil_reset_context(ibpkeycon->context);
+}
+
 static void cil_reset_portcon(struct cil_portcon *portcon)
 {
 	if (portcon->context_str == NULL) {
@@ -489,6 +495,9 @@ int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32
 	case CIL_FILECON:
 		cil_reset_filecon(node->data);
 		break;
+	case CIL_IBPKEYCON:
+		cil_reset_ibpkeycon(node->data);
+		break;
 	case CIL_PORTCON:
 		cil_reset_portcon(node->data);
 		break;
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 8925b271..9e3cb2b5 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1923,6 +1923,30 @@ int cil_resolve_filecon(struct cil_tree_node *current, void *extra_args)
 	return SEPOL_OK;
 }
 
+int cil_resolve_ibpkeycon(struct cil_tree_node *current, void *extra_args)
+{
+	struct cil_ibpkeycon *ibpkeycon = current->data;
+	struct cil_symtab_datum *context_datum = NULL;
+	int rc = SEPOL_ERR;
+
+	if (ibpkeycon->context_str) {
+		rc = cil_resolve_name(current, ibpkeycon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		if (rc != SEPOL_OK)
+			goto exit;
+
+		ibpkeycon->context = (struct cil_context *)context_datum;
+	} else {
+		rc = cil_resolve_context(current, ibpkeycon->context, extra_args);
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
 int cil_resolve_portcon(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_portcon *portcon = current->data;
@@ -3567,6 +3591,9 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		case CIL_FILECON:
 			rc = cil_resolve_filecon(node, args);
 			break;
+		case CIL_IBPKEYCON:
+			rc = cil_resolve_ibpkeycon(node, args);
+			break;
 		case CIL_PORTCON:
 			rc = cil_resolve_portcon(node, args);
 			break;
diff --git a/libsepol/cil/src/cil_resolve_ast.h b/libsepol/cil/src/cil_resolve_ast.h
index 1175f974..0506a3de 100644
--- a/libsepol/cil/src/cil_resolve_ast.h
+++ b/libsepol/cil/src/cil_resolve_ast.h
@@ -74,6 +74,7 @@ int cil_resolve_constrain(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_validatetrans(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_context(struct cil_tree_node *current, struct cil_context *context, void *extra_args);
 int cil_resolve_filecon(struct cil_tree_node *current, void *extra_args);
+int cil_resolve_ibpkeycon(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_portcon(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_genfscon(struct cil_tree_node *current, void *extra_args);
 int cil_resolve_nodecon(struct cil_tree_node *current, void *extra_args);
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 2cc2744a..89706d0f 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1,6 +1,6 @@
 /*
  * Copyright 2011 Tresys Technology, LLC. All rights reserved.
- * 
+ *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
  * 
@@ -1409,6 +1409,20 @@ void cil_tree_print_node(struct cil_tree_node *node)
 			return;
 
 		}
+		case CIL_IBPKEYCON: {
+			struct cil_ibpkeycon *ibpkeycon = node->data;
+
+			cil_log(CIL_INFO, "IBPKEYCON: %s", ibpkeycon->subnet_prefix_str);
+			cil_log(CIL_INFO, " (%d %d) ", ibpkeycon->pkey_low, ibpkeycon->pkey_high);
+
+			if (ibpkeycon->context)
+				cil_tree_print_context(ibpkeycon->context);
+			else if (ibpkeycon->context_str)
+				cil_log(CIL_INFO, " %s", ibpkeycon->context_str);
+
+			cil_log(CIL_INFO, "\n");
+			return;
+		}
 		case CIL_PORTCON: {
 			struct cil_portcon *portcon = node->data;
 			cil_log(CIL_INFO, "PORTCON:");
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 47dcfaa2..108da33d 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1080,6 +1080,26 @@ exit:
 	return rc;
 }
 
+int __cil_verify_ibpkeycon(struct cil_db *db, struct cil_tree_node *node)
+{
+	int rc = SEPOL_ERR;
+	struct cil_ibpkeycon *pkey = node->data;
+	struct cil_context *ctx = pkey->context;
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
+	cil_tree_log(node, CIL_ERR, "Invalid ibpkeycon");
+	return rc;
+}
+
 int __cil_verify_portcon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
@@ -1452,6 +1472,9 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *ex
 		case CIL_NODECON:
 			rc = __cil_verify_nodecon(db, node);
 			break;
+		case CIL_IBPKEYCON:
+			rc = __cil_verify_ibpkeycon(db, node);
+			break;
 		case CIL_PORTCON:
 			rc = __cil_verify_portcon(db, node);
 			break;
-- 
2.12.2
