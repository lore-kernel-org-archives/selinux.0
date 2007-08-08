Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l78JEKIQ031225
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 15:14:20 -0400
Received: from tresys-winxppro.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l78JEJCU007491
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 19:14:19 GMT
Received: from tresys-winxppro.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by tresys-winxppro.columbia.tresys.com (8.13.8/8.13.8) with ESMTP id l78KMsD2017162
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2007 16:22:54 -0400
Received: (from paul@localhost)
	by tresys-winxppro.columbia.tresys.com (8.13.8/8.13.8/Submit) id l78KMsUg017161
	for selinux@tycho.nsa.gov; Wed, 8 Aug 2007 16:22:54 -0400
Message-Id: <20070808202254.135044847@tresys.com>
References: <20070808202252.190491979@tresys.com>
Date: Wed, 08 Aug 2007 16:22:54 -0400
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Subject: [patch 2/3] libsemanage: test functions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Test functions for libsemanage/src/utilities.c and
libsemanage/src/utilities.h

Index: selinux/libsemanage/tests/libsemanage-tests.c
===================================================================
--- selinux.orig/libsemanage/tests/libsemanage-tests.c
+++ selinux/libsemanage/tests/libsemanage-tests.c
@@ -20,6 +20,7 @@
  */
 
 #include "test_semanage_store.h"
+#include "test_utilities.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -55,6 +56,7 @@ static int do_tests(int interactive, int
 		return CU_get_error();
 
 	DECLARE_SUITE(semanage_store);
+	DECLARE_SUITE(semanage_utilities);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
Index: selinux/libsemanage/tests/Makefile
===================================================================
--- selinux.orig/libsemanage/tests/Makefile
+++ selinux/libsemanage/tests/Makefile
@@ -13,7 +13,7 @@ EXECUTABLE = libsemanage-tests
 CC = gcc
 CFLAGS = -c -g -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include/semanage
-LDFLAGS = -lcunit
+LDFLAGS = -lcunit -lustr
 OBJECTS = $(SOURCES:.c=.o) 
 
 all: $(EXECUTABLE) 
