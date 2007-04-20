Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KDbIwJ002321
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:37:18 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KDbFxQ018617
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 13:37:16 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3KDbEho017401
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:37:14 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3KDbEIs013839
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:37:14 -0400
Received: from localhost.localdomain (vpn-14-141.rdu.redhat.com [10.11.14.141])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3KDbDlZ021914
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:37:13 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [POLICYREP PATCH] Add objpool data structure to libsepol
To: selinux@tycho.nsa.gov
Date: Fri, 20 Apr 2007 09:33:35 -0400
Message-ID: <20070420133335.9801.52803.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a reference counted object pool data structure to libsepol. Object
pools allow the storage of reference counted pools of objects. This
allows, for example, for many data structures to reference a single copy
of an object (e.g., a string).

This version is updated to remove improper use of void** based on comments
from James Antill.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
---

 libsepol/include/sepol/objpool.h |  141 ++++++++++++++++++++++++++++++++++++++
 libsepol/src/objpool.c           |  135 ++++++++++++++++++++++++++++++++++++
 libsepol/tests/libsepol-tests.c  |    2 +
 libsepol/tests/test-objpool.c    |  117 ++++++++++++++++++++++++++++++++
 libsepol/tests/test-objpool.h    |   12 +++
 5 files changed, 407 insertions(+), 0 deletions(-)

