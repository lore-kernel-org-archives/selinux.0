Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0GLANJq025013
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 16:10:23 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0GLBG1E005386
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 21:11:16 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0GLBGac015489
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 16:11:16 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0GLBGEW000985
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 16:11:16 -0500
Received: from [10.11.14.57] (vpn-14-57.rdu.redhat.com [10.11.14.57])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0GLBESG029501
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2007 16:11:15 -0500
Message-ID: <45AD3F51.9070005@mentalrootkit.com>
Date: Tue, 16 Jan 2007 16:10:41 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [RFC] Add list and iter data types to libsepol
Content-Type: multipart/mixed;
 boundary="------------080207090805040600080505"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080207090805040600080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

As part of some work to improve the parser in checkpolicy and module 
data structures in libsepol, I have implemented doubly-linked list and 
iterator data types. The attached patch adds these to libsepol.

I would appreciate feedback on these before I submit larger patches that 
make use of them. In particular:

* Is the iterator concept acceptable (I plan to add iterator support to 
other data types including hashtabs)?

* We've discussed dropping the use of typedefs on structs (which I do in 
this patch). Is this what we want to do, or should I add typedefs?

Karl

--------------080207090805040600080505
Content-Type: text/x-patch;
 name="sepol-list-iter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepol-list-iter.patch"

diff -r 20ff5c9a577b libsepol/include/sepol/errcodes.h
--- a/libsepol/include/sepol/errcodes.h	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/include/sepol/errcodes.h	Tue Jan 16 16:04:16 2007 -0500
@@ -22,4 +22,7 @@
 #define SEPOL_EEXIST         -EEXIST
 #define SEPOL_ENOENT         -ENOENT
 
+/* Custom error codes */
+#define SEPOL_ITERSTOP       -500
+
 #endif
