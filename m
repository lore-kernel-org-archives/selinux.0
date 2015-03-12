From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol,
 checkpolicy: add device tree ocontext nodes to Xen policy
Date: Thu, 12 Mar 2015 16:40:32 -0400
Message-Id: <1426192832-991-4-git-send-email-dgdegra@tycho.nsa.gov>
In-Reply-To: <1426192832-991-1-git-send-email-dgdegra@tycho.nsa.gov>
References: <1426192832-991-1-git-send-email-dgdegra@tycho.nsa.gov>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In Xen on ARM, device tree nodes identified by a path (string) need to
be labeled by the security policy.

Signed-off-by: Daniel De Graaf <dgdegra@tycho.nsa.gov>
---
 checkpolicy/policy_define.c                | 55 +++++++++++++++++++++++++
 checkpolicy/policy_define.h                |  1 +
 checkpolicy/policy_parse.y                 |  8 +++-
 checkpolicy/policy_scan.l                  |  2 +
 libsepol/cil/src/cil.c                     | 17 ++++++++
 libsepol/cil/src/cil_binary.c              | 29 +++++++++++++
 libsepol/cil/src/cil_build_ast.c           | 66 ++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.h           |  2 +
 libsepol/cil/src/cil_copy_ast.c            | 24 +++++++++++
 libsepol/cil/src/cil_flavor.h              |  1 +
 libsepol/cil/src/cil_internal.h            | 10 +++++
 libsepol/cil/src/cil_post.c                | 34 +++++++++++++++
 libsepol/cil/src/cil_reset_ast.c           | 10 +++++
 libsepol/cil/src/cil_resolve_ast.c         | 28 +++++++++++++
 libsepol/cil/src/cil_tree.c                | 13 ++++++
 libsepol/cil/src/cil_verify.c              | 24 +++++++++++
 libsepol/include/sepol/policydb/policydb.h |  1 +
 libsepol/src/expand.c                      |  7 ++++
 libsepol/src/policydb.c                    | 18 +++++++-
 libsepol/src/write.c                       | 14 ++++++-
 sepolgen/src/sepolgen/refparser.py         | 11 +++++
 sepolgen/src/sepolgen/refpolicy.py         |  9 ++++
 22 files changed, 379 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index f4c6fba..e05d7be 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4115,6 +4115,61 @@ bad:
 	return -1;
 }
 
