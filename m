Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB8EEB581
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 03:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjIMDXf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Sep 2023 23:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjIMDXf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Sep 2023 23:23:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C610CC
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 20:23:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-770fc5363e6so213694185a.2
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 20:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694575410; x=1695180210; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PBOAhi+T1yK2eEqUnakFBS90Nrv+jCl2aUt/ERe6zSU=;
        b=MC0RPs82LvoE5+RdiI95zUCpoaCodpUbHNa1CrPYaxDwIWtZYC+xBr4UGDfHgiJaO1
         RMNkXLSjG59KlWzZVA/wyG8MzjKMSxUShFpi+7z3ZvS3M2dZfs7quAgry2QxwJvVLJ6t
         cLr7C4GaUSm5pHPQ86x5lHMMVWDnZDDUL6r1qx8pdsWF7FsauaWZEb/Ab5+xKEnxmmig
         OdZy9lw98u0vgQMN3AH/xGHAt1X8qZhnB59MfAjHRayuqWIzI04Hp6wynSZeX9IcJg5e
         BsYTEpqW37rAAPy3Nu73QWBkpM+uiGSBDnskBXVgbkXKeF6OOC4FZ/JvVRg1A+6CEbBh
         DKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694575410; x=1695180210;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBOAhi+T1yK2eEqUnakFBS90Nrv+jCl2aUt/ERe6zSU=;
        b=bkUZ8Q44ZgScC/go5MQoji7jcMvwOruozm404BeidyYDqfIwAx0Snk0eBw9zEFc1aW
         5tcjyg3JwBKRT12V40poqTtwl3Kg4goLzmwYy7fKndZYEKcuaOHRYIXJj/eroz5LnyWW
         t5mkFDhO4LZITgQ5iD7QbMvu3q4MVje3dgh48yfA17XRpoIvT+eCVGmdi2s0dM9LCFAn
         xMrZ0QdZ+T3t7BhRfX3aao4qTmjJgdDcMgdGtCkxzfINV2ybE/7dwQaWrbD2QVCHJBM2
         Nmgd2E23oC0cniISvaxugHezi7+0HgEDkaFfwU9n9lcZxcbOEXOoiX3n9Fak9aRorpFV
         eG8w==
X-Gm-Message-State: AOJu0Ywz8JqwrsJHNi/U3ufDy7M8KO75GQybQpLB+APTRUBgjMUisea3
        QWtwYplwjEgTq2YkTSN38bZJ
X-Google-Smtp-Source: AGHT+IG1n9zz5gbMiTAbKrSk3BiPnw3+OznpwaJBM91oCFyd4XygdU3+K4hKTnnmdaCRIDzcJqtP1Q==
X-Received: by 2002:a05:620a:f0e:b0:76f:2c0f:9ddb with SMTP id v14-20020a05620a0f0e00b0076f2c0f9ddbmr1674569qkl.8.1694575410061;
        Tue, 12 Sep 2023 20:23:30 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z4-20020a05620a100400b00763b94432ebsm3634037qkj.18.2023.09.12.20.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 20:23:29 -0700 (PDT)
