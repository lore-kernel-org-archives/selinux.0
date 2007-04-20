Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KDcIug002425
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:38:18 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KDcF9B014343
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 13:38:15 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3KDcFNv018077
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:38:15 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3KDc9dD014054
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:38:09 -0400
Received: from localhost.localdomain (vpn-14-141.rdu.redhat.com [10.11.14.141])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3KDc8Hn022017
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 09:38:08 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [POLICYREP PATCH] Add generic iterators and a list data type to
	libsepol
To: selinux@tycho.nsa.gov
Date: Fri, 20 Apr 2007 09:34:30 -0400
Message-ID: <20070420133430.9884.86379.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a generic iterator data structure and a linked-list implementation
based that uses the iterators to libsepol. Includes test cases for the
linked-list implementation.

This version is updated to remove improper use of void** based on comments 
from James Antill.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
---

 libsepol/include/sepol/errcodes.h |    3 
 libsepol/include/sepol/iter.h     |  237 +++++++++++++++++++++
 libsepol/include/sepol/list.h     |  234 +++++++++++++++++++++
 libsepol/src/iter.c               |  186 ++++++++++++++++
 libsepol/src/list.c               |  419 +++++++++++++++++++++++++++++++++++++
 libsepol/tests/libsepol-tests.c   |    2 
 libsepol/tests/test-list.c        |  373 +++++++++++++++++++++++++++++++++
 libsepol/tests/test-list.h        |   12 +
 8 files changed, 1466 insertions(+), 0 deletions(-)

diff --git a/libsepol/include/sepol/errcodes.h b/libsepol/include/sepol/errcodes.h
index c6f3a8b..91cf569 100644
--- a/libsepol/include/sepol/errcodes.h
+++ b/libsepol/include/sepol/errcodes.h
@@ -22,4 +22,7 @@
 #define SEPOL_EEXIST         -EEXIST
 #define SEPOL_ENOENT         -ENOENT
 
+/* Custom error codes */
+#define SEPOL_ITERSTOP       -500
+
 #endif
