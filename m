Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4AHj5Md007924
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 13:45:10 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4AHj1dn003215
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 17:45:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx2.redhat.com (8.13.1/8.13.1) with ESMTP id l4AHhcAv000792
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 13:43:42 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4AHhbPE007901
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 13:43:37 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Make sepol_iter_get_data return void
Message-Id: <1d04713e6b39fcf695ed.1178819012@localhost.localdomain>
Date: Thu, 10 May 2007 13:43:32 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Cc: kmacmill@redhat.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Make sepol_ter_get_data return void and always succeed. This
is doable because implementors can push all errors into
sepol_iter_next. Forcing this to always succeed simplifies
many error paths.

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

6 files changed, 21 insertions(+), 24 deletions(-)
libsepol/include/sepol/iter.h |   17 ++++++++---------
libsepol/src/hashtab.c        |    2 +-
libsepol/src/iter.c           |    8 ++++----
libsepol/src/list.c           |    8 +++-----
libsepol/tests/test-hashtab.c |    2 +-
libsepol/tests/test-list.c    |    8 ++++----


diff -r e89916201547 -r 1d04713e6b39 libsepol/include/sepol/iter.h
--- a/libsepol/include/sepol/iter.h	Thu May 10 10:59:59 2007 -0400
+++ b/libsepol/include/sepol/iter.h	Thu May 10 13:43:00 2007 -0400
@@ -27,7 +27,7 @@
  *
  *   while (ret == SEPOL_OK) {
  *      // process the data
- *      data = sepol_iter_get_data(h, iter);
+ *      data = sepol_iter_get_data(iter);
  *      ret = sepol_iter_next(h, iter);
  *   }
  *   if (ret != SEPOL_ITERSTOP)
@@ -95,15 +95,14 @@ extern int sepol_iter_clone(struct sepol
 /**
  * \ingroup libsepol_iter
  * Return the data at this iterator location. The type
- * of the returned data is data structure specific.
- *
- * @param h sepol handle (can be NULL)
+ * of the returned data is data structure specific. This function
+ * should always succeed.
+ *
  * @param iter iterator from which to return data
  *
  * \retval non-NULL the data
- * \retval NULL error
- */
-extern void *sepol_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter);
+ */
+extern void *sepol_iter_get_data(struct sepol_iter *iter);
 
 /**
  * \ingroup libsepol_iter
@@ -217,7 +216,7 @@ extern int sepol_iter_backward(struct se
  *  a call to sepol_list_begin).
  */
 #define sepol_foreach(h, ret, cur, iter)				\
-	for (; ret == SEPOL_OK && (cur = sepol_iter_get_data(h, iter)); \
+	for (; ret == SEPOL_OK && (cur = sepol_iter_get_data(iter)); \
 	     ret = sepol_iter_next(h, iter)) \
 		
 
@@ -229,7 +228,7 @@ extern void sepol_iter_set_prev(struct s
 extern void sepol_iter_set_prev(struct sepol_iter *iter,
 				int (*prev)(struct sepol_handle *, struct sepol_iter *));
 extern void sepol_iter_set_get_data(struct sepol_iter *iter,
-				    void *(*get)(struct sepol_handle *, struct sepol_iter *));
+				    void *(*get)(struct sepol_iter *));
 extern void sepol_iter_set_free(struct sepol_iter *iter, void (*state_free)(void *data));
 extern void sepol_iter_set_clone(struct sepol_iter *iter,
 				 int (*clone)(struct sepol_handle *, const struct sepol_iter *old, struct sepol_iter *new_iter));
diff -r e89916201547 -r 1d04713e6b39 libsepol/src/hashtab.c
--- a/libsepol/src/hashtab.c	Thu May 10 10:59:59 2007 -0400
+++ b/libsepol/src/hashtab.c	Thu May 10 13:43:00 2007 -0400
@@ -277,7 +277,7 @@ static int hashtab_iter_next(struct sepo
 	return hashtab_state_next_internal(state);
 }
 
-static void *hashtab_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter)
+static void *hashtab_iter_get_data(struct sepol_iter *iter)
 {
 	struct hashtab_iter_state *state = sepol_iter_get_state(iter);
 	assert(state);
diff -r e89916201547 -r 1d04713e6b39 libsepol/src/iter.c
--- a/libsepol/src/iter.c	Thu May 10 10:59:59 2007 -0400
+++ b/libsepol/src/iter.c	Thu May 10 13:43:00 2007 -0400
@@ -32,7 +32,7 @@ struct sepol_iter
 	void *state;
 	int (*next)(struct sepol_handle *, struct sepol_iter *);
 	int (*prev)(struct sepol_handle *, struct sepol_iter *);
-	void *(*get)(struct sepol_handle *, struct sepol_iter *);
+	void *(*get)(struct sepol_iter *);
 	int (*clone)(struct sepol_handle *, const struct sepol_iter *, struct sepol_iter *);
 	void (*free_fn)(void *);
 };
