Subject: Re: [PATCH] selinux: Unify for- and while-loop style
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
Cc: jmorris@namei.org, eparis@parisplace.org, selinux@tycho.nsa.gov
In-Reply-To: <200808070036.m770ajof012753@ruuvi.it.helsinki.fi>
References: <200808070036.m770ajof012753@ruuvi.it.helsinki.fi>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 12:42:49 -0400
Message-Id: <1218732169.29535.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-08-07 at 03:18 +0300, Vesa-Matti Kari wrote:
> Replace "thing != NULL" comparisons with just "thing" to make
> the code look more uniform (mixed styles were used even in the
> same source file).

Looks fine to me.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
> ---
>  security/selinux/ss/avtab.c       |    2 +-
>  security/selinux/ss/conditional.c |   16 ++++++++--------
>  security/selinux/ss/ebitmap.c     |    4 ++--
>  security/selinux/ss/hashtab.c     |    6 +++---
>  security/selinux/ss/services.c    |    8 ++++----
>  security/selinux/ss/sidtab.c      |   12 ++++++------
>  6 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index e8ae812..1215b8e 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -229,7 +229,7 @@ void avtab_destroy(struct avtab *h)
>  
>  	for (i = 0; i < h->nslot; i++) {
>  		cur = h->htable[i];
> -		while (cur != NULL) {
> +		while (cur) {
>  			temp = cur;
>  			cur = cur->next;
>  			kmem_cache_free(avtab_node_cachep, temp);
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index f8c850a..4a4e35c 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -29,7 +29,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
>  	int s[COND_EXPR_MAXDEPTH];
>  	int sp = -1;
>  
> -	for (cur = expr; cur != NULL; cur = cur->next) {
> +	for (cur = expr; cur; cur = cur->next) {
>  		switch (cur->expr_type) {
>  		case COND_BOOL:
>  			if (sp == (COND_EXPR_MAXDEPTH - 1))
> @@ -97,14 +97,14 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>  		if (new_state == -1)
>  			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
>  		/* turn the rules on or off */
> -		for (cur = node->true_list; cur != NULL; cur = cur->next) {
> +		for (cur = node->true_list; cur; cur = cur->next) {
>  			if (new_state <= 0)
>  				cur->node->key.specified &= ~AVTAB_ENABLED;
>  			else
>  				cur->node->key.specified |= AVTAB_ENABLED;
>  		}
>  
> -		for (cur = node->false_list; cur != NULL; cur = cur->next) {
> +		for (cur = node->false_list; cur; cur = cur->next) {
>  			/* -1 or 1 */
>  			if (new_state)
>  				cur->node->key.specified &= ~AVTAB_ENABLED;
> @@ -128,7 +128,7 @@ int cond_policydb_init(struct policydb *p)
>  static void cond_av_list_destroy(struct cond_av_list *list)
>  {
>  	struct cond_av_list *cur, *next;
> -	for (cur = list; cur != NULL; cur = next) {
> +	for (cur = list; cur; cur = next) {
>  		next = cur->next;
>  		/* the avtab_ptr_t node is destroy by the avtab */
>  		kfree(cur);
> @@ -139,7 +139,7 @@ static void cond_node_destroy(struct cond_node *node)
>  {
>  	struct cond_expr *cur_expr, *next_expr;
>  
> -	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = next_expr) {
> +	for (cur_expr = node->expr; cur_expr; cur_expr = next_expr) {
>  		next_expr = cur_expr->next;
>  		kfree(cur_expr);
>  	}
> @@ -155,7 +155,7 @@ static void cond_list_destroy(struct cond_node *list)
>  	if (list == NULL)
>  		return;
>  
> -	for (cur = list; cur != NULL; cur = next) {
> +	for (cur = list; cur; cur = next) {
>  		next = cur->next;
>  		cond_node_destroy(cur);
>  	}
> @@ -291,7 +291,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>  					goto err;
>  				}
>  				found = 0;
> -				for (cur = other; cur != NULL; cur = cur->next) {
> +				for (cur = other; cur; cur = cur->next) {
>  					if (cur->node == node_ptr) {
>  						found = 1;
>  						break;
> @@ -485,7 +485,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decisi
>  	if (!ctab || !key || !avd)
>  		return;
>  
> -	for (node = avtab_search_node(ctab, key); node != NULL;
> +	for (node = avtab_search_node(ctab, key); node;
>  				node = avtab_search_node_next(node, key->specified)) {
>  		if ((u16)(AVTAB_ALLOWED|AVTAB_ENABLED) ==
>  		    (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index ddc2754..68c7348 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -109,7 +109,7 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
>  	*catmap = c_iter;
>  	c_iter->startbit = e_iter->startbit & ~(NETLBL_CATMAP_SIZE - 1);
>  
> -	while (e_iter != NULL) {
> +	while (e_iter) {
>  		for (i = 0; i < EBITMAP_UNIT_NUMS; i++) {
>  			unsigned int delta, e_startbit, c_endbit;
>  
> @@ -197,7 +197,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
>  			}
>  		}
>  		c_iter = c_iter->next;
> -	} while (c_iter != NULL);
> +	} while (c_iter);
>  	if (e_iter != NULL)
>  		ebmap->highbit = e_iter->startbit + EBITMAP_SIZE;
>  	else
> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index 2e7788e..933e735 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -81,7 +81,7 @@ void *hashtab_search(struct hashtab *h, const void *key)
>  
>  	hvalue = h->hash_value(h, key);
>  	cur = h->htable[hvalue];
> -	while (cur != NULL && h->keycmp(h, key, cur->key) > 0)
> +	while (cur && h->keycmp(h, key, cur->key) > 0)
>  		cur = cur->next;
>  
>  	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
> @@ -100,7 +100,7 @@ void hashtab_destroy(struct hashtab *h)
>  
>  	for (i = 0; i < h->size; i++) {
>  		cur = h->htable[i];
> -		while (cur != NULL) {
> +		while (cur) {
>  			temp = cur;
>  			cur = cur->next;
>  			kfree(temp);
> @@ -127,7 +127,7 @@ int hashtab_map(struct hashtab *h,
>  
>  	for (i = 0; i < h->size; i++) {
>  		cur = h->htable[i];
> -		while (cur != NULL) {
> +		while (cur) {
>  			ret = apply(cur->key, cur->datum, args);
>  			if (ret)
>  				return ret;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b52f923..5a0536b 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -356,7 +356,7 @@ static int context_struct_compute_av(struct context *scontext,
>  			avkey.source_type = i + 1;
>  			avkey.target_type = j + 1;
>  			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
> -			     node != NULL;
> +			     node;
>  			     node = avtab_search_node_next(node, avkey.specified)) {
>  				if (node->key.specified == AVTAB_ALLOWED)
>  					avd->allowed |= node->datum.data;
> @@ -1037,7 +1037,7 @@ static int security_compute_sid(u32 ssid,
>  	/* If no permanent rule, also check for enabled conditional rules */
>  	if (!avdatum) {
>  		node = avtab_search_node(&policydb.te_cond_avtab, &avkey);
> -		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
> +		for (; node; node = avtab_search_node_next(node, specified)) {
>  			if (node->key.specified & AVTAB_ENABLED) {
>  				avdatum = &node->datum;
>  				break;
> @@ -2050,7 +2050,7 @@ int security_set_bools(int len, int *values)
>  			policydb.bool_val_to_struct[i]->state = 0;
>  	}
>  
> -	for (cur = policydb.cond_list; cur != NULL; cur = cur->next) {
> +	for (cur = policydb.cond_list; cur; cur = cur->next) {
>  		rc = evaluate_cond_node(&policydb, cur);
>  		if (rc)
>  			goto out;
> @@ -2102,7 +2102,7 @@ static int security_preserve_bools(struct policydb *p)
>  		if (booldatum)
>  			booldatum->state = bvalues[i];
>  	}
> -	for (cur = p->cond_list; cur != NULL; cur = cur->next) {
> +	for (cur = p->cond_list; cur; cur = cur->next) {
>  		rc = evaluate_cond_node(p, cur);
>  		if (rc)
>  			goto out;
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index a81ded1..e817989 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -43,7 +43,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>  	hvalue = SIDTAB_HASH(sid);
>  	prev = NULL;
>  	cur = s->htable[hvalue];
> -	while (cur != NULL && sid > cur->sid) {
> +	while (cur && sid > cur->sid) {
>  		prev = cur;
>  		cur = cur->next;
>  	}
> @@ -92,7 +92,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>  
>  	hvalue = SIDTAB_HASH(sid);
>  	cur = s->htable[hvalue];
> -	while (cur != NULL && sid > cur->sid)
> +	while (cur && sid > cur->sid)
>  		cur = cur->next;
>  
>  	if (force && cur && sid == cur->sid && cur->context.len)
> @@ -103,7 +103,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>  		sid = SECINITSID_UNLABELED;
>  		hvalue = SIDTAB_HASH(sid);
>  		cur = s->htable[hvalue];
> -		while (cur != NULL && sid > cur->sid)
> +		while (cur && sid > cur->sid)
>  			cur = cur->next;
>  		if (!cur || sid != cur->sid)
>  			return NULL;
> @@ -136,7 +136,7 @@ int sidtab_map(struct sidtab *s,
>  
>  	for (i = 0; i < SIDTAB_SIZE; i++) {
>  		cur = s->htable[i];
> -		while (cur != NULL) {
> +		while (cur) {
>  			rc = apply(cur->sid, &cur->context, args);
>  			if (rc)
>  				goto out;
> @@ -155,7 +155,7 @@ static inline u32 sidtab_search_context(struct sidtab *s,
>  
>  	for (i = 0; i < SIDTAB_SIZE; i++) {
>  		cur = s->htable[i];
> -		while (cur != NULL) {
> +		while (cur) {
>  			if (context_cmp(&cur->context, context))
>  				return cur->sid;
>  			cur = cur->next;
> @@ -242,7 +242,7 @@ void sidtab_destroy(struct sidtab *s)
>  
>  	for (i = 0; i < SIDTAB_SIZE; i++) {
>  		cur = s->htable[i];
> -		while (cur != NULL) {
> +		while (cur) {
>  			temp = cur;
>  			cur = cur->next;
>  			context_destroy(&temp->context);
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
