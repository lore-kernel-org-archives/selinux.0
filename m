Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49KU0bK011734
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 16:30:00 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l49KTw4U015908
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 20:29:58 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l49KTvoq026757
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 16:29:57 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l49KTqYF007210
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 16:29:52 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Make free functions return void in new policyrep code
Message-Id: <c41d53f6549098c4f370.1178742068@localhost.localdomain>
Date: Wed, 09 May 2007 16:21:08 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Cc: kmacmill@redhat.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Patch subject is complete summary.

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

11 files changed, 37 insertions(+), 43 deletions(-)
libsepol/include/sepol/iter.h    |    4 ++--
libsepol/include/sepol/objpool.h |    2 +-
libsepol/src/hashtab.c           |    4 +---
libsepol/src/iter.c              |   13 +++++--------
libsepol/src/list.c              |    2 +-
libsepol/src/objpool.c           |   26 +++++++++++++-------------
libsepol/src/objset.c            |   14 +++++++-------
libsepol/tests/test-hashtab.c    |    2 +-
libsepol/tests/test-list.c       |    8 ++++----
libsepol/tests/test-objpool.c    |    3 +--
libsepol/tests/test-objset.c     |    2 +-


diff -r 33cbee8b7617 -r c41d53f65490 libsepol/include/sepol/iter.h
--- a/libsepol/include/sepol/iter.h	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/include/sepol/iter.h	Wed May 09 16:20:11 2007 -0400
@@ -70,7 +70,7 @@ extern int sepol_iter_create(struct sepo
  * \retval SEPOL_OK success
  * \retval  <0 other errors specific to the underlying data structure
  */
-extern int sepol_iter_free(struct sepol_handle *h, struct sepol_iter *iter);
+extern void sepol_iter_free(struct sepol_iter *iter);
 
 /**
  * \ingroup libsepol_iter
@@ -230,7 +230,7 @@ extern void sepol_iter_set_prev(struct s
 				int (*prev)(struct sepol_handle *, struct sepol_iter *));
 extern void sepol_iter_set_get_data(struct sepol_iter *iter,
 				    void *(*get)(struct sepol_handle *, struct sepol_iter *));
-extern void sepol_iter_set_free(struct sepol_iter *iter, int (*state_free)(struct sepol_handle *, void *data));
+extern void sepol_iter_set_free(struct sepol_iter *iter, void (*state_free)(void *data));
 extern void sepol_iter_set_clone(struct sepol_iter *iter,
 				 int (*clone)(struct sepol_handle *, const struct sepol_iter *old, struct sepol_iter *new_iter));
 
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/include/sepol/objpool.h
--- a/libsepol/include/sepol/objpool.h	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/include/sepol/objpool.h	Wed May 09 16:20:11 2007 -0400
@@ -94,7 +94,7 @@ extern int sepol_objpool_create(struct s
  * \retval SEPOL_OK success
  * \retval SEPOL_ENOMEM out of memory
  */
-extern int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool *s);
+extern void sepol_objpool_free(struct sepol_objpool *s);
 
 /**
  * \ingroup libsepol_objpool
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/src/hashtab.c
--- a/libsepol/src/hashtab.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/src/hashtab.c	Wed May 09 16:20:11 2007 -0400
@@ -242,11 +242,9 @@ struct hashtab_iter_state
 	hashtab_ptr_t cur;
 };
 
-static int hashtab_iter_free(struct sepol_handle *h, void *data)
+static void hashtab_iter_free(void *data)
 {
 	free(data);
-
-	return SEPOL_OK;
 }
 
 
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/src/iter.c
--- a/libsepol/src/iter.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/src/iter.c	Wed May 09 16:20:11 2007 -0400
@@ -34,7 +34,7 @@ struct sepol_iter
 	int (*prev)(struct sepol_handle *, struct sepol_iter *);
 	void *(*get)(struct sepol_handle *, struct sepol_iter *);
 	int (*clone)(struct sepol_handle *, const struct sepol_iter *, struct sepol_iter *);
-	int (*free_fn)(struct sepol_handle *, void *);
+	void (*free_fn)(void *);
 };
 
 int sepol_iter_create(struct sepol_handle *h, struct sepol_iter **iter)
@@ -48,15 +48,12 @@ int sepol_iter_create(struct sepol_handl
 	return SEPOL_OK;
 }
 
-int sepol_iter_free(struct sepol_handle *h, struct sepol_iter *iter)
+void sepol_iter_free(struct sepol_iter *iter)
 {
-	int ret;
 	if (iter->free_fn != NULL) {
-		ret = iter->free_fn(h, iter->state);
+		iter->free_fn(iter->state);
 	}
 	free(iter);
-
-	return ret;
 }
 
 int sepol_iter_clone(struct sepol_handle *h, const struct sepol_iter *iter,
@@ -141,7 +138,7 @@ void sepol_iter_set_state(struct sepol_i
 {
 	assert(iter);
 	if (iter->state && iter->free_fn)
-		iter->free_fn(NULL, iter->state);
+		iter->free_fn(iter->state);
 	iter->state = state;
 }
 
@@ -172,7 +169,7 @@ void sepol_iter_set_get_data(struct sepo
 	iter->get = get;
 }
 
-void sepol_iter_set_free(struct sepol_iter *iter, int (*state_free)(struct sepol_handle *, void *))
+void sepol_iter_set_free(struct sepol_iter *iter, void (*state_free)(void *))
 {
 	assert(iter);
 	iter->free_fn = state_free;
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/src/list.c
--- a/libsepol/src/list.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/src/list.c	Wed May 09 16:20:11 2007 -0400
@@ -223,7 +223,7 @@ int sepol_list_extend_list(struct sepol_
 	ret = sepol_list_extend(h, list, iter);
 
 out:
-	sepol_iter_free(h, iter);
+	sepol_iter_free(iter);
 	return ret;
 }
 
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/src/objpool.c
--- a/libsepol/src/objpool.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/src/objpool.c	Wed May 09 16:20:11 2007 -0400
@@ -50,33 +50,33 @@ int sepol_objpool_create(struct sepol_ha
 	return SEPOL_OK;
 }
 
-int sepol_objpool_free(struct sepol_handle *h, struct sepol_objpool *s)
+void sepol_objpool_free(struct sepol_objpool *s)
 {
 	int ret;
 	struct sepol_iter *iter;
 	hashtab_ptr_t cur;
 
 	if (s == NULL)
-		return SEPOL_OK;
+		return;
 
-	ret = sepol_iter_create(h, &iter);
-	if (ret < 0)
-		return ret;
+	ret = sepol_iter_create(NULL, &iter);
+        /* errors are surprised here because the caller can't really
+	 * recover. What's a little memory leaking between friends
+	 * anyway? */
+	if (ret < 0) {
+		goto out;
+	}
 
