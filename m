Subject: Re: [RFC][PATCH 1/3] Reduce avtab node size
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
	 <200507262053.j6QKrPuY003850@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 11:32:15 -0400
Message-Id: <1122478335.19989.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-26 at 16:53 -0400, Valdis.Kletnieks@vt.edu wrote:
> I gave this a whirl, with bad results...  It applied cleanly to my 2.6.13-rc3-mm1,
> and built OK, but died at system boot.  Partial hand-copied output follows -
> (I didn't have a serial console, and I'm having some CTS issues..)
> 
> security: conflicting type rules when adding type rule for true.

This patch, relative to the prior one, fixes both bugs - the diff for
conditional.c solves the double free problem on the error handling path
and the diff for avtab.c solves the false conflict detection.  

diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab/security/selinux/ss/avtab.c linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/avtab.c
--- linux-2.6.13-rc3-mm1-avtab/security/selinux/ss/avtab.c	2005-07-27 11:19:47.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/avtab.c	2005-07-27 11:02:40.000000000 -0400
@@ -58,6 +58,7 @@ static int avtab_insert(struct avtab *h,
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return -EINVAL;
@@ -69,7 +70,7 @@ static int avtab_insert(struct avtab *h,
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (key->specified & cur->key.specified))
+		    (specified & cur->key.specified))
 			return -EEXIST;
 		if (key->source_type < cur->key.source_type)
 			break;
@@ -98,6 +99,7 @@ avtab_insert_nonunique(struct avtab * h,
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return NULL;
@@ -108,7 +110,7 @@ avtab_insert_nonunique(struct avtab * h,
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (key->specified & cur->key.specified))
+		    (specified & cur->key.specified))
 			break;
 		if (key->source_type < cur->key.source_type)
 			break;
@@ -129,6 +131,7 @@ struct avtab_datum *avtab_search(struct 
 {
 	int hvalue;
 	struct avtab_node *cur;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return NULL;
@@ -138,7 +141,7 @@ struct avtab_datum *avtab_search(struct 
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (key->specified & cur->key.specified))
+		    (specified & cur->key.specified))
 			return &cur->datum;
 
 		if (key->source_type < cur->key.source_type)
@@ -163,6 +166,7 @@ avtab_search_node(struct avtab *h, struc
 {
 	int hvalue;
 	struct avtab_node *cur;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return NULL;
@@ -172,7 +176,7 @@ avtab_search_node(struct avtab *h, struc
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (key->specified & cur->key.specified))
+		    (specified & cur->key.specified))
 			return cur;
 
 		if (key->source_type < cur->key.source_type)
@@ -196,6 +200,7 @@ avtab_search_node_next(struct avtab_node
 	if (!node)
 		return NULL;
 
+	specified &= ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 	for (cur = node->next; cur; cur = cur->next) {
 		if (node->key.source_type == cur->key.source_type &&
 		    node->key.target_type == cur->key.target_type &&
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab/security/selinux/ss/conditional.c linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/conditional.c
--- linux-2.6.13-rc3-mm1-avtab/security/selinux/ss/conditional.c	2005-07-27 11:19:47.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/conditional.c	2005-07-27 10:23:12.000000000 -0400
@@ -474,6 +474,7 @@ int cond_read_list(struct policydb *p, v
 	return 0;
 err:
 	cond_list_destroy(p->cond_list);
+	p->cond_list = NULL;
 	return -1;
 }
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
