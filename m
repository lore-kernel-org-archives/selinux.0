Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MLBoOb023492
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 17:11:50 -0400 (EDT)
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7ML1juD002274
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 21:01:45 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7ML1exr052842
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 17:01:41 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7ML15cX433700
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 15:01:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7ML1YTR026434
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 15:01:34 -0600
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7ML1YxD026367
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 15:01:34 -0600
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MGGIoe004900
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 11:16:18 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MGGIm8004899
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 11:16:18 -0500
Date: Mon, 22 Aug 2005 11:16:18 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 5/6] libsepol: cond_read_node resource leak
Message-ID: <20050822161618.GE4191@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a resource leak found by Coverity:

	1. cond_read_node: node was not freed on failure.  I assume
	it was expected the caller would, but the caller didn't.  And
	since there is only one caller, it seemed easier to have do it
	here.

	2. expr is not freed on error before it is appended
	to node.

thanks,
-serge

Index: src/conditional.c
===================================================================
--- src.orig/conditional.c
+++ src/conditional.c
@@ -706,14 +706,14 @@ static int cond_read_node(policydb_t *p,
 
 	buf = next_entry(fp, sizeof(uint32_t));
 	if (!buf)
-		return -1;
+		goto err;
 
 	node->cur_state = le32_to_cpu(buf[0]);
 	
 	len = 0;
 	buf = next_entry(fp, sizeof(uint32_t));
 	if (!buf)
-		return -1;
+		goto err;
 
 	/* expr */
 	len = le32_to_cpu(buf[0]);
@@ -732,8 +732,10 @@ static int cond_read_node(policydb_t *p,
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
 		
-		if (!expr_isvalid(p, expr))
+		if (!expr_isvalid(p, expr)) {
+			free(expr);
 			goto err;
+		}
 
 		if (i == 0) {
 			node->expr = expr;
@@ -758,6 +760,7 @@ static int cond_read_node(policydb_t *p,
 	return 0;
 err:
 	cond_node_destroy(node);
+	free(node);
 	return -1;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
