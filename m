Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k77FDfSl001542
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 11:13:41 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k77FDXCS012279
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 15:13:33 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k77FDUXQ019467
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 11:13:30 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k77FDUeo019466
	for selinux@tycho.nsa.gov; Mon, 7 Aug 2006 11:13:30 -0400
Subject: [PATCH 3/5] libsepol tests for the linker
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:17:33 -0400
Message-Id: <1154614654.4909.19.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This tests the linker in a macro fashion. It basically runs policies
through the linker and tests for the expected result on the other side.
The coverage is listed at the top of each test file
(test-linker-types.c). 

diff -pruN -x policies trunk.old/libsepol/tests/libsepol-tests.c trunk/libsepol/tests/libsepol-tests.c
--- trunk.old/libsepol/tests/libsepol-tests.c	2006-08-03 09:47:55.000000000 -0400
+++ trunk/libsepol/tests/libsepol-tests.c	2006-08-03 09:50:58.000000000 -0400
@@ -19,6 +19,7 @@
  */
 
 #include "test-cond.h"
+#include "test-linker.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -55,6 +56,7 @@ static int do_tests(int interactive, int
 		return CU_get_error();
 
 	DECLARE_SUITE(cond);
+	DECLARE_SUITE(linker);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff -pruN -x policies trunk.old/libsepol/tests/test-linker.c trunk/libsepol/tests/test-linker.c
--- trunk.old/libsepol/tests/test-linker.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker.c	2006-08-01 11:12:40.000000000 -0400
@@ -0,0 +1,154 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/* This is where the linker tests should go, including:
+ * - check role, type, bool, user, attr mapping
+ * - check for properly enabled optional
+ * - check for properly disabled optional
+ * - check for non-optional disabled blocks
+ * - properly add symbols declared in optionals
+ */
+
+#include "test-linker.h"
+#include "parse_util.h"
+#include "helpers.h"
+#include "test-common.h"
+#include "test-linker-roles.h"
+#include "test-linker-types.h"
+#include "test-linker-cond-map.h"
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/link.h>
+#include <sepol/policydb/conditional.h>
+#include <sepol/policydb/expand.h>
+#include <limits.h>
+#include <stdlib.h>
+
+#define NUM_MODS 2
+#define NUM_POLICIES NUM_MODS+1
+
+#define BASEMOD NUM_MODS
+const char *policies[NUM_POLICIES] = {
+	"module1.conf",
+	"module2.conf",
+	"small-base.conf",
+};
+
+static policydb_t basenomods;
+static policydb_t linkedbase;
+static policydb_t *modules[NUM_MODS];
+extern int mls;
+
+int linker_test_init(void)
+{
+	int i;
+
+	if (test_load_policy(&linkedbase, POLICY_BASE, mls, "test-linker", policies[BASEMOD]))
+		return -1;
+
+	if (test_load_policy(&basenomods, POLICY_BASE, mls, "test-linker", policies[BASEMOD]))
+		return -1;
+
+	for (i = 0; i < NUM_MODS; i++) {
+
+		modules[i] = calloc(1, sizeof(*modules[i]));
+		if (!modules[i]) {
+			fprintf(stderr, "out of memory!\n");
+			return -1;
+		}
+
+		if (test_load_policy(modules[i], POLICY_MOD, mls, "test-linker", policies[i]))
+			return -1;
+
+	}
+
+	if (link_modules(NULL, &linkedbase, modules, NUM_MODS, 0)) {
+		fprintf(stderr, "link modules failed\n");
+		return -1;
+	}
+
+	if (link_modules(NULL, &basenomods, NULL, 0, 0)) {
+		fprintf(stderr, "link modules failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+int linker_test_cleanup(void)
+{
+	int i;
+
+	policydb_destroy(&basenomods);
+	policydb_destroy(&linkedbase);
+
+	for (i = 0; i < NUM_MODS; i++) {
+		policydb_destroy(modules[i]);
+		free(modules[i]);
+	}
+	return 0;
+}
+
+static void test_linker_indexes(void)
+{
+	test_policydb_indexes(&linkedbase);
+}
+
+static void test_linker_roles(void)
+{
+	base_role_tests(&basenomods);
+	base_role_tests(&linkedbase);
+	module_role_tests(&linkedbase);
+}
+
+static void test_linker_types(void)
+{
+	base_type_tests(&basenomods);
+	base_type_tests(&linkedbase);
+	module_type_tests(&linkedbase);
+}
+
+static void test_linker_cond(void)
+{
+	base_cond_tests(&basenomods);
+	base_cond_tests(&linkedbase);
+	module_cond_tests(&linkedbase);
+}
+
+int linker_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "linker_indexes", test_linker_indexes)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL == CU_add_test(suite, "linker_types", test_linker_types)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL == CU_add_test(suite, "linker_roles", test_linker_roles)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL == CU_add_test(suite, "linker_cond", test_linker_cond)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	return 0;
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-linker-cond-map.c trunk/libsepol/tests/test-linker-cond-map.c
--- trunk.old/libsepol/tests/test-linker-cond-map.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker-cond-map.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,159 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "parse_util.h"
+#include "helpers.h"
+#include "test-common.h"
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/link.h>
+#include <sepol/policydb/conditional.h>
+
+#include <CUnit/Basic.h>
+#include <stdlib.h>
+
+/* Tests for conditionals
+ * Test each cond/bool for these
+ * - boolean copied correctly (state is correct)
+ * - conditional expression is correct
+ * Tests: 
+ * - single boolean in base
+ * - single boolean in module
+ * - single boolean in base optional
+ * - single boolean in module optional
+ * - 2 booleans in base
+ * - 2 booleans in module
+ * - 2 booleans in base optional
+ * - 2 booleans in module optional
+ * - 2 booleans, base and module
+ * - 2 booleans, base optional and module
+ * - 2 booleans, base optional and module optional
+ * - 3 booleans, base, base optional, module
+ * - 4 boolean, base, base optional, module, module optional
+ */
+
+typedef struct test_cond_expr {
+	char *bool;
+	uint32_t expr_type;
+} test_cond_expr_t;
+
+void test_cond_expr_mapping(policydb_t * p, avrule_decl_t * d, test_cond_expr_t * bools, int len)
+{
+	int i;
+	cond_expr_t *expr;
+
+	CU_ASSERT_FATAL(d->cond_list != NULL);
+	CU_ASSERT_FATAL(d->cond_list->expr != NULL);
+
+	expr = d->cond_list->expr;
+
+	for (i = 0; i < len; i++) {
+		CU_ASSERT_FATAL(expr != NULL);
+
+		CU_ASSERT(expr->expr_type == bools[i].expr_type);
+		if (bools[i].bool) {
+			CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][expr->bool - 1], bools[i].bool) == 0);
+		}
+		expr = expr->next;
+	}
+}
+
+void test_bool_state(policydb_t * p, char *bool, int state)
+{
+	cond_bool_datum_t *b;
+
+	b = hashtab_search(p->p_bools.table, bool);
+	CU_ASSERT_FATAL(b != NULL);
+	CU_ASSERT(b->state == state);
+}
+
+void base_cond_tests(policydb_t * base)
+{
+	avrule_decl_t *d;
+	unsigned int decls[1];
+	test_cond_expr_t bools[2];
+
+	/* these tests look at booleans and conditionals in the base only
+	 * to ensure that they aren't altered or removed during the link process */
+
+	/* bool existance and state, global scope */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b");
+	decls[0] = d->decl_id;
+	test_sym_presence(base, "g_b_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
+	test_bool_state(base, "g_b_bool_1", 0);
+	/* conditional expression mapped correctly */
+	bools[0].bool = "g_b_bool_1";
+	bools[0].expr_type = COND_BOOL;
+	test_cond_expr_mapping(base, d, bools, 1);
+
+	/* bool existance and state, optional scope */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_b");
+	decls[0] = d->decl_id;
+	test_sym_presence(base, "o1_b_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
+	test_bool_state(base, "o1_b_bool_1", 1);
+	/* conditional expression mapped correctly */
+	bools[0].bool = "o1_b_bool_1";
+	bools[0].expr_type = COND_BOOL;
+	test_cond_expr_mapping(base, d, bools, 1);
+
+}
+
+void module_cond_tests(policydb_t * base)
+{
+	avrule_decl_t *d;
+	unsigned int decls[1];
+	test_cond_expr_t bools[3];
+
+	/* bool existance and state, module 1 global scope */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1");
+	decls[0] = d->decl_id;
+	test_sym_presence(base, "g_m1_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
+	test_bool_state(base, "g_m1_bool_1", 1);
+	/* conditional expression mapped correctly */
+	bools[0].bool = "g_m1_bool_1";
+	bools[0].expr_type = COND_BOOL;
+	test_cond_expr_mapping(base, d, bools, 1);
+
+	/* bool existance and state, module 1 optional scope */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_m1");
+	decls[0] = d->decl_id;
+	test_sym_presence(base, "o1_m1_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
+	test_bool_state(base, "o1_m1_bool_1", 0);
+	/* conditional expression mapped correctly */
+	bools[0].bool = "o1_m1_bool_1";
+	bools[0].expr_type = COND_BOOL;
+	test_cond_expr_mapping(base, d, bools, 1);
+
+	/* bool existance and state, module 2 global scope */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m2");
+	decls[0] = d->decl_id;
+	test_sym_presence(base, "g_m2_bool_1", SYM_BOOLS, SCOPE_DECL, decls, 1);
+	test_sym_presence(base, "g_m2_bool_2", SYM_BOOLS, SCOPE_DECL, decls, 1);
+	test_bool_state(base, "g_m2_bool_1", 1);
+	test_bool_state(base, "g_m2_bool_2", 0);
+	/* conditional expression mapped correctly */
+	bools[0].bool = "g_m2_bool_1";
+	bools[0].expr_type = COND_BOOL;
+	bools[1].bool = "g_m2_bool_2";
+	bools[1].expr_type = COND_BOOL;
+	bools[2].bool = NULL;
+	bools[2].expr_type = COND_AND;
+	test_cond_expr_mapping(base, d, bools, 3);
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-linker-cond-map.h trunk/libsepol/tests/test-linker-cond-map.h
--- trunk.old/libsepol/tests/test-linker-cond-map.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker-cond-map.h	2006-07-26 14:19:16.000000000 -0400
@@ -0,0 +1,27 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_LINKER_COND_MAP_H__
+#define __TEST_LINKER_COND_MAP_H__
+
+extern void base_cond_tests(policydb_t * base);
+extern void module_cond_tests(policydb_t * base);
+
+#endif
diff -pruN -x policies trunk.old/libsepol/tests/test-linker.h trunk/libsepol/tests/test-linker.h
--- trunk.old/libsepol/tests/test-linker.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker.h	2006-07-26 11:01:56.000000000 -0400
@@ -0,0 +1,30 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_LINKER_H__
+#define __TEST_LINKER_H__
+
+#include <CUnit/Basic.h>
+
+int linker_test_init(void);
+int linker_test_cleanup(void);
+int linker_add_tests(CU_pSuite suite);
+
+#endif
diff -pruN -x policies trunk.old/libsepol/tests/test-linker-roles.c trunk/libsepol/tests/test-linker-roles.c
--- trunk.old/libsepol/tests/test-linker-roles.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker-roles.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,206 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "parse_util.h"
+#include "helpers.h"
+#include "test-common.h"
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/link.h>
+
+#include <CUnit/Basic.h>
+#include <stdlib.h>
+
+/* Tests for roles:
+ * Test for each of these for 
+ * - role in appropriate symtab (global and decl)
+ * - datum in the decl symtab has correct type_set
+ * - scope datum has correct decl ids
+ * - dominates bitmap is correct
+ * Tests:
+ * - role in base, no modules
+ * - role in base optional, no modules
+ * - role a in base, b in module
+ * - role a in base and module (additive)
+ * - role a in base and 2 module
+ * - role a in base optional, b in module
+ * - role a in base, b in module optional
+ * - role a in base optional, b in module optional
+ * - role a in base optional and module
+ * - role a in base and module optional
+ * - role a in base optional and module optional
+ * - role a in base optional and 2 modules
+ * - role a and b in base, b dom a, are types correct (TODO)
+ */
+
+/* this simply tests whether the passed in role only has its own 
+ * value in its dominates ebitmap */
+static void only_dominates_self(policydb_t * p, role_datum_t * role)
+{
+	ebitmap_node_t *tnode;
+	unsigned int i;
+	int found = 0;
+
+	ebitmap_for_each_bit(&role->dominates, tnode, i) {
+		if (ebitmap_node_get_bit(tnode, i)) {
+			found++;
+			CU_ASSERT(i == role->value - 1);
+		}
+	}
+	CU_ASSERT(found == 1);
+}
+
+void base_role_tests(policydb_t * base)
+{
+	avrule_decl_t *decl;
+	role_datum_t *role;
+	unsigned int decls[2];
+	char *types[2];
+
+	/* These tests look at roles in the base only, the desire is to ensure that
+	 * roles are not destroyed or otherwise removed during the link process */
+
+	/**** test for g_b_role_1 in base and decl 1 (global) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	test_sym_presence(base, "g_b_role_1", SYM_ROLES, SCOPE_DECL, decls, 1);
+	/* make sure it has the correct type set (g_b_type_1, no negset, no flags) */
+	types[0] = "g_b_type_1";
+	role = test_role_type_set(base, "g_b_role_1", NULL, types, 1, 0);
+	/* This role should only dominate itself */
+	only_dominates_self(base, role);
+
+	/**** test for o1_b_role_1 in optional (decl 2) ****/
+	decl = test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_b");
+	decls[0] = decl->decl_id;
+	test_sym_presence(base, "o1_b_role_1", SYM_ROLES, SCOPE_DECL, decls, 1);
+	/* make sure it has the correct type set (o1_b_type_1, no negset, no flags) */
+	types[0] = "o1_b_type_1";
+	role = test_role_type_set(base, "o1_b_role_1", decl, types, 1, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+}
+
+void module_role_tests(policydb_t * base)
+{
+	role_datum_t *role;
+	avrule_decl_t *decl;
+	unsigned int decls[2];
+	char *types[3];
+
+	/* These tests are run when the base is linked with 2 modules,
+	 * They should test whether the roles get copied correctly from the 
+	 * modules into the base */
+
+	/**** test for role in module 1 (global) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "g_m1_role_1", SYM_ROLES, SCOPE_DECL, decls, 1);
+	/* make sure it has the correct type set (g_m1_type_1, no negset, no flags) */
+	types[0] = "g_m1_type_1";
+	role = test_role_type_set(base, "g_m1_role_1", NULL, types, 1, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+
+	/**** test for role in module 1 (optional) ****/
+	decl = test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_m1");
+	decls[0] = decl->decl_id;
+	test_sym_presence(base, "o1_m1_role_1", SYM_ROLES, SCOPE_DECL, decls, 1);
+	/* make sure it has the correct type set (o1_m1_type_1, no negset, no flags) */
+	types[0] = "o1_m1_type_1";
+	role = test_role_type_set(base, "o1_m1_role_1", decl, types, 1, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+
+	/* These test whether the type sets are copied to the right place and
+	 * correctly unioned when they should be */
+
+	/**** test for type added to base role in module 1 (global) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	decls[1] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "g_b_role_2", SYM_ROLES, SCOPE_DECL, decls, 2);
+	/* make sure it has the correct type set (g_m1_type_1, no negset, no flags) */
+	types[0] = "g_b_type_2";	/* added in base when declared */
+	types[1] = "g_m1_type_1";	/* added in module */
+	role = test_role_type_set(base, "g_b_role_2", NULL, types, 2, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+
+	/**** test for type added to base role in module 1 & 2 (global) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	decls[1] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	decls[2] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m2"))->decl_id;
+	test_sym_presence(base, "g_b_role_3", SYM_ROLES, SCOPE_DECL, decls, 3);
+	/* make sure it has the correct type set (g_b_type_2, g_m1_type_2, g_m2_type_2, no negset, no flags) */
+	types[0] = "g_b_type_2";	/* added in base when declared */
+	types[1] = "g_m1_type_2";	/* added in module 1 */
+	types[2] = "g_m2_type_2";	/* added in module 2 */
+	role = test_role_type_set(base, "g_b_role_3", NULL, types, 3, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+
+	/**** test for role in base optional and module 1 (additive) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_b"))->decl_id;
+	decls[1] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "o1_b_role_2", SYM_ROLES, SCOPE_DECL, decls, 2);
+	/* this one will have 2 type sets, one in the global symtab and one in the base optional 1 */
+	types[0] = "g_m1_type_1";
+	role = test_role_type_set(base, "o1_b_role_2", NULL, types, 1, 0);
+	types[0] = "o1_b_type_1";
+	role = test_role_type_set(base, "o1_b_role_2", test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_b"), types, 1, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+
+	/**** test for role in base and module 1 optional (additive) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	decls[1] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o2_m1"))->decl_id;
+	test_sym_presence(base, "g_b_role_4", SYM_ROLES, SCOPE_DECL, decls, 2);
+	/* this one will have 2 type sets, one in the global symtab and one in the base optional 1 */
+	types[0] = "g_b_type_2";
+	role = test_role_type_set(base, "g_b_role_4", NULL, types, 1, 0);
+	types[0] = "g_m1_type_2";
+	role = test_role_type_set(base, "g_b_role_4", test_find_decl_by_sym(base, SYM_TYPES, "tag_o2_m1"), types, 1, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+
+	/**** test for role in base and module 1 optional (additive) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o3_b"))->decl_id;
+	decls[1] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o3_m1"))->decl_id;
+	test_sym_presence(base, "o3_b_role_1", SYM_ROLES, SCOPE_DECL, decls, 2);
+	/* this one will have 2 type sets, one in the 3rd base optional and one in the 3rd module optional */
+	types[0] = "o3_b_type_1";
+	role = test_role_type_set(base, "o3_b_role_1", test_find_decl_by_sym(base, SYM_TYPES, "tag_o3_b"), types, 1, 0);
+	types[0] = "o3_m1_type_1";
+	role = test_role_type_set(base, "o3_b_role_1", test_find_decl_by_sym(base, SYM_TYPES, "tag_o3_m1"), types, 1, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+
+	/**** test for role in base and module 1 optional (additive) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o4_b"))->decl_id;
+	decls[1] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	decls[2] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m2"))->decl_id;
+	test_sym_presence(base, "o4_b_role_1", SYM_ROLES, SCOPE_DECL, decls, 3);
+	/* this one will have 2 type sets, one in the global symtab (with both module types) and one in the 4th optional of base */
+	types[0] = "g_m1_type_1";
+	role = test_role_type_set(base, "o4_b_role_1", test_find_decl_by_sym(base, SYM_TYPES, "tag_o4_b"), types, 1, 0);
+	types[0] = "g_m2_type_1";
+	types[1] = "g_m1_type_2";
+	role = test_role_type_set(base, "o4_b_role_1", NULL, types, 2, 0);
+	/* and only dominates itself */
+	only_dominates_self(base, role);
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-linker-roles.h trunk/libsepol/tests/test-linker-roles.h
--- trunk.old/libsepol/tests/test-linker-roles.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker-roles.h	2006-08-02 10:37:36.000000000 -0400
@@ -0,0 +1,29 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_LINKER_ROLES_H__
+#define __TEST_LINKER_ROLES_H__
+
+#include <sepol/policydb/policydb.h>
+
+extern void base_role_tests(policydb_t * base);
+extern void module_role_tests(policydb_t * base);
+
+#endif
diff -pruN -x policies trunk.old/libsepol/tests/test-linker-types.c trunk/libsepol/tests/test-linker-types.c
--- trunk.old/libsepol/tests/test-linker-types.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker-types.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,317 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *         Chad Sellers <csellers@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "parse_util.h"
+#include "helpers.h"
+#include "test-common.h"
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/link.h>
+
+#include <CUnit/Basic.h>
+#include <stdlib.h>
+
+/* Tests for types:
+ * Test for each of these for 
+ * - type in appropriate symtab (global and decl)
+ * - datum in the decl symtab has correct type bitmap (if attr)
+ * - primary is set correctly
+ * - scope datum has correct decl ids
+ * Tests:
+ * - type in base, no modules
+ * - type in base optional, no modules
+ * - type a in base, b in module
+ * - type a in base optional, b in module
+ * - type a in base, b in module optional
+ * - type a in base optional, b in module optional
+ * - attr in base, no modules
+ * - attr in base optional, no modules
+ * - attr a in base, b in module
+ * - attr a in base optional, b in module
+ * - attr a in base, b in module optional
+ * - attr a in base optional, b in module optional
+ * - attr a declared in base, added to in module
+ * - attr a declared in base, added to in module optional
+ * - attr a declared in base, added to in 2 modules 
+ * - attr a declared in base, added to in 2 modules (optional and global)
+ * - attr a declared in base optional, added to in module
+ * - attr a declared in base optional, added to in module optional
+ * - attr a added to in base optional, declared in module
+ * - attr a added to in base optional, declared in module optional
+ * - attr a added to in base optional, declared in module, added to in other module
+ * - attr a added to in base optional, declared in module optional, added to in other module
+ * - attr a added to in base optional, declared in module , added to in other module optional
+ * - attr a added to in base optional, declared in module optional, added to in other module optional
+ * - alias in base of primary type in base, no modules
+ * - alias in base optional of primary type in base, no modules
+ * - alias in base optional of primary type in base optional
+ * - alias in module of primary type in base
+ * - alias in module optional of primary type in base
+ * - alias in module optional of primary type in base optional
+ * - alias in module of primary type in module
+ * - alias in module optional of primary type in module
+ * - alias in module optional of primary type in module optional
+ * - alias a in base, b in module, primary type in base
+ * - alias a in base, b in module, primary type in module
+ * - alias a in base optional, b in module, primary type in base
+ * - alias a in base optional, b in module, primary type in module
+ * - alias a in base, b in module optional, primary type in base
+ * - alias a in base, b in module optional, primary type in module
+ * - alias a in base optional, b in module optional, primary type in base
+ * - alias a in base optional, b in module optional, primary type in module
+ * - alias a in base, required in module, primary type in base
+ * - alias a in base, required in base optional, primary type in base
+ * - alias a in base, required in module optional, primary type in base
+ * - alias a in module, required in base optional, primary type in base
+ * - alias a in module, required in module optional, primary type in base
+ * - alias a in base optional, required in module, primary type in base
+ * - alias a in base optional, required in different base optional, primary type in base
+ * - alias a in base optional, required in module optional, primary type in base
+ * - alias a in module optional, required in base optional, primary type in base
+ * - alias a in module optional, required in module optional, primary type in base
+ * - alias a in module, required in base optional, primary type in module
+ * - alias a in module, required in module optional, primary type in module
+ * - alias a in base optional, required in module, primary type in module
+ * - alias a in base optional, required in different base optional, primary type in module
+ * - alias a in base optional, required in module optional, primary type in module
+ * - alias a in module optional, required in base optional, primary type in module
+ * - alias a in module optional, required in module optional, primary type in module
+ */
+
+/* Don't pass in decls from global blocks since symbols aren't stored in their symtab */
+static void test_type_datum(policydb_t * p, char *id, unsigned int *decls, int len, unsigned int primary)
+{
+	int i;
+	unsigned int value;
+	type_datum_t *type;
+
+	/* just test the type datums for each decl to see if it is what we expect */
+	type = hashtab_search(p->p_types.table, id);
+
+	CU_ASSERT_FATAL(type != NULL);
+	CU_ASSERT(type->primary == primary);
+	CU_ASSERT(type->flavor == TYPE_TYPE);
+
+	value = type->value;
+
+	for (i = 0; i < len; i++) {
+		type = hashtab_search(p->decl_val_to_struct[decls[i] - 1]->p_types.table, id);
+		CU_ASSERT_FATAL(type != NULL);
+		CU_ASSERT(type->primary == primary);
+		CU_ASSERT(type->flavor == TYPE_TYPE);
+		CU_ASSERT(type->value == value);
+	}
+
+}
+
+void base_type_tests(policydb_t * base)
+{
+	unsigned int decls[2];
+	char *types[2];
+
+	/* These tests look at types in the base only, the desire is to ensure that
+	 * types are not destroyed or otherwise removed during the link process.
+	 * if this happens these tests won't work anyway since we are using types to 
+	 * mark blocks */
+
+	/**** test for g_b_type_1 in base and decl 1 (global) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	test_sym_presence(base, "g_b_type_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	test_type_datum(base, "g_b_type_1", NULL, 0, 1);
+	/* this attr is in the same decl as the type */
+	test_sym_presence(base, "g_b_attr_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "g_b_type_1";
+	test_attr_types(base, "g_b_attr_1", NULL, types, 1);
+
+	/**** test for o1_b_type_1 in optional (decl 2) ****/
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_b"))->decl_id;
+	test_sym_presence(base, "o1_b_type_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	test_type_datum(base, "o1_b_type_1", NULL, 0, 1);
+	/* this attr is in the same decl as the type */
+	test_sym_presence(base, "o1_b_attr_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "o1_b_type_1";
+	test_attr_types(base, "o1_b_attr_1", base->decl_val_to_struct[decls[0] - 1], types, 1);
+
+	/* tests for aliases */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	test_sym_presence(base, "g_b_alias_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	test_alias_datum(base, "g_b_alias_1", "g_b_type_3", 1, 0);
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o6_b"))->decl_id;
+	test_sym_presence(base, "g_b_alias_2", SYM_TYPES, SCOPE_DECL, decls, 1);
+	test_alias_datum(base, "g_b_alias_2", "g_b_type_3", 1, 0);
+
+}
+
+void module_type_tests(policydb_t * base)
+{
+	unsigned int decls[2];
+	char *types[2];
+	avrule_decl_t *d;
+
+	/* These tests look at types that were copied from modules or attributes
+	 * that were modified and declared in modules and base. These apply to 
+	 * declarations and modifications in and out of optionals. These tests
+	 * should ensure that types and attributes are correctly copied from modules
+	 * and that attribute type sets are correctly copied and mapped. */
+
+	/* note: scope for attributes is currently smashed if the attribute is declared 
+	 * somewhere so the scope test only looks at global, the type bitmap test looks
+	 * at the appropriate decl symtab */
+
+	/* test for type in module 1 (global) */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "g_m1_type_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	test_type_datum(base, "g_m1_type_1", NULL, 0, 1);
+	/* attr has is in the same decl as the above type */
+	test_sym_presence(base, "g_m1_attr_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "g_m1_type_1";
+	types[1] = "g_m1_type_2";
+	test_attr_types(base, "g_m1_attr_1", NULL, types, 2);
+
+	/* test for type in module 1 (optional) */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_m1"))->decl_id;
+	test_sym_presence(base, "o1_m1_type_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	test_type_datum(base, "o1_m1_type_1", NULL, 0, 1);
+	/* attr has is in the same decl as the above type */
+	test_sym_presence(base, "o1_m1_attr_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "o1_m1_type_2";
+	test_attr_types(base, "o1_m1_attr_1", base->decl_val_to_struct[decls[0] - 1], types, 1);
+
+	/* test for attr declared in base, added to in module (global). 
+	 * Since these are both global it'll be merged in the main symtab */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	test_sym_presence(base, "g_b_attr_3", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "g_m1_type_3";
+	test_attr_types(base, "g_b_attr_3", NULL, types, 1);
+
+	/* test for attr declared in base, added to in module (optional). */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	test_sym_presence(base, "g_b_attr_4", SYM_TYPES, SCOPE_DECL, decls, 1);
+
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_m1"))->decl_id;
+	types[0] = "o1_m1_type_3";
+	test_attr_types(base, "g_b_attr_4", base->decl_val_to_struct[decls[0] - 1], types, 1);
+
+	/* test for attr declared in base, added to in 2 modules (global). (merged in main symtab) */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	test_sym_presence(base, "g_b_attr_5", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "g_m1_type_4";
+	types[1] = "g_m2_type_4";
+	test_attr_types(base, "g_b_attr_5", NULL, types, 2);
+
+	/* test for attr declared in base, added to in 2 modules (optional/global). */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
+	test_sym_presence(base, "g_b_attr_6", SYM_TYPES, SCOPE_DECL, decls, 1);
+	/* module 2 was global to its type is in main symtab */
+	types[0] = "g_m2_type_5";
+	test_attr_types(base, "g_b_attr_6", NULL, types, 1);
+	d = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o3_m1"));
+	types[0] = "o3_m1_type_2";
+	test_attr_types(base, "g_b_attr_6", d, types, 1);
+
+	/* test for attr declared in base optional, added to in module (global). */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o4_b"))->decl_id;
+	test_sym_presence(base, "o4_b_attr_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "g_m1_type_5";
+	test_attr_types(base, "o4_b_attr_1", NULL, types, 1);
+
+	/* test for attr declared in base optional, added to in module (optional). */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_b"))->decl_id;
+	test_sym_presence(base, "o1_b_attr_2", SYM_TYPES, SCOPE_DECL, decls, 1);
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_m1");
+	types[0] = "o1_m1_type_5";
+	test_attr_types(base, "o1_b_attr_2", d, types, 1);
+
+	/* test for attr declared in module, added to in base optional */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "g_m1_attr_2", SYM_TYPES, SCOPE_DECL, decls, 1);
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o1_b");
+	types[0] = "o1_b_type_2";
+	test_attr_types(base, "g_m1_attr_2", d, types, 1);
+
+	/* test for attr declared in module optional, added to in base optional */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_o3_m1"))->decl_id;
+	test_sym_presence(base, "o3_m1_attr_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o4_b");
+	types[0] = "o4_b_type_1";
+	test_attr_types(base, "o3_m1_attr_1", d, types, 1);
+
+	/* attr a added to in base optional, declared/added to in module, added to in other module */
+	/* first the module declare/add and module 2 add (since its global it'll be in the main symtab */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "g_m1_attr_3", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "g_m1_type_6";
+	types[1] = "g_m2_type_3";
+	test_attr_types(base, "g_m1_attr_3", NULL, types, 2);
+	/* base add */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o4_b");
+	types[0] = "o4_b_type_2";
+	test_attr_types(base, "g_m1_attr_3", d, types, 1);
+
+	/* attr a added to in base optional, declared/added in module optional, added to in other module */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o3_m1");
+	decls[0] = d->decl_id;
+	test_sym_presence(base, "o3_m1_attr_2", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "o3_m1_type_3";
+	test_attr_types(base, "o3_m1_attr_2", d, types, 1);
+	/* module 2's type will be in the main symtab */
+	types[0] = "g_m2_type_6";
+	test_attr_types(base, "o3_m1_attr_2", NULL, types, 1);
+	/* base add */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o2_b");
+	types[0] = "o2_b_type_1";
+	test_attr_types(base, "o3_m1_attr_2", d, types, 1);
+
+	/* attr a added to in base optional, declared/added in module , added to in other module optional */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "g_m1_attr_4", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "g_m1_type_7";
+	test_attr_types(base, "g_m1_attr_4", NULL, types, 1);
+	/* module 2 */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o2_m2");
+	types[0] = "o2_m2_type_1";
+	test_attr_types(base, "g_m1_attr_4", d, types, 1);
+	/* base add */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o5_b");
+	types[0] = "o5_b_type_1";
+	test_attr_types(base, "g_m1_attr_4", d, types, 1);
+
+	/* attr a added to in base optional, declared/added in module optional, added to in other module optional */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o4_m1");
+	decls[0] = d->decl_id;
+	test_sym_presence(base, "o4_m1_attr_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	types[0] = "o4_m1_type_1";
+	test_attr_types(base, "o4_m1_attr_1", d, types, 1);
+	/* module 2 */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o2_m2");
+	types[0] = "o2_m2_type_2";
+	test_attr_types(base, "o4_m1_attr_1", d, types, 1);
+	/* base add */
+	d = test_find_decl_by_sym(base, SYM_TYPES, "tag_o5_b");
+	types[0] = "o5_b_type_2";
+	test_attr_types(base, "o4_m1_attr_1", d, types, 1);
+
+	/* tests for aliases */
+	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
+	test_sym_presence(base, "g_m_alias_1", SYM_TYPES, SCOPE_DECL, decls, 1);
+	test_alias_datum(base, "g_m_alias_1", "g_b_type_3", 1, 0);
+
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-linker-types.h trunk/libsepol/tests/test-linker-types.h
--- trunk.old/libsepol/tests/test-linker-types.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-linker-types.h	2006-07-26 14:19:16.000000000 -0400
@@ -0,0 +1,27 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __TEST_LINKER_TYPES_H__
+#define __TEST_LINKER_TYPES_H__
+
+extern void base_type_tests(policydb_t * base);
+extern void module_type_tests(policydb_t * base);
+
+#endif


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
