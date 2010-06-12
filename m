Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWbTV016463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:38 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHVmGC003382
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:31:48 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXBIG009798
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:11 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXBlf009797
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:11 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DDQEj9025569
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 09:26:14 -0400
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DDCQ51027268
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 13:12:26 GMT
Received: by wwb39 with SMTP id 39so2961834wwb.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 06:13:13 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:55:01 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 5/7 v2] selinux: fix error codes in cond_policydb_init()
Message-ID: <20100612185501.GT5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It's better to propagate the error code from avtab_init() instead of
returning -1 (-EPERM).  It turns out that avtab_init() never fails so
this patch doesn't change how the code runs but it's still a clean up.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
V2: used "ret" instead of "rc"
    used "if (rc)" instead of "if (rc < 0)"

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 9804df3..a7273bd 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -117,10 +117,14 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 
 int cond_policydb_init(struct policydb *p)
 {
+	int rc;
+
 	p->bool_val_to_struct = NULL;
 	p->cond_list = NULL;
-	if (avtab_init(&p->te_cond_avtab))
-		return -1;
+
+	rc = avtab_init(&p->te_cond_avtab);
+	if (rc)
+		return rc;
 
 	return 0;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
