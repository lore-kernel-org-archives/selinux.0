Date: Tue, 24 Jul 2007 18:32:03 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC] Dynamically deciding number of hash slots for avtab (Was:Re: [patch] customizable AVTAB_HASH_BITS for embedded devices
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        kaigai@ak.jp.nec.com, method@manicmethod.com
In-Reply-To: <1185220711.4177.30.camel@moss-spartans.epoch.ncsc.mil>
References: <20070723124502.17C7.YNAKAM@hitachisoft.jp> <1185220711.4177.30.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20070724181924.41F6.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 23 Jul 2007 15:58:31 -0400
Stephen Smalley  wrote:
> I'm open to making this configurable, although I'm not sure whether it
> should be a Kconfig setting or selinuxfs (or sysctl) setting.  Ideally,
> of course, it would be runtime computed based on the actual policy size.
> Rewriting the avtab and other security server data structures to more
> kernel native would be fine with me too - they don't need to match the
> userland ones.
> 
> (please cc James, Eric, and me on selinux kernel patches)
OK, I made patch about that. 
Please look at patch at the end of this e-mail.

It decides number of hash slots based on number of unconditional TE rules.
I looked at avtab_read, and found number of unconditional TE rules are 
described in binary policy, 
so it can be used.
Number of hash slot is 2^n. n is decided based on number of unconditional TE rules.
If number of unconditional TE rules is 4000, n is 12, so 2^12 = 4096 slots 
are allocated for te_avtab and te_cond_avtab.

I tested the patch against my test policy.
It contains 8486 unconditional TE rules, 3464 conditional TE rules.
So number of hash slots for te_avtab is 16384.
te_cond_avtab is also 16384.
Before tuning, it was 32768 for both, 
so saved 32768 hash slots(about 32768*4 = 131k byte).

I could not find the way to obtain number of "conditinal" TE rules 
before avtab_init(in cond_read_list).
If I could obtain number of conditional TE rules before avtab_init,
number of allocated hash slots for te_cond_avtab would be 4096, can save memory more...
Does anyone know how to obtain number of conditional TE rules?
Should policy format be changed for that?

And I had to change AVTAB_HASH.
Is it OK?

Below is patch.

diff -r -pu security/selinux.orig/ss/avtab.c security/selinux/ss/avtab.c
--- security/selinux.orig/ss/avtab.c	2007-07-20 17:29:30.000000000 +0900
+++ security/selinux/ss/avtab.c	2007-07-24 15:11:43.000000000 +0900
@@ -22,11 +22,11 @@
 #include "avtab.h"
 #include "policydb.h"
 
-#define AVTAB_HASH(keyp) \
+#define AVTAB_HASH(keyp,mask)			\
 ((keyp->target_class + \
  (keyp->target_type << 2) + \
  (keyp->source_type << 9)) & \
- AVTAB_HASH_MASK)
+ mask)
 
 static struct kmem_cache *avtab_node_cachep;
 
