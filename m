Subject: [PATCH 1/5] libsepol unit test infrastructure
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:17:31 -0400
Message-Id: <1154614651.4909.18.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the new infrastructure that makes adding new tests much
easier and fixes the existing tests to use it.


diff -pruN -x policies trunk.old/libsepol/tests/helpers.c trunk/libsepol/tests/helpers.c
--- trunk.old/libsepol/tests/helpers.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/helpers.c	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,81 @@
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
+/* This has helper functions that are common between tests */
+
+#include "helpers.h"
+#include "parse_util.h"
+
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/avrule_block.h>
+
+#include <CUnit/Basic.h>
+
+#include <stdlib.h>
+#include <limits.h>
+
+int test_load_policy(policydb_t * p, int policy_type, int mls, const char *test_name, const char *policy_name)
+{
+	char filename[PATH_MAX];
+
+	if (mls) {
+		if (snprintf(filename, PATH_MAX, "policies/%s/%s.mls", test_name, policy_name) < 0) {
+			return -1;
+		}
+	} else {
+		if (snprintf(filename, PATH_MAX, "policies/%s/%s.std", test_name, policy_name) < 0) {
+			return -1;
+		}
+	}
+
+	if (policydb_init(p)) {
+		fprintf(stderr, "Out of memory");
+		return -1;
+	}
+
+	p->policy_type = policy_type;
+	p->mls = mls;
+
+	if (read_source_policy(p, filename, test_name)) {
+		fprintf(stderr, "failed to read policy %s\n", filename);
+		policydb_destroy(p);
+		return -1;
+	}
+
+	return 0;
+}
+
+avrule_decl_t *test_find_decl_by_sym(policydb_t * p, int symtab, char *sym)
+{
+	scope_datum_t *scope = (scope_datum_t *) hashtab_search(p->scope[symtab].table, sym);
+
+	if (scope == NULL) {
+		return NULL;
+	}
+	if (scope->scope != SCOPE_DECL) {
+		return NULL;
+	}
+	if (scope->decl_ids_len != 1) {
+		return NULL;
+	}
+
+	return p->decl_val_to_struct[scope->decl_ids[0] - 1];
+}
diff -pruN -x policies trunk.old/libsepol/tests/helpers.h trunk/libsepol/tests/helpers.h
--- trunk.old/libsepol/tests/helpers.h	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/tests/helpers.h	2006-08-02 13:27:49.000000000 -0400
@@ -0,0 +1,59 @@
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
+#ifndef __COMMON_H__
+#define __COMMON_H__
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/conditional.h>
+
+/* helper functions */
+
+/* Load a source policy into p. policydb_init will called within this function.
+ * 
+ * Example: test_load_policy(p, POLICY_BASE, 1, "foo", "base.conf") will load the
+ *  policy "policies/foo/mls/base.conf" into p.
+ *
+ * Arguments:
+ *  p            policydb_t into which the policy will be read. This should be
+ *                malloc'd but not passed to policydb_init.
+ *  policy_type  Type of policy expected - POLICY_BASE or POLICY_MOD.
+ *  mls          Boolean value indicating whether an mls policy is expected.
+ *  test_name    Name of the test which will be the name of the directory in
+ *                which the policies are stored.
+ *  policy_name  Name of the policy in the directory.
+ *
+ * Returns:
+ *  0            success
+ * -1            error - the policydb will be destroyed but not freed.
+ */
+extern int test_load_policy(policydb_t * p, int policy_type, int mls, const char *test_name, const char *policy_name);
+
+/* Find an avrule_decl_t by a unique symbol. If the symbol is declared in more
+ * than one decl an error is returned.
+ *
+ * Returns:
+ *  decl      success 
+ *  NULL      error (including more than one declaration)
+ */
+extern avrule_decl_t *test_find_decl_by_sym(policydb_t * p, int symtab, char *sym);
+
+#endif
diff -pruN -x policies trunk.old/libsepol/tests/libsepol-tests.c trunk/libsepol/tests/libsepol-tests.c
--- trunk.old/libsepol/tests/libsepol-tests.c	2006-07-03 10:42:01.000000000 -0400
+++ trunk/libsepol/tests/libsepol-tests.c	2006-08-03 09:42:28.000000000 -0400
@@ -21,28 +21,90 @@
 #include "test-cond.h"
 
 #include <CUnit/Basic.h>
