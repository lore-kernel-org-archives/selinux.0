Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44Laug7015744
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 17:36:56 -0400
Received: by mail-pf0-f181.google.com with SMTP id q66so13404619pfi.3
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 14:36:55 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Add attribute expansion options
Date: Thu,  4 May 2017 14:36:49 -0700
Message-Id: <20170504213649.29165-1-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This commit adds attribute expansion statements to the policy
language allowing compiler defaults to be overridden.

Always expands an attribute example:
expandattribute { foo } true;
CIL example:
(expandtypeattribute (foo) true)

Never expand an attribute example:
expandattribute { bar } false;
CIL example:
(expandtypeattribute (bar) false)

Adding the annotations directly to policy was chosen over other
methods as it is consistent with how targeted runtime optimizations
are specified in other languages. For example, in C the "inline"
command.

Motivation

expandattribute true:
Android has been moving away from a monolithic policy binary to
a two part split policy representing the Android platform and the
underlying vendor-provided hardware interface. The goal is a stable
API allowing these two parts to be updated independently of each
other. Attributes provide an important mechanism for compatibility.
For example, when the vendor provides a HAL for the platform,
permissions needed by clients of the HAL can be granted to an
attribute. Clients need only be assigned the attribute and do not
need to be aware of the underlying types and permissions being
granted.

Inheriting permissions via attribute creates a convenient mechanism
for independence between vendor and platform policy, but results
in the creation of many attributes, and the potential for performance
issues when processes are clients of many HALs. [1] Annotating these
attributes for expansion at compile time allows us to retain the
compatibility benefits of using attributes without the performance
costs. [2]

expandattribute false:
Commit 0be23c3f15fd added the capability to aggresively remove unused
attributes. This is generally useful as too many attributes assigned
to a type results in lengthy policy look up times when there is a
cache miss. However, removing attributes can also result in loss of
information used in external tests. On Android, we're considering
stripping neverallow rules from on-device policy. This is consistent
with the kernel policy binary which also did not contain neverallows.
Removing neverallow rules results in a 5-10% decrease in on-device
policy build and load and a policy size decrease of ~250k. Neverallow
rules are still asserted at build time and during device
certification (CTS). If neverallow rules are absent when secilc is
run, some attributes are being stripped from policy and neverallow
tests in CTS may be violated. [3] This change retains the aggressive
attribute stripping behavior but adds an override mechanism to
preserve attributes marked as necessary.

[1] https://github.com/SELinuxProject/cil/issues/9
[2] Annotating all HAL client attributes for expansion resulted in
    system_server's dropping from 19 attributes to 8. Because these
    attributes were not widely applied to other types, the final
    policy size change was negligible.
[3] data_file_type and service_manager_type are stripped from AOSP
    policy when using secilc's -G option. This impacts 11 neverallow
    tests in CTS.

Test: Build and boot Marlin with all hal_*_client attributes marked
    for expansion. Verify (using seinfo and sesearch) that permissions
    are correctly expanded from attributes to types.
Test: Mark types being stripped by secilc with "preserve" and verify
    that they are retained in policy and applied to the same types.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 checkpolicy/policy_define.c                | 82 ++++++++++++++++++++++++++++++
 checkpolicy/policy_define.h                |  1 +
 checkpolicy/policy_parse.y                 |  5 ++
 checkpolicy/policy_scan.l                  |  2 +
 libsepol/cil/src/cil.c                     | 15 ++++++
 libsepol/cil/src/cil_build_ast.c           | 72 ++++++++++++++++++++++++++
 libsepol/cil/src/cil_build_ast.h           |  2 +
 libsepol/cil/src/cil_copy_ast.c            | 26 ++++++++++
 libsepol/cil/src/cil_flavor.h              |  1 +
 libsepol/cil/src/cil_internal.h            | 16 ++++--
 libsepol/cil/src/cil_post.c                |  8 +++
 libsepol/cil/src/cil_reset_ast.c           |  1 +
 libsepol/cil/src/cil_resolve_ast.c         | 53 ++++++++++++++++++-
 libsepol/cil/src/cil_tree.c                | 11 ++++
 libsepol/include/sepol/policydb/policydb.h |  6 ++-
 libsepol/src/module_to_cil.c               | 11 ++++
 16 files changed, 307 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 949ca711..63e3c53f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1139,6 +1139,88 @@ int define_attrib(void)
 	return 0;
 }
 