diff --git a/libsepol/include/sepol/iter.h b/libsepol/include/sepol/iter.h
new file mode 100644
index 0000000..b95d9ca
--- /dev/null
+++ b/libsepol/include/sepol/iter.h
@@ -0,0 +1,237 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+#ifndef __sepol_iter_h__
+#define __sepol_iter_h__
+
+#include <sepol/handle.h>
+
+/**
+ * \defgroup libsepol_iter sepol_iter: generic iterators
+ * Iterators represent a position within a data structure. They are a
+ * generalization of the concept of pointers. Using iterators allows
+ * algorithms to be cleanly separated from data structures by
+ * abstracting the concept of position and movement. Once an iterator
+ * is created and its position initialized in a data structure
+ * specific way, looping and other control flow can be implemented
+ * only using the generic iterator functions.
+ *
+ * For example, consider the code below which loops through a list
+ * (the error handling and some initialization is ommitted for brevity):
+ * \code
+ *   int ret;
+ *   struct sepol_iter *iter;
+ *   struct sepol_handle *h;
+ *
+ *   sepol_iter_create(h, &iter);
+ *   ret = sepol_list_begin(h, iter);
+ *
+ *   while (ret == SEPOL_OK) {
+ *      // process the data
+ *      data = sepol_iter_get_data(h, iter);
+ *      ret = sepol_iter_next(h, iter);
+ *   }
+ *   if (ret != SEPOL_ITERSTOP)
+ *      // handle errors
+ * \endcode
+ */
+
+/**
+ * \ingroup libsepol_iter
+ * \struct sepol_iter
+ *
+ * Iterator data structuer.
+ *
+ * @see libsepol_iter
+ */
+struct sepol_iter;
+
+/**
+ * \ingroup libsepol_iter
+ * Create an iterator. The iterator is not valid
+ * until a data structure specific call has been
+ * made to initiliaze its position (e.g., sepol_list_begin).
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter pointer to allocated iterator
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_iter_create(struct sepol_handle *h, struct sepol_iter **iter);
+
+/**
+ * \ingroup libsepol_iter
+ * Free an iterator. This has no effect on the data structure or items
+ * that the iterator may represent - only the iterator is destroyed.
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter iterator to destroy
+ *
+ * \retval SEPOL_OK success
+ * \retval  <0 other errors specific to the underlying data structure
+ */
+extern int sepol_iter_free(struct sepol_handle *h, struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_iter
+ * Make a copy of an iterator. The new iterator will be at the
+ * same position as the old iterator.
+ *
+ * Warning: Not all iterators support copying. See the data structure
+ * documentation for details on whether iterators to a specific
+ * data structure support copying.
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter iterator to copy
+ * @param new_iter newly created iterator which is a copy of iter
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ * \retval SEPOL_ENOTSUP iterator copying not supported
+ */
+extern int sepol_iter_clone(struct sepol_handle *h, const struct sepol_iter *iter,
+			    struct sepol_iter **new_iter);
+
+/**
+ * \ingroup libsepol_iter
+ * Return the data at this iterator location. The type
+ * of the returned data is data structure specific.
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter iterator from which to return data
+ *
+ * \retval non-NULL the data
+ * \retval NULL error
+ */
+extern void *sepol_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_iter
+ *
+ * Move the iterator to the next position. If SEPOL_ITERSTOP is
+ * returned, one past the end of the data structure has been reached.
+ * After SEPOL_ITERSTOP has been returned No other calls using this
+ * iterator are valid until a data structure specific call has been
+ * made to reset it to a valid position (e.g., sepol_list_begin).
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter iterator to advance
+ * 
+ * \retval SEPOL_OK iterator successfully moved
+ * \retval SEPOL_ITERSTOP iteration should stop
+ * \retval  <0 other errors specific to the underlying data structure
+ */
+extern int sepol_iter_next(struct sepol_handle *h, struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_iter
+ * Move the iterator to the prev position. If SEPOL_ITERSTOP is
+ * returned, one before the beginning of the data structure has been
+ * reached. No other calls using this iterator are valid until a data
+ * structure specific call has been made to reset it to a valid
+ * position (e.g., sepol_list_end).
+ *
+ * Not all iterators support prev - the data structure specific
+ * iterator documentation should indicate whether prev is supported.
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter iterator to move to the previous position
+ *
+ * \retval SEPOL_OK iterator successfully moved
+ * \retval SEPOL_ITERSTOP iteration should stop
+ * \retval SEPOL_ENOTSUP previous iterator not supported for this
+ *  data structure.
+ * \retval  <0: other errors specific to the underlying data structure
+ */
+extern int sepol_iter_prev(struct sepol_handle *h, struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_iter
+ * Move the iterator forward by distance. This does _not_ set the
+ * absolute position of the iterator. Rather, it moves in by distance
+ * from the current position. For example, moving an iterator at
+ * position 2 by 3 would put the iterator at position 5.
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter iterator to move forward
+ * @param distance distance to move iterator forward
+ *
+ * \retval SEPOL_OK iterator successfully moved
+ * \retval SEPOL_ITERSTOP iteration should stop
+ * \retval SEPOL_ENOTSUP previous iterator not supported for this
+ *  data structure.
+ * \retval  <0: other errors specific to the underlying data structure
+ */
+extern int sepol_iter_forward(struct sepol_handle *h, struct sepol_iter *iter,
+		       unsigned int distance);
+
+/**
+ * \ingroup libsepol_iter
+ * Move the iterator backward by distance. This does _not_ set the
+ * absolute position of the iterator. Rather, it moves in by distance
+ * from the current position. For example, moving an iterator at
+ * position 2 by 1 would put the iterator at position 1.
+ *
+ * Iterator must support sepol_iter_prev.
+ *
+ * @param h sepol handle (can be NULL)
+ * @param iter iterator to move backward
+ * @param distance distance to move iterator
+ *
+ * \retval SEPOL_OK iterator successfully moved
+ * \retval SEPOL_ITERSTOP iteration should stop
+ * \retval SEPOL_ENOTSUP previous iterator not supported for this
+ *  data structure.
+ * \retval  <0: other errors specific to the underlying data structure
+ */
+extern int sepol_iter_backward(struct sepol_handle *h, struct sepol_iter *iter,
+			unsigned int distance);
+
+/**
+ * \ingroup libsepol_iter
+ * \def sepol_foreach
+ * Iterate over a sequence in a for-loop-like manner. This
+ * macro is a convenience wrapper around sepol_iter_next
+ * and sepol_iter_get_state. For example:
+ *
+ * \code
+ * int ret;
+ * struct sepol_iter *iter;
+ * char *name;
+ * // initialization omitted
+ * ret = sepol_list_begin(h, list, iter);
+ * sepol_foreach(h, ret, name, iter) {
+ *         printf("%s\n", name);
+ * }
+ * if (ret != SEPOL_ITERSTOP)
+ *         // handle error
+ * \endcode
+ *
+ * @param h sepol handle (can be NULL)
+ * @param ret int variable used to hold the return value
+ *  of functions called by the macro.
+ * @param cur variable used to hold the results of sepol_iter_get_data.
+ *  The type of the variable must be appropriate for the data stored
+ *  in the data structure.
+ * @param iter iterator initialized to a valid position (e.g., after
+ *  a call to sepol_list_begin).
+ */
+#define sepol_foreach(h, ret, cur, iter)				\
+	for (; ret == SEPOL_OK && (cur = sepol_iter_get_data(h, iter)); \
+	     ret = sepol_iter_next(h, iter)) \
+		
+
+/* used by implementations of iterators */
+extern void sepol_iter_set_state(struct sepol_iter *iter, void *state);
+extern void *sepol_iter_get_state(const struct sepol_iter *iter);
+extern void sepol_iter_set_next(struct sepol_iter *iter,
+				int (*next)(struct sepol_handle *, struct sepol_iter *));
+extern void sepol_iter_set_prev(struct sepol_iter *iter,
+				int (*prev)(struct sepol_handle *, struct sepol_iter *));
+extern void sepol_iter_set_get_data(struct sepol_iter *iter,
+				    void *(*get)(struct sepol_handle *, struct sepol_iter *));
+extern void sepol_iter_set_free(struct sepol_iter *iter, int (*state_free)(struct sepol_handle *, void *data));
+extern void sepol_iter_set_clone(struct sepol_iter *iter,
+				 int (*clone)(struct sepol_handle *, const struct sepol_iter *old, struct sepol_iter *new_iter));
+
+#endif
diff --git a/libsepol/include/sepol/list.h b/libsepol/include/sepol/list.h
new file mode 100644
index 0000000..c9dd229
--- /dev/null
+++ b/libsepol/include/sepol/list.h
@@ -0,0 +1,234 @@
+/* Author : Karl MacMillan <kmacmillan@mentalrootkit.com> */
+
+
+#ifndef __sepol_list_h__
+#define __sepol_list_h__
+
+#include <sepol/iter.h>
+
+/**
+ * \defgroup libsepol_list sepol_list: doubly-linked lists
+ * Doubly-linked list data type.
+ *
+ * The sepol_list data type represents a doubly-linked list.
+ * It supports:
+ *   - forward and backward iteration using sepol_iter.
+ *   - prepending and appending in constant time.
+ *   - getting the length in constant time.
+ *   - insertion and deletion.
+ *   - stack / queue like usage (via sepol_list_pop_front and
+ *     sepol_list_pop_back).
+ *
+ * This list implementation is designed to be generic by storing
+ * void pointers as the objects. These pointers are not interpreted
+ * or manipulated in any way. This means that the memory for the
+ * objects is *not* managed with the rest of the list (e.g.,
+ * sepol_list_free only destroys the memory for the list not the
+ * items stored in the list). This also means that the list is not
+ * ideal for storing simple types (like ints) because they need to
+ * be allocated.
+ *
+ * @see sepol_iter
+ */
+
+/**
+ * \ingroup libsepol_list
+ * \struct sepol_list
+ * Doubly-linked list struct type.
+ *
+ * @see libsepol_list
+ */
+struct sepol_list;
+
+/**
+ * \ingroup libsepol_list
+ * Create an sepol_list. On success, SEPOL_OK is returned
+ * and the list pointer passed in is set to an allocated
+ * sepol_list struct that has been initialized.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list pointer to a list pointer for returning the
+ *  newly created list.
+ *
+ * \retval SEPOL_OK list successfully created
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_list_create(struct sepol_handle *h, struct sepol_list **list);
+
+/**
+ * \ingroup libsepol_list
+ * Destroy an sepol_list. This will _not_ free the memory
+ * for the list items, only for the internal list structures.
+ * The list items memory should be freed by the caller.
+ *
+ * @param list list to destroy
+ */
+extern void sepol_list_free(struct sepol_list *list);
+
+/**
+ * \ingroup libsepol_list
+ * Return the lenght of the list. This is a constant time
+ * operation.
+ *
+ * @param list list object
+ *
+ * \returns length of the list
+ */
+extern unsigned int sepol_list_length(struct sepol_list *list);
+
+/**
+ * \ingroup libsepol_list
+ * Append an item to the list. If successful, the item will
+ * become the last item in the list.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list to which to append
+ * @param item to append
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_list_append(struct sepol_handle *h, struct sepol_list *list,
+			     void *item);
+
+/**
+ * \ingroup libsepol_list
+ * Prepend an item to the list. If successful, the item will
+ * become the first item in the list.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list to which to prepend
+ * @param item to prepend
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_list_prepend(struct sepol_handle *h, struct sepol_list *list,
+			      void *item);
+
+/**
+ * \ingroup libsepol_list
+ * Insert an item before the iterator position. The existing item is
+ * shifted to the next position in the list. The iterator continues to
+ * point at the same item, though the position of that item will have
+ * moved forward by one.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list to which to insert
+ * @param iter iter representing the insertion position
+ * @param item item to insert
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_list_insert(struct sepol_handle *h, struct sepol_list *list,
+			     struct sepol_iter *iter, void *item);
+
+/**
+ * \ingroup libsepol_list
+ * Insert into the list all of the items returned by the iter. This method
+ * is useful for inserting all of the items from another data structure
+ * into the list (because a standard iterator is used any data structure that
+ * supports iteratoration can be used).
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list to extend
+ * @param iter iterator for data to extend
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_list_extend(struct sepol_handle *h, struct sepol_list *list,
+			     struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_list
+ * Convenience function to extend a list with another list. Internally, simply
+ * creates a an iter pointing to the beginning of the list and calls
+ * sepol_list_extend.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list to extend
+ * @param other source list
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ENOMEM out of memory
+ */
+extern int sepol_list_extend_list(struct sepol_handle *h, struct sepol_list *list,
+				  struct sepol_list *other);
+
+/**
+ * \ingroup libsepol_list
+ * Remove and return the first item in the list. Item will be set
+ * to the item if the operation was successful.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list from which to pop item
+ * @param item pointer that will be set to the popped item
+ *
+ * \retval SEPOL_OK succss
+ * \retval SEPOL_ERANGE empty list
+ */
+extern int sepol_list_pop_front(struct sepol_handle *h, struct sepol_list *list,
+				void **item);
+
+/**
+ * \ingroup libsepol_list
+ * Remove and return the last item in the list. Item will be set
+ * to the item if the operation was successful.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list from which to pop item
+ * @param item that will be set to the popped item
+ * 
+ * \retval SEPOL_OK succss
+ * \retval SEPOL_ERANGE: empty list
+ */
+extern int sepol_list_pop_back(struct sepol_handle *h, struct sepol_list *list,
+			       void **item);
+
+/**
+ * \ingroup libsepol_list
+ * Delete an item at the iterator position. The iterator is no longer
+ * valid after deletion (if continued iteration is needed, the iterator
+ * should be copied and the copy advanced prior to deletion).
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list from which to delete item
+ * @param iter representing the position of the item to delete
+ *
+ * \retval SEPOL_OK success
+ */
+extern int sepol_list_del(struct sepol_handle *h, struct sepol_list *list,
+			  struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_list
+ * Position the iterator at the beginning of the list. If the list
+ * is empty SEPOL_ITERSTOP will be returned and the iterator will not
+ * be valid.
+ *
+ * @param h sepol handle (may be NULL)
+ * @param list list to iterate over
+ * @param iter iterator to set to list beginning
+ *
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ITERSTOP empty list
+ */
+extern int sepol_list_begin(struct sepol_handle *h, struct sepol_list *list,
+			    struct sepol_iter *iter);
+
+/**
+ * \ingroup libsepol_list
+ * Position the iterator at the end of the list. If the list
+ * is empty SEPOL_ITERSTOP will be returned and the iterator will not
+ * be valid.
+ *
+ * @param h sepol handle (may be NULL)
+ * \retval SEPOL_OK success
+ * \retval SEPOL_ITERSTOP empty list
+ */
+extern int sepol_list_end(struct sepol_handle *h, struct sepol_list *list,
+			  struct sepol_iter *iter);
+
+#endif
diff --git a/libsepol/src/iter.c b/libsepol/src/iter.c
new file mode 100644
index 0000000..4762bdb
--- /dev/null
+++ b/libsepol/src/iter.c
@@ -0,0 +1,186 @@
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
+#include <sepol/iter.h>
+#include <sepol/errcodes.h>
+
+#include "debug.h"
+
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+
+struct sepol_iter
+{
+	void *state;
+	int (*next)(struct sepol_handle *, struct sepol_iter *);
+	int (*prev)(struct sepol_handle *, struct sepol_iter *);
+	void *(*get)(struct sepol_handle *, struct sepol_iter *);
+	int (*clone)(struct sepol_handle *, const struct sepol_iter *, struct sepol_iter *);
+	int (*free_fn)(struct sepol_handle *, void *);
+};
+
+int sepol_iter_create(struct sepol_handle *h, struct sepol_iter **iter)
+{
+	*iter = (struct sepol_iter*)calloc(1, sizeof(struct sepol_iter));
+	if (*iter == NULL) {
+		ERR(h, "out of memory");
+		return SEPOL_ENOMEM;
+	}
+
+	return SEPOL_OK;
+}
+
+int sepol_iter_free(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	int ret;
+	if (iter->free_fn != NULL) {
+		ret = iter->free_fn(h, iter->state);
+	}
+	free(iter);
+
+	return ret;
+}
+
+int sepol_iter_clone(struct sepol_handle *h, const struct sepol_iter *iter,
+		    struct sepol_iter **new_iter)
+{
+	int ret;
+	
+	if (iter->clone == NULL) {
+		ERR(h, "iterator copying not supported");
+		return SEPOL_ENOTSUP;
+	}
+
+	ret = sepol_iter_create(h, new_iter);
+	if (ret < 0)
+		return ret;
+
+	return iter->clone(h, iter, *new_iter);
+}
+
+void *sepol_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	assert(iter);
+	assert(iter->get);
+
+	return iter->get(h, iter);
+}
+
+int sepol_iter_next(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	assert(iter);
+	assert(iter->next);
+
+	return iter->next(h, iter);
+}
+
+int sepol_iter_prev(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	assert(iter);
+
+	if (iter->prev == NULL) {
+		ERR(h, "iterator previous not supported");
+		return SEPOL_ENOTSUP;
+	}
+
+	return iter->prev(h, iter);
+}
+
+/* At some point forward and backward should be overridable by
+ * the data structures. Depending on the data structure there
+ * could be significant performance improvements by directly
+ * implementing forward and backward.
+ */
+int sepol_iter_forward(struct sepol_handle *h, struct sepol_iter *iter,
+		       unsigned int distance)
+{
+	unsigned int i = 0;
+	int ret = SEPOL_OK;
+	
+	while (i < distance && ret == SEPOL_OK) {
+		ret = sepol_iter_next(h, iter);
+		i++;
+	}
+
+	return ret;
+}
+
+int sepol_iter_backward(struct sepol_handle *h, struct sepol_iter *iter,
+			unsigned int distance)
+{
+	unsigned int i = 0;
+	int ret = SEPOL_OK;
+	
+	while (i < distance && ret == SEPOL_OK) {
+		ret = sepol_iter_prev(h, iter);
+		i++;
+	}
+
+	return ret;
+}
+
+void sepol_iter_set_state(struct sepol_iter *iter, void *state)
+{
+	assert(iter);
+	if (iter->state && iter->free_fn)
+		iter->free_fn(NULL, iter->state);
+	iter->state = state;
+}
+
+void *sepol_iter_get_state(const struct sepol_iter *iter)
+{
+	assert(iter);
+	return iter->state;
+}
+
+void sepol_iter_set_next(struct sepol_iter *iter,
+			 int (*next)(struct sepol_handle *, struct sepol_iter *))
+{
+	assert(iter);
+	iter->next = next;
+}
+
+void sepol_iter_set_prev(struct sepol_iter *iter,
+			 int (*prev)(struct sepol_handle *, struct sepol_iter *))
+{
+	assert(iter);
+	iter->prev = prev;
+}
+
+void sepol_iter_set_get_data(struct sepol_iter *iter,
+			     void *(*get)(struct sepol_handle *, struct sepol_iter *))
+{
+	assert(iter);
+	iter->get = get;
+}
+
+void sepol_iter_set_free(struct sepol_iter *iter, int (*state_free)(struct sepol_handle *, void *))
+{
+	assert(iter);
+	iter->free_fn = state_free;
+}
+
+void sepol_iter_set_clone(struct sepol_iter *iter,
+			 int (*clone)(struct sepol_handle *, const struct sepol_iter *old, struct sepol_iter *new_iter))
+{
+	assert(iter);
+	iter->clone = clone;
+}
diff --git a/libsepol/src/list.c b/libsepol/src/list.c
new file mode 100644
index 0000000..a2d8a6c
--- /dev/null
+++ b/libsepol/src/list.c
@@ -0,0 +1,419 @@
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
+#include <sepol/list.h>
+#include <sepol/iter.h>
+
+#include "debug.h"
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
+	unsigned int len;
+};
+
+int sepol_list_create(struct sepol_handle *h, struct sepol_list **list)
+{
+	assert(list);
+
+	*list = (struct sepol_list *)calloc(1, sizeof(struct sepol_list));
+	if (*list == NULL) {
+		ERR(h, "out of memory");
+		return SEPOL_ENOMEM;
+	}
+
+	return SEPOL_OK;
+}
+
+void sepol_list_free(struct sepol_list *list)
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
+unsigned int sepol_list_length(struct sepol_list *list)
+{
+	assert(list);
+	return list->len;
+}
+
+static int sepol_list_item_create(struct sepol_handle *h,
+				  struct sepol_list_item **x)
+{
+	*x = calloc(1, sizeof(struct sepol_list_item));
+	if (*x == NULL) {
+		ERR(h, "out of memory");
+		return SEPOL_ENOMEM;
+	} else {
+		return SEPOL_OK;
+	}
+}
+
+int sepol_list_append(struct sepol_handle *h, struct sepol_list *list, void *item)
+{
+	int ret;
+	struct sepol_list_item *x;
+
+	assert(list);
+
+	ret = sepol_list_item_create(h, &x);
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
+		/* non-empty list */
+		list->tail->next = x;
+		x->prev = list->tail;
+		x->next = NULL;
+		list->tail = x;
+	}
+
+	list->len++;
+	return SEPOL_OK;
+}
+
+int sepol_list_prepend(struct sepol_handle *h, struct sepol_list *list, void *item)
+{
+	int ret;
+	struct sepol_list_item *x;
+
+	assert(list);
+
+	ret = sepol_list_item_create(h, &x);
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
+	list->len++;
+	return SEPOL_OK;
+}
+
+int sepol_list_insert(struct sepol_handle *h, struct sepol_list *list,
+		      struct sepol_iter *iter, void *item)
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
+		return sepol_list_prepend(h, list, item);
+	} else if (list->tail == cur) {
+		return sepol_list_append(h, list, item);
+	}
+
+	ret = sepol_list_item_create(h, &x);
+	if (ret < 0)
+		return ret;
+	x->item = item;
+
+	x->prev = cur->prev;
+	x->prev->next = x;
+	x->next = cur;
+	cur->prev = x;
+	
+	list->len++;
+	return SEPOL_OK;
+}
+
+int sepol_list_extend(struct sepol_handle *h, struct sepol_list *list,
+		      struct sepol_iter *iter)
+{
+	int ret = SEPOL_OK;
+	void *data;
+
+	while (ret == SEPOL_OK) {
+		data = sepol_iter_get_data(h, iter);
+		if (!data)
+			return SEPOL_ERR;
+		ret = sepol_list_append(h, list, data);
+		if (ret < 0)
+			return ret;
+
+		ret = sepol_iter_next(h, iter);
+	}
+	if (ret != SEPOL_ITERSTOP)
+		return ret;
+	else
+		return SEPOL_OK;
+}
+
+int sepol_list_extend_list(struct sepol_handle *h, struct sepol_list *list,
+			   struct sepol_list *other)
+{
+	int ret;
+	struct sepol_iter *iter;
+
+	if (!other->len)
+		return SEPOL_OK;
+
+	ret = sepol_iter_create(h, &iter);
+	if (ret < 0)
+		return ret;
+
+	ret = sepol_list_begin(h, other, iter);
+	if (ret < 0)
+		goto out;
+	ret = sepol_list_extend(h, list, iter);
+
+out:
+	sepol_iter_free(h, iter);
+	return ret;
+}
+
+
+int sepol_list_pop_front(struct sepol_handle *h, struct sepol_list *list,
+			 void **item)
+{
+	struct sepol_list_item *cur;
+
+	if (list->head == NULL)
+		return SEPOL_ERANGE;
+
+	cur = list->head;
+	if (list->head == list->tail) {
+		list->head = NULL;
+		list->tail = NULL;
+	} else {
+		list->head = list->head->next;
+		if (list->head)
+			list->head->prev = NULL;
+	}
+
+	*item = cur->item;
+	free(cur);
+
+	return SEPOL_OK;
+}
+
+int sepol_list_pop_back(struct sepol_handle *h, struct sepol_list *list,
+			void **item)
+{
+	struct sepol_list_item *cur;
+
+	if (list->tail == NULL)
+		return SEPOL_ERANGE;
+
+	cur = list->tail;
+
+	if (list->head == list->tail) {
+		list->head = NULL;
+		list->tail = NULL;
+	} else {
+		list->tail = list->tail->prev;
+		if (list->tail)
+			list->tail->next = NULL;
+	}
+
+	*item = cur->item;
+	free(cur);
+
+	return SEPOL_OK;
+}
+
+
+int sepol_list_del(struct sepol_handle *h, struct sepol_list *list,
+		   struct sepol_iter *iter)
+{
+	struct sepol_list_item *cur;
+
+	cur = sepol_iter_get_state(iter);
+	assert(cur);
+
+	if (list->head == cur && list->tail == cur) {
+		list->head = NULL;
+		list->tail = NULL;
+		goto out;
+	}
+
+	if (cur->prev)
+		cur->prev->next = cur->next;
+	else
+		list->head = cur->next;
+
+	if (cur->next)
+		cur->next->prev = cur->prev;
+	else
+		list->tail = cur->prev;
+
+out:	
+	free(cur);
+	list->len--;
+	sepol_iter_set_state(iter, NULL);
+	return SEPOL_OK;
+}
+
+static int sepol_list_next(struct sepol_handle *h, struct sepol_iter *iter)
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
+static int sepol_list_prev(struct sepol_handle *h, struct sepol_iter *iter)
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
+static void *sepol_list_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter)
+{
+	struct sepol_list_item *cur;
+
+	assert(iter);
+
+	cur = (struct sepol_list_item*)sepol_iter_get_state(iter);
+	if (!cur) {
+		return NULL;
+	}
+
+	return cur->item;
+}
+
+
+static int sepol_list_iter_clone(struct sepol_handle *h, const struct sepol_iter *o,
+				 struct sepol_iter *n);
+
+#define ITERSETUP(iter) { sepol_iter_set_next(iter, sepol_list_next); \
+                          sepol_iter_set_prev(iter, sepol_list_prev); \
+			  sepol_iter_set_clone(iter, sepol_list_iter_clone); \
+                          sepol_iter_set_get_data(iter, sepol_list_iter_get_data); }
+
+static int sepol_list_iter_clone(struct sepol_handle *h, const struct sepol_iter *o,
+				 struct sepol_iter *n)
+{
+	void *state = sepol_iter_get_state(o);
+	sepol_iter_set_state(n, state);
+
+	ITERSETUP(n);
+
+	return SEPOL_OK;
+}
+
+
+int sepol_list_begin(struct sepol_handle *h, struct sepol_list *list,
+		     struct sepol_iter *iter)
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
+int sepol_list_end(struct sepol_handle *h, struct sepol_list *list,
+		   struct sepol_iter *iter)
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
+
diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index dced1c3..c548cdd 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -22,6 +22,7 @@
 #include "test-linker.h"
 #include "test-expander.h"
 #include "test-deps.h"
