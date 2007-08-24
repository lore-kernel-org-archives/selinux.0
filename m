Date: Fri, 24 Aug 2007 11:55:11 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Cc: ynakam@hitachisoft.jp, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com
In-Reply-To: <1187874925.1451.473.camel@moss-spartans.epoch.ncsc.mil>
References: <20070823094904.1AB9.YNAKAM@hitachisoft.jp> <1187874925.1451.473.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20070824115232.5B89.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Aug 2007 09:15:25 -0400
Stephen Smalley  wrote:
> On Thu, 2007-08-23 at 09:57 +0900, Yuichi Nakamura wrote:
> > Following is updated patch to 2.6.22.
> > 
> > Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
> > ---
> >  security/selinux/ss/avtab.c       |   78 +++++++++++++++++++++++++++-----------
> >  security/selinux/ss/avtab.h       |   16 +++++--
> >  security/selinux/ss/conditional.c |    4 +
> >  security/selinux/ss/policydb.c    |    7 ---
> >  4 files changed, 73 insertions(+), 32 deletions(-)
> > diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/avtab.c linux-2.6.22/security/selinux/ss/avtab.c
> > --- linux-2.6.22.orig/security/selinux/ss/avtab.c	2007-07-09 08:32:17.000000000 +0900
> > +++ linux-2.6.22/security/selinux/ss/avtab.c	2007-08-23 09:30:03.000000000 +0900
> > +int avtab_alloc(struct avtab *h, int nrules)
> 
> nrules should be u32 too.
Fixed.

> 
> And you should likely test for the degenerate case (nrules == 0) and
> bail on it.
Checking nrules==0.
And also checking !h->htable like below in avtab_search_node etc.
-	if (!h)
+	if (!h || !h->htable)

Following is updated patch.
From: Yuichi Nakamura <ynakam@hitachisoft.jp>

This patch reduces memory usage of SELinux by tuning avtab. Number of
hash slots in avtab was 32768. Unused slots used memory when number 
of rules is fewer. This patch decides number of hash slots dynamically
based on number of rules. (chain length)^2 is also printed out in
avtab_hash_eval to see standard deviation of avtab hash table.

Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
---
 security/selinux/ss/avtab.c       |   91 +++++++++++++++++++++++++++-----------
 security/selinux/ss/avtab.h       |   16 ++++--
 security/selinux/ss/conditional.c |    4 +
 security/selinux/ss/policydb.c    |    7 --
 4 files changed, 82 insertions(+), 36 deletions(-)
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/avtab.c linux-2.6.22/security/selinux/ss/avtab.c
--- linux-2.6.22.orig/security/selinux/ss/avtab.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/ss/avtab.c	2007-08-24 11:53:12.000000000 +0900
@@ -12,24 +12,25 @@
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
+ *
+ * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
+ * 	Tuned number of hash slots for avtab to reduce memory usage
  */
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/errno.h>
-
 #include "avtab.h"
 #include "policydb.h"
 
-#define AVTAB_HASH(keyp) \
-((keyp->target_class + \
- (keyp->target_type << 2) + \
- (keyp->source_type << 9)) & \
- AVTAB_HASH_MASK)
-
 static struct kmem_cache *avtab_node_cachep;
 
