Date: Fri, 01 Feb 2008 13:59:27 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Cc: ynakam@hitachisoft.jp, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com,
        Joshua Brindle <method@manicmethod.com>,
        "Todd C. Miller" <tmiller@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <1201813250.4568.118.camel@moss-spartans.epoch.ncsc.mil>
References: <20070824115232.5B89.YNAKAM@hitachisoft.jp> <1201813250.4568.118.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20080201135848.7009.F42EC909@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

On Thu, 31 Jan 2008 16:00:50 -0500
Stephen Smalley  wrote:
> 
> On Fri, 2007-08-24 at 11:55 +0900, Yuichi Nakamura wrote:
> > On Thu, 23 Aug 2007 09:15:25 -0400
> > Stephen Smalley  wrote:
> > > On Thu, 2007-08-23 at 09:57 +0900, Yuichi Nakamura wrote:
> > > > Following is updated patch to 2.6.22.
> > > > 
> > > > Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
> > > > ---
> > > >  security/selinux/ss/avtab.c       |   78 +++++++++++++++++++++++++++-----------
> > > >  security/selinux/ss/avtab.h       |   16 +++++--
> > > >  security/selinux/ss/conditional.c |    4 +
> > > >  security/selinux/ss/policydb.c    |    7 ---
> > > >  4 files changed, 73 insertions(+), 32 deletions(-)
> > > > diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/ss/avtab.c linux-2.6.22/security/selinux/ss/avtab.c
> > > > --- linux-2.6.22.orig/security/selinux/ss/avtab.c	2007-07-09 08:32:17.000000000 +0900
> > > > +++ linux-2.6.22/security/selinux/ss/avtab.c	2007-08-23 09:30:03.000000000 +0900
> > > > +int avtab_alloc(struct avtab *h, int nrules)
> > > 
> > > nrules should be u32 too.
> > Fixed.
> > 
> > > 
> > > And you should likely test for the degenerate case (nrules == 0) and
> > > bail on it.
> > Checking nrules==0.
> > And also checking !h->htable like below in avtab_search_node etc.
> > -	if (!h)
> > +	if (!h || !h->htable)
> > 
> > Following is updated patch.
> > From: Yuichi Nakamura <ynakam@hitachisoft.jp>
> > 
> > This patch reduces memory usage of SELinux by tuning avtab. Number of
> > hash slots in avtab was 32768. Unused slots used memory when number 
> > of rules is fewer. This patch decides number of hash slots dynamically
> > based on number of rules. (chain length)^2 is also printed out in
> > avtab_hash_eval to see standard deviation of avtab hash table.
> > 
> > Signed-off-by: Yuichi Nakamura<ynakam@hitachisoft.jp>
> > ---
> >  security/selinux/ss/avtab.c       |   91 +++++++++++++++++++++++++++-----------
> >  security/selinux/ss/avtab.h       |   16 ++++--
> >  security/selinux/ss/conditional.c |    4 +
> >  security/selinux/ss/policydb.c    |    7 --
> >  4 files changed, 82 insertions(+), 36 deletions(-)
> 
> Hi,
> 
> I'd like to apply the equivalent changes to libsepol, if you have no
> objection (note that libsepol is LGPL rather than GPL).  A port of your
> patch to libsepol is below.  This is to reduce memory usage by
> libsepol/libsemanage when reading in modules and policies. Is that ok
> with you?

It is OK for me.
Please use the code.