Date:   Tue, 12 Sep 2023 23:23:28 -0400
Message-ID: <e55fa937809c138e4b474c8ed55d2fdc.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Subject: Re: [PATCH 1/3] selinux: use arrays for avtab hashtable nodes
References: <20230906154611.31762-2-jsatterfield.linux@gmail.com>
In-Reply-To: <20230906154611.31762-2-jsatterfield.linux@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sep  6, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> The current avtab hashtable employs a separate chaining collision
> resolution strategy where each bucket/chain holds an ordered linked list
> of pointers to kmem_cache allocated avtab_node elements.
> 
> On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
> uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
> A call to kmem_cache_zalloc() is required for every single rule, which
> in the default policy is currently 96,730 and continually rising.
> 
> When both sets of avtab_node (regular and cond.) are turned into arrays
> with the hash table slot indexing into it rather than a pointer, then
> this results in only 2 additional kvcalloc() calls and the complete
> removal of the kmem_cache itself.
> 
> The caching characteristics of iterating a single array are better due
> to locality of reference. Running "perf stat -r 100 -d load_policy"
> has shown a runtime reduction of at least 10% on a Fedora 38 x86_64 VM
> with this single patch. Future patches focused on improving the hash
> table's collision resolution strategy and array layout (struct-of-arrays
> vs. array-of-structs) may elicit even more caching and therefore runtime
> performance improvements.
> 
> On 64-bit machines, the memory usage of the hash table slots is cut in
> half due to the use of u32 indices instead of memory pointers. Since
> ~65k hash slots are used between the regular and cond. tables with the
> default Fedora 38 policy, this equates to around 256KB of memory saved.
> 
> Notes:
> 
> A couple helper functions avtab_get_chain() and avtab_get_node() are
> introduced to provide more standardized interfaces for use in functions
> that need to search through the hash table.
> 
> NULL_NODE_IDX defines a sentinel value which helps determinine if a spot
> in the hash table or the "next" member of an avtab_node are valid.
> 
> This patch causes the cond. rules table to waste memory as the size
> requested for the kvcalloc() is the size of the regular rules table.
> These tables rarely, if ever, have the same number of rules in practice.
> The next patch addresses this shortcoming.

Isn't the more important issue that of there being more conditional
rules than regular rules?  Yes, I'm sure this is very unlikely, but
given just this patch wouldn't this cause a problem?

It is important to remember that even when combined in a patchset,
any given patch should not break the system.  A patch can depend on
prior patches in the patchset, but not upcoming patches.

I've only looked very briefly at patch 2/3, but I suspect at the very
least you may need to squash patches 1/3 and 2/3 to ensure there is
no breakage.

More comments below (all are in the context of patch 1/3, some may not
be relevant in the context of 1/3+2/3).

> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c       | 75 +++++++++++++++----------------
>  security/selinux/ss/avtab.h       | 28 ++++++++++--
>  security/selinux/ss/conditional.c | 13 +++---
>  security/selinux/ss/services.c    | 20 +++++----
>  4 files changed, 81 insertions(+), 55 deletions(-)
> 
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 86d98a8e291b..620ea0a03e41 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -23,7 +23,6 @@
>  #include "avtab.h"
>  #include "policydb.h"
>  
> -static struct kmem_cache *avtab_node_cachep __ro_after_init;
>  static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
>  
>  /* Based on MurmurHash3, written by Austin Appleby and placed in the
> @@ -70,17 +69,17 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
>  		  struct avtab_node *prev,
>  		  const struct avtab_key *key, const struct avtab_datum *datum)
>  {
> +	u32 newnodei;
>  	struct avtab_node *newnode;
>  	struct avtab_extended_perms *xperms;
> -	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> -	if (newnode == NULL)
> -		return NULL;
> +	newnodei = ++h->nel;

This makes me nervous that some future code change forgets to
decrement h->nel in its error handler.  Let's only bump h->nel at the
end of the function.

We also should have a check in this function to ensure we don't
overflow the array size.

> +	newnode = avtab_get_node(h, newnodei);
>  	newnode->key = *key;
>  
>  	if (key->specified & AVTAB_XPERMS) {
>  		xperms = kmem_cache_zalloc(avtab_xperms_cachep, GFP_KERNEL);
>  		if (xperms == NULL) {
> -			kmem_cache_free(avtab_node_cachep, newnode);
> +			--h->nel;
>  			return NULL;
>  		}
>  		*xperms = *(datum->u.xperms);
> @@ -91,15 +90,12 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
>  
>  	if (prev) {
>  		newnode->next = prev->next;
> -		prev->next = newnode;
> +		prev->next = newnodei;
>  	} else {
> -		struct avtab_node **n = &h->htable[hvalue];
> -
> -		newnode->next = *n;
> -		*n = newnode;
> +		newnode->next = h->htable[hvalue];
> +		h->htable[hvalue] = newnodei;
>  	}

See my comments below about the next field in the avtab_node struct.

> -	h->nel++;
>  	return newnode;
>  }
>  
> @@ -114,9 +110,9 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
>  		return -EINVAL;
>  
>  	hvalue = avtab_hash(key, h->mask);
> -	for (prev = NULL, cur = h->htable[hvalue];
> +	for (prev = NULL, cur = avtab_get_chain(h, hvalue);
>  	     cur;
> -	     prev = cur, cur = cur->next) {
> +	     prev = cur, cur = avtab_get_node(h, cur->next)) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
>  		    key->target_class == cur->key.target_class &&
> @@ -159,9 +155,9 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
>  	if (!h || !h->nslot || h->nel == U32_MAX)
>  		return NULL;
>  	hvalue = avtab_hash(key, h->mask);
> -	for (prev = NULL, cur = h->htable[hvalue];
> +	for (prev = NULL, cur = avtab_get_chain(h, hvalue);
>  	     cur;
> -	     prev = cur, cur = cur->next) {
> +	     prev = cur, cur = avtab_get_node(h, cur->next)) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
>  		    key->target_class == cur->key.target_class &&
> @@ -194,8 +190,8 @@ struct avtab_node *avtab_search_node(struct avtab *h,
>  		return NULL;
>  
>  	hvalue = avtab_hash(key, h->mask);
> -	for (cur = h->htable[hvalue]; cur;
> -	     cur = cur->next) {
> +	for (cur = avtab_get_chain(h, hvalue); cur;
> +	     cur = avtab_get_node(h, cur->next)) {
>  		if (key->source_type == cur->key.source_type &&
>  		    key->target_type == cur->key.target_type &&
>  		    key->target_class == cur->key.target_class &&
> @@ -216,7 +212,7 @@ struct avtab_node *avtab_search_node(struct avtab *h,
>  }
>  
>  struct avtab_node*
> -avtab_search_node_next(struct avtab_node *node, u16 specified)
> +avtab_search_node_next(struct avtab *h, struct avtab_node *node, u16 specified)
>  {
>  	struct avtab_node *cur;
>  
> @@ -224,7 +220,7 @@ avtab_search_node_next(struct avtab_node *node, u16 specified)
>  		return NULL;
>  
>  	specified &= ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> -	for (cur = node->next; cur; cur = cur->next) {
> +	for (cur = avtab_get_node(h, node->next); cur; cur = avtab_get_node(h, cur->next)) {
>  		if (node->key.source_type == cur->key.source_type &&
>  		    node->key.target_type == cur->key.target_type &&
>  		    node->key.target_class == cur->key.target_class &&
> @@ -247,24 +243,24 @@ avtab_search_node_next(struct avtab_node *node, u16 specified)
>  void avtab_destroy(struct avtab *h)
>  {
>  	u32 i;
> -	struct avtab_node *cur, *temp;
> +	struct avtab_node *cur;
>  
>  	if (!h)
>  		return;
>  
>  	for (i = 0; i < h->nslot; i++) {
> -		cur = h->htable[i];
> +		cur = avtab_get_chain(h, i);
>  		while (cur) {
> -			temp = cur;
> -			cur = cur->next;
> -			if (temp->key.specified & AVTAB_XPERMS)
> +			if (cur->key.specified & AVTAB_XPERMS)
>  				kmem_cache_free(avtab_xperms_cachep,
> -						temp->datum.u.xperms);
> -			kmem_cache_free(avtab_node_cachep, temp);
> +						cur->datum.u.xperms);
> +			cur = avtab_get_node(h, cur->next);
>  		}
>  	}
>  	kvfree(h->htable);
> +	kvfree(h->nodes);
>  	h->htable = NULL;
> +	h->nodes = NULL;
>  	h->nel = 0;
>  	h->nslot = 0;
>  	h->mask = 0;
> @@ -273,20 +269,26 @@ void avtab_destroy(struct avtab *h)
>  void avtab_init(struct avtab *h)
>  {
>  	h->htable = NULL;
> +	h->nodes = NULL;
>  	h->nel = 0;
>  	h->nslot = 0;
>  	h->mask = 0;
>  }
>  
> -static int avtab_alloc_common(struct avtab *h, u32 nslot)
> +static int avtab_alloc_common(struct avtab *h, u32 nslot, u32 nrules)
>  {
>  	if (!nslot)
>  		return 0;
>  
> -	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
> +	h->htable = kvcalloc(nslot, sizeof(u32), GFP_KERNEL);
>  	if (!h->htable)
>  		return -ENOMEM;
> -
> +	h->nodes = kvcalloc(nrules, sizeof(struct avtab_node), GFP_KERNEL);
> +	if (!h->nodes) {
> +		kvfree(h->htable);
> +		h->htable = NULL;
> +		return -ENOMEM;
> +	}
>  	h->nslot = nslot;
>  	h->mask = nslot - 1;
>  	return 0;
> @@ -308,7 +310,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>  		if (nslot > MAX_AVTAB_HASH_BUCKETS)
>  			nslot = MAX_AVTAB_HASH_BUCKETS;
>  
> -		rc = avtab_alloc_common(h, nslot);
> +		rc = avtab_alloc_common(h, nslot, nrules);
>  		if (rc)
>  			return rc;
>  	}
> @@ -319,7 +321,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>  
>  int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
>  {
> -	return avtab_alloc_common(new, orig->nslot);
> +	return avtab_alloc_common(new, orig->nslot, orig->nel);
>  }
>  
>  #ifdef CONFIG_SECURITY_SELINUX_DEBUG
> @@ -333,13 +335,13 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
>  	max_chain_len = 0;
>  	chain2_len_sum = 0;
>  	for (i = 0; i < h->nslot; i++) {
> -		cur = h->htable[i];
> +		cur = avtab_get_chain(h, i);
>  		if (cur) {
>  			slots_used++;
>  			chain_len = 0;
>  			while (cur) {
>  				chain_len++;
> -				cur = cur->next;
> +				cur = avtab_get_node(h, cur->next);
>  			}
>  
>  			if (chain_len > max_chain_len)
> @@ -627,8 +629,8 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
>  		return rc;
>  
>  	for (i = 0; i < a->nslot; i++) {
> -		for (cur = a->htable[i]; cur;
> -		     cur = cur->next) {
> +		for (cur = avtab_get_chain(a, i); cur;
> +		     cur = avtab_get_node(a, cur->next)) {
>  			rc = avtab_write_item(p, cur, fp);
>  			if (rc)
>  				return rc;
> @@ -640,9 +642,6 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
>  
>  void __init avtab_cache_init(void)
>  {
> -	avtab_node_cachep = kmem_cache_create("avtab_node",
> -					      sizeof(struct avtab_node),
> -					      0, SLAB_PANIC, NULL);
>  	avtab_xperms_cachep = kmem_cache_create("avtab_extended_perms",
>  						sizeof(struct avtab_extended_perms),
>  						0, SLAB_PANIC, NULL);
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index 3c3904bf02b0..72708aed5fff 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -77,16 +77,38 @@ struct avtab_datum {
>  struct avtab_node {
>  	struct avtab_key key;
>  	struct avtab_datum datum;
> -	struct avtab_node *next;
> +	u32 next;

Given that one of the common avtab lookup operations is to simply walk
the list, using the next field, why not keep the next field as a
pointer?  Sure, you loose the 64-bit to 32-bit size reduction on 64-bit
systems (although I wonder if alignment issues rendered that moot), but
I would expect the walk to be quicker if you only needed to do a single
next pointer lookup as opposed to the array indexing.

I may be missing something, but I believe this would also remove the
need for the NULL_NODE_IDX sentinel.

>  };
>  
>  struct avtab {
> -	struct avtab_node **htable;
> +	u32 *htable;

The field name "htable" is a little too confusing now, let's change
it to "indicies", "offsets", or something like that.

> +	struct avtab_node *nodes;
>  	u32 nel;	/* number of elements */
>  	u32 nslot;      /* number of hash slots */
>  	u32 mask;       /* mask to compute hash func */
>  };
>  
> +/* sentinel value to signal an empty node */
> +#define NULL_NODE_IDX		(0)
> +/* compute the actual index into the nodes array */
> +#define NODES_ARRAY_IDX(idx)	((idx) - 1)

