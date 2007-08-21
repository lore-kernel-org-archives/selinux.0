Date: Tue, 21 Aug 2007 23:19:06 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: himainu-ynakam@miomio.jp, ynakam@hitachisoft.jp, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, jmorris@namei.org, eparis@parisplace.org,
        kaigai@ak.jp.nec.com
Subject: Re: [patch] Tuning avtab to reduce memory usage
Message-Id: <20070821231906.2469fb31.himainu-ynakam@miomio.jp>
In-Reply-To: <1187704058.1451.107.camel@moss-spartans.epoch.ncsc.mil>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
	<1187704058.1451.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Aug 2007 09:47:38 -0400
Stephen Smalley  wrote:
> On Tue, 2007-08-21 at 13:29 +0900, Yuichi Nakamura wrote:
<snip>
> 
> The divergence in times between strict/large policy vs. targeted/small
> policy seems curious.
> 
> Is it because targeted/small policy makes more use of type attributes,
> making the nested ebitmap_for_each_bit loops much longer?
I think so.
Targeted policy uses more attributes.
For example, 
Number of attribute for kernel_t, init_t, initrc_t is:
strict policy -> 8, 8, 16
small refpolicy(build as targeted)-> 24,24,32

> We likely should look at optimizing the ebitmap code, or replacing it
> with the native kernel bitmaps (include/linux/bitmap.h, lib/bitmap.c).
> For example, ebitmap_next could possibly use find_next_bit().
I want to look after this patch is done..

> 
> > 
> > Next is a patch.
> > Signed-Off-By: Yuichi Nakamura <ynakam@hitachisoft.jp>
> 
> Looks ok, but a few coding style issues.  Run ./scripts/checkpatch.pl on
> it and fix all issues please.  And make it apply with patch -p1 (and use
> diffstat -p1 to generate the diffstat).
Thanks, about them I will work tomorrow :)


