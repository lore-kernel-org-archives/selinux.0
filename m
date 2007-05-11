Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4BKaNvQ017277
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 16:36:23 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4BKaLDl026981
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 20:36:21 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4BKaL1j001271
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 16:36:21 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4BKaGfw026140
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2007 16:36:16 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Remove stub headers for sepol tests
Message-Id: <b6482ea2e0b8b9e0d04a.1178915228@localhost.localdomain>
Date: Fri, 11 May 2007 16:27:08 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Cc: kmacmill@redhat.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently every test in libsepol requires a stub header to declare
functions that are called in exactly one place. This is irritating
so we should remove them and define the functions in libsepol-tests.c.

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

19 files changed, 38 insertions(+), 207 deletions(-)
libsepol/tests/libsepol-tests.c |   44 ++++++++++++++++++++++-----------------
libsepol/tests/test-cond.c      |    3 +-
libsepol/tests/test-cond.h      |   30 --------------------------
libsepol/tests/test-deps.c      |    3 +-
libsepol/tests/test-deps.h      |   30 --------------------------
libsepol/tests/test-expander.c  |    3 +-
libsepol/tests/test-expander.h  |   29 -------------------------
libsepol/tests/test-hashtab.c   |    2 -
libsepol/tests/test-hashtab.h   |   12 ----------
libsepol/tests/test-linker.c    |    3 +-
libsepol/tests/test-linker.h    |   30 --------------------------
libsepol/tests/test-list.c      |    2 -
libsepol/tests/test-list.h      |   12 ----------
libsepol/tests/test-objpool.c   |    2 -
libsepol/tests/test-objpool.h   |   12 ----------
libsepol/tests/test-objset.c    |    2 -
libsepol/tests/test-objset.h    |   12 ----------
libsepol/tests/test-policy.c    |    2 -
libsepol/tests/test-policy.h    |   12 ----------


diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/libsepol-tests.c
--- a/libsepol/tests/libsepol-tests.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/libsepol-tests.c	Fri May 11 16:26:27 2007 -0400
@@ -18,16 +18,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-cond.h"
-#include "test-linker.h"
-#include "test-expander.h"
-#include "test-deps.h"
-#include "test-list.h"
-#include "test-hashtab.h"
-#include "test-objpool.h"
-#include "test-objset.h"
-#include "test-policy.h"
-
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
@@ -39,6 +29,22 @@ int mls;
 int mls;
 
 #define DECLARE_SUITE(name) \
