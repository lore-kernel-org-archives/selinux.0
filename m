Subject: Re: [PATCH][RFC] Unify printk messgaes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
References: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 07:36:48 -0500
Message-Id: <1204029408.2804.257.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-02-26 at 20:53 +1100, James Morris wrote:
> I noticed that we had a mix of "SELinux:" and "security:" prefixes in our 
> kernel boot messages, so I've unified these to "SELinux:" with the patch 
> below to reduce user confusion.  (It doesn't try and fix every printk, 
> just the ones with "security:").
> 
> Also simplified the avtab hash message, from:
> 
>   SELinux:8192 avtab hash slots allocated. Num of rules:163922
> 
> to
> 
>   SELinux: 8192 avtab hash slots, 163922 rules.
> 
> 
> Comments?

Makes sense from a user perspective - reflects further nativization of
the Flask code for the Linux implementation, but will yield a difference
in output between SELinux and e.g. SEBSD.  Only question I have is
whether any userspace tools are looking for the security: prefix today.
I don't think we can change the avc: prefix for avc messages given the
impact on userspace tools that search for them.

It would also likely help to change error messages in hooks.c to have
SELinux in the message in place of the __FUNCTION__ name, and/or to
ensure that all such functions have a selinux prefix.
inode_doinit_with_dentry is an obvious candidate for renaming - my bad.