diff -r 20ff5c9a577b libsepol/include/sepol/policydb/iter.h
--- a/libsepol/include/sepol/policydb/iter.h	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/include/sepol/policydb/iter.h	Tue Jan 16 16:04:16 2007 -0500
@@ -0,0 +1,118 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __sepol_iter_h__
+#define __sepol_iter_h__
+
+/* Iterators represent a position within a data-structure. They are a
+ * generalization of the concept of pointers. Using iterators allows
+ * algorithms to be cleanly separated from data structures by
+ * abstracting the concept of position and movement. Once an iterator
+ * is created and its position initialized in a data structure
+ * specific way, looping and other control flow can be implemented
+ * only using the generic iterator functions.
+ *
+ * For example, consider the code below which loops through a list
+ * (the error handling is ommitted for brevity):
+ *
+ *   int ret;
+ *   struct sepol_iter *iter;
+ *
+ *   sepol_iter_create(&iter);
+ *   ret = sepol_list_begin(iter);
+ *
+ *   while (ret == SEPOL_OK) {
+ *      // process the data
+ *      data = sepol_iter_get_data(iter);
+ *      ret = sepol_iter_next(iter);
+ *   }
+ *   if (ret != SEPOL_ITERSTOP)
+ *      // handle errors
+ */
+struct sepol_iter;
+
+/* Create an iterator. The iterator is not valid
+ * until a data structure specific call has been
+ * made to initiliaze its position (e.g., sepol_list_begin).
+ *
+ * Returns:
+ *   SEPOL_OK: success
+ *   SEPOL_ENOMEM: out of memory
+ */
+int sepol_iter_create(struct sepol_iter **iter);
+
+/* Destroy an iterator.
+ */
+void sepol_iter_destroy(struct sepol_iter *iter);
+
+/* Return the data at this iterator location. The type
+ * of the returned data is data structure specific.
+ *
+ * Returns:
+ *   Non-null: data at this iterator position
+ *   NULL: error
+ */
+void *sepol_iter_get_data(struct sepol_iter *iter);
+
+/* Move the iterator to the next position. If SEPOL_ITERSTOP is
+ * returned, one past the end of the data structure has been reached.
+ * No other calls using this iterator are valid until a data structure
+ * specific call has been made to reset it to a valid position (e.g.,
+ * sepol_list_begin).
+ *
+ * Returns:
+ *   SEPOL_OK: iterator successfully moved
+ *   SEPOL_ITERSTOP: iteration should stop
+ *   < 0: other errors specific to the underlying data structure
+ */
+int sepol_iter_next(struct sepol_iter *iter);
+
+/* Move the iterator to the prev position. If SEPOL_ITERSTOP is
+ * returned, one before the beginning of the data structure has been
+ * reached. No other calls using this iterator are valid until a data
+ * structure specific call has been made to reset it to a valid
+ * position (e.g., sepol_list_end).
+ *
+ * Not all iterators support prev - the data structure specific
+ * iterator documentation should indicate whether prev is supported.
+ *
+ * Returns:
+ *   SEPOL_OK: iterator successfully moved
+ *   SEPOL_ITERSTOP: iteration should stop
+ *   SEPOL_ENOTSUP: previous iterator not supported for this
+ *     data structure.
+ *   < 0: other errors specific to the underlying data structure
+ */
+int sepol_iter_prev(struct sepol_iter *iter);
+
+/* Move the iterator forward by distance. This does _not_ set the
+ * absolute position of the iterator. Rather, it moves in by distance
+ * from the current position. For example, moving an iterator at
+ * position 2 by 3 would put the iterator at position 5.
+ *
+ * Returns: same as sepol_iter_next
+ */
+int sepol_iter_forward(struct sepol_iter *iter, unsigned int distance);
+
+/* Move the iterator backward by distance. This does _not_ set the
+ * absolute position of the iterator. Rather, it moves in by distance
+ * from the current position. For example, moving an iterator at
+ * position 2 by 1 would put the iterator at position 1.
+ *
+ * Iterator must support sepol_iter_prev.
+ *
+ * Returns: same as sepol_iter_prev
+ */
+int sepol_iter_backward(struct sepol_iter *iter, unsigned int distance);
+
+/* used by implementations of iterators */
+void sepol_iter_set_state(struct sepol_iter *iter, void *state);
+void *sepol_iter_get_state(struct sepol_iter *iter);
+void sepol_iter_set_next(struct sepol_iter *iter,
+			 int (*next)(struct sepol_iter *));
+void sepol_iter_set_prev(struct sepol_iter *iter,
+			 int (*prev)(struct sepol_iter *));
+void sepol_iter_set_get_data(struct sepol_iter *iter,
+			     void *(*get)(struct sepol_iter *));
+void sepol_iter_set_free(struct sepol_iter *iter, void (*state_free)(void *data));
+
+#endif
diff -r 20ff5c9a577b libsepol/include/sepol/policydb/list.h
--- a/libsepol/include/sepol/policydb/list.h	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/include/sepol/policydb/list.h	Tue Jan 16 16:04:16 2007 -0500
@@ -0,0 +1,79 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+
+#ifndef __sepol_list_h__
+#define __sepol_list_h__
+
+#include <sepol/policydb/iter.h>
+
+/* Doubly-linked list data type. */
+
+struct sepol_list;
+
+/* Create an sepol_list. On success, SEPOL_OK is returned
+ * and the list pointer passed in is set to an allocated
+ * sepol_list struct that has been initialized.
+ *
+ * Returns:
+ *   SEPOL_OK: sepol_list successfully created
+ *   SEPOL_ENOMEM: out of memory
+ */
+int sepol_list_create(struct sepol_list **list);
+
+/* Destroy an sepol_list. This will _not_ free the memory
+ * for the list items, only for the internal list structures.
+ * The list item memory should be freed by the caller. Note
+ * that this function can return an error.
+ */
+void sepol_list_destroy(struct sepol_list *list);
+
+/* Append an item to the list. If successful, the item will
+ * become the last item in the list.
+ *
+ * Returns:
+ *   SEPOL_OK: success
+ *   SEPOL_ENOMEM: out of memory
+ */
+int sepol_list_append(struct sepol_list *list, void *item);
+
+/* Prepend an item to the list. If successful, the item will
+ * become the first item in the list.
+ *
+ * Returns:
+ *   SEPOL_OK: success
+ *   SEPOL_ENOMEM: out of memory
+ */
+int sepol_list_prepend(struct sepol_list *list, void *item);
+
+/* Insert an item at the iterator position. The existing item
+ * is shifted to the next position in the list. The iterator
+ * continues to point at the same item, though the position of
+ * that item will have moved forward by one.
+ *
+ * Returns:
+ *   SEPOL_OK: success
+ *   SEPOL_ENOMEM: out of memory
+ */
+int sepol_list_insert(struct sepol_list *list, struct sepol_iter *iter, void *item);
+
+/* Position the iterator at the beginning of the list. If the list
+ * is empty SEPOL_ITERSTOP will be returned and the iterator will not
+ * be valid.
+ *
+ * Returns:
+ *   SEPOL_OK: success
+ *   SEPOL_ITERSTOP: empty list
+ */
+int sepol_list_begin(struct sepol_list *list, struct sepol_iter *iter);
+
+/* Position the iterator at the end of the list. If the list
+ * is empty SEPOL_ITERSTOP will be returned and the iterator will not
+ * be valid.
+ *
+ * Returns:
+ *   SEPOL_OK: success
+ *   SEPOL_ITERSTOP: empty list
+ */
+int sepol_list_end(struct sepol_list *list, struct sepol_iter *iter);
+
+#endif
diff -r 20ff5c9a577b libsepol/src/iter.c
--- a/libsepol/src/iter.c	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/src/iter.c	Tue Jan 16 16:04:16 2007 -0500
@@ -0,0 +1,141 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2006-2007 Red Hat, Inc.
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
+#include <sepol/policydb/iter.h>
+
+#include <sepol/errcodes.h>
+
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+
+struct sepol_iter
+{
+	void *state;
+	int (*next)(struct sepol_iter *);
+	int (*prev)(struct sepol_iter *);
+	void *(*get)(struct sepol_iter *);
+	void (*free)(void *);
+};
+
+int sepol_iter_create(struct sepol_iter **iter)
+{
+	*iter = (struct sepol_iter*)calloc(1, sizeof(struct sepol_iter));
+	if (*iter == NULL)
+		return SEPOL_ENOMEM;
+
+	return SEPOL_OK;
+}
+
+void sepol_iter_destroy(struct sepol_iter *iter)
+{
+	if (iter->free != NULL)
+		iter->free(iter);
+	free(iter);
+}
+
+void *sepol_iter_get_data(struct sepol_iter *iter)
+{
+	assert(iter);
+	assert(iter->get);
+	return iter->get(iter);
+}
+
+int sepol_iter_next(struct sepol_iter *iter)
+{
+	assert(iter);
+	assert(iter->next);
+	return iter->next(iter);
+}
+
+int sepol_iter_prev(struct sepol_iter *iter)
+{
+	assert(iter);
+
+	if (iter->prev == NULL)
+		return SEPOL_ENOTSUP;
+
+	return iter->prev(iter);
+}
+
+int sepol_iter_forward(struct sepol_iter *iter, unsigned int distance)
+{
+	unsigned int i = 0;
+	int ret = SEPOL_OK;
+	
+	while (i < distance && ret == SEPOL_OK) {
+		ret = sepol_iter_next(iter);
+		i++;
+	}
+
+	return ret;
+}
+
+int sepol_iter_backward(struct sepol_iter *iter, unsigned int distance)
+{
+	unsigned int i = 0;
+	int ret = SEPOL_OK;
+	
+	while (i < distance && ret == SEPOL_OK) {
+		ret = sepol_iter_prev(iter);
+		i++;
+	}
+
+	return ret;
+}
+
+void sepol_iter_set_state(struct sepol_iter *iter, void *state)
+{
+	assert(iter);
+	iter->state = state;
+}
+
+void *sepol_iter_get_state(struct sepol_iter *iter)
+{
+	assert(iter);
+	return iter->state;
+}
+
+void sepol_iter_set_next(struct sepol_iter *iter,
+			 int (*next)(struct sepol_iter *))
+{
+	assert(iter);
+	iter->next = next;
+}
+
+void sepol_iter_set_prev(struct sepol_iter *iter,
+			 int (*prev)(struct sepol_iter *))
+{
+	assert(iter);
+	iter->prev = prev;
+}
+
+void sepol_iter_set_get_data(struct sepol_iter *iter,
+			     void *(*get)(struct sepol_iter *))
+{
+	assert(iter);
+	iter->get = get;
+}
+
+void sepol_iter_set_free(struct sepol_iter *iter, void (*state_free)(void *))
+{
+	assert(iter);
+	iter->free = free;
+}
diff -r 20ff5c9a577b libsepol/src/list.c
--- a/libsepol/src/list.c	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/src/list.c	Tue Jan 16 16:04:16 2007 -0500
@@ -0,0 +1,253 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2006-2007 Red Hat, Inc.
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
+#include <sepol/errcodes.h>
+
+#include <sepol/policydb/list.h>
+#include <sepol/policydb/iter.h>
+
+
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+
+struct sepol_list_item
+{
+	struct sepol_list_item *next;
+	struct sepol_list_item *prev;
+	void *item;
+};
+
+struct sepol_list
+{
+	struct sepol_list_item *head;
+	struct sepol_list_item *tail;
+};
+
+int sepol_list_create(struct sepol_list **list)
+{
+	assert(list);
+
+	*list = (struct sepol_list *)calloc(1, sizeof(struct sepol_list));
+	if (*list == NULL)
+		return SEPOL_ENOMEM;
+
+	return SEPOL_OK;
+}
+
+void sepol_list_destroy(struct sepol_list *list)
+{
+	struct sepol_list_item *cur, *next;
+
+	if (list == NULL)
+		return;
+
+	cur = list->head;
+	while (cur != NULL) {
+		next = cur->next;
+		free(cur);
+		cur = next;
+	}
+
+	free(list);
+}
+
+static int sepol_list_item_create(struct sepol_list_item **x)
+{
+	*x = calloc(1, sizeof(struct sepol_list_item));
+	if (*x == NULL)
+		return SEPOL_ENOMEM;
+	else
+		return SEPOL_OK;
+}
+
+int sepol_list_append(struct sepol_list *list, void *item)
+{
+	int ret;
+	struct sepol_list_item *x;
+
+	assert(list);
+
+	ret = sepol_list_item_create(&x);
+	if (ret < 0)
+		return ret;
+	x->item = item;
+
+	/* empty list */
+	if (list->tail == NULL) {
+		list->tail = x;
+		list->head = x;
+		x->prev = NULL;
+		x->next = NULL;
+	} else {
+		list->tail->next = x;
+		x->prev = list->tail;
+		x->next = NULL;
+		list->tail = x;
+	}
+
+	return SEPOL_OK;
+}
+
+int sepol_list_prepend(struct sepol_list *list, void *item)
+{
+	int ret;
+	struct sepol_list_item *x;
+
+	assert(list);
+
+	ret = sepol_list_item_create(&x);
+	if (ret < 0)
+		return ret;
+	x->item = item;
+
+	/* empty list */
+	if (list->tail == NULL) {
+		list->tail = x;
+		list->head = x;
+		x->prev = NULL;
+		x->next = NULL;
+	} else {
+		x->next = list->head;
+		list->head->prev = x;
+		x->prev = NULL;
+		list->head = x;
+	}
+
+	return SEPOL_OK;
+}
+
+int sepol_list_insert(struct sepol_list *list, struct sepol_iter *iter, void *item)
+{
+	int ret;
+	struct sepol_list_item *x, *cur;
+
+	assert(list);
+
+	cur = (struct sepol_list_item*)sepol_iter_get_state(iter);
+	assert(cur);
+
+	/* Short circuit for prepend and append. */
+	if (list->head == cur) {
+		return sepol_list_prepend(list, item);
+	} else if (list->tail == cur) {
+		return sepol_list_append(list, item);
+	}
+
+	ret = sepol_list_item_create(&x);
+	if (ret < 0)
+		return ret;
+	x->item = item;
+
+	x->prev = cur->prev;
+	x->prev->next = x;
+	x->next = cur;
+	cur->prev = x;
+	
+	return SEPOL_OK;
+}
+
+static int sepol_list_next(struct sepol_iter *iter)
+{
+	struct sepol_list_item *cur;
+
+	assert(iter);
+
+	cur = (struct sepol_list_item*)sepol_iter_get_state(iter);
+	assert(cur);
+
+	if (cur->next == NULL) {
+		/* set the state to NULL to catch using this iterator
+		 * after ITERSTOP is returned (which is a bug). */
+		sepol_iter_set_state(iter, NULL);
+		return SEPOL_ITERSTOP;
+	} else {
+		sepol_iter_set_state(iter, cur->next);
+		return SEPOL_OK;
+	}
+}
+
+static int sepol_list_prev(struct sepol_iter *iter)
+{
+	struct sepol_list_item *cur;
+
+	assert(iter);
+
+	cur = (struct sepol_list_item*)sepol_iter_get_state(iter);
+	assert(cur);
+
+	if (cur->prev == NULL) {
+		/* set the state to NULL to catch using this iterator
+		 * after ITERSTOP is returned (which is a bug). */
+		sepol_iter_set_state(iter, NULL);
+		return SEPOL_ITERSTOP;
+	} else {
+		sepol_iter_set_state(iter, cur->prev);
+		return SEPOL_OK;
+	}	
+}
+
+static void *sepol_list_iter_get_data(struct sepol_iter *iter)
+{
+	struct sepol_list_item *cur;
+
+	assert(iter);
+
+	cur = (struct sepol_list_item*)sepol_iter_get_state(iter);
+	assert(cur);
+
+	return cur->item;
+}
+
+#define ITERSETUP(iter) { sepol_iter_set_next(iter, sepol_list_next); \
+                          sepol_iter_set_prev(iter, sepol_list_prev); \
+                          sepol_iter_set_get_data(iter, sepol_list_iter_get_data); }
+
+
+int sepol_list_begin(struct sepol_list *list, struct sepol_iter *iter)
+{
+	assert(list);
+	assert(iter);
+
+	if (list->head == NULL)
+		return SEPOL_ITERSTOP;
+
+	sepol_iter_set_state(iter, list->head);
+
+	ITERSETUP(iter);
+
+	return SEPOL_OK;
+}
+
+int sepol_list_end(struct sepol_list *list, struct sepol_iter *iter)
+{
+	assert(list);
+	assert(iter);
+
+	if (list->tail == NULL)
+		return SEPOL_ITERSTOP;
+
+	sepol_iter_set_state(iter, list->tail);
+
+	ITERSETUP(iter);
+
+	return SEPOL_OK;
+}
+
diff -r 20ff5c9a577b libsepol/tests/libsepol-tests.c
--- a/libsepol/tests/libsepol-tests.c	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/tests/libsepol-tests.c	Tue Jan 16 16:04:16 2007 -0500
@@ -22,6 +22,7 @@
 #include "test-linker.h"
 #include "test-expander.h"
 #include "test-deps.h"
