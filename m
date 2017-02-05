Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15FwkV5005440
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 10:58:46 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BC12D564781
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 16:58:42 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 7/8] libsepol/tests: fix -Wwrite-strings warnings
Date: Sun,  5 Feb 2017 16:58:19 +0100
Message-Id: <20170205155820.29157-7-nicolas.iooss@m4x.org>
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since fd9e5ef7b78b ("libsepol: use constant keys in hashtab functions")
it is possible to call hashtab_search() with a const char* key value.
Doing so fixes compiler warnings about non-const char* string literals
(-Wwrite-strings flag).

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/helpers.c                |  2 +-
 libsepol/tests/helpers.h                |  2 +-
 libsepol/tests/test-common.c            |  8 ++++----
 libsepol/tests/test-common.h            |  8 ++++----
 libsepol/tests/test-deps.c              |  4 ++--
 libsepol/tests/test-expander-attr-map.c | 34 ++++++++++++++++-----------------
 libsepol/tests/test-expander-roles.c    |  2 +-
 libsepol/tests/test-expander-users.c    |  4 ++--
 libsepol/tests/test-expander.c          | 14 +++++++-------
 libsepol/tests/test-linker-cond-map.c   |  4 ++--
 libsepol/tests/test-linker-roles.c      |  4 ++--
 libsepol/tests/test-linker-types.c      |  6 +++---
 12 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/libsepol/tests/helpers.c b/libsepol/tests/helpers.c
index 542e46743aa0..1192734b971f 100644
--- a/libsepol/tests/helpers.c
+++ b/libsepol/tests/helpers.c
@@ -63,7 +63,7 @@ int test_load_policy(policydb_t * p, int policy_type, int mls, const char *test_
 	return 0;
 }
 
-avrule_decl_t *test_find_decl_by_sym(policydb_t * p, int symtab, char *sym)
+avrule_decl_t *test_find_decl_by_sym(policydb_t * p, int symtab, const char *sym)
 {
 	scope_datum_t *scope = (scope_datum_t *) hashtab_search(p->scope[symtab].table, sym);
 
diff --git a/libsepol/tests/helpers.h b/libsepol/tests/helpers.h
index 418ee9541959..10d390946499 100644
--- a/libsepol/tests/helpers.h
+++ b/libsepol/tests/helpers.h
@@ -54,6 +54,6 @@ extern int test_load_policy(policydb_t * p, int policy_type, int mls, const char
  *  decl      success 
  *  NULL      error (including more than one declaration)
  */
-extern avrule_decl_t *test_find_decl_by_sym(policydb_t * p, int symtab, char *sym);
+extern avrule_decl_t *test_find_decl_by_sym(policydb_t * p, int symtab, const char *sym);
 
 #endif
diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
index dae47df3dd01..81074031844d 100644
--- a/libsepol/tests/test-common.c
+++ b/libsepol/tests/test-common.c
@@ -26,7 +26,7 @@
 
 #include <CUnit/Basic.h>
 
-void test_sym_presence(policydb_t * p, char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len)
+void test_sym_presence(policydb_t * p, const char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len)
 {
 	scope_datum_t *scope;
 	int found;
@@ -147,7 +147,7 @@ void test_policydb_indexes(policydb_t * p)
 	}
 }
 
-void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mode, unsigned int flavor)
+void test_alias_datum(policydb_t * p, const char *id, const char *primary_id, char mode, unsigned int flavor)
 {
 	type_datum_t *type, *primary;
 	unsigned int my_primary, my_flavor, my_value;
@@ -181,7 +181,7 @@ void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mode, uns
 	}
 }
 