+int define_devicetree_context()
+{
+	ocontext_t *newc, *c, *l, *head;
+
+	if (policydbp->target_platform != SEPOL_TARGET_XEN) {
+		yyerror("devicetreecon not supported for target");
+		return -1;
+	}
+
+	if (pass == 1) {
+		free(queue_remove(id_queue));
+		parse_security_context(NULL);
+		return 0;
+	}
+
+	newc = malloc(sizeof(ocontext_t));
+	if (!newc) {
+		yyerror("out of memory");
+		return -1;
+	}
+	memset(newc, 0, sizeof(ocontext_t));
+
+	newc->u.name = (char *)queue_remove(id_queue);
+	if (!newc->u.name) {
+		free(newc);
+		return -1;
+	}
+
+	if (parse_security_context(&newc->context[0])) {
+		free(newc->u.name);
+		free(newc);
+		return -1;
+	}
+
+	head = policydbp->ocontexts[OCON_XEN_DEVICETREE];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		if (strcmp(newc->u.name, c->u.name) == 0) {
+			yyerror2("duplicate devicetree entry for '%s'", newc->u.name);
+			goto bad;
+		}
+	}
+
+	if (l)
+		l->next = newc;
+	else
+		policydbp->ocontexts[OCON_XEN_DEVICETREE] = newc;
+
+	return 0;
+
+bad:
+	free(newc->u.name);
+	free(newc);
+	return -1;
+}
+
 int define_port_context(unsigned int low, unsigned int high)
 {
 	ocontext_t *newc, *c, *l, *head;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 14d30e1..a87ced3 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -49,6 +49,7 @@ int define_pirq_context(unsigned int pirq);
 int define_iomem_context(uint64_t low, uint64_t high);
 int define_ioport_context(unsigned long low, unsigned long high);
 int define_pcidevice_context(unsigned long device);
+int define_devicetree_context(void);
 int define_range_trans(int class_specified);
 int define_role_allow(void);
 int define_role_trans(int class_specified);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index e3899b9..8b81f04 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -130,7 +130,7 @@ typedef int (* require_func_t)(int pass);
 %token TARGET
 %token SAMEUSER
 %token FSCON PORTCON NETIFCON NODECON 
-%token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON
+%token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON DEVICETREECON
 %token FSUSEXATTR FSUSETASK FSUSETRANS
 %token GENFSCON
 %token U1 U2 U3 R1 R2 R3 T1 T2 T3 L1 L2 H1 H2
@@ -644,7 +644,8 @@ dev_contexts		: dev_context_def
 dev_context_def		: pirq_context_def |
 			  iomem_context_def |
 			  ioport_context_def |
-			  pci_context_def
+			  pci_context_def |
+			  dtree_context_def
 			;
 pirq_context_def 	: PIRQCON number security_context_def
 		        {if (define_pirq_context($2)) return -1;}
@@ -662,6 +663,9 @@ ioport_context_def	: IOPORTCON number security_context_def
 pci_context_def  	: PCIDEVICECON number security_context_def
 		        {if (define_pcidevice_context($2)) return -1;}
 		        ;
+dtree_context_def	: DEVICETREECON path security_context_def
+		        {if (define_devicetree_context()) return -1;}
+		        ;
 opt_fs_contexts         : fs_contexts 
                         |
                         ;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 6763c38..108edbc 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -187,6 +187,8 @@ ioportcon |
 IOPORTCON           		{ return(IOPORTCON);}
 pcidevicecon |
 PCIDEVICECON           		{ return(PCIDEVICECON);}
+devicetreecon |
+DEVICETREECON           	{ return(DEVICETREECON);}
 fs_use_xattr |
 FS_USE_XATTR			{ return(FSUSEXATTR);}
 fs_use_task |
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index a25f878..1594be6 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -189,6 +189,7 @@ static void cil_init_keys(void)
 	CIL_KEY_IOMEMCON = cil_strpool_add("iomemcon");
 	CIL_KEY_IOPORTCON = cil_strpool_add("ioportcon");
 	CIL_KEY_PCIDEVICECON = cil_strpool_add("pcidevicecon");
+	CIL_KEY_DEVICETREECON = cil_strpool_add("devicetreecon");
 	CIL_KEY_FSUSE = cil_strpool_add("fsuse");
 	CIL_KEY_POLICYCAP = cil_strpool_add("policycap");
 	CIL_KEY_OPTIONAL = cil_strpool_add("optional");
@@ -244,6 +245,7 @@ void cil_db_init(struct cil_db **db)
 	cil_sort_init(&(*db)->iomemcon);
 	cil_sort_init(&(*db)->ioportcon);
 	cil_sort_init(&(*db)->pcidevicecon);
+	cil_sort_init(&(*db)->devicetreecon);
 	cil_sort_init(&(*db)->fsuse);
 	cil_list_init(&(*db)->userprefixes, CIL_LIST_ITEM);
 	cil_list_init(&(*db)->selinuxusers, CIL_LIST_ITEM);
@@ -289,6 +291,7 @@ void cil_db_destroy(struct cil_db **db)
 	cil_sort_destroy(&(*db)->iomemcon);
 	cil_sort_destroy(&(*db)->ioportcon);
 	cil_sort_destroy(&(*db)->pcidevicecon);
+	cil_sort_destroy(&(*db)->devicetreecon);
 	cil_sort_destroy(&(*db)->fsuse);
 	cil_list_destroy(&(*db)->userprefixes, CIL_FALSE);
 	cil_list_destroy(&(*db)->selinuxusers, CIL_FALSE);
@@ -697,6 +700,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_PCIDEVICECON:
 		cil_destroy_pcidevicecon(*data);
 		break;
+	case CIL_DEVICETREECON:
+		cil_destroy_devicetreecon(*data);
+		break;
 	case CIL_POLICYCAP:
 		cil_destroy_policycap(*data);
 		break;
@@ -1026,6 +1032,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_IOPORTCON;
 	case CIL_PCIDEVICECON:
 		return CIL_KEY_PCIDEVICECON;
+	case CIL_DEVICETREECON:
+		return CIL_KEY_DEVICETREECON;
 	case CIL_POLICYCAP:
 		return CIL_KEY_POLICYCAP;
 	case CIL_DEFAULTUSER:
@@ -2181,6 +2189,15 @@ void cil_pcidevicecon_init(struct cil_pcidevicecon **pcidevicecon)
 	(*pcidevicecon)->context = NULL;
 }
 
