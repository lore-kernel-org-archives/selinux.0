Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWcTP016501
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:39 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHVnGC003390
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:31:49 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXC1j009818
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:12 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXBd0009817
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:11 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DEBA3r029260
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 10:11:10 -0400
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DEAL51009351
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 14:10:21 GMT
Received: by wwb39 with SMTP id 39so3002627wwb.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 07:11:08 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:56:01 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 6/7 v2] selinux: fix error codes in cond_read_bool()
Message-ID: <20100612185601.GU5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The original code always returned -1 (-EPERM) on error.  The new code
returns either -ENOMEM, or -EINVAL or it propagates the error codes from
lower level functions next_entry() or hashtab_insert().

next_entry() returns -EINVAL.
hashtab_insert() returns -EINVAL, -EEXIST, or -ENOMEM.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
V2: updated the function "if (rc)" instead of "if (rc < 0)" throughout

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index a7273bd..ca42c51 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -223,34 +223,37 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 
 	booldatum = kzalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
 	if (!booldatum)
-		return -1;
+		return -ENOMEM;
 
 	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
+	if (rc)
 		goto err;
 
 	booldatum->value = le32_to_cpu(buf[0]);
 	booldatum->state = le32_to_cpu(buf[1]);
 
+	rc = -EINVAL;
 	if (!bool_isvalid(booldatum))
 		goto err;
 
 	len = le32_to_cpu(buf[2]);
 
+	rc = -ENOMEM;
 	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key)
 		goto err;
 	rc = next_entry(key, fp, len);
-	if (rc < 0)
+	if (rc)
 		goto err;
 	key[len] = '\0';
-	if (hashtab_insert(h, key, booldatum))
+	rc = hashtab_insert(h, key, booldatum);
+	if (rc)
 		goto err;
 
 	return 0;
 err:
 	cond_destroy_bool(key, booldatum, NULL);
-	return -1;
+	return rc;
 }
 
 struct cond_insertf_data {


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