+#include "test-list.h"
 
 #include <CUnit/Basic.h>
 #include <CUnit/Console.h>
@@ -61,6 +62,7 @@ static int do_tests(int interactive, int verbose)
 	DECLARE_SUITE(linker);
 	DECLARE_SUITE(expander);
 	DECLARE_SUITE(deps);
+	DECLARE_SUITE(list);
 
 	if (verbose)
 		CU_basic_set_mode(CU_BRM_VERBOSE);
diff --git a/libsepol/tests/test-list.c b/libsepol/tests/test-list.c
new file mode 100644
index 0000000..d19a292
--- /dev/null
+++ b/libsepol/tests/test-list.c
@@ -0,0 +1,373 @@
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
+#include <sepol/list.h>
+#include <sepol/iter.h>
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
+	ret = sepol_list_create(NULL, &list);
+	CU_ASSERT(ret == 0);
+
+	sepol_list_free(list);
+}
+
+static void test_list(void)
+{
+	struct sepol_list *list;
+	struct sepol_iter *iter, *iter2;
+	struct sepol_handle *h;
+	int ret;
+	int i, *num, nums[6];
+
+	for (i = 0; i < 6; i++)
+		nums[i] = i;
+
+	h = sepol_handle_create();
+	CU_ASSERT(h != NULL);
+	
+	ret = sepol_iter_create(h, &iter);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_create(h, &list);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_append(h, list, &nums[4]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_append(h, list, &nums[5]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_prepend(h, list, &nums[1]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_begin(h, list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_iter_forward(h, iter, 1);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_insert(h, list, iter, &nums[2]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_begin(h, list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_list_insert(h, list, iter, &nums[0]);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_begin(h, list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_iter_forward(h, iter, 3);
+	CU_ASSERT(ret == 0);
+
+	ret = sepol_list_insert(h, list, iter, &nums[3]);
+	CU_ASSERT(ret == 0);
+
+	CU_ASSERT(sepol_list_length(list) == 6);
+
+	ret = sepol_list_begin(h, list, iter);
+	CU_ASSERT(ret == 0);
+	i = 0;
+
+	sepol_foreach(h, ret, num, iter) {
+		CU_ASSERT(*num == i);
+		i++;
+	}
+
+	CU_ASSERT(i == 6);
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+
+	ret = sepol_list_end(h, list, iter);
+	CU_ASSERT(ret == 0);
+	i = 5;
+	while (ret == SEPOL_OK) {
+		num = (int *)sepol_iter_get_data(h, iter);
+		CU_ASSERT(num != NULL);
+		CU_ASSERT(*num == i);
+		i--;
+		ret = sepol_iter_prev(h, iter);		
+	}
+	CU_ASSERT(i == -1);
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+
+	ret = sepol_list_end(h, list, iter);
+	CU_ASSERT(ret == 0);
+	ret = sepol_iter_prev(h, iter);
+	CU_ASSERT(ret == 0);
+	num = (int *)sepol_iter_get_data(h, iter);
+	CU_ASSERT(num != NULL);
+	CU_ASSERT(*num == 4);
+	
+
+	ret = sepol_list_begin(h, list, iter);
+	CU_ASSERT(ret == 0);
+	i = 0;
+	while (ret == SEPOL_OK) {
+		if (i == 2) {
+			ret = sepol_iter_clone(h, iter, &iter2);
+			CU_ASSERT(ret == SEPOL_OK);
+			ret = sepol_iter_next(h, iter);
+			CU_ASSERT(ret == SEPOL_OK);
+			ret = sepol_list_del(h, list, iter2);
+			CU_ASSERT(ret == SEPOL_OK);
+			i++;
+			continue;
+		}
+		i++;
+		ret = sepol_iter_next(h, iter);
+	}
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+	CU_ASSERT(i == 6);
+	CU_ASSERT(sepol_list_length(list) == 5);
+
+	sepol_iter_free(h, iter);
+	sepol_iter_free(h, iter2);
+	sepol_list_free(list);
+	sepol_handle_destroy(h);
+}
+
+static void test_list_pop(void)
+{
+	int ret;
+	struct sepol_list *list;
+	struct sepol_handle *h;
+	void *item;
+
+	h = sepol_handle_create();
+	CU_ASSERT(h != NULL);
+
+	ret = sepol_list_create(h, &list);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, list, "webern");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, list, "berg");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, list, "schoenberg");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, list, "sessions");
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_pop_back(h, list, &item);
+	CU_ASSERT(ret == SEPOL_OK);
+	CU_ASSERT(strcmp((char*)item, "sessions") == 0);
+
+	ret = sepol_list_pop_back(h, list, &item);
+	CU_ASSERT(ret == SEPOL_OK);
+	CU_ASSERT(strcmp((char*)item, "schoenberg") == 0);
+
+	ret = sepol_list_pop_front(h, list, &item);
+	CU_ASSERT(ret == SEPOL_OK);
+	CU_ASSERT(strcmp((char*)item, "webern") == 0);
+
+	ret = sepol_list_pop_back(h, list, &item);
+	CU_ASSERT(ret == SEPOL_OK);
+	CU_ASSERT(strcmp((char*)item, "berg") == 0);
+
+
+	ret = sepol_list_pop_back(h, list, &item);
+	CU_ASSERT(ret == SEPOL_ERANGE);
+
+	sepol_list_free(list);
+	sepol_handle_destroy(h);
+}
+
+static void test_list_extend(void)
+{
+	int ret, i;
+	struct sepol_list *serialism, *minimalism;
+	struct sepol_iter *iter;
+	struct sepol_handle *h;
+	char *composers[] = {"webern", "berg",
+			     "schoenberg", "sessions",
+			     "adams", "glass", "reich" };
+	char *composer;
+
+	h = sepol_handle_create();
+	CU_ASSERT(h != NULL);
+
+	ret = sepol_list_create(h, &serialism);
+	CU_ASSERT(ret == SEPOL_OK);
+
+
+	ret = sepol_list_create(h, &minimalism);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[0]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[1]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[2]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[3]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, minimalism, composers[4]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, minimalism, composers[5]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, minimalism, composers[6]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_iter_create(h, &iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	ret = sepol_list_begin(h, minimalism, iter);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_extend(h, serialism, iter);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_begin(h, serialism, iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	i = 0;
+	while (ret == SEPOL_OK) {
+		composer = (char *)sepol_iter_get_data(h, iter);
+		CU_ASSERT(composer != NULL);
+		CU_ASSERT(strcmp(composers[i], composer) == 0);
+		ret = sepol_iter_next(h, iter);
+		i++;
+	}
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+
+	sepol_iter_free(h, iter);
+	sepol_list_free(serialism);
+	sepol_list_free(minimalism);
+	sepol_handle_destroy(h);
+}
+
+static void test_list_extend_list(void)
+{
+	int ret, i;
+	struct sepol_list *serialism, *minimalism;
+	struct sepol_iter *iter;
+	struct sepol_handle *h;
+	char *composers[] = {"webern", "berg",
+			     "schoenberg", "sessions",
+			     "adams", "glass", "reich" };
+	char *composer;
+
+
+	h = sepol_handle_create();
+	CU_ASSERT(h != NULL);
+
+	ret = sepol_list_create(h, &serialism);
+	CU_ASSERT(ret == SEPOL_OK);
+
+
+	ret = sepol_list_create(h, &minimalism);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[0]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[1]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[2]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, serialism, composers[3]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, minimalism, composers[4]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, minimalism, composers[5]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_append(h, minimalism, composers[6]);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_list_extend_list(h, serialism, minimalism);
+	CU_ASSERT(ret == SEPOL_OK);
+
+	ret = sepol_iter_create(h, &iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	
+
+	ret = sepol_list_begin(h, serialism, iter);
+	CU_ASSERT(ret == SEPOL_OK);
+	i = 0;
+	while (ret == SEPOL_OK) {
+		composer = (char *)sepol_iter_get_data(h, iter);
+		CU_ASSERT(composer != NULL);
+		CU_ASSERT(strcmp(composers[i], composer) == 0);
+		ret = sepol_iter_next(h, iter);
+		i++;
+	}
+	CU_ASSERT(ret == SEPOL_ITERSTOP);
+
+	sepol_iter_free(h, iter);
+	sepol_list_free(serialism);
+	sepol_list_free(minimalism);
+	sepol_handle_destroy(h);
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
+	if (NULL == CU_add_test(suite, "test_list_pop", test_list_pop)) {
+		return -1;
+	}
+
+	if (NULL == CU_add_test(suite, "test_list_extend", test_list_extend)) {
+		return -1;
+	}
+
+	if (NULL == CU_add_test(suite, "test_list_extend_list", test_list_extend_list)) {
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/libsepol/tests/test-list.h b/libsepol/tests/test-list.h
new file mode 100644
index 0000000..6a51bcb
--- /dev/null
+++ b/libsepol/tests/test-list.h
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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