@@ -73,12 +73,12 @@ int sepol_iter_clone(struct sepol_handle
 	return iter->clone(h, iter, *new_iter);
 }
 
-void *sepol_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter)
+void *sepol_iter_get_data(struct sepol_iter *iter)
 {
 	assert(iter);
 	assert(iter->get);
 
-	return iter->get(h, iter);
+	return iter->get(iter);
 }
 
 int sepol_iter_next(struct sepol_handle *h, struct sepol_iter *iter)
@@ -163,7 +163,7 @@ void sepol_iter_set_prev(struct sepol_it
 }
 
 void sepol_iter_set_get_data(struct sepol_iter *iter,
-			     void *(*get)(struct sepol_handle *, struct sepol_iter *))
+			     void *(*get)(struct sepol_iter *))
 {
 	assert(iter);
 	iter->get = get;
diff -r e89916201547 -r 1d04713e6b39 libsepol/src/list.c
--- a/libsepol/src/list.c	Thu May 10 10:59:59 2007 -0400
+++ b/libsepol/src/list.c	Thu May 10 13:43:00 2007 -0400
@@ -189,7 +189,7 @@ int sepol_list_extend(struct sepol_handl
 	void *data;
 
 	while (ret == SEPOL_OK) {
-		data = sepol_iter_get_data(h, iter);
+		data = sepol_iter_get_data(iter);
 		if (!data)
 			return SEPOL_ERR;
 		ret = sepol_list_append(h, list, data);
@@ -347,16 +347,14 @@ static int sepol_list_prev(struct sepol_
 	}	
 }
 
-static void *sepol_list_iter_get_data(struct sepol_handle *h, struct sepol_iter *iter)
+static void *sepol_list_iter_get_data(struct sepol_iter *iter)
 {
 	struct sepol_list_item *cur;
 
 	assert(iter);
 
 	cur = (struct sepol_list_item*)sepol_iter_get_state(iter);
-	if (!cur) {
-		return NULL;
-	}
+	assert(cur);
 
 	return cur->item;
 }
diff -r e89916201547 -r 1d04713e6b39 libsepol/tests/test-hashtab.c
--- a/libsepol/tests/test-hashtab.c	Thu May 10 10:59:59 2007 -0400
+++ b/libsepol/tests/test-hashtab.c	Thu May 10 13:43:00 2007 -0400
@@ -56,7 +56,7 @@ static void test_hashtab_iter(void)
 	ret = hashtab_iter(NULL, h, iter);
 	CU_ASSERT(ret == SEPOL_OK);
 	while (ret == SEPOL_OK) {
-		cur = (hashtab_ptr_t)sepol_iter_get_data(NULL, iter);
+		cur = (hashtab_ptr_t)sepol_iter_get_data(iter);
 		CU_ASSERT(cur != NULL);
 		i = *(int*)cur->datum;
 		CU_ASSERT(i < 3);
diff -r e89916201547 -r 1d04713e6b39 libsepol/tests/test-list.c
--- a/libsepol/tests/test-list.c	Thu May 10 10:59:59 2007 -0400
+++ b/libsepol/tests/test-list.c	Thu May 10 13:43:00 2007 -0400
@@ -116,7 +116,7 @@ static void test_list(void)
 	CU_ASSERT(ret == 0);
 	i = 5;
 	while (ret == SEPOL_OK) {
-		num = (int *)sepol_iter_get_data(h, iter);
+		num = (int *)sepol_iter_get_data(iter);
 		CU_ASSERT(num != NULL);
 		CU_ASSERT(*num == i);
 		i--;
@@ -129,7 +129,7 @@ static void test_list(void)
 	CU_ASSERT(ret == 0);
 	ret = sepol_iter_prev(h, iter);
 	CU_ASSERT(ret == 0);
-	num = (int *)sepol_iter_get_data(h, iter);
+	num = (int *)sepol_iter_get_data(iter);
 	CU_ASSERT(num != NULL);
 	CU_ASSERT(*num == 4);
 	
@@ -263,7 +263,7 @@ static void test_list_extend(void)
 	CU_ASSERT(ret == SEPOL_OK);
 	i = 0;
 	while (ret == SEPOL_OK) {
-		composer = (char *)sepol_iter_get_data(h, iter);
+		composer = (char *)sepol_iter_get_data(iter);
 		CU_ASSERT(composer != NULL);
 		CU_ASSERT(strcmp(composers[i], composer) == 0);
 		ret = sepol_iter_next(h, iter);
@@ -331,7 +331,7 @@ static void test_list_extend_list(void)
 	CU_ASSERT(ret == SEPOL_OK);
 	i = 0;
 	while (ret == SEPOL_OK) {
-		composer = (char *)sepol_iter_get_data(h, iter);
+		composer = (char *)sepol_iter_get_data(iter);
 		CU_ASSERT(composer != NULL);
 		CU_ASSERT(strcmp(composers[i], composer) == 0);
 		ret = sepol_iter_next(h, iter);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
