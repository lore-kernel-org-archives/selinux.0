Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWbTX016463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:38 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHYEZt012621
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:34:14 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXBVN009810
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXBh2009809
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:11 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DDSdLS027177
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 09:28:39 -0400
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DDTp7D024993
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 13:30:11 GMT
Received: by mail-ww0-f53.google.com with SMTP id 39so2972271wwb.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 06:28:38 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:51:40 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 2/7 v2] selinux: propagate error codes in cond_read_list()
Message-ID: <20100612185140.GQ5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These are passed back when the security module gets loaded.

The original code always returned -1 (-EPERM) on error but after this
patch it can return -EINVAL, or -ENOMEM or propagate the error code from
cond_read_node().  cond_read_node() still returns -1 all the time, but I
fix that in a later patch.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
V2: use "if (rc)" instead of "if (rc < 0)"

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 4a4e35c..775418a 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -445,8 +445,8 @@ int cond_read_list(struct policydb *p, void *fp)
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
-		return -1;
+	if (rc)
+		return rc;
 
 	len = le32_to_cpu(buf[0]);
 
@@ -455,11 +455,13 @@ int cond_read_list(struct policydb *p, void *fp)
 		goto err;
 
 	for (i = 0; i < len; i++) {
+		rc = -ENOMEM;
 		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
 		if (!node)
 			goto err;
 
-		if (cond_read_node(p, node, fp) != 0)
+		rc = cond_read_node(p, node, fp);
+		if (rc)
 			goto err;
 
 		if (i == 0)
@@ -472,7 +474,7 @@ int cond_read_list(struct policydb *p, void *fp)
 err:
 	cond_list_destroy(p->cond_list);
 	p->cond_list = NULL;
-	return -1;
+	return rc;
 }
 
 /* Determine whether additional permissions are granted by the conditional


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
