Date: Wed, 22 Aug 2007 11:55:04 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: James Morris <jmorris@namei.org>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, busybox@kaigai.gr.jp,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com
In-Reply-To: <Xine.LNX.4.64.0708210645130.16813@us.intercode.com.au>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <Xine.LNX.4.64.0708210645130.16813@us.intercode.com.au>
Message-Id: <20070822115145.E7D3.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Aug 2007 07:00:56 -0700 (PDT)
James Morris  wrote:
> On Tue, 21 Aug 2007, Yuichi Nakamura wrote:
> 
> > Hi.
> > 
> > I would like to propose patch that reduce memory usage of avtab again.
> 
> This looks good, although there are some coding style and other issues 
> which need to be fixed.  Also see Documentation/SubmittingPatches and 
> Documentation/CodingStyle in the kernel tree.
Thanks for review !

> > 
> > Next is a patch.
> > Signed-Off-By: Yuichi Nakamura <ynakam@hitachisoft.jp>
> > ----
> 
> Needs to be 3 --- otherwise scripts will break.
Fixed.

> 
> >  avtab.c       |   61 ++++++++++++++++++++++++++++++++++++++++++++--------------
> >  avtab.h       |   13 +++++++-----
> >  conditional.c |    6 +++++
> >  policydb.c    |    9 ++------
> >  4 files changed, 64 insertions(+), 25 deletions(-)
> 
> diffstat -p1
Fixed.

> 
> > 
> > diff -ur security/selinux.notuning/ss/avtab.c security/selinux/ss/avtab.c
> 
> diff -purN
Fixed.

> 
> > +	hvalue = AVTAB_HASH(key,h->mask);
> 
> Add a space after the comma.
Fixed.

> 
> Also, AVTAB_HASH should be converted to a static inline.
> 
> > +	while(work) {
> 
> Space after while.
> 
> > +	if (shift > 2) {
> > +		shift = shift - 2;
> > +	}
> 
> No need for braces for a one-line statement.
Fixed

> 
> > +	nslot = 1 << shift;
> > +	if (nslot > MAX_AVTAB_SIZE) {
> > +		nslot = MAX_AVTAB_SIZE;
> > +	}
> 
> Ditto.
Fixed. 

> 
> > -	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
> > +	h->htable = kmalloc(sizeof(*(h->htable)) * nslot, GFP_KERNEL);
> 
> Use kcalloc(), then consider the effect of the memory zeroing & how much 
> further code can be removed.
Fixed.
And removed loop that clears h->htable.

> > +	printk(KERN_DEBUG "SELinux:%d avtab hash slots allocated. Num of rules:%d\n", h->nslot, nrules);
> 
> This line is too long.
Fixed.

> > +	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
> > +	if (rc) {
> > +		rc = -ENOMEM;
> 
> Why are you resetting rc to the same value?
Removed rc=-ENOMEM.

> 
> > -		goto out_free_symtab;
> > +		goto out_free_symtab;	
> 
> Looks like you added a trailing tab.
Fixed.

> 
> 
> 
> - James
> -- 
> James Morris
> <jmorris@namei.org>

And I've fixed avtab_hash_eval(struct avtab *h, char *tag),
to print out sum of chain length^2 to calculate the standard deviation.
Following is an updated patch.

Signed-off-by: Yuichi Nakamura <ynakam@hitachisoft.jp>
---
 security/selinux/ss/avtab.c       |   71 ++++++++++++++++++++++++++++----------
 security/selinux/ss/avtab.h       |   16 +++++---
 security/selinux/ss/conditional.c |    5 ++
 security/selinux/ss/policydb.c    |    7 +--
 4 files changed, 72 insertions(+), 27 deletions(-)
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/avtab.c linux-2.6.22/security/selinux/ss/avtab.c
--- linux-2.6.22.orig/security/selinux/ss/avtab.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/ss/avtab.c	2007-08-22 11:42:21.000000000 +0900
@@ -12,21 +12,23 @@
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
 
 #include "avtab.h"
 #include "policydb.h"
 
-#define AVTAB_HASH(keyp) \
+#define AVTAB_HASH(keyp, mask) \
 ((keyp->target_class + \
  (keyp->target_type << 2) + \
  (keyp->source_type << 9)) & \
- AVTAB_HASH_MASK)
+ mask)
 
 static struct kmem_cache *avtab_node_cachep;
 
@@ -62,7 +64,7 @@ static int avtab_insert(struct avtab *h,
 	if (!h)
 		return -EINVAL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -102,7 +104,7 @@ avtab_insert_nonunique(struct avtab * h,
 
 	if (!h)
 		return NULL;
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -135,7 +137,7 @@ struct avtab_datum *avtab_search(struct 
 	if (!h)
 		return NULL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key, h->mask);
 	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -170,7 +172,7 @@ avtab_search_node(struct avtab *h, struc
 	if (!h)
 		return NULL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key, h->mask);
 	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -228,7 +230,7 @@ void avtab_destroy(struct avtab *h)
 	if (!h || !h->htable)
 		return;
 
-	for (i = 0; i < AVTAB_SIZE; i++) {
+	for (i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		while (cur != NULL) {
 			temp = cur;
@@ -237,32 +239,58 @@ void avtab_destroy(struct avtab *h)
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
 
-	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
+int avtab_alloc(struct avtab *h, int nrules)
+{
+	u16 mask;
+	u32 shift = 0;
+	u32 work = nrules;
+	u32 nslot;
+
+	while (work) {
+		work  = work>>1;
+		shift++;
+	}
+	if (shift > 2)
+		shift = shift - 2;
+	nslot = 1 << shift;
+	if (nslot > MAX_AVTAB_SIZE)
+		nslot = MAX_AVTAB_SIZE;
+	mask = nslot - 1;
+
+	h->htable = kcalloc(nslot, sizeof(*(h->htable)), GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
-	for (i = 0; i < AVTAB_SIZE; i++)
-		h->htable[i] = NULL;
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
@@ -274,12 +302,14 @@ void avtab_hash_eval(struct avtab *h, ch
 
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
@@ -419,6 +449,13 @@ int avtab_read(struct avtab *a, void *fp
 		rc = -EINVAL;
 		goto bad;
 	}
+
+	rc = avtab_alloc(a, nel);
+	if (rc) {
+		rc = -ENOMEM;
+		goto bad;
+	}
+
 	for (i = 0; i < nel; i++) {
 		rc = avtab_read_item(fp,vers, a, avtab_insertf, NULL);
 		if (rc) {
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/avtab.h linux-2.6.22/security/selinux/ss/avtab.h
--- linux-2.6.22.orig/security/selinux/ss/avtab.h	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/ss/avtab.h	2007-08-22 11:42:27.000000000 +0900
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
+int avtab_alloc(struct avtab *, int);
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
+++ linux-2.6.22/security/selinux/ss/conditional.c	2007-08-22 10:47:32.000000000 +0900
@@ -456,6 +456,11 @@ int cond_read_list(struct policydb *p, v
 
 	len = le32_to_cpu(buf[0]);
 
+	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
+	if (rc) {
+		goto err;
+	}
+
 	for (i = 0; i < len; i++) {
 		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
 		if (!node)
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/policydb.c linux-2.6.22/security/selinux/ss/policydb.c
--- linux-2.6.22.orig/security/selinux/ss/policydb.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/ss/policydb.c	2007-08-22 10:30:04.000000000 +0900
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

-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
