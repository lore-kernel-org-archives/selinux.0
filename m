Message-ID: <47A33D70.7010704@manicmethod.com>
Date: Fri, 01 Feb 2008 10:40:32 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Yuichi Nakamura <ynakam@hitachisoft.jp>,
        "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: [patch] libsepol:  tune avtab to reduce memory usage
References: <1201874336.4568.142.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1201874336.4568.142.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Port of Yuichi Nakamura's tune avtab to reduce memory usage patch
> from the kernel avtab to libsepol.
>
> This patch decides the number of hash slots dynamically based on the
> number of rules.  It also avoids allocating the avtab altogether when
> reading policy modules, as they don't need it.
>
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>
>   

Looks good to me

Acked-By: Joshua Brindle <method@manicmethod.com>

> ---
>
>  checkpolicy/test/dispol.c               |    2 
>  libsepol/include/sepol/policydb/avtab.h |   18 ++++--
>  libsepol/src/avtab.c                    |   88 +++++++++++++++++++++++---------
>  libsepol/src/conditional.c              |    4 +
>  libsepol/src/expand.c                   |   20 +++++++
>  libsepol/src/policydb.c                 |    7 --
>  libsepol/src/write.c                    |   11 ++--
>  7 files changed, 109 insertions(+), 41 deletions(-)
>
> Index: trunk/libsepol/include/sepol/policydb/avtab.h
> ===================================================================
> --- trunk/libsepol/include/sepol/policydb/avtab.h	(revision 2774)
> +++ trunk/libsepol/include/sepol/policydb/avtab.h	(working copy)
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
> Index: trunk/libsepol/src/conditional.c
> ===================================================================
> --- trunk/libsepol/src/conditional.c	(revision 2774)
> +++ trunk/libsepol/src/conditional.c	(working copy)
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
> Index: trunk/libsepol/src/policydb.c
> ===================================================================
> --- trunk/libsepol/src/policydb.c	(revision 2774)
> +++ trunk/libsepol/src/policydb.c	(working copy)
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
> Index: trunk/libsepol/src/expand.c
> ===================================================================
> --- trunk/libsepol/src/expand.c	(revision 2774)
> +++ trunk/libsepol/src/expand.c	(working copy)
> @@ -2137,6 +2137,16 @@
>  	avrule_block_t *curblock;
>  	int retval = -1;
>  
> +	if (avtab_alloc(&state->out->te_avtab, MAX_AVTAB_SIZE)) {
> +		ERR(state->handle, "Out of Memory!");
> +		return -1;
> +	}
> +
> +	if (avtab_alloc(&state->out->te_cond_avtab, MAX_AVTAB_SIZE)) {
> +		ERR(state->handle, "Out of Memory!");
> +		return -1;
> +	}
> +
>  	for (curblock = state->base->global; curblock != NULL;
>  	     curblock = curblock->next) {
>  		avrule_decl_t *decl = curblock->enabled;
> @@ -2548,6 +2558,11 @@
>  {
>  	struct expand_avtab_data data;
>  
> +	if (avtab_alloc(expa, MAX_AVTAB_SIZE)) {
> +		ERR(NULL, "Out of memory!");
> +		return -1;
> +	}
> +
>  	data.expa = expa;
>  	data.p = p;
>  	return avtab_map(a, expand_avtab_node, &data);
> @@ -2676,6 +2691,11 @@
>  	avtab_ptr_t node;
>  	int rc;
>  
> +	if (avtab_alloc(expa, MAX_AVTAB_SIZE)) {
> +		ERR(NULL, "Out of memory!");
> +		return -1;
> +	}
> +
>  	*newl = NULL;
>  	for (cur = l; cur; cur = cur->next) {
>  		node = cur->node;
> Index: trunk/libsepol/src/write.c
> ===================================================================
> --- trunk/libsepol/src/write.c	(revision 2774)
> +++ trunk/libsepol/src/write.c	(working copy)
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
> Index: trunk/libsepol/src/avtab.c
> ===================================================================
> --- trunk/libsepol/src/avtab.c	(revision 2774)
> +++ trunk/libsepol/src/avtab.c	(working copy)
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
> @@ -80,10 +85,10 @@
>  	uint16_t specified =
>  	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
>  
> -	if (!h)
> +	if (!h || !h->htable)
>  		return SEPOL_ENOMEM;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = avtab_hash(key, h->mask);
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur; prev = cur, cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
> @@ -121,9 +126,9 @@
>  	uint16_t specified =
>  	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
>  
> -	if (!h)
> +	if (!h || !h->htable)
>  		return NULL;
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = avtab_hash(key, h->mask);
>  	for (prev = NULL, cur = h->htable[hvalue];
>  	     cur; prev = cur, cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
> @@ -153,10 +158,10 @@
>  	uint16_t specified =
>  	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
>  
> -	if (!h)
> +	if (!h || !h->htable)
>  		return NULL;
>  
> -	hvalue = AVTAB_HASH(key);
> +	hvalue = avtab_hash(key, h->mask);
>  	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
> @@ -188,10 +193,10 @@
>  	uint16_t specified =
>  	    key->specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
>  
> -	if (!h)
> +	if (!h || !h->htable)
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
> Index: trunk/checkpolicy/test/dispol.c
> ===================================================================
> --- trunk/checkpolicy/test/dispol.c	(revision 2774)
> +++ trunk/checkpolicy/test/dispol.c	(working copy)
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



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