+static inline int avtab_hash(struct avtab_key *keyp, u16 mask)
+{
+	return ((keyp->target_class + (keyp->target_type << 2) +
+		 (keyp->source_type << 9)) & mask);
+}
+
 static struct avtab_node*
 avtab_insert_node(struct avtab *h, int hvalue,
 		  struct avtab_node * prev, struct avtab_node * cur,
@@ -59,10 +60,10 @@ static int avtab_insert(struct avtab *h,
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return -EINVAL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = avtab_hash(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -100,9 +101,9 @@ avtab_insert_nonunique(struct avtab * h,
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return NULL;
-	hvalue = AVTAB_HASH(key);
+	hvalue = avtab_hash(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -132,10 +133,10 @@ struct avtab_datum *avtab_search(struct 
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return NULL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = avtab_hash(key, h->mask);
 	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -167,10 +168,10 @@ avtab_search_node(struct avtab *h, struc
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->htable)
 		return NULL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = avtab_hash(key, h->mask);
 	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -228,7 +229,7 @@ void avtab_destroy(struct avtab *h)
 	if (!h || !h->htable)
 		return;
 
-	for (i = 0; i < AVTAB_SIZE; i++) {
+	for (i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		while (cur != NULL) {
 			temp = cur;
@@ -237,32 +238,63 @@ void avtab_destroy(struct avtab *h)
 		}
 		h->htable[i] = NULL;
 	}
-	vfree(h->htable);
+	kfree(h->htable);
 	h->htable = NULL;
+	h->nslot = 0;
+	h->mask = 0;
 }
 
-
 int avtab_init(struct avtab *h)
 {
-	int i;
+	h->htable = NULL;
+	h->nel = 0;
+	return 0;
+}
+
+int avtab_alloc(struct avtab *h, u32 nrules)
+{
+	u16 mask = 0;
+	u32 shift = 0;
+	u32 work = nrules;
+	u32 nslot = 0;
+
+	if (nrules == 0)
+		goto avtab_alloc_out;
+
+	while (work) {
+		work  = work >> 1;
+		shift++;
+	}
+	if (shift > 2)
+		shift = shift - 2;
+	nslot = 1 << shift;
+	if (nslot > MAX_AVTAB_SIZE)
+		nslot = MAX_AVTAB_SIZE;
+	mask = nslot - 1;
 
-	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
+	h->htable = kcalloc(nslot, sizeof(*(h->htable)), GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
-	for (i = 0; i < AVTAB_SIZE; i++)
-		h->htable[i] = NULL;
+
+ avtab_alloc_out:
 	h->nel = 0;
+	h->nslot = nslot;
+	h->mask = mask;
+	printk(KERN_DEBUG "SELinux:%d avtab hash slots allocated."
+	       "Num of rules:%d\n", h->nslot, nrules);
 	return 0;
 }
 
 void avtab_hash_eval(struct avtab *h, char *tag)
 {
 	int i, chain_len, slots_used, max_chain_len;
+	unsigned long long chain2_len_sum;
 	struct avtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
-	for (i = 0; i < AVTAB_SIZE; i++) {
+	chain2_len_sum = 0;
+	for (i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		if (cur) {
 			slots_used++;
@@ -274,12 +306,14 @@ void avtab_hash_eval(struct avtab *h, ch
 
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
+			chain2_len_sum += chain_len * chain_len;
 		}
 	}
 
 	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
-	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,
-	       max_chain_len);
+	       "chain length %d sum of chain length^2 %Lu\n",
+	       tag, h->nel, slots_used, h->nslot, max_chain_len,
+	       chain2_len_sum);
 }
 
 static uint16_t spec_order[] = {
@@ -419,6 +453,11 @@ int avtab_read(struct avtab *a, void *fp
 		rc = -EINVAL;
 		goto bad;
 	}
+
+	rc = avtab_alloc(a, nel);
+	if (rc)
+		goto bad;
+
 	for (i = 0; i < nel; i++) {
 		rc = avtab_read_item(fp,vers, a, avtab_insertf, NULL);
 		if (rc) {
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/avtab.h linux-2.6.22/security/selinux/ss/avtab.h
--- linux-2.6.22.orig/security/selinux/ss/avtab.h	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/ss/avtab.h	2007-08-24 11:52:24.000000000 +0900
@@ -16,6 +16,9 @@
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
+ *
+ * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
+ * 	Tuned number of hash slots for avtab to reduce memory usage
  */
 #ifndef _SS_AVTAB_H_
 #define _SS_AVTAB_H_
@@ -50,9 +53,13 @@ struct avtab_node {
 struct avtab {
 	struct avtab_node **htable;
 	u32 nel;	/* number of elements */
+	u32 nslot;      /* number of hash slots */
+	u16 mask;       /* mask to compute hash func */
+
 };
 
 int avtab_init(struct avtab *);
+int avtab_alloc(struct avtab *, u32);
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, char *tag);
@@ -74,11 +81,10 @@ struct avtab_node *avtab_search_node_nex
 void avtab_cache_init(void);
 void avtab_cache_destroy(void);
 
-#define AVTAB_HASH_BITS 15
-#define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
-#define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
-
-#define AVTAB_SIZE AVTAB_HASH_BUCKETS
+#define MAX_AVTAB_HASH_BITS 13
+#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
+#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
+#define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
 
 #endif	/* _SS_AVTAB_H_ */
 
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/conditional.c linux-2.6.22/security/selinux/ss/conditional.c
--- linux-2.6.22.orig/security/selinux/ss/conditional.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/ss/conditional.c	2007-08-24 11:52:24.000000000 +0900
@@ -456,6 +456,10 @@ int cond_read_list(struct policydb *p, v
 
 	len = le32_to_cpu(buf[0]);
 
+	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
+	if (rc)
+		goto err;
+
 	for (i = 0; i < len; i++) {
 		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
 		if (!node)
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/policydb.c linux-2.6.22/security/selinux/ss/policydb.c
--- linux-2.6.22.orig/security/selinux/ss/policydb.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/ss/policydb.c	2007-08-24 11:52:24.000000000 +0900
@@ -176,18 +176,15 @@ static int policydb_init(struct policydb
 
 	rc = roles_init(p);
 	if (rc)
-		goto out_free_avtab;
+		goto out_free_symtab;
 
 	rc = cond_policydb_init(p);
 	if (rc)
-		goto out_free_avtab;
+		goto out_free_symtab;
 
 out:
 	return rc;
 
-out_free_avtab:
-	avtab_destroy(&p->te_avtab);
-
 out_free_symtab:
 	for (i = 0; i < SYM_NUM; i++)
 		hashtab_destroy(p->symtab[i].table);

Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