-	ret = hashtab_iter(h, s->objs, iter);
-	sepol_foreach(h, ret, cur, iter) {
+	ret = hashtab_iter(NULL, s->objs, iter);
+	sepol_foreach(NULL, ret, cur, iter) {
 		s->obj_free(cur->key);
 		free(cur->datum);
 	}
-	sepol_iter_free(h, iter);
-	if (ret != SEPOL_ITERSTOP) {
-		return ret;
-	}
+	sepol_iter_free(iter);
 
+out:
 	hashtab_destroy(s->objs);
 	free(s);
-	
-	return SEPOL_OK;
 }
 
 
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/src/objset.c
--- a/libsepol/src/objset.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/src/objset.c	Wed May 09 16:20:11 2007 -0400
@@ -92,7 +92,7 @@ static int sepol_objset_seek(struct sepo
 		ERR(h, "iteration ended abnormally");
 	}
 
-	sepol_iter_free(h, iter);
+	sepol_iter_free(iter);
 	*out = NULL;
 	return ret;
 }
@@ -105,11 +105,11 @@ int sepol_objset_add(struct sepol_handle
 	ret = sepol_objset_seek(h, s, &iter, obj);
 	switch (ret) {
 	case SEPOL_EEXIST:
-		sepol_iter_free(h, iter);
+		sepol_iter_free(iter);
 		break;
 	case SEPOL_ENOENT:
 		ret = sepol_list_insert(h, s->objs, iter, obj);
-		sepol_iter_free(h, iter);
+		sepol_iter_free(iter);
 		break;
 	case SEPOL_ITERSTOP:
 		ret = sepol_list_append(h, s->objs, obj);
@@ -128,10 +128,10 @@ int sepol_objset_del(struct sepol_handle
 	switch (ret) {
 	case SEPOL_EEXIST:
 		ret = sepol_list_del(h, s->objs, iter);
-		sepol_iter_free(h, iter);
+		sepol_iter_free(iter);
 		break;
 	case SEPOL_ENOENT:
-		sepol_iter_free(h, iter);
+		sepol_iter_free(iter);
 		break;
 	case SEPOL_ITERSTOP:
 		ret = SEPOL_ENOENT;
@@ -149,11 +149,11 @@ int sepol_objset_contains(struct sepol_h
 	ret = sepol_objset_seek(h, s, &iter, obj);
 	switch (ret) {
 	case SEPOL_EEXIST:
-		sepol_iter_free(h, iter);
+		sepol_iter_free(iter);
 		ret = 1;
 		break;
 	case SEPOL_ENOENT:
-		sepol_iter_free(h, iter);
+		sepol_iter_free(iter);
 		ret = 0;
 		break;
 	case SEPOL_ITERSTOP:
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/tests/test-hashtab.c
--- a/libsepol/tests/test-hashtab.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/tests/test-hashtab.c	Wed May 09 16:20:11 2007 -0400
@@ -64,7 +64,7 @@ static void test_hashtab_iter(void)
 		ret = sepol_iter_next(NULL, iter);
 	}
 	CU_ASSERT(ret == SEPOL_ITERSTOP);
-	sepol_iter_free(NULL, iter);
+	sepol_iter_free(iter);
 	hashtab_destroy(h);
 }
 
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/tests/test-list.c
--- a/libsepol/tests/test-list.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/tests/test-list.c	Wed May 09 16:20:11 2007 -0400
@@ -155,8 +155,8 @@ static void test_list(void)
 	CU_ASSERT(i == 6);
 	CU_ASSERT(sepol_list_length(list) == 5);
 
-	sepol_iter_free(h, iter);
-	sepol_iter_free(h, iter2);
+	sepol_iter_free(iter);
+	sepol_iter_free(iter2);
 	sepol_list_free(list);
 	sepol_handle_destroy(h);
 }
@@ -272,7 +272,7 @@ static void test_list_extend(void)
 	}
 	CU_ASSERT(ret == SEPOL_ITERSTOP);
 
-	sepol_iter_free(h, iter);
+	sepol_iter_free(iter);
 	sepol_list_free(serialism);
 	sepol_list_free(minimalism);
 	sepol_handle_destroy(h);
@@ -340,7 +340,7 @@ static void test_list_extend_list(void)
 	}
 	CU_ASSERT(ret == SEPOL_ITERSTOP);
 
-	sepol_iter_free(h, iter);
+	sepol_iter_free(iter);
 	sepol_list_free(serialism);
 	sepol_list_free(minimalism);
 	sepol_handle_destroy(h);
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/tests/test-objpool.c
--- a/libsepol/tests/test-objpool.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/tests/test-objpool.c	Wed May 09 16:20:11 2007 -0400
@@ -100,8 +100,7 @@ static void test_objpool(void)
 	CU_ASSERT(str != NULL);
 	CU_ASSERT(str == strs[2]);
 
-	ret = sepol_objpool_free(h, objpool);
-	CU_ASSERT(ret == SEPOL_OK);
+	sepol_objpool_free(objpool);
 
 	sepol_handle_destroy(h);
 }
diff -r 33cbee8b7617 -r c41d53f65490 libsepol/tests/test-objset.c
--- a/libsepol/tests/test-objset.c	Wed May 09 15:37:15 2007 -0400
+++ b/libsepol/tests/test-objset.c	Wed May 09 16:20:11 2007 -0400
@@ -134,7 +134,7 @@ static void test_objset(void)
 
 	CU_ASSERT(sepol_objset_length(s) == 2);
 
-	sepol_objpool_free(h, objpool);
+	sepol_objpool_free(objpool);
 	sepol_objset_free(s);
 	sepol_handle_destroy(h);
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
