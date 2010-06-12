Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWbTT016463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:37 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHVmGC003381
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:31:48 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXBF9009794
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXBrr009792
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:11 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DDO4jV025080
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 09:24:08 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DDPc7B023908
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 13:25:39 GMT
Received: by wyb35 with SMTP id 35so2995254wyb.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 06:24:04 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:53:46 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 4/7 v2] selinux: fix error codes in cond_read_node()
Message-ID: <20100612185346.GS5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Originally cond_read_node() returned -1 (-EPERM) on errors which was
incorrect.  Now it either propagates the error codes from lower level
functions next_entry() or cond_read_av_list() or it returns -ENOMEM or
-EINVAL.

next_entry() returns -EINVAL.
cond_read_av_list() returns -EINVAL or -ENOMEM.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
V2: use "if (rc)" instead of "if (rc < 0)"

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 8245f78..9804df3 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -392,24 +392,25 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 	struct cond_expr *expr = NULL, *last = NULL;
 
 	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
-		return -1;
+	if (rc)
+		return rc;
 
 	node->cur_state = le32_to_cpu(buf[0]);
 
 	len = 0;
 	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
-		return -1;
+	if (rc)
+		return rc;
 
 	/* expr */
 	len = le32_to_cpu(buf[0]);
 
 	for (i = 0; i < len; i++) {
 		rc = next_entry(buf, fp, sizeof(u32) * 2);
-		if (rc < 0)
+		if (rc)
 			goto err;
 
+		rc = -ENOMEM;
 		expr = kzalloc(sizeof(struct cond_expr), GFP_KERNEL);
 		if (!expr)
 			goto err;
@@ -418,6 +419,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 		expr->bool = le32_to_cpu(buf[1]);
 
 		if (!expr_isvalid(p, expr)) {
+			rc = -EINVAL;
 			kfree(expr);
 			goto err;
 		}
@@ -429,14 +431,16 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 		last = expr;
 	}
 
-	if (cond_read_av_list(p, fp, &node->true_list, NULL) != 0)
+	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
+	if (rc)
 		goto err;
-	if (cond_read_av_list(p, fp, &node->false_list, node->true_list) != 0)
+	rc = cond_read_av_list(p, fp, &node->false_list, node->true_list);
+	if (rc)
 		goto err;
 	return 0;
 err:
 	cond_node_destroy(node);
-	return -1;
+	return rc;
 }
 
 int cond_read_list(struct policydb *p, void *fp)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