@@ -62,7 +62,7 @@ static int avtab_insert(struct avtab *h,
 	if (!h)
 		return -EINVAL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key,h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -102,7 +102,7 @@ avtab_insert_nonunique(struct avtab * h,
 
 	if (!h)
 		return NULL;
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -135,7 +135,7 @@ struct avtab_datum *avtab_search(struct 
 	if (!h)
 		return NULL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key, h->mask);
 	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -170,7 +170,7 @@ avtab_search_node(struct avtab *h, struc
 	if (!h)
 		return NULL;
 
-	hvalue = AVTAB_HASH(key);
+	hvalue = AVTAB_HASH(key, h->mask);
 	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
@@ -228,7 +228,7 @@ void avtab_destroy(struct avtab *h)
 	if (!h || !h->htable)
 		return;
 
-	for (i = 0; i < AVTAB_SIZE; i++) {
+	for (i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		while (cur != NULL) {
 			temp = cur;
@@ -239,19 +239,38 @@ void avtab_destroy(struct avtab *h)
 	}
 	vfree(h->htable);
 	h->htable = NULL;
+	h->nslot = 0;
+	h->mask = 0;
 }
 
-
-int avtab_init(struct avtab *h)
-{
+int avtab_init(struct avtab *h, int nrules) {
 	int i;
+	u16 mask;
+	int shift = 0;
+	int work = nrules;
+	int nslot;
+	
+	if (nrules > MAX_AVTAB_SIZE) {
+		nslot = MAX_AVTAB_SIZE;
+		mask =  MAX_AVTAB_HASH_MASK ;
+	} else {
+		while(work) {
+			work  = work>>1;
+			shift++;
+		}
+		mask =(1 << shift) - 1;	
+		nslot = 1 << shift;
+	}
 
-	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
+	h->htable = vmalloc(sizeof(*(h->htable)) * nslot);
 	if (!h->htable)
 		return -ENOMEM;
-	for (i = 0; i < AVTAB_SIZE; i++)
+	for (i = 0; i < nslot; i++)
 		h->htable[i] = NULL;
 	h->nel = 0;
+	h->nslot = nslot;
+	h->mask = mask;	
+	printk(KERN_DEBUG "SELinux:%d avtab hash slots allocated. Num of rules:%d\n", h->nslot, nrules);
 	return 0;
 }
 
@@ -262,7 +281,7 @@ void avtab_hash_eval(struct avtab *h, ch
 
 	slots_used = 0;
 	max_chain_len = 0;
-	for (i = 0; i < AVTAB_SIZE; i++) {
+	for (i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		if (cur) {
 			slots_used++;
@@ -278,7 +297,7 @@ void avtab_hash_eval(struct avtab *h, ch
 	}
 
 	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
-	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,
+	       "chain length %d\n", tag, h->nel, slots_used, h->nslot,
 	       max_chain_len);
 }
 
@@ -419,6 +438,13 @@ int avtab_read(struct avtab *a, void *fp
 		rc = -EINVAL;
 		goto bad;
 	}
+
+	rc = avtab_init(a, nel);
+	if (rc) {
+		rc = -ENOMEM;
+		goto bad;
+	}
+
 	for (i = 0; i < nel; i++) {
 		rc = avtab_read_item(fp,vers, a, avtab_insertf, NULL);
 		if (rc) {

diff -r -pu security/selinux.orig/ss/avtab.h security/selinux/ss/avtab.h
--- security/selinux.orig/ss/avtab.h	2007-07-20 17:29:30.000000000 +0900
+++ security/selinux/ss/avtab.h	2007-07-24 14:31:28.000000000 +0900
@@ -50,9 +50,12 @@ struct avtab_node {
 struct avtab {
 	struct avtab_node **htable;
 	u32 nel;	/* number of elements */
+	u32 nslot;      /* number of hash slots */
+	u16 mask;       /* mask to compute hash func */
+
 };
 
-int avtab_init(struct avtab *);
+int avtab_init(struct avtab *, int);
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, char *tag);
@@ -74,11 +77,10 @@ struct avtab_node *avtab_search_node_nex
 void avtab_cache_init(void);
 void avtab_cache_destroy(void);
 
-#define AVTAB_HASH_BITS 15
-#define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
-#define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
-
-#define AVTAB_SIZE AVTAB_HASH_BUCKETS
+#define MAX_AVTAB_HASH_BITS 15
+#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
+#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
+#define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
 
 #endif	/* _SS_AVTAB_H_ */
 

diff -r -pu security/selinux.orig/ss/conditional.c security/selinux/ss/conditional.c
--- security/selinux.orig/ss/conditional.c	2007-07-20 17:29:30.000000000 +0900
+++ security/selinux/ss/conditional.c	2007-07-24 18:15:50.000000000 +0900
@@ -122,8 +122,8 @@ int cond_policydb_init(struct policydb *
 {
 	p->bool_val_to_struct = NULL;
 	p->cond_list = NULL;
-	if (avtab_init(&p->te_cond_avtab))
-		return -1;
+	p->te_cond_avtab.htable = NULL;
+	p->te_cond_avtab.nel = 0;
 
 	return 0;
 }
@@ -455,6 +455,16 @@ int cond_read_list(struct policydb *p, v
 		return -1;
 
 	len = le32_to_cpu(buf[0]);
+	
+	rc = avtab_init(&(p->te_cond_avtab), p->te_avtab.nel);
+	/* FIXME
+	  Number of hash slots is the same as te_avtab for now..
+	  Could be smaller.. Ideas?
+	 */
+	if (rc) {
+		rc = -ENOMEM;
+		goto err;
+	}
 
 	for (i = 0; i < len; i++) {
 		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);


diff -r -pu security/selinux.orig/ss/policydb.c security/selinux/ss/policydb.c
--- security/selinux.orig/ss/policydb.c	2007-07-20 17:29:30.000000000 +0900
+++ security/selinux/ss/policydb.c	2007-07-24 17:09:24.000000000 +0900
@@ -169,25 +169,21 @@ static int policydb_init(struct policydb
 		if (rc)
 			goto out_free_symtab;
 	}
-
-	rc = avtab_init(&p->te_avtab);
-	if (rc)
-		goto out_free_symtab;
-
+	
+	p->te_avtab.htable = NULL;
+	p->te_avtab.nel = 0;
+	
 	rc = roles_init(p);
 	if (rc)
-		goto out_free_avtab;
+		goto out_free_symtab;
 
 	rc = cond_policydb_init(p);
 	if (rc)
-		goto out_free_avtab;
+	  goto out_free_symtab;
 
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
