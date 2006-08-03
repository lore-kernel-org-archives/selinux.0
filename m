Subject: [PATCH 4/5] libsepol expander tests
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:17:38 -0400
Message-Id: <1154614658.4909.21.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These are the expander tests. They work similarly to the linker tests
but aren't quite as comprehensive.

diff -pruN -x policies trunk.old/libsepol/tests/libsepol-tests.c trunk/libsepol/tests/libsepol-tests.c
--- trunk.old/libsepol/tests/libsepol-tests.c	2006-08-03 09:55:43.000000000 -0400
+++ trunk/libsepol/tests/libsepol-tests.c	2006-08-03 09:56:09.000000000 -0400
@@ -20,6 +20,7 @@
 
 #include "test-cond.h"
 #include "test-linker.h"
+#include "test-expander.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -57,6 +58,7 @@ static int do_tests(int interactive, int
 
 	DECLARE_SUITE(cond);
 	DECLARE_SUITE(linker);
+	DECLARE_SUITE(expander);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff -pruN -x policies trunk.old/libsepol/tests/test-expander-attr-map.c trunk/libsepol/tests/test-expander-attr-map.c
--- trunk.old/libsepol/tests/test-expander-attr-map.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander-attr-map.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,105 @@
+/*
+ * Authors: Chad Sellers <csellers@tresys.com>
+ *          Joshua Brindle <jbrindle@tresys.com>
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
+#include "test-expander-attr-map.h"
+#include "test-common.h"
+
+#include <sepol/policydb/policydb.h>
+#include <CUnit/Basic.h>
+#include <stdlib.h>
+
+extern policydb_t base_expanded2;
+
+void test_expander_attr_mapping(void)
+{
+	/* note that many cases are ommitted because they don't make sense
+	   (i.e. declaring in an optional and then using it in the base) or
+	   because declare in optional then require in a different optional
+	   logic still doesn't work */
+
+	char *typesb1[] = { "attr_check_base_1_1_t", "attr_check_base_1_2_t" };
+	char *typesb2[] = { "attr_check_base_2_1_t", "attr_check_base_2_2_t" };
+	char *typesb3[] = { "attr_check_base_3_1_t", "attr_check_base_3_2_t",
+		"attr_check_base_3_3_t", "attr_check_base_3_4_t"
+	};
+	char *typesb4[] = { "attr_check_base_4_1_t", "attr_check_base_4_2_t" };
+	char *typesb5[] = { "attr_check_base_5_1_t", "attr_check_base_5_2_t" };
+	char *typesb6[] = { "attr_check_base_6_1_t", "attr_check_base_6_2_t",
+		"attr_check_base_6_3_t", "attr_check_base_6_4_t"
+	};
+	char *typesbo2[] = { "attr_check_base_optional_2_1_t",
+		"attr_check_base_optional_2_2_t"
+	};
+	char *typesbo5[] = { "attr_check_base_optional_5_1_t",
+		"attr_check_base_optional_5_2_t"
+	};
+	char *typesm2[] = { "attr_check_mod_2_1_t", "attr_check_mod_2_2_t" };
+	char *typesm4[] = { "attr_check_mod_4_1_t", "attr_check_mod_4_2_t" };
+	char *typesm5[] = { "attr_check_mod_5_1_t", "attr_check_mod_5_2_t" };
+	char *typesm6[] = { "attr_check_mod_6_1_t", "attr_check_mod_6_2_t",
+		"attr_check_mod_6_3_t", "attr_check_mod_6_4_t"
+	};
+	char *typesmo2[] = { "attr_check_mod_optional_4_1_t",
+		"attr_check_mod_optional_4_2_t"
+	};
+	char *typesb10[] = { "attr_check_base_10_1_t", "attr_check_base_10_2_t" };
+	char *typesb11[] = { "attr_check_base_11_3_t", "attr_check_base_11_4_t" };
+	char *typesm10[] = { "attr_check_mod_10_1_t", "attr_check_mod_10_2_t" };
+	char *typesm11[] = { "attr_check_mod_11_3_t", "attr_check_mod_11_4_t" };
+
+	test_attr_types(&base_expanded2, "attr_check_base_1", NULL, typesb1, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_2", NULL, typesb2, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_3", NULL, typesb3, 4);
+	test_attr_types(&base_expanded2, "attr_check_base_4", NULL, typesb4, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_5", NULL, typesb5, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_6", NULL, typesb6, 4);
+	test_attr_types(&base_expanded2, "attr_check_base_optional_2", NULL, typesbo2, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_optional_5", NULL, typesbo5, 2);
+	test_attr_types(&base_expanded2, "attr_check_mod_2", NULL, typesm2, 2);
+	test_attr_types(&base_expanded2, "attr_check_mod_4", NULL, typesm4, 2);
+	test_attr_types(&base_expanded2, "attr_check_mod_5", NULL, typesm5, 2);
+	test_attr_types(&base_expanded2, "attr_check_mod_6", NULL, typesm6, 4);
+	test_attr_types(&base_expanded2, "attr_check_mod_optional_4", NULL, typesmo2, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_7", NULL, NULL, 0);
+	test_attr_types(&base_expanded2, "attr_check_base_8", NULL, NULL, 0);
+	test_attr_types(&base_expanded2, "attr_check_base_9", NULL, NULL, 0);
+	test_attr_types(&base_expanded2, "attr_check_base_10", NULL, typesb10, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_11", NULL, typesb11, 2);
+	test_attr_types(&base_expanded2, "attr_check_mod_7", NULL, NULL, 0);
+	test_attr_types(&base_expanded2, "attr_check_mod_8", NULL, NULL, 0);
+	test_attr_types(&base_expanded2, "attr_check_mod_9", NULL, NULL, 0);
+	test_attr_types(&base_expanded2, "attr_check_mod_10", NULL, typesm10, 2);
+	test_attr_types(&base_expanded2, "attr_check_mod_11", NULL, typesm11, 2);
+	test_attr_types(&base_expanded2, "attr_check_base_optional_8", NULL, NULL, 0);
+	test_attr_types(&base_expanded2, "attr_check_mod_optional_7", NULL, NULL, 0);
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_base_optional_disabled_5"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_base_optional_disabled_5_1_t"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_base_optional_disabled_5_2_t"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_base_optional_disabled_8"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_base_optional_disabled_8_1_t"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_base_optional_disabled_8_2_t"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_mod_optional_disabled_4"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_mod_optional_disabled_4_1_t"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_mod_optional_disabled_4_2_t"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_mod_optional_disabled_7"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_mod_optional_disabled_7_1_t"));
+	CU_ASSERT(!hashtab_search((&base_expanded2)->p_types.table, "attr_check_mod_optional_disabled_7_2_t"));
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-expander-attr-map.h trunk/libsepol/tests/test-expander-attr-map.h
--- trunk.old/libsepol/tests/test-expander-attr-map.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander-attr-map.h	2006-08-01 11:27:39.000000000 -0400
@@ -0,0 +1,26 @@
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
+#ifndef __TEST_EXPANDER__ATTR_MAP_H__
+#define __TEST_EXPANDER__ATTR_MAP_H__
+
+void test_expander_attr_mapping(void);
+
+#endif
diff -pruN -x policies trunk.old/libsepol/tests/test-expander.c trunk/libsepol/tests/test-expander.c
--- trunk.old/libsepol/tests/test-expander.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,220 @@
+/*
+ * Authors: Chad Sellers <csellers@tresys.com>
+ *          Joshua Brindle <jbrindle@tresys.com>
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
+/* This is where the expander tests should go, including:
+ * - check role, type, bool, user mapping
+ * - add symbols declared in enabled optionals
+ * - do not add symbols declared in disabled optionals
+ * - add rules from enabled optionals
+ * - do not add rules from disabled optionals
+ * - verify attribute mapping
+
+ * - check conditional expressions for correct mapping
+ */
+
+#include "test-expander.h"
+#include "parse_util.h"
+#include "helpers.h"
+#include "test-common.h"
+#include "test-expander-users.h"
+#include "test-expander-roles.h"
+#include "test-expander-attr-map.h"
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/link.h>
+#include <sepol/policydb/conditional.h>
+#include <limits.h>
+#include <stdlib.h>
+
+policydb_t role_expanded;
+policydb_t user_expanded;
+policydb_t base_expanded2;
+static policydb_t basemod;
+static policydb_t basemod2;
+static policydb_t mod2;
+static policydb_t base_expanded;
+static policydb_t base_only_mod;
+static policydb_t base_only_expanded;
+static policydb_t role_basemod;
+static policydb_t role_mod;
+static policydb_t user_basemod;
+static policydb_t user_mod;
+static policydb_t alias_basemod;
+static policydb_t alias_mod;
+static policydb_t alias_expanded;
+static uint32_t *typemap;
+extern int mls;
+
+/* Takes base, some number of modules, links them, and expands them
+   reads source from myfiles array, which has the base string followed by
+   each module string */
+int expander_policy_init(policydb_t * mybase, int num_modules, policydb_t ** mymodules, policydb_t * myexpanded, char **myfiles)
+{
+	char *filename[num_modules + 1];
+	int i;
+
+	for (i = 0; i < num_modules + 1; i++) {
+		filename[i] = calloc(PATH_MAX, sizeof(char));
+		if (snprintf(filename[i], PATH_MAX, "policies/test-expander/%s%s", myfiles[i], mls ? ".mls" : ".std") < 0)
+			return -1;
+	}
+
+	if (policydb_init(mybase)) {
+		fprintf(stderr, "out of memory!\n");
+		return -1;
+	}
+
+	for (i = 0; i < num_modules; i++) {
+		if (policydb_init(mymodules[i])) {
+			fprintf(stderr, "out of memory!\n");
+			return -1;
+		}
+	}
+
+	if (policydb_init(myexpanded)) {
+		fprintf(stderr, "out of memory!\n");
+		return -1;
+	}
+
+	mybase->policy_type = POLICY_BASE;
+	mybase->mls = mls;
+
+	if (read_source_policy(mybase, filename[0], myfiles[0])) {
+		fprintf(stderr, "read source policy failed %s\n", filename[0]);
+		return -1;
+	}
+
+	for (i = 1; i < num_modules + 1; i++) {
+		mymodules[i - 1]->policy_type = POLICY_MOD;
+		mymodules[i - 1]->mls = mls;
+		if (read_source_policy(mymodules[i - 1], filename[i], myfiles[i])) {
+			fprintf(stderr, "read source policy failed %s\n", filename[i]);
+			return -1;
+		}
+	}
+
+	if (link_modules(NULL, mybase, mymodules, num_modules, 0)) {
+		fprintf(stderr, "link modules failed\n");
+		return -1;
+	}
+
+	if (expand_module(NULL, mybase, myexpanded, 0, 0)) {
+		fprintf(stderr, "expand modules failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+int expander_test_init(void)
+{
+	char *small_base_file = "small-base.conf";
+	char *base_only_file = "base-base-only.conf";
+	int rc;
+	policydb_t *mymod2;
+	char *files2[] = { "small-base.conf", "module.conf" };
+	char *role_files[] = { "role-base.conf", "role-module.conf" };
+	char *user_files[] = { "user-base.conf", "user-module.conf" };
+	char *alias_files[] = { "alias-base.conf", "alias-module.conf" };
+
+	rc = expander_policy_init(&basemod, 0, NULL, &base_expanded, &small_base_file);
+	if (rc != 0)
+		return rc;
+
+	mymod2 = &mod2;
+	rc = expander_policy_init(&basemod2, 1, &mymod2, &base_expanded2, files2);
+	if (rc != 0)
+		return rc;
+
+	rc = expander_policy_init(&base_only_mod, 0, NULL, &base_only_expanded, &base_only_file);
+	if (rc != 0)
+		return rc;
+
+	mymod2 = &role_mod;
+	rc = expander_policy_init(&role_basemod, 1, &mymod2, &role_expanded, role_files);
+	if (rc != 0)
+		return rc;
+
+	/* Just init the base for now, until we figure out how to separate out
+	   mls and non-mls tests since users can't be used in mls module */
+	mymod2 = &user_mod;
+	rc = expander_policy_init(&user_basemod, 0, NULL, &user_expanded, user_files);
+	if (rc != 0)
+		return rc;
+
+	mymod2 = &alias_mod;
+	rc = expander_policy_init(&alias_basemod, 1, &mymod2, &alias_expanded, alias_files);
+	if (rc != 0)
+		return rc;
+
+	return 0;
+}
+
+int expander_test_cleanup(void)
+{
+	policydb_destroy(&basemod);
+	policydb_destroy(&base_expanded);
+	free(typemap);
+
+	return 0;
+}
+
+static void test_expander_indexes(void)
+{
+	test_policydb_indexes(&base_expanded);
+}
+
+static void test_expander_alias(void)
+{
+	test_alias_datum(&alias_expanded, "alias_check_1_a", "alias_check_1_t", 1, 0);
+	test_alias_datum(&alias_expanded, "alias_check_2_a", "alias_check_2_t", 1, 0);
+	test_alias_datum(&alias_expanded, "alias_check_3_a", "alias_check_3_t", 1, 0);
+}
+
+int expander_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "expander_indexes", test_expander_indexes)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+#if 0
+	/* this is a very useful test and in fact has caught some bugs but cannot be used
+	 * currently because of the way the expander removes attributes, please FIXME :) */
+	if (NULL == CU_add_test(suite, "expander_attr_mapping", test_expander_attr_mapping)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+#endif
+	if (NULL == CU_add_test(suite, "expander_role_mapping", test_expander_role_mapping)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL == CU_add_test(suite, "expander_user_mapping", test_expander_user_mapping)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	if (NULL == CU_add_test(suite, "expander_alias", test_expander_alias)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	return 0;
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-expander.h trunk/libsepol/tests/test-expander.h
--- trunk.old/libsepol/tests/test-expander.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander.h	2006-07-26 11:01:56.000000000 -0400
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
+#ifndef __TEST_EXPANDER_H__
+#define __TEST_EXPANDER_H__
+
+#include <CUnit/Basic.h>
+
+int expander_test_init(void);
+int expander_test_cleanup(void);
+int expander_add_tests(CU_pSuite suite);
+
+#endif
diff -pruN -x policies trunk.old/libsepol/tests/test-expander-roles.c trunk/libsepol/tests/test-expander-roles.c
--- trunk.old/libsepol/tests/test-expander-roles.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander-roles.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,37 @@
+/*
+ * Authors: Chad Sellers <csellers@tresys.com>
+ *          Joshua Brindle <jbrindle@tresys.com>
+ *          Chris PeBenito <cpebenito@tresys.com>
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
+#include "test-expander-roles.h"
+#include "test-common.h"
+
+#include <sepol/policydb/policydb.h>
+#include <CUnit/Basic.h>
+#include <stdlib.h>
+
+extern policydb_t role_expanded;
+
+void test_expander_role_mapping(void)
+{
+	char *types1[] = { "role_check_1_1_t", "role_check_1_2_t" };
+
+	test_role_type_set(&role_expanded, "role_check_1", NULL, types1, 2, 0);
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-expander-roles.h trunk/libsepol/tests/test-expander-roles.h
--- trunk.old/libsepol/tests/test-expander-roles.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander-roles.h	2006-08-02 10:51:44.000000000 -0400
@@ -0,0 +1,27 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ * Author: Chris PeBenito <cpebenito@tresys.com>
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
+#ifndef __TEST_EXPANDER_ROLE_H__
+#define __TEST_EXPANDER_ROLE_H__
+
+void test_expander_role_mapping(void);
+
+#endif
diff -pruN -x policies trunk.old/libsepol/tests/test-expander-users.c trunk/libsepol/tests/test-expander-users.c
--- trunk.old/libsepol/tests/test-expander-users.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander-users.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,75 @@
+/*
+ * Authors: Chad Sellers <csellers@tresys.com>
+ *          Joshua Brindle <jbrindle@tresys.com>
+ *          Chris PeBenito <cpebenito@tresys.com>
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
+#include "test-expander-users.h"
+
+#include <sepol/policydb/policydb.h>
+#include <CUnit/Basic.h>
+#include <stdlib.h>
+
+extern policydb_t user_expanded;
+
+static void check_user_roles(policydb_t * p, char *user_name, char **role_names, int num_roles)
+{
+	user_datum_t *user;
+	ebitmap_node_t *tnode;
+	unsigned int i;
+	int j;
+	unsigned char *found;	/* array of booleans of roles found */
+	int extra = 0;		/* number of extra roles found */
+
+	user = (user_datum_t *) hashtab_search(p->p_users.table, user_name);
+	if (!user) {
+		printf("%s not found\n", user_name);
+		CU_FAIL("user not found");
+		return;
+	}
+	found = calloc(num_roles, sizeof(unsigned char));
+	CU_ASSERT_FATAL(found != NULL);
+	ebitmap_for_each_bit(&user->roles.roles, tnode, i) {
+		if (ebitmap_node_get_bit(tnode, i)) {
+			extra++;
+			for (j = 0; j < num_roles; j++) {
+				if (strcmp(role_names[j], p->p_role_val_to_name[i]) == 0) {
+					extra--;
+					found[j] += 1;
+					break;
+				}
+			}
+		}
+	}
+	for (j = 0; j < num_roles; j++) {
+		if (found[j] != 1) {
+			printf("role %s associated with user %s %d times\n", role_names[j], user_name, found[j]);
+			CU_FAIL("user mapping failure\n");
+		}
+	}
+	free(found);
+	CU_ASSERT_EQUAL(extra, 0);
+}
+
+void test_expander_user_mapping(void)
+{
+	char *roles1[] = { "user_check_1_1_r", "user_check_1_2_r" };
+
+	check_user_roles(&user_expanded, "user_check_1", roles1, 2);
+}
diff -pruN -x policies trunk.old/libsepol/tests/test-expander-users.h trunk/libsepol/tests/test-expander-users.h
--- trunk.old/libsepol/tests/test-expander-users.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/test-expander-users.h	2006-08-02 10:39:26.000000000 -0400
@@ -0,0 +1,27 @@
+/*
+ * Author: Joshua Brindle <jbrindle@tresys.com>
+ * Author: Chris PeBenito <cpebenito@tresys.com>
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
+#ifndef __TEST_EXPANDER_USER_H__
+#define __TEST_EXPANDER_USER_H__
+
+void test_expander_user_mapping(void);
+
+#endif



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
