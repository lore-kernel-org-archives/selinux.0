Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MKoYOb023175
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:50:34 -0400 (EDT)
Received: from e5.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MKdQo5018209
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 20:39:26 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7MKeURY014216
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:40:31 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MKeGPr271232
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:40:21 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7MKe6kH029121
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:40:06 -0400
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7MKe6lY028664
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:40:06 -0400
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MFsiLw004316
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 10:54:45 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MFsioI004315
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 10:54:44 -0500
Date: Mon, 22 Aug 2005 10:54:44 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 2/6] libsepol: conditional.c resource leaks
Message-ID: <20050822155444.GB4191@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a few bugs found by Coverity:

	in cond_node_find:
		1. new_node was memset before the check for (!new_node).
		2. new_node was not freed on an error path.
	in cond_copy_expr:
		3. on memory failure, NULL was returned without freeing
		the list built thus far.

thanks,
-serge

Index: src/conditional.c
===================================================================
--- src.orig/conditional.c
+++ src/conditional.c
@@ -144,13 +144,15 @@ cond_node_t *cond_node_find(policydb_t *
 	}
         *was_created = 1;
         new_node = (cond_node_t *)malloc(sizeof (cond_node_t));
-        memset(new_node, 0, sizeof(cond_node_t));
         if (!new_node) {
                 return NULL;
         }
+        memset(new_node, 0, sizeof(cond_node_t));
         new_node->expr = cond_copy_expr(needle->expr);
-        if (!new_node->expr)
+        if (!new_node->expr) {
+		free(new_node);
                 return NULL;
+	}
         new_node->cur_state = cond_evaluate_expr(p, new_node->expr);
         new_node->nbools = needle->nbools;
         for (i = 0; i < needle->nbools; i++)
@@ -247,7 +249,7 @@ cond_expr_t *cond_copy_expr(cond_expr_t 
         while (cur) {
                 new_expr = (cond_expr_t*)malloc(sizeof(cond_expr_t));
                 if (!new_expr)
-                        return NULL;
+			goto free_head;
                 memset(new_expr, 0, sizeof(cond_expr_t));
 
                 new_expr->expr_type = cur->expr_type;
@@ -261,6 +263,14 @@ cond_expr_t *cond_copy_expr(cond_expr_t 
                 cur = cur->next;
         }
         return head;
+
+free_head:
+	while (head) {
+		tail = head->next;
+		free(head);
+		head = tail;
+	}
+	return NULL;
 }
 
 /*

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
