Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GMOVHi027620
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 17:24:31 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0GMPOE0018560
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 22:25:24 GMT
Message-ID: <45AD50B7.40805@mentalrootkit.com>
Date: Tue, 16 Jan 2007 17:24:55 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Add list and iter data types to libsepol
References: <45AD3F51.9070005@mentalrootkit.com>
In-Reply-To: <45AD3F51.9070005@mentalrootkit.com>
Content-Type: multipart/mixed;
 boundary="------------080306040505030508010509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080306040505030508010509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Karl MacMillan wrote:
> As part of some work to improve the parser in checkpolicy and module 
> data structures in libsepol, I have implemented doubly-linked list and 
> iterator data types. The attached patch adds these to libsepol.
> 
> I would appreciate feedback on these before I submit larger patches that 
> make use of them. In particular:
> 
> * Is the iterator concept acceptable (I plan to add iterator support to 
> other data types including hashtabs)?
> 

Attached is a patch that implements iterators for hash tables (it also 
includes some unrelated cleanups).

Karl


--------------080306040505030508010509
Content-Type: text/x-patch;
 name="sepol-hashtab-iter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepol-hashtab-iter.patch"

diff -r fceafe45b35c libsepol/include/sepol/policydb/hashtab.h
--- a/libsepol/include/sepol/policydb/hashtab.h	Tue Jan 16 17:22:30 2007 -0500
+++ b/libsepol/include/sepol/policydb/hashtab.h	Tue Jan 16 17:22:40 2007 -0500
@@ -15,6 +15,7 @@
 #define _SEPOL_POLICYDB_HASHTAB_H_
 
 #include <sepol/errcodes.h>
+#include <sepol/policydb/iter.h>
 
 #include <stdint.h>
 #include <stdio.h>
@@ -40,19 +41,18 @@ typedef struct hashtab_val {
 
 typedef hashtab_val_t *hashtab_t;
 
+typedef unsigned int (*hash_value_fnc_t)(hashtab_t h, const hashtab_key_t key);
+typedef int (*keycmp_fnc_t)(hashtab_t h, const hashtab_key_t key1,
+		      const hashtab_key_t key2);
 /*
    Creates a new hash table with the specified characteristics.
 
    Returns NULL if insufficent space is available or
    the new hash table otherwise.
  */
-extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-							    const hashtab_key_t
-							    key),
-				int (*keycmp) (hashtab_t h,
-					       const hashtab_key_t key1,
-					       const hashtab_key_t key2),
+extern hashtab_t hashtab_create(hash_value_fnc_t hash, keycmp_fnc_t keycmp,
 				unsigned int size);
+
 /*
    Inserts the specified (key, datum) pair into the specified hash table.
 
@@ -61,6 +61,9 @@ extern hashtab_t hashtab_create(unsigned
    SEPOL_OK otherwise.
  */
 extern int hashtab_insert(hashtab_t h, hashtab_key_t k, hashtab_datum_t d);
+extern int hashtab_insert2(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
+			   hashtab_ptr_t *current);
+
 
 /*
    Removes the entry with the specified key from the hash table.
@@ -103,6 +106,16 @@ extern void hashtab_destroy(hashtab_t h)
 extern void hashtab_destroy(hashtab_t h);
 
 /*
+  Initializes an iterator for the hash table (see
+  sepol/policydb/iter.h).  sepol_iter_get_data will return a
+  hashtab_ptr_t.
+
+  Returns NULL if the iterator cannot be created or the iterator
+  otherwise.
+ */
+extern int hashtab_iter(hashtab_t h, struct sepol_iter *iter);
+
+/*
    Applies the specified apply function to (key,datum,args)
    for each entry in the specified hash table.
 
diff -r fceafe45b35c libsepol/src/hashtab.c
--- a/libsepol/src/hashtab.c	Tue Jan 16 17:22:30 2007 -0500
+++ b/libsepol/src/hashtab.c	Tue Jan 16 17:22:40 2007 -0500
@@ -28,9 +28,11 @@
  * Implementation of the hash table type.
  */
 
+#include <sepol/policydb/hashtab.h>
+
 #include <stdlib.h>
 #include <string.h>
-#include <sepol/policydb/hashtab.h>
+#include <assert.h>
 
 hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 						     const hashtab_key_t key),