I'm pretty sure we can do away with NULL_NODE_IDX if we keep the next
field as a pointer (NULL works as a sentinel), does that also mean we
can get rid of the NODES_ARRAY_IDX translation?

> +static inline struct avtab_node *avtab_get_chain(struct avtab *h, u32 slot)
> +{
> +	u32 chain_start = h->htable[slot];
> +
> +	if (chain_start != NULL_NODE_IDX)
> +		return &h->nodes[NODES_ARRAY_IDX(chain_start)];
> +	return NULL;

Don't duplicate avtab_get_node() here, call it instead; for example:

 struct avtab_node *avtab_get_chain(h, slot)
 {
   return avtab_get_node(h, h->table[slot]); 
 }

> +}
> +
> +static inline struct avtab_node *avtab_get_node(struct avtab *h, u32 idx)
> +{
> +	if (idx != NULL_NODE_IDX)
> +		return &h->nodes[NODES_ARRAY_IDX(idx)];
> +	return NULL;
> +}
> +
>  void avtab_init(struct avtab *h);
>  int avtab_alloc(struct avtab *, u32);
>  int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
> @@ -117,7 +139,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
>  struct avtab_node *avtab_search_node(struct avtab *h,
>  				     const struct avtab_key *key);
>  
> -struct avtab_node *avtab_search_node_next(struct avtab_node *node, u16 specified);
> +struct avtab_node *avtab_search_node_next(struct avtab *h, struct avtab_node *node, u16 specified);

