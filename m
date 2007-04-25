Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PLwTT6021519
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:58:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3PLwSYP006112
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 21:58:28 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3PLwRFd010974
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:58:28 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3PLwMmF009381
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:58:22 -0400
Received: from localhost.localdomain (vpn-14-34.rdu.redhat.com [10.11.14.34])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3PLwLEB015184
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:58:21 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [POLICYREP PATCH] Add objset to libsepol
To: selinux@tycho.nsa.gov
Date: Wed, 25 Apr 2007 17:58:22 -0400
Message-ID: <20070425215822.16055.18880.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add the objset data structure to libsepol. Object sets behave similarly to
Python sets.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
---

 libsepol/include/sepol/objset.h |  169 +++++++++++++++++++++++++++++++++++++++
 libsepol/src/objset.c           |  154 ++++++++++++++++++++++++++++++++++++
 libsepol/tests/libsepol-tests.c |    2 
 libsepol/tests/test-objset.c    |  147 ++++++++++++++++++++++++++++++++++
 libsepol/tests/test-objset.h    |   12 +++
 5 files changed, 484 insertions(+), 0 deletions(-)

diff --git a/libsepol/include/sepol/objset.h b/libsepol/include/sepol/objset.h
new file mode 100644
index 0000000..14f49e8
--- /dev/null
+++ b/libsepol/include/sepol/objset.h
@@ -0,0 +1,169 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __sepol_objset_h__
+#define __sepol_objset_h__
+
+#include <sepol/iter.h>
+#include <sepol/handle.h>
+
+/**
+ * \defgroup libsepol_objset sepol_objset: sets of unique objects
+ * Object sets store sets of objects unique objects (think sets in
+ * the mathematical sense). The data structure is unordered.
+ * 
+ * For example, consider the following example:
+ *
+ * \code
+ * struct sepol_objset *set;
+ * struct sepol_handle *h;
+ * 
+ * // object set creation ommitted
+ * sepol_objset_add(h, set, "foo");
+ * sepol_objset_add(h, set, "bar");
+ * sepol_objset_add(h, set, "baz");
+ * sepol_objset_add(h, set, "foo");
+ * // at this point the objset contains the strings
+ * // "foo", "bar", and "baz". The duplicate "foo"
+ * // was not added.
+ * \endcode
+ *
+ * In contrast to the objpool data structure, objsets are designed to
+ * be space efficient and hold a relatively small number of objects.
+ * Additionally, the lifecycle management of the objects is not
+ * handled by objsets - it is the responsibility of the caller.
+ *
+ * It is possible to use objsets in conjunction with objpools. In this
+ * mode all of the objects should be added to the pool first so that
+ * the objset comparison function can become a simple pointer
+ * compare. This likely only makes sense when several objsets share a
+ * single objpool (each holding a different subset of the objects
+ * stored in the objpool).
+ */
+struct sepol_objset;
+
+/**
+ * \ingroup libsepol_objset
+ * Function type for comparison of objects stored an objset.
+ */
+typedef int (*sepol_objset_cmp_t)(struct sepol_objset *s, void *a, void *b);
+
+/**
+ * \ingroup libsepol_objset
+ * Create a new objset.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param set out pointer for newly created objset
+ * @param cmp comparison function for objects stored in the set
+ *
+ * \retval SEPOL_ENOMEM out of memory
+ * \retval SEPOL_OK success
+ */
+extern int sepol_objset_create(struct sepol_handle *h, struct sepol_objset **set,
+			       sepol_objset_cmp_t cmp);
+
+/**
+ * \ingroup libsepol_objset
+ *
+ * Free an objset. The contained objects are not freed, only the
+ * objset itself.
+ *
+ * @param s objset to free
+ */
+extern void sepol_objset_free(struct sepol_objset *s);
+
+/**
+ * \ingroup libsepol_objset
+ *
+ * Return the length (number of objects) of the objset. This operation
+ * is constant time.
+ *
+ * @param s objset to determine length
+ *
+ * \retval >=0 number of objects in objset
+ */
+extern unsigned int sepol_objset_length(struct sepol_objset *s);
+
+/**
+ * \ingroup libsepol_objset
+ * Set the compare function.
+ *
+ * @param s objset
+ * @param cmp new compare function
+ *
+ * \retval SEPOL_OK success
+ */
+extern int sepol_objset_set_cmp(struct sepol_objset *s, sepol_objset_cmp_t cmp);
+
+/**
+ * \ingroup libsepol_objset
+ *
+ * Add an object to the object set. The object is only added if an
+ * identical object is not already present.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param s objset to add object
+ * @param obj object to add
+ *
+ * \retval SEPOL_OK success (object was added)
+ * \retval SEPOL_EEXIST object not added because object already exists
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_objset_add(struct sepol_handle *h, struct sepol_objset *s,
+			    void *obj);
+
+/**
+ * \ingroup libsepol_objset
+ *
+ * Delete an object from the object set.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param s objset from which to delete object
+ * @param obj object to delete
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOENT object does not exist in set
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_objset_del(struct sepol_handle *h, struct sepol_objset *s,
+			    void *obj);
+
+/**
+ * \ingroup libsepol_objset
+ *
+ * Iterate over the objects in the set. The objset is unordered so the
+ * order the objects are returned from the iterator should not be
+ * depended upon.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param s objset to iterate over
+ * @param iter already created iterator to set to initial position
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ITERSTOP stop iteration (set is empty)
+ */
+extern int sepol_objset_iter(struct sepol_handle *h, struct sepol_objset *s,
+			     struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_objset
+ *
+ * Mark this set as a compliment. This is simply a flag and does not change
+ * the contents of the set.
+ *
+ * @param s objset to compliment
+ * @param compliment value of compliment flag (0 or 1)
+ */
+extern void sepol_objset_set_compliment(struct sepol_objset *s, char compliment);
+
+/**
+ * \ingroup libsepol_objset
+ *
+ * Return the current value of the compliement flag.
+ *
+ * @param s objset from which to obtain the compliment value
+ *
+ * \retval 0|1 current value of compliment flag
+ */
+extern char sepol_objset_get_compliement(struct sepol_objset *s);
+
+#endif
diff --git a/libsepol/src/objset.c b/libsepol/src/objset.c
new file mode 100644
index 0000000..7b86e6b
--- /dev/null
+++ b/libsepol/src/objset.c
@@ -0,0 +1,154 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <sepol/objset.h>
+#include <sepol/list.h>
+#include <sepol/errcodes.h>
+
+#include "debug.h"
+
+#include <stdlib.h>
+
+struct sepol_objset
+{
+	struct sepol_list *objs;
+	sepol_objset_cmp_t cmp;
+	unsigned int len;
+	char compliment;
+};
+
+int sepol_objset_create(struct sepol_handle *h, struct sepol_objset **set,
+			sepol_objset_cmp_t cmp)
+{
+	int ret;
+
+	*set = calloc(1, sizeof(struct sepol_objset));
+	if (*set == NULL)
+		return SEPOL_ENOMEM;
+
+	(*set)->cmp = cmp;
+
+	ret = sepol_list_create(h, &(*set)->objs);
+	if (ret < 0) {
+		free(set);
+		return ret;
+	}
+	
+	return SEPOL_OK;
+}
+
+void sepol_objset_free(struct sepol_objset *s)
+{
+	if (s == NULL)
+		return;
+	sepol_list_free(s->objs);
+	free(s);
+}
+
+unsigned int sepol_objset_length(struct sepol_objset *s)
+{
+	return sepol_list_length(s->objs);
+}
+
+int sepol_objset_set_cmp(struct sepol_objset *s, sepol_objset_cmp_t cmp)
+{
+	s->cmp = cmp;
+	
+	return SEPOL_OK;
+}
+
+int sepol_objset_add(struct sepol_handle *h, struct sepol_objset *s, void *obj)
+{
+	int ret, ret2, cmp;
+	struct sepol_iter *iter;
+	void *cur;
+
+	ret = sepol_iter_create(h, &iter);
+	if (ret < 0)
+		return ret;
+
+	ret = sepol_list_begin(h, s->objs, iter);
+	sepol_foreach(h, ret, cur, iter) {
+		cmp = s->cmp(s, cur, obj);
+		if (cmp == 0) {
+			ret = SEPOL_EEXIST;
+			goto out;
+		} else if (cmp > 0) {
+			ret = sepol_list_insert(h, s->objs, iter, obj);
+			goto out;
+		}
+	}
+	if (ret != SEPOL_ITERSTOP) {
+		ERR(h, "iteration ended abnormally");
+		goto out;
+	}
+	ret = sepol_list_append(h, s->objs, obj);
+out:
+	ret2 = sepol_iter_free(h, iter);
+	if (ret2 != SEPOL_OK) {
+		ERR(h, "error freeing iterator");
+		return ret2;
+	}
+	return ret;
+}
+
+int sepol_objset_del(struct sepol_handle *h, struct sepol_objset *s, void *obj)
+{
+	int ret, ret2, cmp;
+	struct sepol_iter *iter;
+	void *cur;
+
+	ret = sepol_iter_create(h, &iter);
+	if (ret < 0)
+		return ret;
+
+	ret = sepol_list_begin(h, s->objs, iter);
+	sepol_foreach(h, ret, cur, iter) {
+		cmp = s->cmp(s, cur, obj);
+		if (cmp == 0) {
+			ret = sepol_list_del(h, s->objs, iter);
+			goto out;
+		}
+	}
+	if (ret == SEPOL_ITERSTOP)
+		ret = SEPOL_ENOENT;
+		
+out:
+	ret2 = sepol_iter_free(h, iter);
+	if (ret2 != SEPOL_OK)
+		return ret2;
+	return ret;	
+}
+
+int sepol_objset_iter(struct sepol_handle *h, struct sepol_objset *s,
+		      struct sepol_iter *iter)
+{
+	return sepol_list_begin(h, s->objs, iter);
+}
+
+void sepol_objset_set_compliment(struct sepol_objset *s, char compliment)
+{
+	s->compliment = compliment;
+}
+
+char sepol_objset_get_compliement(struct sepol_objset *s)
+{
+	return s->compliment;
+}
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 2fee01d..5156ada 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -25,6 +25,7 @@
 #include "test-list.h"
 #include "test-hashtab.h"
 #include "test-objpool.h"
+#include "test-objset.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -67,6 +68,7 @@ static int do_tests(int interactive, int verbose)
 	DECLARE_SUITE(list);
 	DECLARE_SUITE(hashtab);
 	DECLARE_SUITE(objpool);
+	DECLARE_SUITE(objset);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/test-objset.c b/libsepol/tests/test-objset.c
new file mode 100644
index 0000000..a6bb934
--- /dev/null
+++ b/libsepol/tests/test-objset.c
@@ -0,0 +1,147 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "test-objset.h"
+
+#include <sepol/objset.h>
+#include <sepol/objpool.h>
+#include <sepol/iter.h>
+#include <sepol/policydb/symtab.h>
+#include <sepol/errcodes.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+
+int objset_test_init(void)
+{
+	return 0;
+}
+
+int objset_test_cleanup(void)
+{
+	return 0;
+}
+
+static int ptrcmp(struct sepol_objset *s, void *a, void *b)
+{
+	if (a == b)
+		return 0;
+	else if (a < b)
+		return -1;
+	else
+		return 1;
+}
+
+static void test_objset(void)
+{
+	int ret;
+	struct sepol_objset *s;
+	struct sepol_objpool *objpool;
+	struct sepol_handle *h;
+	char *strs[3];
+	char *str;
+
+	h = sepol_handle_create();
+	CU_ASSERT(h != NULL);
+
+	ret = sepol_objset_create(h, &s, (sepol_objset_cmp_t)sepol_symcmp);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_objset_add(h, s, "foo");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_objset_add(h, s, "foo");
+	CU_ASSERT(ret == SEPOL_EEXIST);
+
+	CU_ASSERT(sepol_objset_length(s) == 1);
+
+	ret = sepol_objset_add(h, s, "bar");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	CU_ASSERT(sepol_objset_length(s) == 2);
+
+	ret = sepol_objset_del(h, s, "bar");
+	CU_ASSERT(ret == SEPOL_OK);
+	
+	CU_ASSERT(sepol_objset_length(s) == 1);
+
+	ret = sepol_objset_del(h, s, "bar");
+	CU_ASSERT(ret == SEPOL_ENOENT);
+
+	ret = sepol_objset_del(h, s, "foo");
+	CU_ASSERT(ret == SEPOL_OK);
+	
+	CU_ASSERT(sepol_objset_length(s) == 0);
+
+	sepol_objset_free(s);
+
+
+	/* obj pool test */
+	ret = sepol_objset_create(h, &s, (sepol_objset_cmp_t)ptrcmp);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	strs[0] = strdup("foo");
+	CU_ASSERT(strs[0] != NULL);
+	strs[1] = strdup("foo");
+	CU_ASSERT(strs[1] != NULL);
+	strs[2] = strdup("bar");
+	CU_ASSERT(strs[2] != NULL);
+
+	ret = sepol_objpool_create(h, &objpool, (sepol_objpool_hash_t)sepol_symhash,
+				   (sepol_objpool_cmp_t)sepol_symcmp, free, 64);
+	CU_ASSERT(ret == SEPOL_OK);
+	
+	str = strs[0];
+	str = sepol_objpool_add(h, objpool, (void*)str);
+	CU_ASSERT(str != NULL);
+	str = strs[1];
+	str = sepol_objpool_add(h, objpool,(void*)str);
+	CU_ASSERT(str != NULL);
+	str = strs[2];
+	str = sepol_objpool_add(h, objpool, (void*)str);
+	CU_ASSERT(str != NULL);
+
+	ret = sepol_objset_add(h, s, strs[0]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_objset_add(h, s, strs[0]);
+	CU_ASSERT(ret == SEPOL_EEXIST);
+
+	CU_ASSERT(sepol_objset_length(s) == 1);
+
+	ret = sepol_objset_add(h, s, strs[2]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	CU_ASSERT(sepol_objset_length(s) == 2);
+
+	sepol_objpool_free(h, objpool);
+	sepol_objset_free(s);
+	sepol_handle_destroy(h);
+}
+
+int objset_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "test_objset",
+				test_objset)) {
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/libsepol/tests/test-objset.h b/libsepol/tests/test-objset.h
new file mode 100644
index 0000000..d6ab340
--- /dev/null
+++ b/libsepol/tests/test-objset.h
@@ -0,0 +1,12 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __test_objset_h__
+#define __test_objset_h__
+
+#include <CUnit/Basic.h>
+
+int objset_test_init(void);
+int objset_test_cleanup(void);
+int objset_add_tests(CU_pSuite suite);
+
+#endif


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