diff --git a/libsepol/include/sepol/objpool.h b/libsepol/include/sepol/objpool.h
new file mode 100644
index 0000000..624fa38
--- /dev/null
+++ b/libsepol/include/sepol/objpool.h
@@ -0,0 +1,141 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __objpool_h__
+#define __objpool_h__
+
+#include <sepol/handle.h>
+
+/**
+ * \defgroup libsepol_objpool sepol_objpool: reference counted object pooling
+ * Object pools allow the storage of reference counted pools of objects. This
+ * allows, for example, for many data structures to reference a single
+ * copy of an object (e.g., a string).
+ *
+ * Each object pool stores a single type of object. Hashing, comparison,
+ * and freeing functions must be provided by the user for the object
+ * to be stored. The objects are treated as generic void pointers by
+ * the object pool, and are not manipulated or interpreted in any way.
+ *
+ * The object pool manages the memory for objects. For example, consider
+ * the following example (error handling omitted for brevity):
+ *
+ * \code
+ * struct sepol_objpool *p;
+ * char *a = strdup("foo");
+ * char *b = strdup("foo");
+ * char *c = strdup("bar");
+ *
+ * // creation of object pool ommitted
+ * a = sepol_object_add(p, a);
+ * b = sepol_object_add(p, b);
+ * assert(a == b);
+ * // a and b now point to a single copy for the string "foo".
+ * // The copy originally pointed to by b has been destroyed.
+ * c = sepol_object_add(p, c);
+ * sepol_object_del(p, c);
+ * // The object pool has destroyed its copy of the string "bar"
+ * // because the reference count became 0. The pointer c is no
+ * // longer valid.
+ * sepol_object_del(p, "foo");
+ * sepol_object_del(p, a);
+ * // deletion can use objects that compare as equal in addition
+ * // to pointers. The object pool is now empty.
+ * \endcode
+ */
+
+/* FIXME: These are the same as the hashing and key compare functions
+ * in policydb/hashtab.h - when hashtab.h is properly encapsulated and
+ * exported these should be merged.
+ */
+typedef unsigned int (*sepol_objpool_hash_t)(void *h, const void *key);
+typedef int (*sepol_objpool_cmp_t)(void *h, const void *key1, const void *key2);
+typedef void (*sepol_objpool_free_t)(void *obj);
+
+/**
+ * \ingroup libsepol_objpool
+ * \struct sepol_objpool
+ * The object pool data structure.
+ */
+struct sepol_objpool;
+
+/**
+ * \ingroup libsepol_objpool
+ * Create an object pool.
+ *
+ * Create an object pool with the appropriate functions for hashing,
+ * comparing, and freeing of the object type to be stored in the pool.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param s pointer that will be set to the newly created object pool.
+ * @param hash pointer to a function to hash objects that will be managed
+ *  by the object pool. See sepol_symhash defined policydb/symtab.h for
+ *  an example hashing function.
+ * @param cmp pointer to a function to compare object that will be managed
+ *  by the object pool.
+ * @param obj_free pointer to a function to free the memory for objects
+ *  managed by the object pool.
+ * @param size size of the underlying hash table used to hold the objects.
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_objpool_create(struct sepol_handle * h, struct sepol_objpool **s,
+				sepol_objpool_hash_t hash, sepol_objpool_cmp_t cmp,
+				sepol_objpool_free_t obj_free, unsigned int size);
+
+/**
+ * \ingroup libsepol_objpool
+ * Destroy an object pool. All of the memory associated with the object
+ * pool and all of the objects that it is managing is freed.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param s object pool to destroy
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool *s);
+
+/**
+ * \ingroup libsepol_objpool
+ *
+ * Add an object to the object pool. The pointer returned will point
+ * to the object pool copy of the object (the pointer may or may not
+ * equal the passed in pointer depending upon whether the object pool
+ * already contains a copy of the object). If the object pool already
+ * contains a copy of the passed in object the passed in copy will be
+ * freed and the reference count of the existing object will be
+ * incremented.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param s object pool to which to add the object
+ * @param obj object to be added
+ *
+ * \retval non-NULL success (pointer to shared object)
+ * \retval NULL error
+ */
+extern void *sepol_objpool_add(struct sepol_handle *h, struct sepol_objpool *s,
+			       void *obj);
+
+/**
+ * \ingroup libsepol_objpool
+ *
+ * Delete an object from the object pool. If other references to the
+ * object remain (from calls to sepol_objpool_add) the object will not
+ * be destroyed. However, the caller should *never* depend upon the
+ * object persisting beyond a call sepol_objpool_del. The object
+ * passed in does is not required to be a pointer returned by
+ * sepol_objpool_add; however, it is required to compare as equal to
+ * an existing object.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param s object pool from which to delete object
+ * @param obj object to delete
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOENT object does not exist in pool
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_objpool_del(struct sepol_handle *h, struct sepol_objpool *s, void *obj);
+
+#endif
diff --git a/libsepol/src/objpool.c b/libsepol/src/objpool.c
new file mode 100644
index 0000000..1c7cdde
--- /dev/null
+++ b/libsepol/src/objpool.c
@@ -0,0 +1,135 @@
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
+#include <sepol/objpool.h>
+#include <sepol/policydb/hashtab.h>
+
+#include <stdlib.h>
+
+struct sepol_objpool
+{
+	hashtab_t objs;
+	sepol_objpool_free_t obj_free;
+};
+
+int sepol_objpool_create(struct sepol_handle *h, struct sepol_objpool **s,
+			 sepol_objpool_hash_t hash, sepol_objpool_cmp_t cmp,
+			 sepol_objpool_free_t obj_free, unsigned int size)
+{
+	*s = calloc(1, sizeof(struct sepol_objpool));
+	if (*s == NULL) {
+		return SEPOL_ENOMEM;
+	}
+
+	(*s)->obj_free = obj_free;
+
+	(*s)->objs = hashtab_create((hash_value_fnc_t)hash, (keycmp_fnc_t)cmp, size);
+	if ((*s)->objs == NULL) {
+		free(*s);
+		return SEPOL_ENOMEM;
+	}
+
+
+	return SEPOL_OK;
+}
+
+int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool *s)
+{
+	int ret;
+	struct sepol_iter *iter;
+	hashtab_ptr_t cur;
+
+	if (s == NULL)
+		return SEPOL_OK;
+
+	ret = sepol_iter_create(h, &iter);
+	if (ret < 0)
+		return ret;
+
+	ret = hashtab_iter(h, s->objs, iter);
+	sepol_foreach(h, ret, cur, iter) {
+		s->obj_free(cur->key);
+		free(cur->datum);
+	}
+	sepol_iter_free(h, iter);
+	if (ret != SEPOL_ITERSTOP) {
+		return ret;
+	}
+
+	hashtab_destroy(s->objs);
+	free(s);
+	
+	return SEPOL_OK;
+}
+
+
+void *sepol_objpool_add(struct sepol_handle *h, struct sepol_objpool *s,
+			void *obj)
+{
+	int ret;
+	hashtab_ptr_t cur;
+	unsigned int *refcount;
+
+	refcount = malloc(sizeof(unsigned int));
+	if (refcount == NULL)
+		return NULL;
+	*refcount = 1;
+
+	ret = hashtab_insert2(s->objs, obj, refcount, &cur);
+	if (ret == SEPOL_OK) {
+		return obj;
+	} else if (ret == SEPOL_EEXIST) {
+		free(refcount);
+		s->obj_free(obj);
+		refcount = cur->datum;
+		*refcount += 1;
+		return cur->key;
+	} else {
+		free(refcount);
+		return NULL;
+	}
+}
+
+static void sepol_objpool_hashtab_free(hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	struct sepol_objpool *s = args;
+
+	s->obj_free(k);
+	free(d);
+}
+
+int sepol_objpool_del(struct sepol_handle *h, struct sepol_objpool *s, void *obj)
+{
+	int ret;
+	unsigned int *refcount;
+	
+	refcount = hashtab_search(s->objs, obj);
+	if (refcount == NULL)
+		return SEPOL_ENOENT;
+	
+	(*refcount)--;
+	if (*refcount == 0) {
+		ret = hashtab_remove(s->objs, obj,
+				     sepol_objpool_hashtab_free, s);
+		if (ret != SEPOL_OK)
+			return ret;
+	}
+	return 0;
+}
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index d2f7e8a..2fee01d 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -24,6 +24,7 @@
 #include "test-deps.h"
 #include "test-list.h"
 #include "test-hashtab.h"
+#include "test-objpool.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -65,6 +66,7 @@ static int do_tests(int interactive, int verbose)
 	DECLARE_SUITE(deps);
 	DECLARE_SUITE(list);
 	DECLARE_SUITE(hashtab);
+	DECLARE_SUITE(objpool);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/test-objpool.c b/libsepol/tests/test-objpool.c
new file mode 100644
index 0000000..bbb1c51
--- /dev/null
+++ b/libsepol/tests/test-objpool.c
@@ -0,0 +1,117 @@
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
+#include "test-objpool.h"
+
+#include <sepol/objpool.h>
+#include <sepol/policydb/symtab.h>
+#include <sepol/iter.h>
+#include <sepol/errcodes.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+
+int objpool_test_init(void)
+{
+	return 0;
+}
+
+int objpool_test_cleanup(void)
+{
+	return 0;
+}
+
+static void test_objpool(void)
+{
+	int ret;
+	struct sepol_objpool *objpool;
+	struct sepol_handle *h;
+	char *strs[3];
+	char *str;
+
+	h = sepol_handle_create();
+	CU_ASSERT(h != NULL);
+
+	strs[0] = strdup("foo");
+	CU_ASSERT(strs[0] != NULL);
+	strs[1] = strdup("foo");
+	CU_ASSERT(strs[1] != NULL);
+	strs[2] = strdup("bar");
+	CU_ASSERT(strs[2] != NULL);
+
+	ret = sepol_objpool_create(h, &objpool, (sepol_objpool_hash_t)sepol_symhash,
+				   (sepol_objpool_cmp_t)sepol_symcmp,
+				   free, 64);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	str = strs[0];
+	str = (char *)sepol_objpool_add(h, objpool, str);
+	CU_ASSERT(ret == SEPOL_OK);
+	CU_ASSERT(str == strs[0]);
+
+	str = strs[1];
+	str = (char *)sepol_objpool_add(h, objpool, str);
+	CU_ASSERT(str != NULL);
+	CU_ASSERT(str == strs[0]);
+
+	str = strs[2];
+	str = (char *)sepol_objpool_add(h, objpool, str);
+	CU_ASSERT(str != NULL);
+	CU_ASSERT(str == strs[2]);
+
+	ret = sepol_objpool_del(h, objpool, "foo");
+	CU_ASSERT(ret == SEPOL_OK);
+
+
+	ret = sepol_objpool_del(h, objpool, "foo");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_objpool_del(h,objpool, "foo");
+	CU_ASSERT(ret == SEPOL_ENOENT);
+
+
+	ret = sepol_objpool_del(h, objpool, "bar");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_objpool_del(h, objpool, "bar");
+	CU_ASSERT(ret == SEPOL_ENOENT);
+
+	strs[2] = strdup("bar");
+	CU_ASSERT(strs[2] != NULL);
+	str = strs[2];
+	str = (char *)sepol_objpool_add(h, objpool, str);
+	CU_ASSERT(str != NULL);
+	CU_ASSERT(str == strs[2]);
+
+	ret = sepol_objpool_free(h, objpool);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	sepol_handle_destroy(h);
+}
+
+int objpool_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "test_objpool",
+				test_objpool)) {
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/libsepol/tests/test-objpool.h b/libsepol/tests/test-objpool.h
new file mode 100644
index 0000000..4ed81f2
--- /dev/null
+++ b/libsepol/tests/test-objpool.h
@@ -0,0 +1,12 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __test_objpool_h__
+#define __test_objpool_h__
+
+#include <CUnit/Basic.h>
+
+int objpool_test_init(void);
+int objpool_test_cleanup(void);
+int objpool_add_tests(CU_pSuite suite);
+
+#endif


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