@@ -63,7 +65,8 @@ hashtab_t hashtab_create(unsigned int (*
 	return p;
 }
 
-int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
+int hashtab_insert2(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
+		    hashtab_ptr_t *current)
 {
 	int hvalue;
 	hashtab_ptr_t prev, cur, newnode;
@@ -79,8 +82,11 @@ int hashtab_insert(hashtab_t h, hashtab_
 		cur = cur->next;
 	}
 
-	if (cur && (h->keycmp(h, key, cur->key) == 0))
+	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
+		if (current)
+			*current = cur;
 		return SEPOL_EEXIST;
+	}
 
 	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
 	if (newnode == NULL)
@@ -98,6 +104,11 @@ int hashtab_insert(hashtab_t h, hashtab_
 
 	h->nel++;
 	return SEPOL_OK;
+}
+
+int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
+{
+ 	return hashtab_insert2(h, key, datum, NULL);
 }
 
 int hashtab_remove(hashtab_t h, hashtab_key_t key,
@@ -219,6 +230,84 @@ void hashtab_destroy(hashtab_t h)
 	free(h);
 }
 
+/* to support removal of items, a prev hashtab_ptr_t will
+ * need to be added.
+ */
+struct hashtab_iter_state
+{
+	hashtab_t h;
+	unsigned int bucket;
+	hashtab_ptr_t cur;
+};
+
+static void hashtab_iter_destroy(void *data)
+{
+	free(data);
+}
+
+
+static int hashtab_state_next_internal(struct hashtab_iter_state *state)
+{
+	if (state->cur == NULL) {
+		for (state->bucket++;
+		     state->bucket < state->h->size; state->bucket++) {
+			state->cur = state->h->htable[state->bucket];
+			if (state->cur)
+				break;
+		}
+	}
+	
+	if (state->cur == NULL) {
+		return SEPOL_ITERSTOP;
+	} else {
+		return SEPOL_OK;
+	}
+
+}
+
+static int hashtab_iter_next(struct sepol_iter *iter)
+{
+	struct hashtab_iter_state *state = sepol_iter_get_state(iter);
+
+	if (state->cur != NULL)
+		state->cur = state->cur->next;
+	return hashtab_state_next_internal(state);
+}
+
+static void *hashtab_iter_get_data(struct sepol_iter *iter)
+{
+	struct hashtab_iter_state *state = sepol_iter_get_state(iter);
+	assert(state);
+	return state->cur;
+}
+
+int hashtab_iter(hashtab_t h, struct sepol_iter *iter)
+{
+	struct hashtab_iter_state *state;
+
+	assert(iter);
+
+	state = sepol_iter_get_state(iter);
+	if (state)
+		free(state);
+
+	state = malloc(sizeof(struct hashtab_iter_state));
+	if (state == NULL) {
+		free(state);
+		return ENOMEM;
+	}
+
+	state->h = h;
+	state->bucket = 0;
+	state->cur = h->htable[0];
+	sepol_iter_set_state(iter, state);
+	sepol_iter_set_next(iter, hashtab_iter_next);
+	sepol_iter_set_free(iter, hashtab_iter_destroy);
+	sepol_iter_set_get_data(iter, hashtab_iter_get_data);
+
+	return hashtab_state_next_internal(state);
+}
+
 int hashtab_map(hashtab_t h,
 		int (*apply) (hashtab_key_t k,
 			      hashtab_datum_t d, void *args), void *args)
diff -r fceafe45b35c libsepol/tests/libsepol-tests.c
--- a/libsepol/tests/libsepol-tests.c	Tue Jan 16 17:22:30 2007 -0500
+++ b/libsepol/tests/libsepol-tests.c	Tue Jan 16 17:22:40 2007 -0500
@@ -23,6 +23,7 @@
 #include "test-expander.h"
 #include "test-deps.h"
 #include "test-list.h"
+#include "test-hashtab.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -63,6 +64,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(expander);
 	DECLARE_SUITE(deps);
 	DECLARE_SUITE(list);
+	DECLARE_SUITE(hashtab);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff -r fceafe45b35c libsepol/tests/test-hashtab.c
--- a/libsepol/tests/test-hashtab.c	Tue Jan 16 17:22:30 2007 -0500
+++ b/libsepol/tests/test-hashtab.c	Tue Jan 16 17:22:40 2007 -0500
@@ -0,0 +1,99 @@
+/*
+ * Author: Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2007 Red Hat, Inc.
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
+#include "test-hashtab.h"
+
+#include <sepol/policydb/hashtab.h>
+
+#include <string.h>
+
+int hashtab_test_init(void)
+{
+	return 0;
+}
+
+int hashtab_test_cleanup(void)
+{
+	return 0;
+}
+
+static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
+{
+	char *p, *keyp;
+	size_t size;
+	unsigned int val;
+
+	val = 0;
+	keyp = (char *)key;
+	size = strlen(keyp);
+	for (p = keyp; ((size_t) (p - keyp)) < size; p++)
+		val =
+		    (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^ (*p);
+	return val & (h->size - 1);
+}
+
+static int reqsymcmp(hashtab_t h
+		     __attribute__ ((unused)), hashtab_key_t key1,
+		     hashtab_key_t key2)
+{
+	char *keyp1, *keyp2;
+
+	keyp1 = (char *)key1;
+	keyp2 = (char *)key2;
+	return strcmp(keyp1, keyp2);
+}
+
+static void test_hashtab_iter(void)
+{
+	hashtab_t h;
+	hashtab_ptr_t cur;
+	struct sepol_iter *iter;
+	int ret, i;
+	char *strings[] = {"foo", "bar", "baz"};
+
+	h = hashtab_create(reqsymhash, reqsymcmp, 64);
+	CU_ASSERT(h != NULL);
+	
+	ret = hashtab_insert(h, strings[0], (void *)0);
+	ret = hashtab_insert(h, strings[1], (void *)1);
+	ret = hashtab_insert(h, strings[2], (void *)2);
+
+	ret = sepol_iter_create(&iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	ret = hashtab_iter(h, iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	while (ret == SEPOL_OK) {
+		cur = sepol_iter_get_data(iter);
+		i = (int)cur->datum;
+		CU_ASSERT(i < 3);
+		CU_ASSERT(strcmp(strings[i], (char *)cur->key) == 0);
+		ret = sepol_iter_next(iter);
+	}
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+	sepol_iter_destroy(iter);
+}
+
+int hashtab_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "test_hashtab_iter", test_hashtab_iter)) {
+		return -1;
+	}
+	return 0;
+}
diff -r fceafe45b35c libsepol/tests/test-hashtab.h
--- a/libsepol/tests/test-hashtab.h	Tue Jan 16 17:22:30 2007 -0500
+++ b/libsepol/tests/test-hashtab.h	Tue Jan 16 17:22:40 2007 -0500
@@ -0,0 +1,12 @@
+/* Author: Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __test_hashtab_h__
+#define __test_hashtab_h__
+
+#include <CUnit/Basic.h>
+
+int hashtab_test_init(void);
+int hashtab_test_cleanup(void);
+int hashtab_add_tests(CU_pSuite suite);
+
+#endif

--------------080306040505030508010509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