+void cil_devicetreecon_init(struct cil_devicetreecon **dtcon)
+{
+	*dtcon = cil_malloc(sizeof(**dtcon));
+
+	(*dtcon)->path = NULL;
+	(*dtcon)->context_str = NULL;
+	(*dtcon)->context = NULL;
+}
+
 void cil_fsuse_init(struct cil_fsuse **fsuse)
 {
 	*fsuse = cil_malloc(sizeof(**fsuse));
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 387237f..03f4924 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2993,6 +2993,30 @@ exit:
 	return rc;
 }
 
+int cil_devicetreecon_to_policydb(policydb_t *pdb, struct cil_sort *devicetreecons)
+{
+	int rc = SEPOL_ERR;
+	uint32_t i = 0;
+	ocontext_t *tail = NULL;
+
+	for (i = 0; i < devicetreecons->count; i++) {
+		ocontext_t *new_ocon = cil_add_ocontext(&pdb->ocontexts[OCON_XEN_DEVICETREE], &tail);
+		struct cil_devicetreecon *cil_devicetreecon = devicetreecons->array[i];
+
+		new_ocon->u.name = cil_strdup(cil_devicetreecon->path);
+
+		rc = __cil_context_to_sepol_context(pdb, cil_devicetreecon->context, &new_ocon->context[0]);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int cil_default_to_policydb(policydb_t *pdb, struct cil_default *def)
 {
 	struct cil_list_item *curr;
@@ -3340,6 +3364,11 @@ int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_db *db)
 		if (rc != SEPOL_OK) {
 			goto exit;
 		}
+
+		rc = cil_devicetreecon_to_policydb(pdb, db->devicetreecon);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
 	}
 	return SEPOL_OK;
 exit:
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 1949d2b..d4ef73c 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4529,6 +4529,69 @@ void cil_destroy_pcidevicecon(struct cil_pcidevicecon *pcidevicecon)
 	free(pcidevicecon);
 }
 