+int expand_attrib(void)
+{
+	char *id;
+	ebitmap_t attrs;
+	type_datum_t *attr;
+	ebitmap_node_t *node;
+	uint32_t i;
+	int rc = -1;
+	int flags = 0;
+
+	if (pass == 1) {
+		for (i = 0; i < 2; i++) {
+			while ((id = queue_remove(id_queue))) {
+				free(id);
+			}
+		}
+		return 0;
+	}
+
+	ebitmap_init(&attrs);
+	while ((id = queue_remove(id_queue))) {
+		if (!id) {
+			yyerror("No attribute name for expandattribute statement?");
+			goto exit;
+		}
+
+		if (!is_id_in_scope(SYM_TYPES, id)) {
+			yyerror2("attribute %s is not within scope", id);
+			goto exit;
+		}
+
+		attr = hashtab_search(policydbp->p_types.table, id);
+		if (!attr) {
+			yyerror2("attribute %s is not declared", id);
+			goto exit;
+		}
+
+		if (attr->flavor != TYPE_ATTRIB) {
+			yyerror2("%s is a type, not an attribute", id);
+			goto exit;
+		}
+
+		if (attr->flags & TYPE_FLAGS_EXPAND_ATTR) {
+			yyerror2("%s already has the expandattribute option specified", id);
+			goto exit;
+		}
+		if (ebitmap_set_bit(&attrs, attr->s.value - 1, TRUE)) {
+			yyerror("Out of memory!");
+			goto exit;
+		}
+
+		free(id);
+	}
+
+	id = (char *) queue_remove(id_queue);
+	if (!id) {
+		yyerror("No option specified for attribute expansion.");
+		goto exit;
+	}
+
+	if (!strcmp(id, "T")) {
+		flags = TYPE_FLAGS_EXPAND_ATTR_TRUE;
+	} else {
+		flags = TYPE_FLAGS_EXPAND_ATTR_FALSE;
+	}
+
+	ebitmap_for_each_bit(&attrs, node, i) {
+		if (!ebitmap_node_get_bit(node, i)){
+			continue;
+		}
+		attr = hashtab_search(policydbp->p_types.table,
+				policydbp->sym_val_to_name[SYM_TYPES][i]);
+		attr->flags |= flags;
+	}
+
+	rc = 0;
+exit:
+	ebitmap_destroy(&attrs);
+	free(id);
+	return rc;
+}
+
 static int add_aliases_to_type(type_datum_t * type)
 {
 	char *id;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 964baae0..9f4b6d0d 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -65,6 +65,7 @@ int define_typebounds(void);
 int define_type(int alias);
 int define_user(void);
 int define_validatetrans(constraint_expr_t *expr);
+int expand_attrib(void);
 int insert_id(const char *id,int push);
 int insert_separator(int push);
 role_datum_t *define_role_dom(role_datum_t *r);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 3b6a2f86..1ac1c96b 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -103,6 +103,7 @@ typedef int (* require_func_t)(int pass);
 %token TYPES
 %token ALIAS
 %token ATTRIBUTE
+%token EXPANDATTRIBUTE
 %token BOOL
 %token TUNABLE
 %token IF
@@ -314,6 +315,7 @@ rbac_decl		: attribute_role_def
 			| role_attr_def
 			;
 te_decl			: attribute_def
+                        | expandattribute_def
                         | type_def
                         | typealias_def
                         | typeattribute_def
@@ -328,6 +330,9 @@ te_decl			: attribute_def
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) return -1;}
                         ;
+expandattribute_def     : EXPANDATTRIBUTE names bool_val ';'
+                        { if (expand_attrib()) return -1;}
+                        ;
 type_def		: TYPE identifier alias_def opt_attr_list ';'
                         {if (define_type(1)) return -1;}
 	                | TYPE identifier opt_attr_list ';'
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 2f7f2216..028bd25e 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -106,6 +106,8 @@ ALIAS |
 alias				{ return(ALIAS); }
 ATTRIBUTE |
 attribute			{ return(ATTRIBUTE); }