+#include "test-list.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -61,6 +62,7 @@ static int do_tests(int interactive, int
 	DECLARE_SUITE(linker);
 	DECLARE_SUITE(expander);
 	DECLARE_SUITE(deps);
+	DECLARE_SUITE(list);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff -r 20ff5c9a577b libsepol/tests/test-list.c
--- a/libsepol/tests/test-list.c	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/tests/test-list.c	Tue Jan 16 16:04:16 2007 -0500
@@ -0,0 +1,145 @@
+/*
+ * Author : Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2006 Red Hat, Inc.
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
+#include "test-list.h"
+
+#include <sepol/policydb/list.h>
+#include <sepol/policydb/iter.h>
+#include <sepol/errcodes.h>
+
+#include <stdlib.h>
+#include <stdio.h>
+
+int list_test_init(void)
+{
+	return 0;
+}
+
+int list_test_cleanup(void)
+{
+	return 0;
+}
+
+static void test_list_create(void)
+{
+	struct sepol_list *list;
+	int ret;
+	
+	ret = sepol_list_create(&list);
+	CU_ASSERT(ret == 0);
+
+	sepol_list_destroy(list);
+}
+
+static void test_list(void)
+{
+	struct sepol_list *list;
+	struct sepol_iter *iter;
+	int ret;
+	int i, *num, nums[6];
+
+	for (i = 0; i < 6; i++)
+		nums[i] = i;
+	
+	ret = sepol_iter_create(&iter);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_create(&list);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_append(list, &nums[4]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_append(list, &nums[5]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_prepend(list, &nums[1]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_begin(list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_iter_forward(iter, 1);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_insert(list, iter, &nums[2]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_begin(list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_list_insert(list, iter, &nums[0]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_begin(list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_iter_forward(iter, 3);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_insert(list, iter, &nums[3]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_begin(list, iter);
+	CU_ASSERT(ret == 0);
+	i = 0;
+	while (ret == SEPOL_OK) {
+		num = (int*)sepol_iter_get_data(iter);
+		CU_ASSERT(*num == i);
+		i++;
+		ret = sepol_iter_next(iter);
+	}
+	CU_ASSERT(i == 6);
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+
+	ret = sepol_list_end(list, iter);
+	CU_ASSERT(ret == 0);
+	i = 5;
+	while (ret == SEPOL_OK) {
+		num = (int*)sepol_iter_get_data(iter);
+		CU_ASSERT(*num == i);
+		i--;
+		ret = sepol_iter_prev(iter);		
+	}
+	CU_ASSERT(i == -1);
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+
+	ret = sepol_list_end(list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_iter_prev(iter);
+	CU_ASSERT(ret == 0);
+	num = (int*)sepol_iter_get_data(iter);
+	CU_ASSERT(*num == 4);
+	
+
+	sepol_iter_destroy(iter);
+	sepol_list_destroy(list);
+}
+
+int list_add_tests(CU_pSuite suite)
+{
+	if (NULL == CU_add_test(suite, "test_list_create", test_list_create)) {
+		return -1;
+	}
+
+	if (NULL == CU_add_test(suite, "test_list",
+				test_list)) {
+		return -1;
+	}
+
+	return 0;
+}
diff -r 20ff5c9a577b libsepol/tests/test-list.h
--- a/libsepol/tests/test-list.h	Tue Jan 16 15:50:54 2007 -0500
+++ b/libsepol/tests/test-list.h	Tue Jan 16 16:04:16 2007 -0500
@@ -0,0 +1,12 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __test_list_h__
+#define __test_list_h__
+
+#include <CUnit/Basic.h>
+
+int list_test_init(void);
+int list_test_cleanup(void);
+int list_add_tests(CU_pSuite suite);
+
+#endif

--------------080207090805040600080505--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