+#include <CUnit/Console.h>
+#include <CUnit/TestDB.h>
+
 #include <stdio.h>
+#include <getopt.h>
+#include <stdlib.h>
 
-int main(int argc, char **argv)
+int mls;
+
+#define DECLARE_SUITE(name) \
+	suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
+	if (NULL == suite) { \
+		CU_cleanup_registry(); \
+		return CU_get_error(); } \
+	if (name##_add_tests(suite)) { \
+		CU_cleanup_registry(); \
+		return CU_get_error(); }
+
+static void usage(char *progname)
+{
+	printf("usage:  %s [options]\n", progname);
+	printf("options:\n");
+	printf("\t-v, --verbose\t\t\tverbose output\n");
+	printf("\t-i, --interactive\t\tinteractive console\n");
+}
+
+static int do_tests(int interactive, int verbose)
 {
 	CU_pSuite suite = NULL;
 
 	if (CUE_SUCCESS != CU_initialize_registry())
 		return CU_get_error();
 
-	suite = CU_add_suite("cond", cond_test_init, cond_test_cleanup);
-	if (NULL == suite) {
-		CU_cleanup_registry();
-		return CU_get_error();
-	}
+	DECLARE_SUITE(cond);
 
-	if (cond_add_tests(suite)) {
-		CU_cleanup_registry();
-		return CU_get_error();
-	}
-
-	CU_basic_set_mode(CU_BRM_VERBOSE);
-	CU_basic_run_tests();
+	if (verbose)
+		CU_basic_set_mode(CU_BRM_VERBOSE);
+	else
+		CU_basic_set_mode(CU_BRM_NORMAL);
+
+	if (interactive)
+		CU_console_run_tests();
+	else
+		CU_basic_run_tests();
 	CU_cleanup_registry();
 	return CU_get_error();
+
+}
+
+int main(int argc, char **argv)
+{
+	int i, verbose = 1, interactive = 0;
+
+	struct option opts[] = {
+		{"verbose", 0, NULL, 'v'},
+		{"interactive", 0, NULL, 'i'},
+		{NULL, 0, NULL, 0}
+	};
+
+	while ((i = getopt_long(argc, argv, "vi", opts, NULL)) != -1) {
+		switch (i) {
+		case 'v':
+			verbose = 1;
+			break;
+		case 'i':
+			interactive = 1;
+			break;
+		case 'h':
+		default:{
+				usage(argv[0]);
+				exit(1);
+			}
+		}
+	}
+
+	/* first do the non-mls tests */
+	mls = 0;
+	if (do_tests(interactive, verbose))
+		return -1;
+
+	/* then with mls */
+	mls = 1;
+	if (do_tests(interactive, verbose))
+		return -1;
+
+	return 0;
 }
diff -pruN -x policies trunk.old/libsepol/tests/Makefile trunk/libsepol/tests/Makefile
--- trunk.old/libsepol/tests/Makefile	2006-05-08 10:24:07.000000000 -0400
+++ trunk/libsepol/tests/Makefile	2006-07-26 15:13:50.000000000 -0400
@@ -1,28 +1,49 @@
+M4 ?= m4
+MKDIR ?= mkdir
+EXE ?= libsepol-tests
+
+CFLAGS += -g3 -gdwarf-2 -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter -Werror
+
 # Statically link libsepol on the assumption that we are going to
 # be testing internal functions.
-LIBSEPOL = -L../src/ -static -lsepol
+LIBSEPOL := ../src/libsepol.a
 
 # In order to load source policies we need to link in the checkpolicy/checkmodule parser and util code.
 # This is less than ideal, but it makes the tests easier to maintain by allowing source policies
 # to be loaded directly.
-CHECKPOLICY = ../../checkpolicy/
-PARSEROBJS = $(CHECKPOLICY)queue.o $(CHECKPOLICY)y.tab.o $(CHECKPOLICY)parse_util.o $(CHECKPOLICY)lex.yy.o \
+CHECKPOLICY := ../../checkpolicy/
+CPPFLAGS += -I../include/ -I$(CHECKPOLICY)
+
+# test program object files
+objs := $(patsubst %.c,%.o,$(wildcard *.c))
+parserobjs := $(CHECKPOLICY)queue.o $(CHECKPOLICY)y.tab.o $(CHECKPOLICY)parse_util.o $(CHECKPOLICY)lex.yy.o \
 	$(CHECKPOLICY)module_compiler.o