Index: selinux/libsemanage/tests/test_utilities.c
===================================================================
--- /dev/null
+++ selinux/libsemanage/tests/test_utilities.c
@@ -0,0 +1,285 @@
+/* Authors: Mark Goldman <mgoldman@tresys.com>
+ *
+ * Copyright (C) 2007 Tresys Technology, LLC
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
+/*  The purpose of this file is to provide unit tests of the functions in:
+ *
+ *  libsemanage/src/utilities.c
+ *
+ */
+
+#include <CUnit/Basic.h>
+#include <CUnit/Console.h>
+#include <CUnit/TestDB.h>
+
+#include <utilities.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+void test_semanage_is_prefix(void);
+void test_semanage_split_on_space(void);
+void test_semanage_split(void);
+void test_semanage_list(void);
+void test_semanage_str_count(void);
+void test_semanage_rtrim(void);
+void test_semanage_findval(void);
+void test_slurp_file_filter(void);
+
+char fname[] = {
+	'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X', 'X',
+	'X', 'X'
+};
+int fd;
+FILE *fptr;
+
+int semanage_utilities_test_init(void)
+{
+	fd = mkstemp(fname);
+
+	if (fd < 0) {
+		perror("test_semanage_findval: ");
+		CU_FAIL_FATAL
+		    ("Error opening temporary file, test cannot start.");
+	}
+
+	fptr = fdopen(fd, "w+");
+	if (!fptr) {
+		perror("test_semanage_findval file: ");
+		CU_FAIL_FATAL("Error opening file stream, test cannot start.");
+	}
+
+	fprintf(fptr, "one\ntwo\nthree\nsigma=foo\n#boo\n#bar\n");
+
+	rewind(fptr);
+	return 0;
+}
+
+int semanage_utilities_test_cleanup(void)
+{
+	unlink(fname);
+	return 0;
+}
+
+int semanage_utilities_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "semanage_is_prefix",
+				test_semanage_is_prefix)) {
+		goto err;
+	}
+	if (NULL == CU_add_test(suite, "semanage_split_on_space",
+				test_semanage_split_on_space)) {
+		goto err;
+	}
+	if (NULL == CU_add_test(suite, "semanage_split", test_semanage_split)) {
+		goto err;
+	}
+	if (NULL == CU_add_test(suite, "semanage_list", test_semanage_list)) {
+		goto err;
+	}
+	if (NULL == CU_add_test(suite, "semanage_str_count",
+				test_semanage_str_count)) {
+		goto err;
+	}
+	if (NULL == CU_add_test(suite, "semanage_rtrim", test_semanage_rtrim)) {
+		goto err;
+	}
+	if (NULL == CU_add_test(suite, "semanage_findval",
+				test_semanage_findval)) {
+		goto err;
+	}
+	if (NULL == CU_add_test(suite, "slurp_file_filter",
+				test_slurp_file_filter)) {
+		goto err;
+	}
+	return 0;
+      err:
+	CU_cleanup_registry();
+	return CU_get_error();
+}
+
+void test_semanage_is_prefix(void)
+{
+	char *str = "some string";
+	char *pre = "some";
+	char *not_pre = "not this";
+
+	CU_ASSERT_TRUE(semanage_is_prefix(str, pre));
+	CU_ASSERT_TRUE(semanage_is_prefix(str, ""));
+	CU_ASSERT_TRUE(semanage_is_prefix(str, NULL));
+	CU_ASSERT_FALSE(semanage_is_prefix(str, not_pre));
+}
+
+void test_semanage_split_on_space(void)
+{
+	char *str = strdup("foo bar baz");
+	char *temp;
+
+	if (!str) {
+		CU_FAIL
+		    ("semanage_split_on_space: unable to perform test, no memory");
+	}
+	temp = semanage_split_on_space(str);
+	if (strncmp(temp, "bar", 3)) {
+		CU_FAIL("semanage_split_on_space: token did not match");
+	}
+	temp = semanage_split_on_space(temp);
+	if (strncmp(temp, "baz", 3)) {
+		CU_FAIL("semanage_split_on_space: token did not match");
+	}
+	temp = semanage_split_on_space(temp);
+	if (strcmp(temp, "")) {
+		CU_FAIL("semanage_split_on_space: token did not match");
+	}
+
+	free(str);
+}
+
+void test_semanage_split(void)
+{
+	char *str = strdup("foo1 foo2 foo:bar");
+	char *temp;
+
+	if (!str) {
+		CU_FAIL
+		    ("semanage_split_on_space: unable to perform test, no memory");
+		return;
+	}
+	temp = semanage_split(str, NULL);
+	CU_ASSERT_NSTRING_EQUAL(temp, "foo2", 4);
+	temp = semanage_split(temp, "");
+	CU_ASSERT_NSTRING_EQUAL(temp, "foo", 3);
+	temp = semanage_split(temp, ":");
+	CU_ASSERT_NSTRING_EQUAL(temp, "bar", 3);
+
+	free(str);
+}
+
+void test_semanage_list(void)
+{
+	list_t *list = NULL;
+	list_t *ptr = NULL;
+	char *temp = NULL;
+	int retval = 0;
+
+	semanage_list_push(&list, "foo");
+	CU_ASSERT_PTR_NOT_NULL(list);
+	semanage_list_push(&list, "bar");
+	semanage_list_push(&list, "gonk");
+	semanage_list_push(&list, "zebra");
+
+	for (ptr = list; ptr; ptr = ptr->next)
+		retval++;
+	CU_ASSERT_EQUAL(retval, 4);
+
+	temp = semanage_list_pop(&list);
+	CU_ASSERT_STRING_EQUAL(temp, "zebra");
+	semanage_list_push(&list, temp);
+	free(temp);
+	temp = NULL;
+
+	retval = 0;
+	for (ptr = list; ptr; ptr = ptr->next)
+		retval++;
+	CU_ASSERT_EQUAL(retval, 4);
+
+	retval = semanage_list_sort(&list);
+	if (retval) {
+		CU_FAIL
+		    ("semanage_list_sort: error unrelated to sort (memory?)");
+		goto past_sort;
+	}
+	CU_ASSERT_STRING_EQUAL(list->data, "bar");
+	CU_ASSERT_STRING_EQUAL(list->next->data, "foo");
+	CU_ASSERT_STRING_EQUAL(list->next->next->data, "gonk");
+	CU_ASSERT_STRING_EQUAL(list->next->next->next->data, "zebra");
+
+      past_sort:
+	ptr = semanage_list_find(list, "zebra");
+	CU_ASSERT_PTR_NOT_NULL(ptr);
+	ptr = semanage_list_find(list, "bogus");
+	CU_ASSERT_PTR_NULL(ptr);
+
+	semanage_list_destroy(&list);
+	CU_ASSERT_PTR_NULL(list);
+}
+
+void test_semanage_str_count(void)
+{
+	char *test_string = "abaababbaaaba";
+
+	CU_ASSERT_EQUAL(semanage_str_count(test_string, 'z'), 0);
+	CU_ASSERT_EQUAL(semanage_str_count(test_string, 'a'), 8);
+	CU_ASSERT_EQUAL(semanage_str_count(test_string, 'b'), 5);
+}
+
+void test_semanage_rtrim(void)
+{
+	char *str = strdup("/blah/foo/bar/baz/");
+
+	CU_ASSERT_PTR_NOT_NULL_FATAL(str);
+
+	semanage_rtrim(str, 'Q');
+	CU_ASSERT_STRING_EQUAL(str, "/blah/foo/bar/baz/");
+	semanage_rtrim(str, 'a');
+	CU_ASSERT_STRING_EQUAL(str, "/blah/foo/bar/b");
+	semanage_rtrim(str, '/');
+	CU_ASSERT_STRING_EQUAL(str, "/blah/foo/bar");
+}
+
+void test_semanage_findval(void)
+{
+	char *tok;
+	if (!fptr) {
+		CU_FAIL_FATAL("Temporary file was not created, aborting test.");
+	}
+	tok = semanage_findval(fname, "one", NULL);
+	CU_ASSERT_STRING_EQUAL(tok, "");
+	rewind(fptr);
+	tok = semanage_findval(fname, "one", "");
+	CU_ASSERT_STRING_EQUAL(tok, "");
+	free(tok);
+	rewind(fptr);
+	tok = semanage_findval(fname, "sigma", "=");
+	CU_ASSERT_STRING_EQUAL(tok, "foo");
+}
+
+int PREDICATE(const char *str)
+{
+	return semanage_is_prefix(str, "#");
+}
+
+void test_slurp_file_filter(void)
+{
+	list_t *data, *tmp;
+	int cnt = 0;
+
+	if (!fptr) {
+		CU_FAIL_FATAL("Temporary file was not created, aborting test.");
+	}
+	rewind(fptr);
+	data = semanage_slurp_file_filter(fptr, PREDICATE);
+	CU_ASSERT_PTR_NOT_NULL_FATAL(data);
+	for (tmp = data; tmp; tmp = tmp->next)
+		cnt++;
+	CU_ASSERT_EQUAL(cnt, 2);
+
+	semanage_list_destroy(&data);
+}
Index: selinux/libsemanage/tests/test_utilities.h
===================================================================
--- /dev/null
+++ selinux/libsemanage/tests/test_utilities.h
@@ -0,0 +1,5 @@
+#include <CUnit/Basic.h>
+
+int semanage_utilities_test_init(void);
+int semanage_utilities_test_cleanup(void);
+int semanage_utilities_add_tests(CU_pSuite suite);

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
