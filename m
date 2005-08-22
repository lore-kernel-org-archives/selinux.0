Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7ML65Ob023407
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 17:06:05 -0400 (EDT)
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MKsto5019815
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 20:54:56 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7MKu0F3193428
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:56:00 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MKu4h5311380
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:56:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7MKtteA007935
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:55:55 -0600
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7MKtrMB007882
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 14:55:54 -0600
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MGAchG004815
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 11:10:38 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MGAbDV004814
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 11:10:37 -0500
Date: Mon, 22 Aug 2005 11:10:37 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 4/6] libsepol: expand.c resource leaks
Message-ID: <20050822161037.GD4191@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes two resource leaks found by Coverity:

	1. constrant_node_clone: new_con is not freed on error.  There
	is no case where we goto out_of_mem after new_con has been
	appended to *dst, so I believe this patch is safe.

	2. copy_neverallow: avrule is not freed on error path.

thanks,
-serge

Index: src/expand.c
===================================================================
--- src.orig/expand.c
+++ src/expand.c
@@ -254,7 +254,7 @@ static int common_copy_callback(hashtab_
 
 static int constraint_node_clone(constraint_node_t **dst, constraint_node_t *src, expand_state_t *state)
 {
-        constraint_node_t *new_con, *last_new_con = NULL;
+        constraint_node_t *new_con = NULL, *last_new_con = NULL;
         constraint_expr_t *new_expr = NULL;
         *dst = NULL;
         while (src != NULL) {
@@ -313,6 +313,8 @@ static int constraint_node_clone(constra
         return 0;
  out_of_mem:
         write_error(state, "Out of memory!");
+	if (new_con)
+		free(new_con);
         constraint_expr_destroy(new_expr);
         return -1;
 }
@@ -1660,17 +1662,17 @@ static int copy_neverallow (policydb_t *
         avrule->flags = source_rule->flags;
 
 	if (ebitmap_cpy(&avrule->stypes.types, &stypes))
-		return -1;
+		goto err;
 
 	if (ebitmap_cpy(&avrule->ttypes.types, &ttypes))
-		return -1;
+		goto err;
 
 	cur_perm = source_rule->perms;
 	tail_perm = NULL;
 	while (cur_perm) {
 		new_perm = (class_perm_node_t*)malloc(sizeof(class_perm_node_t));
 		if (!new_perm)
-			return -1;
+			goto err;
 		class_perm_node_init(new_perm);
 		new_perm->class = cur_perm->class;
 		assert(new_perm->class);
@@ -1700,6 +1702,17 @@ static int copy_neverallow (policydb_t *
 	ebitmap_destroy(&ttypes);
 
 	return 0;
+
+err:
+	ebitmap_destroy(&avrule->stypes.types);
+	ebitmap_destroy(&avrule->ttypes.types);
+	cur_perm = avrule->perms;
+	while (cur_perm) {
+		tail_perm = cur_perm->next;
+		free(cur_perm);
+		cur_perm = tail_perm;
+	}
+	free(avrule);
 }
 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
