Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l49LPVBa015428
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 17:25:31 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l49LPUoo011854
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 21:25:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l49LNQhx027284
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 17:23:26 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l49LNPDY029311
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2007 17:23:25 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Convert sepol_list_del to void return
Message-Id: <63fcfe6bf3ffc49cf83b.1178745281@localhost.localdomain>
Date: Wed, 09 May 2007 17:14:41 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Cc: kmacmill@redhat.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Convert sepol_list_del to void return. There is no possibility of error after
converting the free functions to always return void.

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

4 files changed, 5 insertions(+), 8 deletions(-)
libsepol/include/sepol/list.h |    3 +--
libsepol/src/list.c           |    4 +---
libsepol/src/objset.c         |    3 ++-
libsepol/tests/test-list.c    |    3 +--


diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/include/sepol/list.h
--- a/libsepol/include/sepol/list.h	Wed May 09 16:20:11 2007 -0400
+++ b/libsepol/include/sepol/list.h	Wed May 09 17:13:42 2007 -0400
@@ -199,8 +199,7 @@ extern int sepol_list_pop_back(struct se
  *
  * \retval SEPOL_OK success
  */
-extern int sepol_list_del(struct sepol_handle *h, struct sepol_list *list,
-			  struct sepol_iter *iter);
+extern void sepol_list_del(struct sepol_list *list, struct sepol_iter *iter);
 
 /**
  * \ingroup libsepol_list
diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/src/list.c
--- a/libsepol/src/list.c	Wed May 09 16:20:11 2007 -0400
+++ b/libsepol/src/list.c	Wed May 09 17:13:42 2007 -0400
@@ -278,8 +278,7 @@ int sepol_list_pop_back(struct sepol_han
 }
 
 
-int sepol_list_del(struct sepol_handle *h, struct sepol_list *list,
-		   struct sepol_iter *iter)
+void sepol_list_del(struct sepol_list *list, struct sepol_iter *iter)
 {
 	struct sepol_list_item *cur;
 
@@ -306,7 +305,6 @@ out:
 	free(cur);
 	list->len--;
 	sepol_iter_set_state(iter, NULL);
-	return SEPOL_OK;
 }
 
 static int sepol_list_next(struct sepol_handle *h, struct sepol_iter *iter)
diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/src/objset.c
--- a/libsepol/src/objset.c	Wed May 09 16:20:11 2007 -0400
+++ b/libsepol/src/objset.c	Wed May 09 17:13:42 2007 -0400
@@ -127,8 +127,9 @@ int sepol_objset_del(struct sepol_handle
 	ret = sepol_objset_seek(h, s, &iter, obj);
 	switch (ret) {
 	case SEPOL_EEXIST:
-		ret = sepol_list_del(h, s->objs, iter);
+		sepol_list_del(s->objs, iter);
 		sepol_iter_free(iter);
+		ret = SEPOL_OK;
 		break;
 	case SEPOL_ENOENT:
 		sepol_iter_free(iter);
diff -r c41d53f65490 -r 63fcfe6bf3ff libsepol/tests/test-list.c
--- a/libsepol/tests/test-list.c	Wed May 09 16:20:11 2007 -0400
+++ b/libsepol/tests/test-list.c	Wed May 09 17:13:42 2007 -0400
@@ -143,8 +143,7 @@ static void test_list(void)
 			CU_ASSERT(ret == SEPOL_OK);
 			ret = sepol_iter_next(h, iter);
 			CU_ASSERT(ret == SEPOL_OK);
-			ret = sepol_list_del(h, list, iter2);
-			CU_ASSERT(ret == SEPOL_OK);
+			sepol_list_del(list, iter2);
 			i++;
 			continue;
 		}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