+EXPANDATTRIBUTE |
+expandattribute                 { return(EXPANDATTRIBUTE); }
 TYPE_TRANSITION |
 type_transition			{ return(TYPE_TRANSITION); }
 TYPE_MEMBER |
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index a64c5284..9b9ccc36 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -159,6 +159,7 @@ static void cil_init_keys(void)
 	CIL_KEY_SELINUXUSERDEFAULT = cil_strpool_add("selinuxuserdefault");
 	CIL_KEY_TYPEATTRIBUTE = cil_strpool_add("typeattribute");
 	CIL_KEY_TYPEATTRIBUTESET = cil_strpool_add("typeattributeset");
+	CIL_KEY_EXPANDTYPEATTRIBUTE = cil_strpool_add("expandtypeattribute");
 	CIL_KEY_TYPEALIAS = cil_strpool_add("typealias");
 	CIL_KEY_TYPEALIASACTUAL = cil_strpool_add("typealiasactual");
 	CIL_KEY_TYPEBOUNDS = cil_strpool_add("typebounds");
@@ -623,6 +624,9 @@ void cil_destroy_data(void **data, enum cil_flavor flavor)
 	case CIL_TYPEATTRIBUTESET:
 		cil_destroy_typeattributeset(*data);
 		break;
+	case CIL_EXPANDTYPEATTRIBUTE:
+		cil_destroy_expandtypeattribute(*data);
+		break;
 	case CIL_TYPEALIASACTUAL:
 		cil_destroy_aliasactual(*data);
 		break;
@@ -987,6 +991,8 @@ const char * cil_node_to_string(struct cil_tree_node *node)
 		return CIL_KEY_TYPEALIAS;
 	case CIL_TYPEATTRIBUTESET:
 		return CIL_KEY_TYPEATTRIBUTESET;
+	case CIL_EXPANDTYPEATTRIBUTE:
+		return CIL_KEY_EXPANDTYPEATTRIBUTE;
 	case CIL_TYPEALIASACTUAL:
 		return CIL_KEY_TYPEALIASACTUAL;
 	case CIL_TYPEBOUNDS:
@@ -2038,6 +2044,15 @@ void cil_typeattributeset_init(struct cil_typeattributeset **attrset)
 	(*attrset)->datum_expr = NULL;
 }
 
+void cil_expandtypeattribute_init(struct cil_expandtypeattribute **expandattr)
+{
+	*expandattr = cil_malloc(sizeof(**expandattr));
+
+	(*expandattr)->attr_strs = NULL;
+	(*expandattr)->attr_datums = NULL;
+	(*expandattr)->expand = 0;
+}
+
 void cil_alias_init(struct cil_alias **alias)
 {
 	*alias = cil_malloc(sizeof(**alias));
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4b03dc35..36cc6735 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3176,6 +3176,75 @@ void cil_destroy_typeattributeset(struct cil_typeattributeset *attrset)
 	free(attrset);
 }
 
+int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+{
+	enum cil_syntax syntax[] = {
+		CIL_SYN_STRING,
+		CIL_SYN_STRING | CIL_SYN_LIST,
+		CIL_SYN_STRING,
+		CIL_SYN_END
+	};
+	char *expand_str;
+	int syntax_len = sizeof(syntax)/sizeof(*syntax);
+	struct cil_expandtypeattribute *expandattr = NULL;
+	int rc = SEPOL_ERR;
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
+	cil_expandtypeattribute_init(&expandattr);
+
+	if (parse_current->next->cl_head == NULL) {
+		cil_list_init(&expandattr->attr_strs, CIL_TYPE);
+		cil_list_append(expandattr->attr_strs, CIL_STRING, parse_current->next->data);
+	} else {
+		rc = cil_fill_list(parse_current->next->cl_head, CIL_TYPE, &expandattr->attr_strs);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+	}
+
+	expand_str = parse_current->next->next->data;
+
+	if (expand_str == CIL_KEY_CONDTRUE) {
+		expandattr->expand = CIL_TRUE;
+	} else if (expand_str == CIL_KEY_CONDFALSE) {
+		expandattr->expand = CIL_FALSE;
+	} else {
+		cil_log(CIL_ERR, "Value must be either \'true\' or \'false\'");
+		goto exit;
+	}
+
+	ast_node->data = expandattr;
+	ast_node->flavor = CIL_EXPANDTYPEATTRIBUTE;
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(parse_current, CIL_ERR, "Bad expandtypeattribute statement");
+	cil_destroy_expandtypeattribute(expandattr);
+	return rc;
+}
+
+void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute *expandattr)
+{
+	if (expandattr == NULL) {
+		return;
+	}
+
+	cil_list_destroy(&expandattr->attr_strs, CIL_TRUE);
+
+	cil_list_destroy(&expandattr->attr_datums, CIL_FALSE);
+
+	free(expandattr);
+}
+
 int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