> ---
> 
> >From baed7a785c9fce03ae694209116e15dd2dfc53c6 Mon Sep 17 00:00:00 2001
> From: James Morris <jmorris@namei.org>
> Date: Tue, 26 Feb 2008 20:42:02 +1100
> Subject: [PATCH] SELinux: unify printk messages
> 
> Replace "security:" prefixes in printk messages with "SELinux"
> to help users identify the source of the messages.  Also fix a
> couple of minor formatting issues.
> 
> Signed-off-by: James Morris <jmorris@namei.org>
> ---
>  security/selinux/ss/avtab.c       |   40 +++++++++++++-------------
>  security/selinux/ss/conditional.c |   16 +++++-----
>  security/selinux/ss/ebitmap.c     |   14 +++++-----
>  security/selinux/ss/policydb.c    |   54 ++++++++++++++++++------------------
>  security/selinux/ss/services.c    |   28 +++++++++---------
>  5 files changed, 76 insertions(+), 76 deletions(-)
> 
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index cd10e27..916e73a 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -280,8 +280,8 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>  	h->nel = 0;
>  	h->nslot = nslot;
>  	h->mask = mask;
> -	printk(KERN_DEBUG "SELinux:%d avtab hash slots allocated. "
> -	       "Num of rules:%d\n", h->nslot, nrules);
> +	printk(KERN_DEBUG "SELinux: %d avtab hash slots, %d rules.\n",
> +	       h->nslot, nrules);
>  	return 0;
>  }
>  
> @@ -345,18 +345,18 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>  	if (vers < POLICYDB_VERSION_AVTAB) {
>  		rc = next_entry(buf32, fp, sizeof(u32));
>  		if (rc < 0) {
> -			printk(KERN_ERR "security: avtab: truncated entry\n");
> +			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
>  			return -1;
>  		}
>  		items2 = le32_to_cpu(buf32[0]);
>  		if (items2 > ARRAY_SIZE(buf32)) {
> -			printk(KERN_ERR "security: avtab: entry overflow\n");
> +			printk(KERN_ERR "SELinux: avtab: entry overflow\n");
>  			return -1;
>  
>  		}
>  		rc = next_entry(buf32, fp, sizeof(u32)*items2);
>  		if (rc < 0) {
> -			printk(KERN_ERR "security: avtab: truncated entry\n");
> +			printk(KERN_ERR "SELinux: avtab: truncated entry\n");
>  			return -1;
>  		}
>  		items = 0;
> @@ -364,19 +364,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>  		val = le32_to_cpu(buf32[items++]);
>  		key.source_type = (u16)val;
>  		if (key.source_type != val) {
> -			printk("security: avtab: truncated source type\n");
> +			printk("SELinux: avtab: truncated source type\n");
>  			return -1;
>  		}
>  		val = le32_to_cpu(buf32[items++]);
>  		key.target_type = (u16)val;
>  		if (key.target_type != val) {
> -			printk("security: avtab: truncated target type\n");
> +			printk("SELinux: avtab: truncated target type\n");
>  			return -1;
>  		}
>  		val = le32_to_cpu(buf32[items++]);
>  		key.target_class = (u16)val;
>  		if (key.target_class != val) {
> -			printk("security: avtab: truncated target class\n");
> +			printk("SELinux: avtab: truncated target class\n");
>  			return -1;
>  		}
>  
> @@ -384,12 +384,12 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>  		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
>  
>  		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
> -			printk("security: avtab: null entry\n");
> +			printk("SELinux: avtab: null entry\n");
>  			return -1;
>  		}
>  		if ((val & AVTAB_AV) &&
>  		    (val & AVTAB_TYPE)) {
> -			printk("security: avtab: entry has both access vectors and types\n");
> +			printk("SELinux: avtab: entry has both access vectors and types\n");
>  			return -1;
>  		}
>  
> @@ -403,7 +403,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>  		}
>  
>  		if (items != items2) {
> -			printk("security: avtab: entry only had %d items, expected %d\n", items2, items);
> +			printk("SELinux: avtab: entry only had %d items, expected %d\n", items2, items);
>  			return -1;
>  		}
>  		return 0;
> @@ -411,7 +411,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>  
>  	rc = next_entry(buf16, fp, sizeof(u16)*4);
>  	if (rc < 0) {
> -		printk("security: avtab: truncated entry\n");
> +		printk("SELinux: avtab: truncated entry\n");
>  		return -1;
>  	}
>  
> @@ -424,7 +424,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>  	if (!policydb_type_isvalid(pol, key.source_type) ||
>  	    !policydb_type_isvalid(pol, key.target_type) ||
>  	    !policydb_class_isvalid(pol, key.target_class)) {
> -		printk(KERN_WARNING "security: avtab: invalid type or class\n");
> +		printk(KERN_WARNING "SELinux: avtab: invalid type or class\n");
>  		return -1;
>  	}
>  
> @@ -435,19 +435,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
>  	}
>  	if (!set || set > 1) {
>  		printk(KERN_WARNING
> -			"security:  avtab:  more than one specifier\n");
> +			"SELinux:  avtab:  more than one specifier\n");
>  		return -1;
>  	}
>  
>  	rc = next_entry(buf32, fp, sizeof(u32));
>  	if (rc < 0) {
> -		printk("security: avtab: truncated entry\n");
> +		printk("SELinux: avtab: truncated entry\n");
>  		return -1;
>  	}
>  	datum.data = le32_to_cpu(*buf32);
>  	if ((key.specified & AVTAB_TYPE) &&
>  	    !policydb_type_isvalid(pol, datum.data)) {
> -		printk(KERN_WARNING "security: avtab: invalid type\n");
> +		printk(KERN_WARNING "SELinux: avtab: invalid type\n");
>  		return -1;
>  	}
>  	return insertf(a, &key, &datum, p);
> @@ -468,12 +468,12 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
>  
>  	rc = next_entry(buf, fp, sizeof(u32));
>  	if (rc < 0) {
> -		printk(KERN_ERR "security: avtab: truncated table\n");
> +		printk(KERN_ERR "SELinux: avtab: truncated table\n");
>  		goto bad;
>  	}
>  	nel = le32_to_cpu(buf[0]);
>  	if (!nel) {
> -		printk(KERN_ERR "security: avtab: table is empty\n");
> +		printk(KERN_ERR "SELinux: avtab: table is empty\n");
>  		rc = -EINVAL;
>  		goto bad;
>  	}
> @@ -486,9 +486,9 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
>  		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
>  		if (rc) {
>  			if (rc == -ENOMEM)
> -				printk(KERN_ERR "security: avtab: out of memory\n");
> +				printk(KERN_ERR "SELinux: avtab: out of memory\n");
>  			else if (rc == -EEXIST)
> -				printk(KERN_ERR "security: avtab: duplicate entry\n");
> +				printk(KERN_ERR "SELinux: avtab: duplicate entry\n");
>  			else
>  				rc = -EINVAL;
>  			goto bad;
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 50ad85d..a996cf1 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -96,7 +96,7 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
>  	if (new_state != node->cur_state) {
>  		node->cur_state = new_state;
>  		if (new_state == -1)
> -			printk(KERN_ERR "security: expression result was undefined - disabling all rules.\n");
> +			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
>  		/* turn the rules on or off */
>  		for (cur = node->true_list; cur != NULL; cur = cur->next) {
>  			if (new_state <= 0) {
> @@ -276,7 +276,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>  	 */
>  	if (k->specified & AVTAB_TYPE) {
>  		if (avtab_search(&p->te_avtab, k)) {
> -			printk("security: type rule already exists outside of a conditional.");
> +			printk("SELinux: type rule already exists outside of a conditional.");
>  			goto err;
>  		}
>  		/*
> @@ -291,7 +291,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>  			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
>  			if (node_ptr) {
>  				if (avtab_search_node_next(node_ptr, k->specified)) {
> -					printk("security: too many conflicting type rules.");
> +					printk("SELinux: too many conflicting type rules.");
>  					goto err;
>  				}
>  				found = 0;
> @@ -302,13 +302,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>  					}
>  				}
>  				if (!found) {
> -					printk("security: conflicting type rules.\n");
> +					printk("SELinux: conflicting type rules.\n");
>  					goto err;
>  				}
>  			}
>  		} else {
>  			if (avtab_search(&p->te_cond_avtab, k)) {
> -				printk("security: conflicting type rules when adding type rule for true.\n");
> +				printk("SELinux: conflicting type rules when adding type rule for true.\n");
>  				goto err;
>  			}
>  		}
> @@ -316,7 +316,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
>  
>  	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
>  	if (!node_ptr) {
> -		printk("security: could not insert rule.");
> +		printk("SELinux: could not insert rule.");
>  		goto err;
>  	}
>  
> @@ -376,12 +376,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
>  static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
>  {
>  	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
> -		printk("security: conditional expressions uses unknown operator.\n");
> +		printk("SELinux: conditional expressions uses unknown operator.\n");
>  		return 0;
>  	}
>  
>  	if (expr->bool > p->p_bools.nprim) {
> -		printk("security: conditional expressions uses unknown bool.\n");
> +		printk("SELinux: conditional expressions uses unknown bool.\n");
>  		return 0;
>  	}
>  	return 1;
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 920b5e3..e499af4 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -364,7 +364,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  	count = le32_to_cpu(buf[2]);
>  
>  	if (mapunit != sizeof(u64) * 8) {
> -		printk(KERN_ERR "security: ebitmap: map size %u does not "
> +		printk(KERN_ERR "SELinux: ebitmap: map size %u does not "
>  		       "match my size %Zd (high bit was %d)\n",
>  		       mapunit, sizeof(u64) * 8, e->highbit);
>  		goto bad;
> @@ -382,19 +382,19 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  	for (i = 0; i < count; i++) {
>  		rc = next_entry(&startbit, fp, sizeof(u32));
>  		if (rc < 0) {
> -			printk(KERN_ERR "security: ebitmap: truncated map\n");
> +			printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
>  			goto bad;
>  		}
>  		startbit = le32_to_cpu(startbit);
>  
>  		if (startbit & (mapunit - 1)) {
> -			printk(KERN_ERR "security: ebitmap start bit (%d) is "
> +			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
>  			       "not a multiple of the map unit size (%u)\n",
>  			       startbit, mapunit);
>  			goto bad;
>  		}
>  		if (startbit > e->highbit - mapunit) {
> -			printk(KERN_ERR "security: ebitmap start bit (%d) is "
> +			printk(KERN_ERR "SELinux: ebitmap start bit (%d) is "
>  			       "beyond the end of the bitmap (%u)\n",
>  			       startbit, (e->highbit - mapunit));
>  			goto bad;
> @@ -405,7 +405,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  			tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
>  			if (!tmp) {
>  				printk(KERN_ERR
> -				       "security: ebitmap: out of memory\n");
> +				       "SELinux: ebitmap: out of memory\n");
>  				rc = -ENOMEM;
>  				goto bad;
>  			}
> @@ -418,7 +418,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  			}
>  			n = tmp;
>  		} else if (startbit <= n->startbit) {
> -			printk(KERN_ERR "security: ebitmap: start bit %d"
> +			printk(KERN_ERR "SELinux: ebitmap: start bit %d"
>  			       " comes after start bit %d\n",
>  			       startbit, n->startbit);
>  			goto bad;
> @@ -426,7 +426,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>  
>  		rc = next_entry(&map, fp, sizeof(u64));
>  		if (rc < 0) {
> -			printk(KERN_ERR "security: ebitmap: truncated map\n");
> +			printk(KERN_ERR "SELinux: ebitmap: truncated map\n");
>  			goto bad;
>  		}
>  		map = le64_to_cpu(map);
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index bd7d6a0..9272065 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -401,14 +401,14 @@ static int policydb_index_others(struct policydb *p)
>  {
>  	int i, rc = 0;
>  
> -	printk(KERN_DEBUG "security:  %d users, %d roles, %d types, %d bools",
> +	printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
>  	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
>  	if (selinux_mls_enabled)
>  		printk(", %d sens, %d cats", p->p_levels.nprim,
>  		       p->p_cats.nprim);
>  	printk("\n");
>  
> -	printk(KERN_DEBUG "security:  %d classes, %d rules\n",
> +	printk(KERN_DEBUG "SELinux:  %d classes, %d rules\n",
>  	       p->p_classes.nprim, p->te_avtab.nel);
>  
>  #ifdef DEBUG_HASHES
> @@ -702,20 +702,20 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
>  
>  	rc = sidtab_init(s);
>  	if (rc) {
> -		printk(KERN_ERR "security:  out of memory on SID table init\n");
> +		printk(KERN_ERR "SELinux:  out of memory on SID table init\n");
>  		goto out;
>  	}
>  
>  	head = p->ocontexts[OCON_ISID];
>  	for (c = head; c; c = c->next) {
>  		if (!c->context[0].user) {
> -			printk(KERN_ERR "security:  SID %s was never "
> +			printk(KERN_ERR "SELinux:  SID %s was never "
>  			       "defined.\n", c->u.name);
>  			rc = -EINVAL;
>  			goto out;
>  		}
>  		if (sidtab_insert(s, c->sid[0], &c->context[0])) {
> -			printk(KERN_ERR "security:  unable to load initial "
> +			printk(KERN_ERR "SELinux:  unable to load initial "
>  			       "SID %s.\n", c->u.name);
>  			rc = -EINVAL;
>  			goto out;
> @@ -809,13 +809,13 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
>  
>  	items = le32_to_cpu(buf[0]);
>  	if (items > ARRAY_SIZE(buf)) {
> -		printk(KERN_ERR "security: mls:  range overflow\n");
> +		printk(KERN_ERR "SELinux: mls:  range overflow\n");
>  		rc = -EINVAL;
>  		goto out;
>  	}
>  	rc = next_entry(buf, fp, sizeof(u32) * items);
>  	if (rc < 0) {
> -		printk(KERN_ERR "security: mls:  truncated range\n");
> +		printk(KERN_ERR "SELinux: mls:  truncated range\n");
>  		goto out;
>  	}
>  	r->level[0].sens = le32_to_cpu(buf[0]);
> @@ -826,21 +826,21 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
>  
>  	rc = ebitmap_read(&r->level[0].cat, fp);
>  	if (rc) {
> -		printk(KERN_ERR "security: mls:  error reading low "
> +		printk(KERN_ERR "SELinux: mls:  error reading low "
>  		       "categories\n");
>  		goto out;
>  	}
>  	if (items > 1) {
>  		rc = ebitmap_read(&r->level[1].cat, fp);
>  		if (rc) {
> -			printk(KERN_ERR "security: mls:  error reading high "
> +			printk(KERN_ERR "SELinux: mls:  error reading high "
>  			       "categories\n");
>  			goto bad_high;
>  		}
>  	} else {
>  		rc = ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
>  		if (rc) {
> -			printk(KERN_ERR "security: mls:  out of memory\n");
> +			printk(KERN_ERR "SELinux: mls:  out of memory\n");
>  			goto bad_high;
>  		}
>  	}
> @@ -866,7 +866,7 @@ static int context_read_and_validate(struct context *c,
>  
>  	rc = next_entry(buf, fp, sizeof buf);
>  	if (rc < 0) {
> -		printk(KERN_ERR "security: context truncated\n");
> +		printk(KERN_ERR "SELinux: context truncated\n");
>  		goto out;
>  	}
>  	c->user = le32_to_cpu(buf[0]);
> @@ -874,7 +874,7 @@ static int context_read_and_validate(struct context *c,
>  	c->type = le32_to_cpu(buf[2]);
>  	if (p->policyvers >= POLICYDB_VERSION_MLS) {
>  		if (mls_read_range_helper(&c->range, fp)) {
> -			printk(KERN_ERR "security: error reading MLS range of "
> +			printk(KERN_ERR "SELinux: error reading MLS range of "
>  			       "context\n");
>  			rc = -EINVAL;
>  			goto out;
> @@ -882,7 +882,7 @@ static int context_read_and_validate(struct context *c,
>  	}
>  
>  	if (!policydb_context_isvalid(p, c)) {
> -		printk(KERN_ERR "security:  invalid security context\n");
> +		printk(KERN_ERR "SELinux:  invalid security context\n");
>  		context_destroy(c);
>  		rc = -EINVAL;
>  	}
> @@ -1128,7 +1128,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
>  		cladatum->comdatum = hashtab_search(p->p_commons.table,
>  						    cladatum->comkey);
>  		if (!cladatum->comdatum) {
> -			printk(KERN_ERR "security:  unknown common %s\n",
> +			printk(KERN_ERR "SELinux:  unknown common %s\n",
>  			       cladatum->comkey);
>  			rc = -EINVAL;
>  			goto bad;
> @@ -1283,13 +1283,13 @@ static int mls_read_level(struct mls_level *lp, void *fp)
>  
>  	rc = next_entry(buf, fp, sizeof buf);
>  	if (rc < 0) {
> -		printk(KERN_ERR "security: mls: truncated level\n");
> +		printk(KERN_ERR "SELinux: mls: truncated level\n");
>  		goto bad;
>  	}
>  	lp->sens = le32_to_cpu(buf[0]);
>  
>  	if (ebitmap_read(&lp->cat, fp)) {
> -		printk(KERN_ERR "security: mls:  error reading level "
> +		printk(KERN_ERR "SELinux: mls:  error reading level "
>  		       "categories\n");
>  		goto bad;
>  	}
> @@ -1491,7 +1491,7 @@ int policydb_read(struct policydb *p, void *fp)
>  		goto bad;
>  
>  	if (le32_to_cpu(buf[0]) != POLICYDB_MAGIC) {
> -		printk(KERN_ERR "security:  policydb magic number 0x%x does "
> +		printk(KERN_ERR "SELinux:  policydb magic number 0x%x does "
>  		       "not match expected magic number 0x%x\n",
>  		       le32_to_cpu(buf[0]), POLICYDB_MAGIC);
>  		goto bad;
> @@ -1499,27 +1499,27 @@ int policydb_read(struct policydb *p, void *fp)
>  
>  	len = le32_to_cpu(buf[1]);
>  	if (len != strlen(POLICYDB_STRING)) {
> -		printk(KERN_ERR "security:  policydb string length %d does not "
> +		printk(KERN_ERR "SELinux:  policydb string length %d does not "
>  		       "match expected length %Zu\n",
>  		       len, strlen(POLICYDB_STRING));
>  		goto bad;
>  	}
>  	policydb_str = kmalloc(len + 1,GFP_KERNEL);
>  	if (!policydb_str) {
> -		printk(KERN_ERR "security:  unable to allocate memory for policydb "
> +		printk(KERN_ERR "SELinux:  unable to allocate memory for policydb "
>  		       "string of length %d\n", len);
>  		rc = -ENOMEM;
>  		goto bad;
>  	}
>  	rc = next_entry(policydb_str, fp, len);
>  	if (rc < 0) {
> -		printk(KERN_ERR "security:  truncated policydb string identifier\n");
> +		printk(KERN_ERR "SELinux:  truncated policydb string identifier\n");
>  		kfree(policydb_str);
>  		goto bad;
>  	}
>  	policydb_str[len] = 0;
>  	if (strcmp(policydb_str, POLICYDB_STRING)) {
> -		printk(KERN_ERR "security:  policydb string %s does not match "
> +		printk(KERN_ERR "SELinux:  policydb string %s does not match "
>  		       "my string %s\n", policydb_str, POLICYDB_STRING);
>  		kfree(policydb_str);
>  		goto bad;
> @@ -1536,7 +1536,7 @@ int policydb_read(struct policydb *p, void *fp)
>  	p->policyvers = le32_to_cpu(buf[0]);
>  	if (p->policyvers < POLICYDB_VERSION_MIN ||
>  	    p->policyvers > POLICYDB_VERSION_MAX) {
> -	    	printk(KERN_ERR "security:  policydb version %d does not match "
> +	    	printk(KERN_ERR "SELinux:  policydb version %d does not match "
>  	    	       "my version range %d-%d\n",
>  	    	       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
>  	    	goto bad;
> @@ -1572,14 +1572,14 @@ int policydb_read(struct policydb *p, void *fp)
>  
>  	info = policydb_lookup_compat(p->policyvers);
>  	if (!info) {
> -		printk(KERN_ERR "security:  unable to find policy compat info "
> +		printk(KERN_ERR "SELinux:  unable to find policy compat info "
>  		       "for version %d\n", p->policyvers);
>  		goto bad;
>  	}
>  
>  	if (le32_to_cpu(buf[2]) != info->sym_num ||
>  		le32_to_cpu(buf[3]) != info->ocon_num) {
> -		printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
> +		printk(KERN_ERR "SELinux:  policydb table sizes (%d,%d) do "
>  		       "not match mine (%d,%d)\n", le32_to_cpu(buf[2]),
>  			le32_to_cpu(buf[3]),
>  		       info->sym_num, info->ocon_num);
> @@ -1823,7 +1823,7 @@ int policydb_read(struct policydb *p, void *fp)
>  		for (genfs_p = NULL, genfs = p->genfs; genfs;
>  		     genfs_p = genfs, genfs = genfs->next) {
>  			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
> -				printk(KERN_ERR "security:  dup genfs "
> +				printk(KERN_ERR "SELinux:  dup genfs "
>  				       "fstype %s\n", newgenfs->fstype);
>  				kfree(newgenfs->fstype);
>  				kfree(newgenfs);
> @@ -1873,7 +1873,7 @@ int policydb_read(struct policydb *p, void *fp)
>  				if (!strcmp(newc->u.name, c->u.name) &&
>  				    (!c->v.sclass || !newc->v.sclass ||
>  				     newc->v.sclass == c->v.sclass)) {
> -					printk(KERN_ERR "security:  dup genfs "
> +					printk(KERN_ERR "SELinux:  dup genfs "
>  					       "entry (%s,%s)\n",
>  					       newgenfs->fstype, c->u.name);
>  					goto bad_newc;
> @@ -1931,7 +1931,7 @@ int policydb_read(struct policydb *p, void *fp)
>  			if (rc)
>  				goto bad;
>  			if (!mls_range_isvalid(p, &rt->target_range)) {
> -				printk(KERN_WARNING "security:  rangetrans:  invalid range\n");
> +				printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
>  				goto bad;
>  			}
>  			lrt = rt;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index f374186..07ac67c 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1094,7 +1094,7 @@ static int validate_classes(struct policydb *p)
>  			continue;
>  		if (i > p->p_classes.nprim) {
>  			printk(KERN_INFO
> -			       "security:  class %s not defined in policy\n",
> +			       "SELinux:  class %s not defined in policy\n",
>  			       def_class);
>  			if (p->reject_unknown)
>  				return -EINVAL;
> @@ -1105,7 +1105,7 @@ static int validate_classes(struct policydb *p)
>  		pol_class = p->p_class_val_to_name[i-1];
>  		if (strcmp(pol_class, def_class)) {
>  			printk(KERN_ERR
> -			       "security:  class %d is incorrect, found %s but should be %s\n",
> +			       "SELinux:  class %d is incorrect, found %s but should be %s\n",
>  			       i, pol_class, def_class);
>  			return -EINVAL;
>  		}
> @@ -1123,7 +1123,7 @@ static int validate_classes(struct policydb *p)
>  		nprim = 1 << (perms->nprim - 1);
>  		if (perm_val > nprim) {
>  			printk(KERN_INFO
> -			       "security:  permission %s in class %s not defined in policy\n",
> +			       "SELinux:  permission %s in class %s not defined in policy\n",
>  			       def_perm, pol_class);
>  			if (p->reject_unknown)
>  				return -EINVAL;
> @@ -1134,14 +1134,14 @@ static int validate_classes(struct policydb *p)
>  		perdatum = hashtab_search(perms->table, def_perm);
>  		if (perdatum == NULL) {
>  			printk(KERN_ERR
> -			       "security:  permission %s in class %s not found in policy, bad policy\n",
> +			       "SELinux:  permission %s in class %s not found in policy, bad policy\n",
>  			       def_perm, pol_class);
>  			return -EINVAL;
>  		}
>  		pol_val = 1 << (perdatum->value - 1);
>  		if (pol_val != perm_val) {
>  			printk(KERN_ERR
> -			       "security:  permission %s in class %s has incorrect value\n",
> +			       "SELinux:  permission %s in class %s has incorrect value\n",
>  			       def_perm, pol_class);
>  			return -EINVAL;
>  		}
> @@ -1155,7 +1155,7 @@ static int validate_classes(struct policydb *p)
>  		BUG_ON(!cladatum);
>  		if (!cladatum->comdatum) {
>  			printk(KERN_ERR
> -			       "security:  class %s should have an inherits clause but does not\n",
> +			       "SELinux:  class %s should have an inherits clause but does not\n",
>  			       pol_class);
>  			return -EINVAL;
>  		}
> @@ -1170,7 +1170,7 @@ static int validate_classes(struct policydb *p)
>  			def_perm = kdefs->av_inherit[i].common_pts[j];
>  			if (j >= perms->nprim) {
>  				printk(KERN_INFO
> -				       "security:  permission %s in class %s not defined in policy\n",
> +				       "SELinux:  permission %s in class %s not defined in policy\n",
>  				       def_perm, pol_class);
>  				if (p->reject_unknown)
>  					return -EINVAL;
> @@ -1181,13 +1181,13 @@ static int validate_classes(struct policydb *p)
>  			perdatum = hashtab_search(perms->table, def_perm);
>  			if (perdatum == NULL) {
>  				printk(KERN_ERR
> -				       "security:  permission %s in class %s not found in policy, bad policy\n",
> +				       "SELinux:  permission %s in class %s not found in policy, bad policy\n",
>  				       def_perm, pol_class);
>  				return -EINVAL;
>  			}
>  			if (perdatum->value != j + 1) {
>  				printk(KERN_ERR
> -				       "security:  permission %s in class %s has incorrect value\n",
> +				       "SELinux:  permission %s in class %s has incorrect value\n",
>  				       def_perm, pol_class);
>  				return -EINVAL;
>  			}
> @@ -1217,7 +1217,7 @@ static inline int convert_context_handle_invalid_context(struct context *context
>  		u32 len;
>  
>  		context_struct_to_string(context, &s, &len);
> -		printk(KERN_ERR "security:  context %s is invalid\n", s);
> +		printk(KERN_ERR "SELinux:  context %s is invalid\n", s);
>  		kfree(s);
>  	}
>  	return rc;
> @@ -1297,7 +1297,7 @@ out:
>  bad:
>  	context_struct_to_string(&oldc, &s, &len);
>  	context_destroy(&oldc);
> -	printk(KERN_ERR "security:  invalidating context %s\n", s);
> +	printk(KERN_ERR "SELinux:  invalidating context %s\n", s);
>  	kfree(s);
>  	goto out;
>  }
> @@ -1348,7 +1348,7 @@ int security_load_policy(void *data, size_t len)
>  		/* Verify that the kernel defined classes are correct. */
>  		if (validate_classes(&policydb)) {
>  			printk(KERN_ERR
> -			       "security:  the definition of a class is incorrect\n");
> +			       "SELinux:  the definition of a class is incorrect\n");
>  			LOAD_UNLOCK;
>  			sidtab_destroy(&sidtab);
>  			policydb_destroy(&policydb);
> @@ -1382,14 +1382,14 @@ int security_load_policy(void *data, size_t len)
>  	/* Verify that the kernel defined classes are correct. */
>  	if (validate_classes(&newpolicydb)) {
>  		printk(KERN_ERR
> -		       "security:  the definition of a class is incorrect\n");
> +		       "SELinux:  the definition of a class is incorrect\n");
>  		rc = -EINVAL;
>  		goto err;
>  	}
>  
>  	rc = security_preserve_bools(&newpolicydb);
>  	if (rc) {
> -		printk(KERN_ERR "security:  unable to preserve booleans\n");
> +		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
>  		goto err;
>  	}
>  
> -- 
> 1.5.4.2
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