+	int name##_test_init(void); \
+	int name##_test_cleanup(void); \
+	int name##_add_tests(CU_pSuite suite); \
+
+DECLARE_SUITE(cond)
+DECLARE_SUITE(linker)
+DECLARE_SUITE(expander)
+DECLARE_SUITE(deps)
+DECLARE_SUITE(list)
+DECLARE_SUITE(hashtab)
+DECLARE_SUITE(objpool)
+DECLARE_SUITE(objset)
+DECLARE_SUITE(policy)
+
+
+#define SETUP_SUITE(name) \
 	suite = CU_add_suite(#name, name##_test_init, name##_test_cleanup); \
 	if (NULL == suite) { \
 		CU_cleanup_registry(); \
@@ -62,15 +68,15 @@ static int do_tests(int interactive, int
 	if (CUE_SUCCESS != CU_initialize_registry())
 		return CU_get_error();
 
-	DECLARE_SUITE(cond);
-	DECLARE_SUITE(linker);
-	DECLARE_SUITE(expander);
-	DECLARE_SUITE(deps);
-	DECLARE_SUITE(list);
-	DECLARE_SUITE(hashtab);
-	DECLARE_SUITE(objpool);
-	DECLARE_SUITE(objset);
-	DECLARE_SUITE(policy);
+	SETUP_SUITE(cond);
+	SETUP_SUITE(linker);
+	SETUP_SUITE(expander);
+	SETUP_SUITE(deps);
+	SETUP_SUITE(list);
+	SETUP_SUITE(hashtab);
+	SETUP_SUITE(objpool);
+	SETUP_SUITE(objset);
+	SETUP_SUITE(policy);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-cond.c
--- a/libsepol/tests/test-cond.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-cond.c	Fri May 11 16:26:27 2007 -0400
@@ -18,7 +18,8 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-cond.h"
+#include <CUnit/Basic.h>
+
 #include "parse_util.h"
 #include "helpers.h"
 
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-cond.h
--- a/libsepol/tests/test-cond.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-cond.h	Fri May 11 16:26:27 2007 -0400
@@ -1,30 +0,0 @@
-/*
- * Author: Karl MacMillan <kmacmillan@tresys.com>
- *
- * Copyright (C) 2006 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef __TEST_COND_H__
-#define __TEST_COND_H__
-
-#include <CUnit/Basic.h>
-
-int cond_test_init(void);
-int cond_test_cleanup(void);
-int cond_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-deps.c
--- a/libsepol/tests/test-deps.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-deps.c	Fri May 11 16:26:27 2007 -0400
@@ -18,7 +18,8 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-deps.h"
+#include <CUnit/Basic.h>
+
 #include "parse_util.h"
 #include "helpers.h"
 
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-deps.h
--- a/libsepol/tests/test-deps.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-deps.h	Fri May 11 16:26:27 2007 -0400
@@ -1,30 +0,0 @@
-/*
- * Author: Karl MacMillan <kmacmillan@tresys.com>
- *
- * Copyright (C) 2006 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef __TEST_DEPS_H__
-#define __TEST_DEPS_H__
-
-#include <CUnit/Basic.h>
-
-int deps_test_init(void);
-int deps_test_cleanup(void);
-int deps_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-expander.c
--- a/libsepol/tests/test-expander.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-expander.c	Fri May 11 16:26:27 2007 -0400
@@ -30,7 +30,8 @@
  * - check conditional expressions for correct mapping
  */
 
-#include "test-expander.h"
+#include <CUnit/Basic.h>
+
 #include "parse_util.h"
 #include "helpers.h"
 #include "test-common.h"
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-expander.h
--- a/libsepol/tests/test-expander.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-expander.h	Fri May 11 16:26:27 2007 -0400
@@ -1,30 +1,1 @@
-/*
- * Author: Joshua Brindle <jbrindle@tresys.com>
- *
- * Copyright (C) 2006 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
 
-#ifndef __TEST_EXPANDER_H__
-#define __TEST_EXPANDER_H__
-
-#include <CUnit/Basic.h>
-
-int expander_test_init(void);
-int expander_test_cleanup(void);
-int expander_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-hashtab.c
--- a/libsepol/tests/test-hashtab.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-hashtab.c	Fri May 11 16:26:27 2007 -0400
@@ -18,7 +18,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-hashtab.h"
+#include <CUnit/Basic.h>
 
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-hashtab.h
--- a/libsepol/tests/test-hashtab.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-hashtab.h	Fri May 11 16:26:27 2007 -0400
@@ -1,12 +0,0 @@
-/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
-
-#ifndef __test_hashtab_h__
-#define __test_hashtab_h__
-
-#include <CUnit/Basic.h>
-
-int hashtab_test_init(void);
-int hashtab_test_cleanup(void);
-int hashtab_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-linker.c
--- a/libsepol/tests/test-linker.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-linker.c	Fri May 11 16:26:27 2007 -0400
@@ -26,7 +26,8 @@
  * - properly add symbols declared in optionals
  */
 
-#include "test-linker.h"
+#include <CUnit/Basic.h>
+
 #include "parse_util.h"
 #include "helpers.h"
 #include "test-common.h"
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-linker.h
--- a/libsepol/tests/test-linker.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-linker.h	Fri May 11 16:26:27 2007 -0400
@@ -1,30 +0,0 @@
-/*
- * Author: Joshua Brindle <jbrindle@tresys.com>
- *
- * Copyright (C) 2006 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef __TEST_LINKER_H__
-#define __TEST_LINKER_H__
-
-#include <CUnit/Basic.h>
-
-int linker_test_init(void);
-int linker_test_cleanup(void);
-int linker_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-list.c
--- a/libsepol/tests/test-list.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-list.c	Fri May 11 16:26:27 2007 -0400
@@ -18,7 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-list.h"
+#include <CUnit/Basic.h>
 
 #include <sepol/list.h>
 #include <sepol/iter.h>
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-list.h
--- a/libsepol/tests/test-list.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-list.h	Fri May 11 16:26:27 2007 -0400
@@ -1,12 +0,0 @@
-/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
-
-#ifndef __test_list_h__
-#define __test_list_h__
-
-#include <CUnit/Basic.h>
-
-int list_test_init(void);
-int list_test_cleanup(void);
-int list_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-objpool.c
--- a/libsepol/tests/test-objpool.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-objpool.c	Fri May 11 16:26:27 2007 -0400
@@ -18,7 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-objpool.h"
+#include <CUnit/Basic.h>
 
 #include <sepol/objpool.h>
 #include <sepol/policydb/symtab.h>
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-objpool.h
--- a/libsepol/tests/test-objpool.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-objpool.h	Fri May 11 16:26:27 2007 -0400
@@ -1,12 +0,0 @@
-/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
-
-#ifndef __test_objpool_h__
-#define __test_objpool_h__
-
-#include <CUnit/Basic.h>
-
-int objpool_test_init(void);
-int objpool_test_cleanup(void);
-int objpool_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-objset.c
--- a/libsepol/tests/test-objset.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-objset.c	Fri May 11 16:26:27 2007 -0400
@@ -18,7 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-objset.h"
+#include <CUnit/Basic.h>
 
 #include <sepol/objset.h>
 #include <sepol/objpool.h>
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-objset.h
--- a/libsepol/tests/test-objset.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-objset.h	Fri May 11 16:26:27 2007 -0400
@@ -1,12 +0,0 @@
-/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
-
-#ifndef __test_objset_h__
-#define __test_objset_h__
-
-#include <CUnit/Basic.h>
-
-int objset_test_init(void);
-int objset_test_cleanup(void);
-int objset_add_tests(CU_pSuite suite);
-
-#endif
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-policy.c
--- a/libsepol/tests/test-policy.c	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-policy.c	Fri May 11 16:26:27 2007 -0400
@@ -18,7 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "test-policy.h"
+#include <CUnit/Basic.h>
 
 #include <sepol/policy.h>
 #include <sepol/iter.h>
diff -r 78649882a100 -r b6482ea2e0b8 libsepol/tests/test-policy.h
--- a/libsepol/tests/test-policy.h	Fri May 11 16:00:55 2007 -0400
+++ b/libsepol/tests/test-policy.h	Fri May 11 16:26:27 2007 -0400
@@ -1,12 +0,0 @@
-/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
-
-#ifndef __test_policy_h__
-#define __test_policy_h__
-
-#include <CUnit/Basic.h>
-
-int policy_test_init(void);
-int policy_test_cleanup(void);
-int policy_add_tests(CU_pSuite suite);
-
-#endif

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
