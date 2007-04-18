Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IL9kAp008986
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:09:46 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3IL9jOP028882
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 21:09:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL9jhA030482
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:09:45 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL9dLL006018
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:09:40 -0400
Received: from [10.11.14.21] (vpn-14-21.rdu.redhat.com [10.11.14.21])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3IL9d6S030188
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 17:09:39 -0400
Subject: [PATCH - policyrep] hashtab iterator support
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 18 Apr 2007 17:06:17 -0400
Message-Id: <1176930377.11469.55.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support for iterators to the hashtab data structure.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 6e4df8877c3c libsepol/include/sepol/policydb/hashtab.h
--- a/libsepol/include/sepol/policydb/hashtab.h	Wed Apr 18 17:00:23 2007 -0400
+++ b/libsepol/include/sepol/policydb/hashtab.h	Wed Apr 18 17:05:06 2007 -0400
@@ -15,6 +15,7 @@
 #define _SEPOL_POLICYDB_HASHTAB_H_
 
 #include <sepol/errcodes.h>
+#include <sepol/iter.h>
 
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
@@ -103,6 +106,17 @@ extern void hashtab_destroy(hashtab_t h)
 extern void hashtab_destroy(hashtab_t h);
 
 /*
+  Initializes an iterator for the hash table (see
+  sepol/policydb/iter.h).  sepol_iter_get_data will return a
+  hashtab_ptr_t.
+
+  Returns NULL if the iterator cannot be created or the iterator
+  otherwise.
+ */
+extern int hashtab_iter(struct sepol_handle *h, hashtab_t ht,
+			struct sepol_iter *iter);
+
+/*
    Applies the specified apply function to (key,datum,args)
    for each entry in the specified hash table.
 
diff -r 6e4df8877c3c libsepol/src/hashtab.c
--- a/libsepol/src/hashtab.c	Wed Apr 18 17:00:23 2007 -0400
+++ b/libsepol/src/hashtab.c	Wed Apr 18 17:05:06 2007 -0400
@@ -28,9 +28,13 @@
  * Implementation of the hash table type.
  */
 
+#include <sepol/policydb/hashtab.h>
+
+#include "debug.h"
+
 #include <stdlib.h>
 #include <string.h>
-#include <sepol/policydb/hashtab.h>
+#include <assert.h>
 
 hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 						     const hashtab_key_t key),
@@ -63,7 +67,8 @@ hashtab_t hashtab_create(unsigned int (*
 	return p;
 }
 
-int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
+int hashtab_insert2(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
+		    hashtab_ptr_t *current)
 {
 	int hvalue;
 	hashtab_ptr_t prev, cur, newnode;
@@ -79,8 +84,11 @@ int hashtab_insert(hashtab_t h, hashtab_
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
@@ -98,6 +106,11 @@ int hashtab_insert(hashtab_t h, hashtab_
 
 	h->nel++;
 	return SEPOL_OK;
+}
+
+int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
+{
+ 	return hashtab_insert2(h, key, datum, NULL);
 }
 
 int hashtab_remove(hashtab_t h, hashtab_key_t key,
@@ -219,6 +232,86 @@ void hashtab_destroy(hashtab_t h)
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
+static int hashtab_iter_free(struct sepol_handle *h, void *data)
+{
+	free(data);
+
+	return SEPOL_OK;
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
+static int hashtab_iter_next(struct sepol_handle *h,
+			     struct sepol_iter *iter)
+{
+	struct hashtab_iter_state *state = sepol_iter_get_state(iter);
+
+	if (state->cur != NULL)
+		state->cur = state->cur->next;
+	return hashtab_state_next_internal(state);
+}
+
+static int hashtab_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter,
+				 void **data)
+{
+	struct hashtab_iter_state *state = sepol_iter_get_state(iter);
+	assert(state);
+	*data = state->cur;
+	
+	return SEPOL_OK;
+}
+
+int hashtab_iter(struct sepol_handle *h, hashtab_t ht, struct sepol_iter *iter)
+{
+	struct hashtab_iter_state *state;
+
+	assert(iter);
+
+	state = calloc(1, sizeof(struct hashtab_iter_state));
+	if (state == NULL) {
+		ERR(h, "out of memory");
+		return ENOMEM;
+	}
+
+	state->h = ht;
+	state->bucket = 0;
+	state->cur = ht->htable[0];
+	sepol_iter_set_state(iter, state);
+	sepol_iter_set_next(iter, hashtab_iter_next);
+	sepol_iter_set_free(iter, hashtab_iter_free);
+	sepol_iter_set_get_data(iter, hashtab_iter_get_data);
+
+	return hashtab_state_next_internal(state);
+}
+
 int hashtab_map(hashtab_t h,
 		int (*apply) (hashtab_key_t k,
 			      hashtab_datum_t d, void *args), void *args)
diff -r 6e4df8877c3c libsepol/tests/libsepol-tests.c
--- a/libsepol/tests/libsepol-tests.c	Wed Apr 18 17:00:23 2007 -0400
+++ b/libsepol/tests/libsepol-tests.c	Wed Apr 18 17:05:06 2007 -0400
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
diff -r 6e4df8877c3c libsepol/tests/test-hashtab.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/libsepol/tests/test-hashtab.c	Wed Apr 18 17:05:06 2007 -0400
@@ -0,0 +1,76 @@
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
+#include <sepol/policydb/symtab.h>
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
+static void test_hashtab_iter(void)
+{
+	hashtab_t h;
+	hashtab_ptr_t cur;
+	struct sepol_iter *iter;
+	int ret, i;
+	char *strings[] = {"foo", "bar", "baz"};
+
+	h = hashtab_create(sepol_symhash, sepol_symcmp, 64);
+	CU_ASSERT(h != NULL);
+	
+	ret = hashtab_insert(h, strings[0], (void *)0);
+	ret = hashtab_insert(h, strings[1], (void *)1);
+	ret = hashtab_insert(h, strings[2], (void *)2);
+
+	ret = sepol_iter_create(NULL, &iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	ret = hashtab_iter(NULL, h, iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	while (ret == SEPOL_OK) {
+		ret = sepol_iter_get_data(NULL, iter, (void **)&cur);
+		CU_ASSERT(ret == SEPOL_OK);
+		i = (int)cur->datum;
+		CU_ASSERT(i < 3);
+		CU_ASSERT(strcmp(strings[i], (char *)cur->key) == 0);
+		ret = sepol_iter_next(NULL, iter);
+	}
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+	sepol_iter_free(NULL, iter);
+	hashtab_destroy(h);
+}
+
+int hashtab_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "test_hashtab_iter", test_hashtab_iter)) {
+		return -1;
+	}
+	return 0;
+}
diff -r 6e4df8877c3c libsepol/tests/test-hashtab.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/libsepol/tests/test-hashtab.h	Wed Apr 18 17:05:06 2007 -0400
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



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