> > > ----
> >  avtab.c       |   61 ++++++++++++++++++++++++++++++++++++++++++++--------------
> >  avtab.h       |   13 +++++++-----
> >  conditional.c |    6 +++++
> >  policydb.c    |    9 ++------
> >  4 files changed, 64 insertions(+), 25 deletions(-)
> 
> > diff -ur security/selinux.notuning/ss/avtab.c security/selinux/ss/avtab.c
> > --- security/selinux.notuning/ss/avtab.c	2007-08-05 14:30:24.000000000 +0900
> > +++ security/selinux/ss/avtab.c	2007-08-21 10:15:09.000000000 +0900
> > @@ -16,17 +16,16 @@
> >  
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> > -#include <linux/vmalloc.h>
> >  #include <linux/errno.h>
> >  
> >  #include "avtab.h"
> >  #include "policydb.h"
> >  
> > -#define AVTAB_HASH(keyp) \
> > +#define AVTAB_HASH(keyp,mask)			\
> >  ((keyp->target_class + \
> >   (keyp->target_type << 2) + \
> >   (keyp->source_type << 9)) & \
> > - AVTAB_HASH_MASK)
> > + mask)
> >  
> >  static struct kmem_cache *avtab_node_cachep;
> >  
> > @@ -62,7 +61,7 @@
> >  	if (!h)
> >  		return -EINVAL;
> >  
> > -	hvalue = AVTAB_HASH(key);
> > +	hvalue = AVTAB_HASH(key,h->mask);
> >  	for (prev = NULL, cur = h->htable[hvalue];
> >  	     cur;
> >  	     prev = cur, cur = cur->next) {
> > @@ -102,7 +101,7 @@
> >  
> >  	if (!h)
> >  		return NULL;
> > -	hvalue = AVTAB_HASH(key);
> > +	hvalue = AVTAB_HASH(key, h->mask);
> >  	for (prev = NULL, cur = h->htable[hvalue];
> >  	     cur;
> >  	     prev = cur, cur = cur->next) {
> > @@ -135,7 +134,7 @@
> >  	if (!h)
> >  		return NULL;
> >  
> > -	hvalue = AVTAB_HASH(key);
> > +	hvalue = AVTAB_HASH(key, h->mask);
> >  	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
> >  		if (key->source_type == cur->key.source_type &&
> >  		    key->target_type == cur->key.target_type &&
> > @@ -170,7 +169,7 @@
> >  	if (!h)
> >  		return NULL;
> >  
> > -	hvalue = AVTAB_HASH(key);
> > +	hvalue = AVTAB_HASH(key, h->mask);
> >  	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
> >  		if (key->source_type == cur->key.source_type &&
> >  		    key->target_type == cur->key.target_type &&
> > @@ -228,7 +227,7 @@
> >  	if (!h || !h->htable)
> >  		return;
> >  
> > -	for (i = 0; i < AVTAB_SIZE; i++) {
> > +	for (i = 0; i < h->nslot; i++) {
> >  		cur = h->htable[i];
> >  		while (cur != NULL) {
> >  			temp = cur;
> > @@ -237,21 +236,48 @@
> >  		}
> >  		h->htable[i] = NULL;
> >  	}
> > -	vfree(h->htable);
> > +	kfree(h->htable);
> >  	h->htable = NULL;
> > +	h->nslot = 0;
> > +	h->mask = 0;
> >  }
> >  
> > -
> >  int avtab_init(struct avtab *h)
> >  {
> > +	h->htable = NULL;
> > +	h->nel = 0;
> > +	return 0;
> > +}
> > +
> > +int avtab_alloc(struct avtab *h, int nrules) {
> >  	int i;
> > +	u16 mask;
> > +	u32 shift = 0;
> > +	u32 work = nrules;
> > +	u32 nslot;
> > +	
> > +	while(work) {
> > +		work  = work>>1;
> > +		shift++;
> > +	}	
> > +	if (shift > 2) {
> > +		shift = shift - 2;
> > +	}
> > +	nslot = 1 << shift;
> > +	if (nslot > MAX_AVTAB_SIZE) {
> > +		nslot = MAX_AVTAB_SIZE;
> > +	}
> > +	mask = nslot - 1;
> >  
> > -	h->htable = vmalloc(sizeof(*(h->htable)) * AVTAB_SIZE);
> > +	h->htable = kmalloc(sizeof(*(h->htable)) * nslot, GFP_KERNEL);
> >  	if (!h->htable)
> >  		return -ENOMEM;
> > -	for (i = 0; i < AVTAB_SIZE; i++)
> > +	for (i = 0; i < nslot; i++)
> >  		h->htable[i] = NULL;
> >  	h->nel = 0;
> > +	h->nslot = nslot;
> > +	h->mask = mask;	
> > +	printk(KERN_DEBUG "SELinux:%d avtab hash slots allocated. Num of rules:%d\n", h->nslot, nrules);
> >  	return 0;
> >  }
> >  
> > @@ -262,7 +288,7 @@
> >  
> >  	slots_used = 0;
> >  	max_chain_len = 0;
> > -	for (i = 0; i < AVTAB_SIZE; i++) {
> > +	for (i = 0; i < h->nslot; i++) {
> >  		cur = h->htable[i];
> >  		if (cur) {
> >  			slots_used++;
> > @@ -278,7 +304,7 @@
> >  	}
> >  
> >  	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
> > -	       "chain length %d\n", tag, h->nel, slots_used, AVTAB_SIZE,
> > +	       "chain length %d\n", tag, h->nel, slots_used, h->nslot,
> >  	       max_chain_len);
> >  }
> >  
> > @@ -419,6 +445,13 @@
> >  		rc = -EINVAL;
> >  		goto bad;
> >  	}
> > +
> > +	rc = avtab_alloc(a, nel);
> > +	if (rc) {
> > +		rc = -ENOMEM;
> > +		goto bad;
> > +	}
> > +
> >  	for (i = 0; i < nel; i++) {
> >  		rc = avtab_read_item(fp,vers, a, avtab_insertf, NULL);
> >  		if (rc) {
> > diff -ur security/selinux.notuning/ss/avtab.h security/selinux/ss/avtab.h
> > --- security/selinux.notuning/ss/avtab.h	2007-08-05 14:30:24.000000000 +0900
> > +++ security/selinux/ss/avtab.h	2007-08-21 09:56:51.000000000 +0900
> > @@ -50,9 +50,13 @@
> >  struct avtab {
> >  	struct avtab_node **htable;
> >  	u32 nel;	/* number of elements */
> > +	u32 nslot;      /* number of hash slots */
> > +	u16 mask;       /* mask to compute hash func */
> > +
> >  };
> >  
> >  int avtab_init(struct avtab *);
> > +int avtab_alloc(struct avtab *, int);
> >  struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
> >  void avtab_destroy(struct avtab *h);
> >  void avtab_hash_eval(struct avtab *h, char *tag);
> > @@ -74,11 +78,10 @@
> >  void avtab_cache_init(void);
> >  void avtab_cache_destroy(void);
> >  
> > -#define AVTAB_HASH_BITS 15
> > -#define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
> > -#define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
> > -
> > -#define AVTAB_SIZE AVTAB_HASH_BUCKETS
> > +#define MAX_AVTAB_HASH_BITS 13
> > +#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
> > +#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
> > +#define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
> >  
> >  #endif	/* _SS_AVTAB_H_ */
> >  
> > diff -ur security/selinux.notuning/ss/conditional.c security/selinux/ss/conditional.c
> > --- security/selinux.notuning/ss/conditional.c	2007-08-05 14:30:24.000000000 +0900
> > +++ security/selinux/ss/conditional.c	2007-08-21 09:56:26.000000000 +0900
> > @@ -455,6 +455,12 @@
> >  		return -1;
> >  
> >  	len = le32_to_cpu(buf[0]);
> > +	
> > +	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
> > +	if (rc) {
> > +		rc = -ENOMEM;
> > +		goto err;
> > +	}
> >  
> >  	for (i = 0; i < len; i++) {
> >  		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
> > diff -ur security/selinux.notuning/ss/policydb.c security/selinux/ss/policydb.c
> > --- security/selinux.notuning/ss/policydb.c	2007-08-05 14:30:24.000000000 +0900
> > +++ security/selinux/ss/policydb.c	2007-08-21 11:50:38.000000000 +0900
> > @@ -172,22 +172,19 @@
> >  
> >  	rc = avtab_init(&p->te_avtab);
> >  	if (rc)
> > -		goto out_free_symtab;
> > +		goto out_free_symtab;	
> >  
> >  	rc = roles_init(p);
> >  	if (rc)
> > -		goto out_free_avtab;
> > +		goto out_free_symtab;
> >  
> >  	rc = cond_policydb_init(p);
> >  	if (rc)
> > -		goto out_free_avtab;
> > +		goto out_free_symtab;
> >  
> >  out:
> >  	return rc;
> >  
> > -out_free_avtab:
> > -	avtab_destroy(&p->te_avtab);
> > -
> >  out_free_symtab:
> >  	for (i = 0; i < SYM_NUM; i++)
> >  		hashtab_destroy(p->symtab[i].table);
> > 
> > 
> > Regards,
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