@@ -6013,6 +6082,9 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 	} else if (parse_current->data == CIL_KEY_TYPEATTRIBUTESET) {
 		rc = cil_gen_typeattributeset(db, parse_current, ast_node);
 		*finished = CIL_TREE_SKIP_NEXT;
+	} else if (parse_current->data == CIL_KEY_EXPANDTYPEATTRIBUTE) {
+		rc = cil_gen_expandtypeattribute(db, parse_current, ast_node);
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_TYPEALIAS) {
 		rc = cil_gen_alias(db, parse_current, ast_node, CIL_TYPEALIAS);
 	} else if (parse_current->data == CIL_KEY_TYPEALIASACTUAL) {
diff --git a/libsepol/cil/src/cil_build_ast.h b/libsepol/cil/src/cil_build_ast.h
index 54662035..33bae997 100644
--- a/libsepol/cil/src/cil_build_ast.h
+++ b/libsepol/cil/src/cil_build_ast.h
@@ -138,6 +138,8 @@ int cil_gen_aliasactual(struct cil_db *db, struct cil_tree_node *parse_current,
 void cil_destroy_aliasactual(struct cil_aliasactual *aliasactual);
 int cil_gen_typeattributeset(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_typeattributeset(struct cil_typeattributeset *attrtypes);
+int cil_gen_expandtypeattribute(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
+void cil_destroy_expandtypeattribute(struct cil_expandtypeattribute *expandattr);
 int cil_gen_typebounds(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 int cil_gen_typepermissive(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node);
 void cil_destroy_typepermissive(struct cil_typepermissive *typeperm);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 2d085dd7..d6685050 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -648,6 +648,29 @@ int cil_copy_typeattributeset(struct cil_db *db, void *data, void **copy, __attr
 	return SEPOL_OK;
 }
 
+int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
+{
+	struct cil_expandtypeattribute *orig = data;
+	struct cil_expandtypeattribute *new = NULL;
+
+	fprintf(stderr, "%s %u\n", __func__, __LINE__);
+	cil_expandtypeattribute_init(&new);
+
+	if (orig->attr_strs != NULL) {
+		cil_copy_list(orig->attr_strs, &new->attr_strs);
+	}
+
+	if (orig->attr_datums != NULL) {
+		cil_copy_list(orig->attr_datums, &new->attr_datums);
+	}
+
+	new->expand = orig->expand;
+
+	*copy = new;
+
+	return SEPOL_OK;
+}
+
 int cil_copy_alias(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
 {
 	struct cil_alias *orig = data;
@@ -1808,6 +1831,9 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 	case CIL_TYPEATTRIBUTESET:
 		copy_func = &cil_copy_typeattributeset;
 		break;
+	case CIL_EXPANDTYPEATTRIBUTE:
+		copy_func = &cil_copy_expandtypeattribute;
+		break;
 	case CIL_TYPEALIAS:
 		copy_func = &cil_copy_alias;
 		break;
diff --git a/libsepol/cil/src/cil_flavor.h b/libsepol/cil/src/cil_flavor.h
index cd08b972..c01f967a 100644
--- a/libsepol/cil/src/cil_flavor.h
+++ b/libsepol/cil/src/cil_flavor.h
@@ -73,6 +73,7 @@ enum cil_flavor {
 	CIL_ROLETYPE,
 	CIL_ROLEBOUNDS,
 	CIL_TYPEATTRIBUTESET,
+	CIL_EXPANDTYPEATTRIBUTE,
 	CIL_TYPEALIASACTUAL,
 	CIL_TYPEBOUNDS,
 	CIL_TYPEPERMISSIVE,
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
index efa2cd6e..aee3f00c 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -174,6 +174,7 @@ char *CIL_KEY_SELINUXUSER;
 char *CIL_KEY_SELINUXUSERDEFAULT;
 char *CIL_KEY_TYPEATTRIBUTE;
 char *CIL_KEY_TYPEATTRIBUTESET;
+char *CIL_KEY_EXPANDTYPEATTRIBUTE;
 char *CIL_KEY_TYPEALIAS;
 char *CIL_KEY_TYPEALIASACTUAL;
 char *CIL_KEY_TYPEBOUNDS;
@@ -515,9 +516,11 @@ struct cil_type	{
 	int value;
 };
 
-#define CIL_ATTR_AVRULE     0x01
-#define CIL_ATTR_NEVERALLOW 0x02
-#define CIL_ATTR_CONSTRAINT 0x04
+#define CIL_ATTR_AVRULE		(1 << 0)
+#define CIL_ATTR_NEVERALLOW	(1 << 1)
+#define CIL_ATTR_CONSTRAINT	(1 << 2)
+#define CIL_ATTR_EXPAND_TRUE	(1 << 3)
+#define CIL_ATTR_EXPAND_FALSE	(1 << 4)
 struct cil_typeattribute {
 	struct cil_symtab_datum datum;
 	struct cil_list *expr_list;
@@ -531,6 +534,12 @@ struct cil_typeattributeset {
 	struct cil_list *datum_expr;
 };
 
+struct cil_expandtypeattribute {
+	struct cil_list *attr_strs;
+	struct cil_list *attr_datums;
+	int expand;
+};
+
 struct cil_typepermissive {
 	char *type_str;
 	void *type; /* type or alias */
@@ -977,6 +986,7 @@ void cil_roleattributeset_init(struct cil_roleattributeset **attrset);
 void cil_roletype_init(struct cil_roletype **roletype);
 void cil_typeattribute_init(struct cil_typeattribute **attribute);
 void cil_typeattributeset_init(struct cil_typeattributeset **attrset);
+void cil_expandtypeattribute_init(struct cil_expandtypeattribute **expandattr);
 void cil_alias_init(struct cil_alias **alias);
 void cil_aliasactual_init(struct cil_aliasactual **aliasactual);
 void cil_typepermissive_init(struct cil_typepermissive **typeperm);
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index e32a8fc9..1941fab3 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1194,6 +1194,14 @@ static int cil_typeattribute_used(struct cil_typeattribute *attr, struct cil_db
 		return CIL_FALSE;
 	}
 
+	if (attr->used & CIL_ATTR_EXPAND_FALSE) {
+		return CIL_TRUE;
+	}
+
+	if (attr->used & CIL_ATTR_EXPAND_TRUE) {
+		return CIL_FALSE;
+	}
+
 	if (attr->used & CIL_ATTR_CONSTRAINT) {
 		return CIL_TRUE;
 	}
diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index de00679e..676e156e 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -549,6 +549,7 @@ int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)) uint32
 	case CIL_CLASSORDER:
 	case CIL_CATORDER:
 	case CIL_SENSITIVITYORDER:
+	case CIL_EXPANDTYPEATTRIBUTE:
 		break; /* Nothing to reset */
 	default:
 		break;
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 6da44ba1..8925b271 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -271,14 +271,24 @@ exit:
 
 int cil_type_used(struct cil_symtab_datum *datum, int used)
 {
+	int rc = SEPOL_ERR;
 	struct cil_typeattribute *attr = NULL;
 
 	if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
 		attr = (struct cil_typeattribute*)datum;
 		attr->used |= used;
+		if ((attr->used & CIL_ATTR_EXPAND_TRUE) &&
+				(attr->used & CIL_ATTR_EXPAND_FALSE)) {
+			cil_log(CIL_ERR, "Conflicting use of expandtypeattribute. "
+					"Expandtypeattribute may be set to true or false "
+					"but not both. \n");
+			goto exit;
+		}
 	}
 
-	return 0;
+	return SEPOL_OK;
+exit:
+	return rc;
 }
 
 int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
@@ -453,6 +463,44 @@ exit:
 	return rc;
 }
 
+int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void *extra_args)
+{
+	struct cil_expandtypeattribute *expandattr = current->data;
+	struct cil_symtab_datum *attr_datum = NULL;
+	struct cil_tree_node *attr_node = NULL;
+	struct cil_list_item *curr;
+	int used;
+	int rc = SEPOL_ERR;
+
+	cil_list_init(&expandattr->attr_datums, CIL_TYPE);
+
+	cil_list_for_each(curr, expandattr->attr_strs) {
+		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_TYPES, extra_args, &attr_datum);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		attr_node = attr_datum->nodes->head->data;
+
+		if (attr_node->flavor != CIL_TYPEATTRIBUTE) {
+			rc = SEPOL_ERR;
+			cil_log(CIL_ERR, "Attribute type not an attribute\n");
+			goto exit;
+		}
+		used = expandattr->expand ? CIL_ATTR_EXPAND_TRUE : CIL_ATTR_EXPAND_FALSE;
+		rc = cil_type_used(attr_datum, used);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+
+		cil_list_append(expandattr->attr_datums, CIL_TYPE, attr_datum);
+	}
+
+	return SEPOL_OK;
+exit:
+	return rc;
+}
+
 int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)
 {
 	int rc = SEPOL_ERR;
@@ -3432,6 +3480,9 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 		case CIL_TYPEATTRIBUTESET:
 			rc = cil_resolve_typeattributeset(node, args);
 			break;
+		case CIL_EXPANDTYPEATTRIBUTE:
+			rc = cil_resolve_expandtypeattribute(node, args);
+			break;
 		case CIL_TYPEBOUNDS:
 			rc = cil_resolve_bounds(node, args, CIL_TYPE, CIL_TYPEATTRIBUTE);
 			break;
diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 9ff9d4b4..2cc2744a 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -703,6 +703,17 @@ void cil_tree_print_node(struct cil_tree_node *node)
 			cil_log(CIL_INFO, "TYPE: %s\n", type->datum.name);
 			return;
 		}
+		case CIL_EXPANDTYPEATTRIBUTE: {
+			struct cil_expandtypeattribute *attr = node->data;
+
+			fprintf(stderr, "%s %u\n", __func__, __LINE__);
+			cil_log(CIL_INFO, "(EXPANDTYPEATTRIBUTE ");
+			cil_tree_print_expr(attr->attr_datums, attr->attr_strs);
+			cil_log(CIL_INFO, "%s)\n",attr->expand ?
+					CIL_KEY_CONDTRUE : CIL_KEY_CONDFALSE);
+
+			return;
+		}
 		case CIL_TYPEATTRIBUTESET: {
 			struct cil_typeattributeset *attr = node->data;
 
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 4336a3f2..37e0c9e5 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -178,7 +178,11 @@ typedef struct type_datum {
 #define TYPE_ALIAS 2		/* alias in modular policy */
 	uint32_t flavor;
 	ebitmap_t types;	/* types with this attribute */
-#define TYPE_FLAGS_PERMISSIVE	0x01
+#define TYPE_FLAGS_PERMISSIVE		(1 << 0)
+#define TYPE_FLAGS_EXPAND_ATTR_TRUE	(1 << 1)
+#define TYPE_FLAGS_EXPAND_ATTR_FALSE	(1 << 2)
+#define TYPE_FLAGS_EXPAND_ATTR (TYPE_FLAGS_EXPAND_ATTR_TRUE | \
+				TYPE_FLAGS_EXPAND_ATTR_FALSE)
 	uint32_t flags;
 	uint32_t bounds;	/* bounds type, if exist */
 } type_datum_t;
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ac095c30..7d8eb204 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2244,6 +2244,17 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_println(indent, "(typeattribute %s)", key);
 		}
 
+		if (type->flags & TYPE_FLAGS_EXPAND_ATTR) {
+			cil_indent(indent);
+			cil_printf("(expandtypeattribute (%s) ", key);
+			if (type->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) {
+				cil_printf("true");
+			} else if (type->flags & TYPE_FLAGS_EXPAND_ATTR_FALSE) {
+				cil_printf("false");
+			}
+			cil_printf(")\n");
+		}
+
 		if (ebitmap_cardinality(&type->types) > 0) {
 			cil_indent(indent);
 			cil_printf("(typeattributeset %s (", key);
-- 
2.13.0.rc1.294.g07d810a77f-goog
