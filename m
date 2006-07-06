Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k66KlfvH026625
	for <selinux@tycho.nsa.gov>; Thu, 6 Jul 2006 16:47:41 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k66Kldlv019058
	for <selinux@tycho.nsa.gov>; Thu, 6 Jul 2006 20:47:39 GMT
Date: Thu, 6 Jul 2006 16:52:21 -0400
From: Caleb Case <ccase@tresys.com>
Message-Id: <200607062052.k66KqLUx012479@localhost.localdomain>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: Read-only FS [2/2]
Cc: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch compliments the libsemanage: Read-only FS patch by adding CUnit tests.  The tests in semanage_access_check should not be run as root (they use DAC permissions to simulate a read-only fs).

diff -pruN -x .svn trunk/libsemanage/tests/libsemanage-tests.c rofs/libsemanage/tests/libsemanage-tests.c
--- trunk/libsemanage/tests/libsemanage-tests.c	1969-12-31 19:00:00.000000000 -0500
+++ rofs/libsemanage/tests/libsemanage-tests.c	2006-07-06 09:55:14.000000000 -0400
@@ -0,0 +1,107 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case <ccase@tresys.com>
+ *          Chad Sellers <csellers@tresys.com>
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
+#include "test_semanage_store.h"
+
+#include <CUnit/Basic.h>
+#include <CUnit/Console.h>
+#include <CUnit/TestDB.h>
+
+#include <stdio.h>
+#include <getopt.h>
+#include <stdlib.h>
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
+{
+	CU_pSuite suite = NULL;
+
+	/* Initialize the CUnit test registry. */
+	if (CUE_SUCCESS != CU_initialize_registry())
+		return CU_get_error();
+
+	DECLARE_SUITE(semanage_store);
+	
+	if (verbose)
+		CU_basic_set_mode(CU_BRM_VERBOSE);
+	else
+		CU_basic_set_mode(CU_BRM_NORMAL);
+
+	if (interactive)
+		CU_console_run_tests();
+	else
+		CU_basic_run_tests();
+	CU_cleanup_registry();
+	return CU_get_error();
+
+}
+
+/* The main function for setting up and running the libsemanage unit tests.
+ * Returns a CUE_SUCCESS on success, or a CUnit error code on failure.
+ */
+int main(int argc, char **argv)
+{
+	int i, verbose = 1, interactive = 0;
+
+	struct option opts[] = {
+		{"verbose", 0, NULL, 'v'},
+		{"interactive", 0, NULL, 'i'},
+		{ NULL, 0, NULL, 0 }
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
+		default: {
+			usage(argv[0]);
+			exit(1);
+		}
+		}
+	}
+
+	if (do_tests(interactive, verbose))
+		return -1;
+
+	return 0;
+}
+
diff -pruN -x .svn trunk/libsemanage/tests/Makefile rofs/libsemanage/tests/Makefile
--- trunk/libsemanage/tests/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ rofs/libsemanage/tests/Makefile	2006-07-06 09:55:14.000000000 -0400
@@ -0,0 +1,32 @@
+# Add your test source files here:
+SOURCES = $(wildcard *.c)
+
+# Point this variable to the libsemanage source directory you want to test:
+TESTSRC=../src
+
+# Add the required external object files here:
+LIBSEMANAGE = ../src/libsemanage.a
+
+###########################################################################
+
+EXECUTABLE = libsemanage-tests
+CC = gcc
+CFLAGS = -c -g -o0 -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
+INCLUDE = -I$(TESTSRC) -I$(TESTSRC)/../include/semanage
+LDFLAGS = -lcunit -lsemanage
+OBJECTS = $(SOURCES:.c=.o) 
+
+all: $(EXECUTABLE) 
+
+$(EXECUTABLE): $(OBJECTS) 
+	$(CC) $(OBJECTS) $(LIBSEMANAGE) $(LDFLAGS) -o $@
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(INCLUDE) $*.c -o $*.o
+
+clean: 
+	rm -rf $(OBJECTS) $(EXECUTABLE)
+
+test: all 
+	./$(EXECUTABLE)
+
diff -pruN -x .svn trunk/libsemanage/tests/README rofs/libsemanage/tests/README
--- trunk/libsemanage/tests/README	1969-12-31 19:00:00.000000000 -0500
+++ rofs/libsemanage/tests/README	2006-07-06 12:30:25.000000000 -0400
@@ -0,0 +1,64 @@
+Notes on tests
+============================
+The semanage_access_check test in the semanage_store suite simulates a
+read-only filesystem by using DAC permissions. Consequently, these tests
+will fail if run as root, as root can override DAC permissions.
+
+
+How to add and use unit tests 
+=============================
+
+We are using the CUnit unit testing framework.  This framework--and the
+official documentation of the framework--may be found here:
+
+http://cunit.sourceforge.net/
+
+If you have not yet installed CUnit, first do that.  (There is an RPM,
+or you can compile from source.)  Once installed, follow these steps to
+add unit tests for your code:
+
+1. Create a .h and .c file corresponding to the .c file you want to test.
+   For example, test_semanage_store.c provides tests of the functions in
+   semanage_store.c.   Your new .h/.c files represent a suite of related
+   tests.
+
+2. Write or add new tests to a suite.  Tests are simply functions that 
+   take the form:
+
+	void test_my_function(void)
+
+   These tests are where you will make calls to the CUnit assertions.
+ 
+   If you are making a new test suite, also add the suite init/cleanup
+   functions.  These take the form:
+
+   	int <suite_name>_test_init(void)
+    int <suite_name>_cleanup(void)
+
+   These functions will be called before and after the test functions
+   in your suite, respectively.  They return 0 on success, 1 on failure.
+
+3. Update libsemanage-tests.c to add your new suite and/or your new tests
+   using the DECLARE_SUITE macro in do_tests().
+
+4. Update the Makefile:
+     + Make sure that the TESTSRC variable is set to the location
+	   of the libsemanage source code you want to test.
+
+5. Compile the libsemanage source code you will be testing, to ensure
+   the object files are available and up to date.
+
+6. Run your tests.  Rejoice or despair, as appropriate.
+
+
+A note on the the utilities.c: Add functions that can be commonly used 
+here.  For example, it is handy to have a dummy message callback 
+function to silence error messages produced by libsemanage and keep 
+your output pretty.  To do this, include utilities.h and specify the
+callback like so:
+
+        semanage_handle_t *sh;
+        sh = semanage_handle_create();
+        sh->msg_callback = test_msg_handler;
+
+Feel free to add other such functions here as well.
diff -pruN -x .svn trunk/libsemanage/tests/test_semanage_store.c rofs/libsemanage/tests/test_semanage_store.c
--- trunk/libsemanage/tests/test_semanage_store.c	1969-12-31 19:00:00.000000000 -0500
+++ rofs/libsemanage/tests/test_semanage_store.c	2006-07-06 12:32:53.000000000 -0400
@@ -0,0 +1,280 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
+ *          Caleb Case <ccase@tresys.com>
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
+/*  The purpose of this file is to provide unit tests of the functions in:
+ *
+ *  libsemanage/src/semanage_store.c
+ *
+ */
+
+#include "handle.h"
+#include "semanage_store.h"
+
+#include "utilities.h"
+#include "test_semanage_store.h"
+
+#include <libgen.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <CUnit/Basic.h>
+
+semanage_handle_t *sh = NULL;
+const char* polpath = "./test-policy";
+const char* lockpath = "./test-policy/modules";
+const char* readlockpath = "./test-policy/modules/semanage.read.LOCK";
+const char* translockpath = "./test-policy/modules/semanage.trans.LOCK";
+const char* actpath = "./test-policy/modules/active";
+const char* modpath = "./test-policy/modules/active/modules";
+
+/* The suite initialization function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int semanage_store_test_init(void)
+{
+	int err;
+	
+	/* create directories */
+	err = mkdir(polpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	if (err != 0) return -1;
+	
+	err = mkdir(lockpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	if (err != 0) return -1;
+	
+	err = mkdir(actpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	if (err != 0) return -1;
+	
+	err = mkdir(modpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	if (err != 0) return -1;
+	
+	/* initialize the handle */
+	sh = semanage_handle_create();
+	if (sh == NULL) return -1;
+	
+	/* hide error messages */
+	sh->msg_callback = test_msg_handler;
+	
+	/* initialize paths */
+	err = semanage_check_init(polpath);
+	if (err != 0) return -1;
+
+	return 0;
+}
+
+/* The suite cleanup function.
+ * Returns zero on success, non-zero otherwise.
+ */
+int semanage_store_test_cleanup(void)
+{
+	int err;
+	
+	/* remove the test policy directories */
+	err = rmdir(modpath);
+	if (err != 0) return -1;
+	
+	err = rmdir(actpath);
+	if (err != 0) return -1;
+	
+	err = rmdir(lockpath);
+	if (err != 0) return -1;
+	
+	err = rmdir(polpath);
+	if (err != 0) return -1;
+	
+	/* cleanup the handle */
+	semanage_handle_destroy(sh);
+	return 0;
+}
+
+/* Adds all the tests needed for this suite. 
+ */
+int semanage_store_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "semanage_store_access_check", test_semanage_store_access_check)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	
+	if (NULL == CU_add_test(suite, "semanage_get_lock", test_semanage_get_lock)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+	
+	return 0;
+}
+
+/* Tests the semanage_store_access_check function in semanage_store.c
+ */
+void test_semanage_store_access_check(void)
+{
+	int err;
+
+	/* create lock file */
+	err = mknod(readlockpath, S_IRUSR | S_IWUSR, S_IFREG);
+	
+	/* check with permissions 000 */
+	err = chmod(modpath, 0);
+	CU_ASSERT( err == 0 );
+	err = chmod(readlockpath, 0);
+	CU_ASSERT( err == 0 );
+	err = chmod(polpath, 0);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == -1 );
+	
+	/* check with permissions 500 */
+	err = chmod(polpath, S_IRUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(readlockpath, S_IRUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(modpath, S_IRUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == SEMANAGE_CAN_READ );
+	
+	/* check with permissions 700 */
+	err = chmod(polpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(readlockpath, S_IRUSR | S_IWUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(modpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == SEMANAGE_CAN_WRITE );
+	
+	/* check with lock file 000 and others 500 */
+	err = chmod(polpath, S_IRUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(readlockpath, 0);
+	CU_ASSERT( err == 0 );
+	err = chmod(modpath, S_IRUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* check with lock file 000 and others 700 */
+	err = chmod(polpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(readlockpath, 0);
+	CU_ASSERT( err == 0 );
+	err = chmod(modpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* remove lock file */
+	err = remove(readlockpath);
+	CU_ASSERT( err == 0 );
+	
+	/* check with no lock file and 000 */
+	err = chmod(modpath, 0);
+	CU_ASSERT( err == 0 );
+	err = chmod(lockpath, 0);
+	CU_ASSERT( err == 0 );
+	err = chmod(polpath, 0);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == -1 );
+	
+	/* check with no lock file and 500 */
+	err = chmod(polpath, S_IRUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(lockpath, S_IRUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(modpath, S_IRUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* check with no lock file but write in lockpath */
+	err = chmod(lockpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == SEMANAGE_CAN_READ );
+	
+	/* check with no lock file and 700 */
+	err = chmod(polpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	err = chmod(modpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	CU_ASSERT( err == 0 );
+	
+	err = semanage_store_access_check(sh);
+	CU_ASSERT( err == SEMANAGE_CAN_WRITE );
+}
+
+/* Tests the semanage_get_lock functions in semanage_store.c
+ */
+void test_semanage_get_lock(void)
+{
+	int err;
+	
+	/* attempt to get an active lock */
+	err = semanage_get_active_lock(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* attempt to get the lock again */
+	err = semanage_get_active_lock(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* attempt to release the active lock */
+	semanage_release_active_lock(sh);
+	
+	/* attempt to get an active lock */
+	err = semanage_get_active_lock(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* attempt to release the active lock */
+	semanage_release_active_lock(sh);
+	
+	/* attempt to get a trans lock */
+	err = semanage_get_trans_lock(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* attempt to get the lock again */
+	err = semanage_get_trans_lock(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* attempt to release the trans lock */
+	semanage_release_trans_lock(sh);
+	
+	/* attempt to get a trans lock */
+	err = semanage_get_trans_lock(sh);
+	CU_ASSERT( err == 0 );
+	
+	/* attempt to release the trans lock */
+	semanage_release_trans_lock(sh);
+	
+	/* remove the lock files */
+	err = remove(readlockpath);
+	CU_ASSERT( err == 0 );
+	err = remove(translockpath);
+	CU_ASSERT( err == 0 );
+}
+
diff -pruN -x .svn trunk/libsemanage/tests/test_semanage_store.h rofs/libsemanage/tests/test_semanage_store.h
--- trunk/libsemanage/tests/test_semanage_store.h	1969-12-31 19:00:00.000000000 -0500
+++ rofs/libsemanage/tests/test_semanage_store.h	2006-07-06 09:55:14.000000000 -0400
@@ -0,0 +1,32 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
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
+#ifndef __TEST_SEMANAGE_STORE_H__
+#define __TEST_SEMANAGE_STORE_H__
+
+#include <CUnit/Basic.h>
+
+int semanage_store_test_init(void);
+int semanage_store_test_cleanup(void);
+int semanage_store_add_tests(CU_pSuite suite);
+
+void test_semanage_store_access_check(void);
+void test_semanage_get_lock(void);
+
+#endif
diff -pruN -x .svn trunk/libsemanage/tests/utilities.c rofs/libsemanage/tests/utilities.c
--- trunk/libsemanage/tests/utilities.c	1969-12-31 19:00:00.000000000 -0500
+++ rofs/libsemanage/tests/utilities.c	2006-07-06 11:39:38.000000000 -0400
@@ -0,0 +1,36 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
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
+/*  The purpose of this file is to provide some functions commonly needed 
+ *  by our unit tests.
+ */
+
+#include "utilities.h"
+
+/* Silence any error output caused by our tests
+ * by using this dummy function to catch messages. 
+ */
+void test_msg_handler(
+        void* varg,
+        semanage_handle_t* handle,
+        const char* fmt,
+        ...) 
+{
+}
+ 
diff -pruN -x .svn trunk/libsemanage/tests/utilities.h rofs/libsemanage/tests/utilities.h
--- trunk/libsemanage/tests/utilities.h	1969-12-31 19:00:00.000000000 -0500
+++ rofs/libsemanage/tests/utilities.h	2006-07-06 11:38:50.000000000 -0400
@@ -0,0 +1,22 @@
+/* Authors: Christopher Ashworth <cashworth@tresys.com>
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
+#include "handle.h"
+
+void test_msg_handler(void* varg, semanage_handle_t* handle, const char* fmt, ...);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