> 
>  checkpolicy/test/dispol.c               |    2 
>  libsepol/include/sepol/policydb/avtab.h |   18 ++++---
>  libsepol/src/avtab.c                    |   80 ++++++++++++++++++++++++--------
>  libsepol/src/conditional.c              |    4 +
>  libsepol/src/policydb.c                 |    7 --
>  libsepol/src/write.c                    |   11 ++--
>  6 files changed, 85 insertions(+), 37 deletions(-)
> 
> Index: libsepol/include/sepol/policydb/avtab.h
> ===================================================================
> --- libsepol/include/sepol/policydb/avtab.h	(revision 2773)
> +++ libsepol/include/sepol/policydb/avtab.h	(working copy)
> @@ -1,6 +1,11 @@
>  
>  /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
>  
> +/*
> + * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
> + * 	Tuned number of hash slots for avtab to reduce memory usage
> + */
> +
>  /* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
>   *
>   * 	Added conditional policy language extensions
> @@ -75,10 +80,12 @@
>  typedef struct avtab {
>  	avtab_ptr_t *htable;
>  	uint32_t nel;		/* number of elements */
> +	uint32_t nslot;         /* number of hash slots */
> +	uint16_t mask;          /* mask to compute hash func */
>  } avtab_t;
>  
>  extern int avtab_init(avtab_t *);
> -
> +extern int avtab_alloc(avtab_t *, uint32_t);
>  extern int avtab_insert(avtab_t * h, avtab_key_t * k, avtab_datum_t * d);
>  
>  extern avtab_datum_t *avtab_search(avtab_t * h, avtab_key_t * k);
> @@ -110,12 +117,11 @@
>  
>  extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
>  
> -#define AVTAB_HASH_BITS 15
> -#define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
> -#define AVTAB_HASH_MASK (AVTAB_HASH_BUCKETS-1)
> +#define MAX_AVTAB_HASH_BITS 13
> +#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
> +#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
> +#define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS
>  
> -#define AVTAB_SIZE AVTAB_HASH_BUCKETS
> -
>  #endif				/* _AVTAB_H_ */
>  
>  /* FLASK */
> Index: libsepol/src/conditional.c
> ===================================================================
> --- libsepol/src/conditional.c	(revision 2773)
> +++ libsepol/src/conditional.c	(working copy)
> @@ -829,6 +829,10 @@
>  
>  	len = le32_to_cpu(buf[0]);
>  
> +	rc = avtab_alloc(&p->te_cond_avtab, p->te_avtab.nel);
> +	if (rc)
> +		goto err;
> +
>  	for (i = 0; i < len; i++) {
>  		node = malloc(sizeof(cond_node_t));
>  		if (!node)
> Index: libsepol/src/policydb.c
> ===================================================================
> --- libsepol/src/policydb.c	(revision 2773)
> +++ libsepol/src/policydb.c	(working copy)
> @@ -492,17 +492,14 @@
>  
>  	rc = roles_init(p);
>  	if (rc)
> -		goto out_free_avtab;
> +		goto out_free_symtab;
>  
>  	rc = cond_policydb_init(p);
>  	if (rc)
> -		goto out_free_avtab;
> +		goto out_free_symtab;
>        out:
>  	return rc;
>  
> -      out_free_avtab:
> -	avtab_destroy(&p->te_avtab);
> -
>        out_free_symtab:
>  	for (i = 0; i < SYM_NUM; i++) {
>  		hashtab_destroy(p->symtab[i].table);
> Index: libsepol/src/write.c
> ===================================================================
> --- libsepol/src/write.c	(revision 2773)
> +++ libsepol/src/write.c	(working copy)
> @@ -229,9 +229,9 @@
>  
>  static inline void avtab_reset_merged(avtab_t * a)
>  {
> -	int i;
> +	unsigned int i;
>  	avtab_ptr_t cur;
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < a->nslot; i++) {
>  		for (cur = a->htable[i]; cur; cur = cur->next)
>  			cur->merged = 0;
>  	}
> @@ -239,7 +239,8 @@
>  
>  static int avtab_write(struct policydb *p, avtab_t * a, struct policy_file *fp)
>  {
> -	int i, rc;
> +	unsigned int i;
> +	int rc;
>  	avtab_t expa;
>  	avtab_ptr_t cur;
>  	uint32_t nel;
> @@ -269,7 +270,7 @@
>  			return POLICYDB_ERROR;
>  	}
>  
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < a->nslot; i++) {
>  		for (cur = a->htable[i]; cur; cur = cur->next) {
>  			/* If old format, compute final nel.
>  			   If new format, write out the items. */
> @@ -290,7 +291,7 @@
>  			goto out;
>  		}
>  		avtab_reset_merged(a);
> -		for (i = 0; i < AVTAB_SIZE; i++) {
> +		for (i = 0; i < a->nslot; i++) {
>  			for (cur = a->htable[i]; cur; cur = cur->next) {
>  				if (avtab_write_item(p, cur, fp, 1, 1, NULL)) {
>  					rc = -1;
> Index: libsepol/src/avtab.c
> ===================================================================
> --- libsepol/src/avtab.c	(revision 2773)
> +++ libsepol/src/avtab.c	(working copy)
> @@ -1,6 +1,11 @@
>  
>  /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
>  
> +/*
> + * Updated: Yuichi Nakamura <ynakam@hitachisoft.jp>
> + * 	Tuned number of hash slots for avtab to reduce memory usage
> + */
> +
>  /* Updated: Frank Mayer <mayerf@tresys.com>
>   *          and Karl MacMillan <kmacmillan@mentalrootkit.com>
>   *
> @@ -44,11 +49,11 @@
>  #include "debug.h"
>  #include "private.h"
>  
> -#define AVTAB_HASH(keyp) \
> -((keyp->target_class + \
> - (keyp->target_type << 2) + \
> - (keyp->source_type << 9)) & \
> - AVTAB_HASH_MASK)
> +static inline int avtab_hash(struct avtab_key *keyp, uint16_t mask)
> +{
> +	return ((keyp->target_class + (keyp->target_type << 2) +
> +		 (keyp->source_type << 9)) & mask);
> +}
>  
>  static avtab_ptr_t
>  avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t prev, avtab_key_t * key,
> @@ -83,7 +88,7 @@
>  	if (!h)
>  		return SEPOL_ENOMEM;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = avtab_hash(key, h->mask);
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur; prev = cur, cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
> @@ -123,7 +128,7 @@
>  
>  	if (!h)
>  		return NULL;
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = avtab_hash(key, h->mask);
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur; prev = cur, cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
> @@ -156,7 +161,7 @@
>  	if (!h)
>  		return NULL;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = avtab_hash(key, h->mask);
>  	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
> @@ -191,7 +196,7 @@
>  	if (!h)
>  		return NULL;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = avtab_hash(key, h->mask);
>  	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
> @@ -242,13 +247,13 @@
>  
>  void avtab_destroy(avtab_t * h)
>  {
> -	int i;
> +	unsigned int i;
>  	avtab_ptr_t cur, temp;
>  
>  	if (!h || !h->htable)
>  		return;
>  
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
>  		while (cur != NULL) {
>  			temp = cur;
> @@ -259,19 +264,22 @@
>  	}
>  	free(h->htable);
>  	h->htable = NULL;
> +	h->nslot = 0;
> +	h->mask = 0;
>  }
>  
>  int avtab_map(avtab_t * h,
>  	      int (*apply) (avtab_key_t * k,
>  			    avtab_datum_t * d, void *args), void *args)
>  {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>  	avtab_ptr_t cur;
>  
>  	if (!h)
>  		return 0;
>  
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
>  		while (cur != NULL) {
>  			ret = apply(&cur->key, &cur->datum, args);
> @@ -285,25 +293,50 @@
>  
>  int avtab_init(avtab_t * h)
>  {
> -	int i;
> +	h->htable = NULL;
> +	h->nel = 0;
> +	return 0;
> +}
>  
> -	h->htable = malloc(sizeof(avtab_ptr_t) * AVTAB_SIZE);
> +int avtab_alloc(avtab_t *h, uint32_t nrules)
> +{
> +	uint16_t mask = 0;
> +	uint32_t shift = 0;
> +	uint32_t work = nrules;
> +	uint32_t nslot = 0;
> +
> +	if (nrules == 0)
> +		goto out;
> +
> +	while (work) {
> +		work  = work >> 1;
> +		shift++;
> +	}
> +	if (shift > 2)
> +		shift = shift - 2;
> +	nslot = 1 << shift;
> +	if (nslot > MAX_AVTAB_SIZE)
> +		nslot = MAX_AVTAB_SIZE;
> +	mask = nslot - 1;
> +
> +	h->htable = calloc(nslot, sizeof(avtab_ptr_t));
>  	if (!h->htable)
>  		return -1;
> -	for (i = 0; i < AVTAB_SIZE; i++)
> -		h->htable[i] = (avtab_ptr_t) NULL;
> +out:
>  	h->nel = 0;
> +	h->nslot = nslot;
> +	h->mask = mask;
>  	return 0;
>  }
>  
>  void avtab_hash_eval(avtab_t * h, char *tag)
>  {
> -	int i, chain_len, slots_used, max_chain_len;
> +	unsigned int i, chain_len, slots_used, max_chain_len;
>  	avtab_ptr_t cur;
>  
>  	slots_used = 0;
>  	max_chain_len = 0;
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
>  		if (cur) {
>  			slots_used++;
> @@ -320,7 +353,7 @@
>  
>  	printf
>  	    ("%s:  %d entries and %d/%d buckets used, longest chain length %d\n",
> -	     tag, h->nel, slots_used, AVTAB_SIZE, max_chain_len);
> +	     tag, h->nel, slots_used, h->nslot, max_chain_len);
>  }
>  
>  /* Ordering of datums in the original avtab format in the policy file. */
> @@ -471,6 +504,13 @@
>  		ERR(fp->handle, "table is empty");
>  		goto bad;
>  	}
> +
> +	rc = avtab_alloc(a, nel);
> +	if (rc) {
> +		ERR(fp->handle, "out of memory");
> +		goto bad;
> +	}
> +
>  	for (i = 0; i < nel; i++) {
>  		rc = avtab_read_item(fp, vers, a, avtab_insertf, NULL);
>  		if (rc) {
> Index: checkpolicy/test/dispol.c
> ===================================================================
> --- checkpolicy/test/dispol.c	(revision 2773)
> +++ checkpolicy/test/dispol.c	(working copy)
> @@ -169,7 +169,7 @@
>  	}
>  
>  	/* hmm...should have used avtab_map. */
> -	for (i = 0; i < AVTAB_SIZE; i++) {
> +	for (i = 0; i < expa.nslot; i++) {
>  		for (cur = expa.htable[i]; cur; cur = cur->next) {
>  			render_av_rule(&cur->key, &cur->datum, what, p, fp);
>  		}
> 
> 
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
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