-INCLUDE = -I../include/ -I$(CHECKPOLICY)
 
-OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
-CFLAGS = -g -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
+# test policy pieces
+m4support := $(wildcard policies/support/*.spt)
+testsuites := $(wildcard policies/test-*)
+policysrc := $(foreach path,$(testsuites),$(wildcard $(path)/*.conf))
+stdpol := $(addsuffix .std,$(policysrc))
+mlspol := $(addsuffix .mls,$(policysrc))
+policies := $(stdpol) $(mlspol)
+
+all: $(EXE) $(policies)
+policies: $(policies)
 
-EXE = libsepol-tests
+$(EXE): $(objs) $(parserobjs) $(LIBSEPOL)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(objs) $(parserobjs) -lfl -lcunit -lcurses $(LIBSEPOL) -o $@
 
-all: $(OBJS)
-	$(CC) $(CFLAGS) $(INCLUDE) $(OBJS) $(PARSEROBJS) -lfl -lcunit -lcurses $(LIBSEPOL) -o $(EXE)
+%.conf.std: $(m4support) %.conf
+	$(M4) $(M4PARAMS) $^ > $@
 
-%.o: %.c
-	$(CC) $(CFLAGS) $(INCLUDE) -c $*.c -o $*.o
+%.conf.mls: $(m4support) %.conf
+	$(M4) $(M4PARAMS) -D enable_mls $^ > $@
 
 clean: 
-	rm -rf $(OBJS) $(EXE)
+	rm -f $(objs) $(EXE)
+	rm -f $(policies)
 
-test: all
+test: $(EXE) $(policies)
 	./$(EXE)
+
+.PHONY: all policies clean test
diff -pruN -x policies trunk.old/libsepol/tests/test-cond.c trunk/libsepol/tests/test-cond.c
--- trunk.old/libsepol/tests/test-cond.c	2006-07-03 10:42:01.000000000 -0400
+++ trunk/libsepol/tests/test-cond.c	2006-08-02 13:27:49.000000000 -0400
@@ -20,6 +20,7 @@
 
 #include "test-cond.h"
 #include "parse_util.h"
+#include "helpers.h"
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/link.h>
@@ -31,34 +32,31 @@ static policydb_t base_expanded;
 
 int cond_test_init(void)
 {
-	if (policydb_init(&basemod)) {
-		fprintf(stderr, "out of memory!\n");
-		return -1;
-	}
-
 	if (policydb_init(&base_expanded)) {
 		fprintf(stderr, "out of memory!\n");
+		policydb_destroy(&basemod);
 		return -1;
 	}
 
-	basemod.policy_type = POLICY_BASE;
-	basemod.mls = 1;
-
-	if (read_source_policy(&basemod, "policies/refpolicy-base.conf",
-			       "test-cond"))
-		return -1;
+	if (test_load_policy(&basemod, POLICY_BASE, 1, "test-cond", "refpolicy-base.conf"))
+		goto cleanup;
 
 	if (link_modules(NULL, &basemod, NULL, 0, 0)) {
 		fprintf(stderr, "link modules failed\n");
-		return -1;
+		goto cleanup;
 	}
 
 	if (expand_module(NULL, &basemod, &base_expanded, 0, 1)) {
 		fprintf(stderr, "expand module failed\n");
-		return -1;
+		goto cleanup;
 	}
 
 	return 0;
+
+      cleanup:
+	policydb_destroy(&basemod);
+	policydb_destroy(&base_expanded);
+	return -1;
 }
 
 int cond_test_cleanup(void)
@@ -91,7 +89,6 @@ static void test_cond_expr_equal(void)
 int cond_add_tests(CU_pSuite suite)
 {
 	if (NULL == CU_add_test(suite, "cond_expr_equal", test_cond_expr_equal)) {
-		CU_cleanup_registry();
 		return CU_get_error();
 	}
 	return 0;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