+int cil_gen_devicetreecon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING,
+		CIL_SYN_STRING | CIL_SYN_LIST,
+		CIL_SYN_END
+	};
+	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	int rc = SEPOL_ERR;
+	struct cil_devicetreecon *devicetreecon = NULL;
+
+	if (db == NULL || parse_current == NULL || ast_node == NULL) {
+		goto exit;
+	}
+
+	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
+	if (rc != SEPOL_OK) {
+		goto exit;
+	}
+
+	cil_devicetreecon_init(&devicetreecon);
+
+	devicetreecon->path = parse_current->next->data;
+
+	if (parse_current->next->next->cl_head == NULL) {
+		devicetreecon->context_str = parse_current->next->next->data;
+	} else {
+		cil_context_init(&devicetreecon->context);
+
+		rc = cil_fill_context(parse_current->next->next->cl_head, devicetreecon->context);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	ast_node->data = devicetreecon;
+	ast_node->flavor = CIL_DEVICETREECON;
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Bad devicetreecon declaration at line %d of %s\n", 
+		parse_current->line, parse_current->path);
+	cil_destroy_devicetreecon(devicetreecon);
+	return rc;
+}
+
+void cil_destroy_devicetreecon(struct cil_devicetreecon *devicetreecon)
+{
+	if (devicetreecon == NULL) {
+		return;
+	}
+
+	free(devicetreecon->path);
+
+	if (devicetreecon->context_str == NULL && devicetreecon->context != NULL) {
+		cil_destroy_context(devicetreecon->context);
+	}
+
+	free(devicetreecon);
+}
+
 int cil_gen_fsuse(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
@@ -5806,6 +5869,9 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_PCIDEVICECON) {
 		rc = cil_gen_pcidevicecon(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_DEVICETREECON) {
+		rc = cil_gen_devicetreecon(db, parse_current, ast_node);
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_FSUSE) {
 		rc = cil_gen_fsuse(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 1bd33ce..43bc7f6 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -182,6 +182,8 @@ int cil_gen_ioportcon(struct cil_db *db, struct cil_tree_node *parse_current, st
 void cil_destroy_ioportcon(struct cil_ioportcon *ioportcon);
 int cil_gen_pcidevicecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_pcidevicecon(struct cil_pcidevicecon *pcidevicecon);
+int cil_gen_devicetreecon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+void cil_destroy_devicetreecon(struct cil_devicetreecon *devicetreecon);
 int cil_gen_fsuse(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_fsuse(struct cil_fsuse *fsuse);
 void cil_destroy_param(struct cil_param *param);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 5a24555..199ce1c 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -1211,6 +1211,27 @@ int cil_copy_pcidevicecon(struct cil_db *db, void *data, void **copy, __attribut
 	return SEPOL_OK;
 }
 
+int cil_copy_devicetreecon(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_devicetreecon *orig = data;
+	struct cil_devicetreecon *new = NULL;
+
+	cil_devicetreecon_init(&new);
+
+	new->path = orig->path;
+
+	if (orig->context_str != NULL) {
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
 int cil_copy_fsuse(struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
 	struct cil_fsuse *orig = data;
@@ -1780,6 +1801,9 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 	case CIL_PCIDEVICECON:
 		copy_func = &cil_copy_pcidevicecon;
 		break;
+	case CIL_DEVICETREECON:
+		copy_func = &cil_copy_devicetreecon;
+		break;
 	case CIL_FSUSE:
 		copy_func = &cil_copy_fsuse;
 		break;
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index 7295b19..d839f68 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -102,6 +102,7 @@ enum cil_flavor {
 	CIL_IOMEMCON,
 	CIL_IOPORTCON,
 	CIL_PCIDEVICECON,
+	CIL_DEVICETREECON,
 	CIL_DEFAULTUSER,
 	CIL_DEFAULTROLE,
 	CIL_DEFAULTTYPE,
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index 11a2085..a43d111 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -206,6 +206,7 @@ char *CIL_KEY_PIRQCON;
 char *CIL_KEY_IOMEMCON;
 char *CIL_KEY_IOPORTCON;
 char *CIL_KEY_PCIDEVICECON;
+char *CIL_KEY_DEVICETREECON;
 char *CIL_KEY_FSUSE;
 char *CIL_KEY_POLICYCAP;
 char *CIL_KEY_OPTIONAL;
@@ -273,6 +274,7 @@ struct cil_db {
 	struct cil_sort *iomemcon;
 	struct cil_sort *ioportcon;
 	struct cil_sort *pcidevicecon;
+	struct cil_sort *devicetreecon;
 	struct cil_sort *fsuse;
 	struct cil_list *userprefixes;
 	struct cil_list *selinuxusers;
@@ -738,6 +740,13 @@ struct cil_pcidevicecon {
 	struct cil_context *context;
 };
 
+struct cil_devicetreecon {
+	char *path;
+	char *context_str;
+	struct cil_context *context;
+};
+
+
 /* Ensure that CIL uses the same values as sepol services.h */
 enum cil_fsuse_types {
 	CIL_FSUSE_XATTR = SECURITY_FS_USE_XATTR,
@@ -933,6 +942,7 @@ void cil_pirqcon_init(struct cil_pirqcon **pirqcon);
 void cil_iomemcon_init(struct cil_iomemcon **iomemcon);
 void cil_ioportcon_init(struct cil_ioportcon **ioportcon);
 void cil_pcidevicecon_init(struct cil_pcidevicecon **pcidevicecon);
+void cil_devicetreecon_init(struct cil_devicetreecon **devicetreecon);
 void cil_fsuse_init(struct cil_fsuse **fsuse);
 void cil_constrain_init(struct cil_constrain **constrain);
 void cil_validatetrans_init(struct cil_validatetrans **validtrans);
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index e89f16b..633a5a1 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -296,6 +296,17 @@ int cil_post_pcidevicecon_compare(const void *a, const void *b)
 	return rc;
 }
 
+int cil_post_devicetreecon_compare(const void *a, const void *b)
+{
+	int rc = SEPOL_ERR;
+	struct cil_devicetreecon *adevicetreecon = *(struct cil_devicetreecon**)a;
+	struct cil_devicetreecon *bdevicetreecon = *(struct cil_devicetreecon**)b;
+
+	rc = strcmp(adevicetreecon->path, bdevicetreecon->path);
+
+	return rc;
+}
+
 int cil_post_fsuse_compare(const void *a, const void *b)
 {
 	int rc;
@@ -377,6 +388,9 @@ static int __cil_post_db_count_helper(struct cil_tree_node *node, uint32_t *fini
 	case CIL_PCIDEVICECON:
 		db->pcidevicecon->count++;
 		break;	
+	case CIL_DEVICETREECON:
+		db->devicetreecon->count++;
+		break;
 	case CIL_FSUSE:
 		db->fsuse->count++;
 		break;
@@ -540,6 +554,17 @@ static int __cil_post_db_array_helper(struct cil_tree_node *node, __attribute__(
 		sort->index++;
 		break;
 	}
+	case CIL_DEVICETREECON: {
+		struct cil_sort *sort = db->devicetreecon;
+		uint32_t count = sort->count;
+		uint32_t i = sort->index;
+		if (sort->array == NULL) {
+			sort->array = cil_malloc(sizeof(*sort->array)*count);
+		}
+		sort->array[i] = node->data;
+		sort->index++;
+		break;
+	}
 	default:
 		break;
 	}
@@ -1305,6 +1330,14 @@ static int __cil_post_db_cat_helper(struct cil_tree_node *node, uint32_t *finish
 		}
 		break;
 	}
+	case CIL_DEVICETREECON: {
+		struct cil_devicetreecon *devicetreecon = node->data;
+		rc = __evaluate_levelrange_expression(devicetreecon->context->range, db);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		break;
+	}
 	case CIL_FSUSE: {
 		struct cil_fsuse *fsuse = node->data;
 		rc = __evaluate_levelrange_expression(fsuse->context->range, db);
@@ -1590,6 +1623,7 @@ static int cil_post_db(struct cil_db *db)
 	qsort(db->iomemcon->array, db->iomemcon->count, sizeof(db->iomemcon->array), cil_post_iomemcon_compare);
 	qsort(db->ioportcon->array, db->ioportcon->count, sizeof(db->ioportcon->array), cil_post_ioportcon_compare);
 	qsort(db->pcidevicecon->array, db->pcidevicecon->count, sizeof(db->pcidevicecon->array), cil_post_pcidevicecon_compare);
+	qsort(db->devicetreecon->array, db->devicetreecon->count, sizeof(db->devicetreecon->array), cil_post_devicetreecon_compare);
 
 exit:
 	return rc;
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 170e612..92f7720 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -323,6 +323,13 @@ static void cil_reset_pcidevicecon(struct cil_pcidevicecon *pcidevicecon)
 	}
 }
 
+static void cil_reset_devicetreecon(struct cil_devicetreecon *devicetreecon)
+{
+	if (devicetreecon->context_str == NULL) {
+		cil_reset_context(devicetreecon->context);
+	}
+}
+
 static void cil_reset_fsuse(struct cil_fsuse *fsuse)
 {
 	if (fsuse->context_str == NULL) {
@@ -475,6 +482,9 @@ int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32
 	case CIL_PCIDEVICECON:
 		cil_reset_pcidevicecon(node->data);
 		break;
+	case CIL_DEVICETREECON:
+		cil_reset_devicetreecon(node->data);
+		break;
 	case CIL_FSUSE:
 		cil_reset_fsuse(node->data);
 		break;
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index e27f965..7d46fd5 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1969,6 +1969,31 @@ exit:
 	return rc;
 }
 
+int cil_resolve_devicetreecon(struct cil_tree_node *current, void *extra_args)
+{
+	struct cil_devicetreecon *devicetreecon = current->data;
+	struct cil_symtab_datum *context_datum = NULL;
+	int rc = SEPOL_ERR;
+
+	if (devicetreecon->context_str != NULL) {
+		rc = cil_resolve_name(current, devicetreecon->context_str, CIL_SYM_CONTEXTS, extra_args, &context_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		devicetreecon->context = (struct cil_context*)context_datum;
+	} else {
+		rc = cil_resolve_context(current, devicetreecon->context, extra_args);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	return rc;
+}
+
 int cil_resolve_fsuse(struct cil_tree_node *current, void *extra_args)
 {
 	struct cil_fsuse *fsuse = current->data;
@@ -3185,6 +3210,9 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		case CIL_PCIDEVICECON:
 			rc = cil_resolve_pcidevicecon(node, args);
 			break;
+		case CIL_DEVICETREECON:
+			rc = cil_resolve_devicetreecon(node, args);
+			break;
 		case CIL_FSUSE:
 			rc = cil_resolve_fsuse(node, args);
 			break;
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 5420af2..2f5098f 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -1428,6 +1428,19 @@ void cil_tree_print_node(struct cil_tree_node *node)
 			cil_log(CIL_INFO, "\n");
 			return;
 		}
+		case CIL_DEVICETREECON: {
+			struct cil_devicetreecon *devicetreecon = node->data;
+
+			cil_log(CIL_INFO, "DEVICETREECON %s", devicetreecon->path);
+			if (devicetreecon->context != NULL) {
+				cil_tree_print_context(devicetreecon->context);
+			} else {
+				cil_log(CIL_INFO, " %s", devicetreecon->context_str);
+			}
+
+			cil_log(CIL_INFO, "\n");
+			return;
+		}
 		case CIL_FSUSE: {
 			struct cil_fsuse *fsuse = node->data;
 			cil_log(CIL_INFO, "FSUSE: ");
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 03e0fd1..399c94a 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1181,6 +1181,27 @@ exit:
 	return rc;
 }
 
+int __cil_verify_devicetreecon(struct cil_db *db, struct cil_tree_node *node)
+{
+	int rc = SEPOL_ERR;
+	struct cil_devicetreecon *dt = node->data;
+	struct cil_context *ctx = dt->context;
+
+	/* Verify only when anonymous */
+	if (ctx->datum.name == NULL) {
+		rc = __cil_verify_context(db, ctx);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR, "Invalid devicetreecon at line %d of %s\n", node->line, node->path);
+	return rc;
+}
+
 int __cil_verify_fsuse(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
@@ -1390,6 +1411,9 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished, void *ex
 		case CIL_PCIDEVICECON:
 			rc = __cil_verify_pcidevicecon(db, node);
 			break;
+		case CIL_DEVICETREECON:
+			rc = __cil_verify_devicetreecon(db, node);
+			break;
 		case CIL_FSUSE:
 			rc = __cil_verify_fsuse(db, node);
 			break;
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 946cbaf..31efc3a 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -375,6 +375,7 @@ typedef struct genfs {
 #define OCON_XEN_IOPORT     2    /* io ports */
 #define OCON_XEN_IOMEM	    3    /* io memory */
 #define OCON_XEN_PCIDEVICE  4    /* pci devices */
+#define OCON_XEN_DEVICETREE 5    /* device tree node */
 
 /* OCON_NUM needs to be the largest index in any platform's ocontext array */
 #define OCON_NUM   7
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 3193ef5..a8b1115 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2091,6 +2091,13 @@ static int ocontext_copy_xen(expand_state_t *state)
 			case OCON_XEN_PCIDEVICE:
 				n->u.device = c->u.device;
 				break;
+			case OCON_XEN_DEVICETREE:
+				n->u.name = strdup(c->u.name);
+				if (!n->u.name) {
+					ERR(state->handle, "Out of memory!");
+					return -1;
+				}
+				break;
 			default:
 				/* shouldn't get here */
 				ERR(state->handle, "Unknown ocontext");
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index d54eb9e..b45b662 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -70,7 +70,7 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_XEN_DEVICETREE,
 	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_XEN_PCIDEVICE + 1,
+	 .ocon_num = OCON_XEN_DEVICETREE + 1,
 	 .target_platform = SEPOL_TARGET_XEN,
 	 },
 	{
@@ -2478,7 +2478,7 @@ static int ocontext_read_xen(struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
 	unsigned int i, j;
-	size_t nel;
+	size_t nel, len;
 	ocontext_t *l, *c;
 	uint32_t buf[8];
 	int rc;
@@ -2555,6 +2555,20 @@ static int ocontext_read_xen(struct policydb_compat_info *info,
 				    (&c->context[0], p, fp))
 					return -1;
 				break;
+			case OCON_XEN_DEVICETREE:
+				rc = next_entry(buf, fp, sizeof(uint32_t));
+				if (rc < 0)
+					return -1;
+				len = le32_to_cpu(buf[1]);
+				c->u.name = malloc(len + 1);
+				if (!c->u.name)
+					return -1;
+				rc = next_entry(c->u.name, fp, len);
+				c->u.name[len] = 0;
+				if (context_read_and_validate
+				    (&c->context[0], p, fp))
+					return -1;
+				break;
 			default:
 				/* should never get here */
 				ERR(fp->handle, "Unknown Xen ocontext");
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 3452017..c97a4da 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1211,7 +1211,7 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
 			  struct policy_file *fp)
 {
 	unsigned int i, j;
-	size_t nel, items;
+	size_t nel, items, len;
 	uint32_t buf[32];
 	ocontext_t *c;
 	for (i = 0; i < info->ocon_num; i++) {
@@ -1288,6 +1288,18 @@ static int ocontext_write_xen(struct policydb_compat_info *info, policydb_t *p,
 				if (context_write(p, &c->context[0], fp))
 					return POLICYDB_ERROR;
 				break;
+			case OCON_XEN_DEVICETREE:
+				len = strlen(c->u.name);
+				buf[0] = cpu_to_le32(len);
+				items = put_entry(buf, sizeof(uint32_t), 1, fp);
+				if (items != 1)
+					return POLICYDB_ERROR;
+				items = put_entry(c->u.name, 1, len, fp);
+				if (items != len)
+					return POLICYDB_ERROR;
+				if (context_write(p, &c->context[0], fp))
+					return POLICYDB_ERROR;
+				break;
 			}
 		}
 	}
diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index b453a29..83542d3 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -88,6 +88,7 @@ tokens = (
     'IOMEMCON',
     'IOPORTCON',
     'PCIDEVICECON',
+    'DEVICETREECON',
     #   object classes
     'CLASS',
     #   types and attributes
@@ -152,6 +153,7 @@ reserved = {
     'iomemcon' : 'IOMEMCON',
     'ioportcon' : 'IOPORTCON',
     'pcidevicecon' : 'PCIDEVICECON',
+    'devicetreecon' : 'DEVICETREECON',
     # object classes
     'class' : 'CLASS',
     # types and attributes
@@ -524,6 +526,7 @@ def p_policy_stmt(p):
                    | iomemcon
                    | ioportcon
                    | pcidevicecon
+                   | devicetreecon
     '''
     if p[1]:
         p[0] = [p[1]]
@@ -703,6 +706,14 @@ def p_pcidevicecon(p):
 
     p[0] = c
 
+def p_devicetreecon(p):
+    'devicetreecon : DEVICETREECON NUMBER context'
+    c = refpolicy.DevicetTeeCon()
+    c.path = p[2]
+    c.context = p[3]
+
+    p[0] = c
+
 def p_mls_range_def(p):
     '''mls_range_def : mls_level_def MINUS mls_level_def
                      | mls_level_def
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index 8ad64a9..b8ed5c1 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -687,6 +687,15 @@ class PciDeviceCon(Leaf):
     def to_string(self):
         return "pcidevicecon %s %s" % (self.device, str(self.context))
 
+class DeviceTreeCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.path = ""
+        self.context = None
+
+    def to_string(self):
+        return "devicetreecon %s %s" % (self.path, str(self.context))
+
 # Reference policy specific types
 
 def print_tree(head):
-- 
2.1.0
