Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5IHWbTY016463
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:32:38 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5IHYFZt012622
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 17:34:15 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4) with ESMTP id o5IHXCW2009822
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2010 13:33:12 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.4/8.14.4/Submit) id o5IHXCoZ009821
	for selinux@tycho.nsa.gov; Fri, 18 Jun 2010 13:33:12 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DEDJ0h029344
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 10:13:19 -0400
Received: from mail-bw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DEEo7B004539
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 14:14:50 GMT
Received: by bwz12 with SMTP id 12so1650363bwz.12
        for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 07:13:16 -0700 (PDT)
Date: Sat, 12 Jun 2010 20:52:19 +0200
From: Dan Carpenter <error27@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: [patch 3/7 v2] selinux: fix error codes in cond_read_av_list()
Message-ID: <20100612185219.GR5483@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After this patch cond_read_av_list() no longer returns -1 for any
errors.  It just propagates error code back from lower levels.  Those can
either be -EINVAL or -ENOMEM.

I also modified cond_insertf() since cond_read_av_list() passes that as a 
function pointer to avtab_read_item().  It isn't used anywhere else.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
V2: used "rc" instead of "ret".
    return -ENOMEM if avtab_insert_nonunique() returns NULL.
    use "if (rc)" instead of "if (rc < 0)"

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index acaa6cd..8245f78 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -263,7 +263,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	struct cond_av_list *other = data->other, *list, *cur;
 	struct avtab_node *node_ptr;
 	u8 found;
-
+	int rc = -EINVAL;
 
 	/*
 	 * For type rules we have to make certain there aren't any
@@ -313,12 +313,15 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
 		printk(KERN_ERR "SELinux: could not insert rule.\n");
+		rc = -ENOMEM;
 		goto err;
 	}
 
 	list = kzalloc(sizeof(struct cond_av_list), GFP_KERNEL);
-	if (!list)
+	if (!list) {
+		rc = -ENOMEM;
 		goto err;
+	}
 
 	list->node = node_ptr;
 	if (!data->head)
@@ -331,7 +334,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 err:
 	cond_av_list_destroy(data->head);
 	data->head = NULL;
-	return -1;
+	return rc;
 }
 
 static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
@@ -345,8 +348,8 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 
 	len = 0;
 	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
-		return -1;
+	if (rc)
+		return rc;
 
 	len = le32_to_cpu(buf[0]);
 	if (len == 0)
@@ -361,7 +364,6 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 				     &data);
 		if (rc)
 			return rc;
-
 	}
 
 	*ret_list = data.head;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