-role_datum_t *test_role_type_set(policydb_t * p, char *id, avrule_decl_t * decl, char **types, unsigned int len, unsigned int flags)
+role_datum_t *test_role_type_set(policydb_t * p, const char *id, avrule_decl_t * decl, const char **types, unsigned int len, unsigned int flags)
 {
 	ebitmap_node_t *tnode;
 	unsigned int i, j, new, found = 0;
@@ -222,7 +222,7 @@ role_datum_t *test_role_type_set(policydb_t * p, char *id, avrule_decl_t * decl,
 	return role;
 }
 
-void test_attr_types(policydb_t * p, char *id, avrule_decl_t * decl, char **types, int len)
+void test_attr_types(policydb_t * p, const char *id, avrule_decl_t * decl, const char **types, int len)
 {
 	ebitmap_node_t *tnode;
 	int j, new, found = 0;
diff --git a/libsepol/tests/test-common.h b/libsepol/tests/test-common.h
index 5a1e65070b54..1e31c8d1f80c 100644
--- a/libsepol/tests/test-common.h
+++ b/libsepol/tests/test-common.h
@@ -34,7 +34,7 @@
  * This is a utility function to test for the symbol's presence in the global symbol table, 
  * the scope table, and that the decl blocks we think this symbol is in are correct
  */
-extern void test_sym_presence(policydb_t * p, char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len);
+extern void test_sym_presence(policydb_t * p, const char *id, int sym_type, unsigned int scope_type, unsigned int *decls, unsigned int len);
 
 /* Test the indexes in the policydb to ensure their correctness. These include
  * the sym_val_to_name[], class_val_to_struct, role_val_to_struct, type_val_to_struct,
@@ -50,7 +50,7 @@ extern void test_policydb_indexes(policydb_t * p);
          1 = automatically detect the flavor value and test the datum accordingly
  * flavor = flavor value if in mode 0
  */
-extern void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mode, unsigned int flavor);
+extern void test_alias_datum(policydb_t * p, const char *id, const char *primary_id, char mode, unsigned int flavor);
 
 /* p		the policy being inspected
  * id		string role identifier
@@ -62,7 +62,7 @@ extern void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mo
  * This is a utility function to test whether the type set associated with a role in a specific
  * avrule decl block matches our expectations
  */
-extern role_datum_t *test_role_type_set(policydb_t * p, char *id, avrule_decl_t * decl, char **types, unsigned int len, unsigned int flags);
+extern role_datum_t *test_role_type_set(policydb_t * p, const char *id, avrule_decl_t * decl, const char **types, unsigned int len, unsigned int flags);
 
 /* p		the policy being inspected
  * id		string attribute identifier
@@ -73,6 +73,6 @@ extern role_datum_t *test_role_type_set(policydb_t * p, char *id, avrule_decl_t
  * This is a utility function to test whether the type set associated with an attribute in a specific
  * avrule decl block matches our expectations 
  */
-extern void test_attr_types(policydb_t * p, char *id, avrule_decl_t * decl, char **types, int len);
+extern void test_attr_types(policydb_t * p, const char *id, avrule_decl_t * decl, const char **types, int len);
 
 #endif
diff --git a/libsepol/tests/test-deps.c b/libsepol/tests/test-deps.c
index ed23e0992ced..f495087ac41a 100644
--- a/libsepol/tests/test-deps.c
+++ b/libsepol/tests/test-deps.c
@@ -135,7 +135,7 @@ int deps_test_cleanup(void)
  *  decl_type          name of the unique type found in the module's global
  *                       section is to find that avrule_decl.
  */
-static void do_deps_modreq_global(int req_met, int b, char *policy, char *decl_type)
+static void do_deps_modreq_global(int req_met, int b, const char *policy, const char *decl_type)
 {
 	policydb_t *base;
 	policydb_t mod;
@@ -218,7 +218,7 @@ static void deps_modreq_global(void)
  *  decl_type          name of the unique type found in the module's global
  *                       section is to find that avrule_decl.
  */
-static void do_deps_modreq_opt(int req_met, int ret_val, int b, char *policy, char *decl_type)
+static void do_deps_modreq_opt(int req_met, int ret_val, int b, const char *policy, const char *decl_type)
 {
 	policydb_t *base;
 	policydb_t mod;
diff --git a/libsepol/tests/test-expander-attr-map.c b/libsepol/tests/test-expander-attr-map.c
index 5c24ced237dd..b2f59aee42c8 100644
--- a/libsepol/tests/test-expander-attr-map.c
+++ b/libsepol/tests/test-expander-attr-map.c
@@ -35,35 +35,35 @@ void test_expander_attr_mapping(void)
 	   because declare in optional then require in a different optional
 	   logic still doesn't work */
 
-	char *typesb1[] = { "attr_check_base_1_1_t", "attr_check_base_1_2_t" };
-	char *typesb2[] = { "attr_check_base_2_1_t", "attr_check_base_2_2_t" };
-	char *typesb3[] = { "attr_check_base_3_1_t", "attr_check_base_3_2_t",
+	const char *typesb1[] = { "attr_check_base_1_1_t", "attr_check_base_1_2_t" };
+	const char *typesb2[] = { "attr_check_base_2_1_t", "attr_check_base_2_2_t" };
+	const char *typesb3[] = { "attr_check_base_3_1_t", "attr_check_base_3_2_t",
 		"attr_check_base_3_3_t", "attr_check_base_3_4_t"
 	};
-	char *typesb4[] = { "attr_check_base_4_1_t", "attr_check_base_4_2_t" };
-	char *typesb5[] = { "attr_check_base_5_1_t", "attr_check_base_5_2_t" };
-	char *typesb6[] = { "attr_check_base_6_1_t", "attr_check_base_6_2_t",
+	const char *typesb4[] = { "attr_check_base_4_1_t", "attr_check_base_4_2_t" };
+	const char *typesb5[] = { "attr_check_base_5_1_t", "attr_check_base_5_2_t" };
+	const char *typesb6[] = { "attr_check_base_6_1_t", "attr_check_base_6_2_t",
 		"attr_check_base_6_3_t", "attr_check_base_6_4_t"
 	};
-	char *typesbo2[] = { "attr_check_base_optional_2_1_t",
+	const char *typesbo2[] = { "attr_check_base_optional_2_1_t",
 		"attr_check_base_optional_2_2_t"
 	};
-	char *typesbo5[] = { "attr_check_base_optional_5_1_t",
+	const char *typesbo5[] = { "attr_check_base_optional_5_1_t",
 		"attr_check_base_optional_5_2_t"
 	};
-	char *typesm2[] = { "attr_check_mod_2_1_t", "attr_check_mod_2_2_t" };
-	char *typesm4[] = { "attr_check_mod_4_1_t", "attr_check_mod_4_2_t" };
-	char *typesm5[] = { "attr_check_mod_5_1_t", "attr_check_mod_5_2_t" };
-	char *typesm6[] = { "attr_check_mod_6_1_t", "attr_check_mod_6_2_t",
+	const char *typesm2[] = { "attr_check_mod_2_1_t", "attr_check_mod_2_2_t" };
+	const char *typesm4[] = { "attr_check_mod_4_1_t", "attr_check_mod_4_2_t" };
+	const char *typesm5[] = { "attr_check_mod_5_1_t", "attr_check_mod_5_2_t" };
+	const char *typesm6[] = { "attr_check_mod_6_1_t", "attr_check_mod_6_2_t",
 		"attr_check_mod_6_3_t", "attr_check_mod_6_4_t"
 	};
-	char *typesmo2[] = { "attr_check_mod_optional_4_1_t",
+	const char *typesmo2[] = { "attr_check_mod_optional_4_1_t",
 		"attr_check_mod_optional_4_2_t"
 	};
-	char *typesb10[] = { "attr_check_base_10_1_t", "attr_check_base_10_2_t" };
-	char *typesb11[] = { "attr_check_base_11_3_t", "attr_check_base_11_4_t" };
-	char *typesm10[] = { "attr_check_mod_10_1_t", "attr_check_mod_10_2_t" };
-	char *typesm11[] = { "attr_check_mod_11_3_t", "attr_check_mod_11_4_t" };
+	const char *typesb10[] = { "attr_check_base_10_1_t", "attr_check_base_10_2_t" };
+	const char *typesb11[] = { "attr_check_base_11_3_t", "attr_check_base_11_4_t" };
+	const char *typesm10[] = { "attr_check_mod_10_1_t", "attr_check_mod_10_2_t" };
+	const char *typesm11[] = { "attr_check_mod_11_3_t", "attr_check_mod_11_4_t" };
 
 	test_attr_types(&base_expanded2, "attr_check_base_1", NULL, typesb1, 2);
 	test_attr_types(&base_expanded2, "attr_check_base_2", NULL, typesb2, 2);
diff --git a/libsepol/tests/test-expander-roles.c b/libsepol/tests/test-expander-roles.c
index ecfa88e338d0..aba3c9bd19c4 100644
--- a/libsepol/tests/test-expander-roles.c
+++ b/libsepol/tests/test-expander-roles.c
@@ -31,7 +31,7 @@ extern policydb_t role_expanded;
 
 void test_expander_role_mapping(void)
 {
-	char *types1[] = { "role_check_1_1_t", "role_check_1_2_t" };
+	const char *types1[] = { "role_check_1_1_t", "role_check_1_2_t" };
 
 	test_role_type_set(&role_expanded, "role_check_1", NULL, types1, 2, 0);
 }
diff --git a/libsepol/tests/test-expander-users.c b/libsepol/tests/test-expander-users.c
index 549492b183a6..f3b98a6c224e 100644
--- a/libsepol/tests/test-expander-users.c
+++ b/libsepol/tests/test-expander-users.c
@@ -28,7 +28,7 @@
 
 extern policydb_t user_expanded;
 
-static void check_user_roles(policydb_t * p, char *user_name, char **role_names, int num_roles)
+static void check_user_roles(policydb_t * p, const char *user_name, const char **role_names, int num_roles)
 {
 	user_datum_t *user;
 	ebitmap_node_t *tnode;
@@ -69,7 +69,7 @@ static void check_user_roles(policydb_t * p, char *user_name, char **role_names,
 
 void test_expander_user_mapping(void)
 {
-	char *roles1[] = { "user_check_1_1_r", "user_check_1_2_r" };
+	const char *roles1[] = { "user_check_1_1_r", "user_check_1_2_r" };
 
 	check_user_roles(&user_expanded, "user_check_1", roles1, 2);
 }
diff --git a/libsepol/tests/test-expander.c b/libsepol/tests/test-expander.c
index bc946c778b1d..ee70e220918c 100644
--- a/libsepol/tests/test-expander.c
+++ b/libsepol/tests/test-expander.c
@@ -67,7 +67,7 @@ extern int mls;
 /* Takes base, some number of modules, links them, and expands them
    reads source from myfiles array, which has the base string followed by
    each module string */
-int expander_policy_init(policydb_t * mybase, int num_modules, policydb_t ** mymodules, policydb_t * myexpanded, char **myfiles)
+int expander_policy_init(policydb_t * mybase, int num_modules, policydb_t ** mymodules, policydb_t * myexpanded, const char *const *myfiles)
 {
 	char *filename[num_modules + 1];
 	int i;
@@ -130,14 +130,14 @@ int expander_policy_init(policydb_t * mybase, int num_modules, policydb_t ** mym
 
 int expander_test_init(void)
 {
-	char *small_base_file = "small-base.conf";
-	char *base_only_file = "base-base-only.conf";
+	const char *small_base_file = "small-base.conf";
+	const char *base_only_file = "base-base-only.conf";
 	int rc;
 	policydb_t *mymod2;
-	char *files2[] = { "small-base.conf", "module.conf" };
-	char *role_files[] = { "role-base.conf", "role-module.conf" };
-	char *user_files[] = { "user-base.conf", "user-module.conf" };
-	char *alias_files[] = { "alias-base.conf", "alias-module.conf" };
+	const char *files2[] = { "small-base.conf", "module.conf" };
+	const char *role_files[] = { "role-base.conf", "role-module.conf" };
+	const char *user_files[] = { "user-base.conf", "user-module.conf" };
+	const char *alias_files[] = { "alias-base.conf", "alias-module.conf" };
 
 	rc = expander_policy_init(&basemod, 0, NULL, &base_expanded, &small_base_file);
 	if (rc != 0)
diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/test-linker-cond-map.c
index 0ef0d698d58c..712d99149883 100644
--- a/libsepol/tests/test-linker-cond-map.c
+++ b/libsepol/tests/test-linker-cond-map.c
@@ -50,7 +50,7 @@
  */
 
 typedef struct test_cond_expr {
-	char *bool;
+	const char *bool;
 	uint32_t expr_type;
 } test_cond_expr_t;
 
@@ -75,7 +75,7 @@ void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_expr_t
 	}
 }
 
-void test_bool_state(policydb_t * p, char *bool, int state)
+void test_bool_state(policydb_t * p, const char *bool, int state)
 {
 	cond_bool_datum_t *b;
 
diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-linker-roles.c
index 569e2ccf5ee7..c9e2f2ba7e90 100644
--- a/libsepol/tests/test-linker-roles.c
+++ b/libsepol/tests/test-linker-roles.c
@@ -72,7 +72,7 @@ void base_role_tests(policydb_t * base)
 	avrule_decl_t *decl;
 	role_datum_t *role;
 	unsigned int decls[2];
-	char *types[2];
+	const char *types[2];
 
 	/* These tests look at roles in the base only, the desire is to ensure that
 	 * roles are not destroyed or otherwise removed during the link process */
@@ -102,7 +102,7 @@ void module_role_tests(policydb_t * base)
 	role_datum_t *role;
 	avrule_decl_t *decl;
 	unsigned int decls[3];
-	char *types[3];
+	const char *types[3];
 
 	/* These tests are run when the base is linked with 2 modules,
 	 * They should test whether the roles get copied correctly from the 
diff --git a/libsepol/tests/test-linker-types.c b/libsepol/tests/test-linker-types.c
index 94f16ac1615c..b41e08e0099c 100644
--- a/libsepol/tests/test-linker-types.c
+++ b/libsepol/tests/test-linker-types.c
@@ -97,7 +97,7 @@
  */
 
 /* Don't pass in decls from global blocks since symbols aren't stored in their symtab */
-static void test_type_datum(policydb_t * p, char *id, unsigned int *decls, int len, unsigned int primary)
+static void test_type_datum(policydb_t * p, const char *id, unsigned int *decls, int len, unsigned int primary)
 {
 	int i;
 	unsigned int value;
@@ -125,7 +125,7 @@ static void test_type_datum(policydb_t * p, char *id, unsigned int *decls, int l
 void base_type_tests(policydb_t * base)
 {
 	unsigned int decls[2];
-	char *types[2];
+	const char *types[2];
 
 	/* These tests look at types in the base only, the desire is to ensure that
 	 * types are not destroyed or otherwise removed during the link process.
@@ -163,7 +163,7 @@ void base_type_tests(policydb_t * base)
 void module_type_tests(policydb_t * base)
 {
 	unsigned int decls[2];
-	char *types[2];
+	const char *types[2];
 	avrule_decl_t *d;
 
 	/* These tests look at types that were copied from modules or attributes
-- 
2.11.0