Another benefit of preserving the next field as a pointer is that we
should be able to leave the avtab_search_node_next() prototype intact.
Probably the implementation too.

>  #define MAX_AVTAB_HASH_BITS 16
>  #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 81ff676f209a..448bdacb1769 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -262,6 +262,7 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
>  	struct cond_insertf_data *data = ptr;
>  	struct policydb *p = data->p;
>  	struct cond_av_list *other = data->other;
> +	struct avtab *cond_avtab = &p->te_cond_avtab;
>  	struct avtab_node *node_ptr;
>  	u32 i;
>  	bool found;
> @@ -285,9 +286,9 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
>  		 * be any other entries.
>  		 */
>  		if (other) {
> -			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
> +			node_ptr = avtab_search_node(cond_avtab, k);
>  			if (node_ptr) {
> -				if (avtab_search_node_next(node_ptr, k->specified)) {
> +				if (avtab_search_node_next(cond_avtab, node_ptr, k->specified)) {
>  					pr_err("SELinux: too many conflicting type rules.\n");
>  					return -EINVAL;
>  				}
> @@ -304,14 +305,14 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
>  				}
>  			}
>  		} else {
> -			if (avtab_search_node(&p->te_cond_avtab, k)) {
> +			if (avtab_search_node(cond_avtab, k)) {
>  				pr_err("SELinux: conflicting type rules when adding type rule for true.\n");
>  				return -EINVAL;
>  			}
>  		}
>  	}
>  
> -	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
> +	node_ptr = avtab_insert_nonunique(cond_avtab, k, d);
>  	if (!node_ptr) {
>  		pr_err("SELinux: could not insert rule.\n");
>  		return -ENOMEM;
> @@ -563,7 +564,7 @@ void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
>  		return;
>  
>  	for (node = avtab_search_node(ctab, key); node;
> -			node = avtab_search_node_next(node, key->specified)) {
> +			node = avtab_search_node_next(ctab, node, key->specified)) {
>  		if (node->key.specified & AVTAB_ENABLED)
>  			services_compute_xperms_decision(xpermd, node);
>  	}
> @@ -580,7 +581,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>  		return;
>  
>  	for (node = avtab_search_node(ctab, key); node;
> -				node = avtab_search_node_next(node, key->specified)) {
> +				node = avtab_search_node_next(ctab, node, key->specified)) {
>  		if ((u16)(AVTAB_ALLOWED|AVTAB_ENABLED) ==
>  		    (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
>  			avd->allowed |= node->datum.u.data;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1eeffc66ea7d..89cb4fc2d4aa 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -617,6 +617,7 @@ static void context_struct_compute_av(struct policydb *policydb,
>  {
>  	struct constraint_node *constraint;
>  	struct role_allow *ra;
> +	struct avtab *avtab;
>  	struct avtab_key avkey;
>  	struct avtab_node *node;
>  	struct class_datum *tclass_datum;
> @@ -644,6 +645,7 @@ static void context_struct_compute_av(struct policydb *policydb,
>  	 * If a specific type enforcement rule was defined for
>  	 * this permission check, then use it.
>  	 */
> +	avtab = &policydb->te_avtab;
>  	avkey.target_class = tclass;
>  	avkey.specified = AVTAB_AV | AVTAB_XPERMS;
>  	sattr = &policydb->type_attr_map_array[scontext->type - 1];
> @@ -652,10 +654,9 @@ static void context_struct_compute_av(struct policydb *policydb,
>  		ebitmap_for_each_positive_bit(tattr, tnode, j) {
>  			avkey.source_type = i + 1;
>  			avkey.target_type = j + 1;
> -			for (node = avtab_search_node(&policydb->te_avtab,
> -						      &avkey);
> +			for (node = avtab_search_node(avtab, &avkey);
>  			     node;
> -			     node = avtab_search_node_next(node, avkey.specified)) {
> +			     node = avtab_search_node_next(avtab, node, avkey.specified)) {
>  				if (node->key.specified == AVTAB_ALLOWED)
>  					avd->allowed |= node->datum.u.data;
>  				else if (node->key.specified == AVTAB_AUDITALLOW)
> @@ -1008,6 +1009,7 @@ void security_compute_xperms_decision(u32 ssid,
>  	struct sidtab *sidtab;
>  	u16 tclass;
>  	struct context *scontext, *tcontext;
> +	struct avtab *avtab;
>  	struct avtab_key avkey;
>  	struct avtab_node *node;
>  	struct ebitmap *sattr, *tattr;
> @@ -1055,6 +1057,7 @@ void security_compute_xperms_decision(u32 ssid,
>  		goto out;
>  	}
>  
> +	avtab = &policydb->te_avtab;
>  	avkey.target_class = tclass;
>  	avkey.specified = AVTAB_XPERMS;
>  	sattr = &policydb->type_attr_map_array[scontext->type - 1];
> @@ -1063,10 +1066,9 @@ void security_compute_xperms_decision(u32 ssid,
>  		ebitmap_for_each_positive_bit(tattr, tnode, j) {
>  			avkey.source_type = i + 1;
>  			avkey.target_type = j + 1;
> -			for (node = avtab_search_node(&policydb->te_avtab,
> -						      &avkey);
> +			for (node = avtab_search_node(avtab, &avkey);
>  			     node;
> -			     node = avtab_search_node_next(node, avkey.specified))
> +			     node = avtab_search_node_next(avtab, node, avkey.specified))
>  				services_compute_xperms_decision(xpermd, node);
>  
>  			cond_compute_xperms(&policydb->te_cond_avtab,
> @@ -1705,6 +1707,7 @@ static int security_compute_sid(u32 ssid,
>  	struct class_datum *cladatum;
>  	struct context *scontext, *tcontext, newcontext;
>  	struct sidtab_entry *sentry, *tentry;
> +	struct avtab *cond_avtab;
>  	struct avtab_key avkey;
>  	struct avtab_node *avnode, *node;
>  	u16 tclass;
> @@ -1810,6 +1813,7 @@ static int security_compute_sid(u32 ssid,
>  	}
>  
>  	/* Look for a type transition/member/change rule. */
> +	cond_avtab = &policydb->te_cond_avtab;
>  	avkey.source_type = scontext->type;
>  	avkey.target_type = tcontext->type;
>  	avkey.target_class = tclass;
> @@ -1818,8 +1822,8 @@ static int security_compute_sid(u32 ssid,
>  
>  	/* If no permanent rule, also check for enabled conditional rules */
>  	if (!avnode) {
> -		node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
> -		for (; node; node = avtab_search_node_next(node, specified)) {
> +		node = avtab_search_node(cond_avtab, &avkey);
> +		for (; node; node = avtab_search_node_next(cond_avtab, node, specified)) {
>  			if (node->key.specified & AVTAB_ENABLED) {
>  				avnode = node;
>  				break;
> -- 
> 2.41.0

--
paul-moore.com
