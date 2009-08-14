Subject: Re: [PATCH 2/2 -v3] Namespacing of security/selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1247003356.2149.3.camel@Ares>
References: <1247003356.2149.3.camel@Ares>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 11:24:52 -0400
Message-Id: <1250263492.3629.39.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-07 at 17:49 -0400, Thomas Liu wrote:
> Second namespacing patch, adding sel_ for the global variables
> ss_initialized and policydb.

This patch looks fine to me.  But I think it would be more useful to go
one step beyond and do what I suggested in the original kernel todo
item, i.e. wrap the active policydb and sidtab in a single
heap-allocated container struct, and introduce a single active policy
pointer to that struct.  Then on policy reload, we get to switch from
the old policy/sidtab to the new one just by atomically setting a single
pointer.  At the same time you could address the false kmemleak warning
during policy reload since you would be rewriting the policy reload
logic, so the new policydb and sidtab would get allocated on the heap
and we wouldn't have the temporary copy on the stack.

> Signed-off-by: Thomas Liu <tliu@redhat.com>
> ---
>  Some lines in this patch are over 80 characters, but breaking them
>  would possibly make the code more confusing. The longest line is 
>  88 characters.
>  security/selinux/hooks.c       |   12 +-
>  security/selinux/ss/mls.c      |   20 ++--
>  security/selinux/ss/policydb.c |    6 +-
>  security/selinux/ss/services.c |  198 ++++++++++++++++++++--------------------
>  security/selinux/ss/services.h |    2 +-
>  5 files changed, 119 insertions(+), 119 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9d27178..c4653ce 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -326,7 +326,7 @@ static void sk_free_security(struct sock *sk)
>  
>  /* The security server must be initialized before
>     any labeling or access decisions can be provided. */
> -extern int ss_initialized;
> +extern int sel_ss_initialized;
>  
>  /* The file system's label must be initialized prior to use. */
>  
> @@ -497,7 +497,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return -EINVAL;
>  
> -	if (!ss_initialized)
> +	if (!sel_ss_initialized)
>  		return -EINVAL;
>  
>  	tmp = sbsec->flags & SE_MNTMASK;
> @@ -610,7 +610,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  
>  	mutex_lock(&sbsec->lock);
>  
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		if (!num_opts) {
>  			/* Defer initialization until selinux_complete_init,
>  			   after the initial policy is loaded and the security
> @@ -814,7 +814,7 @@ static void selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  	 * mount options.  thus we can safely put this sb on the list and deal
>  	 * with it later
>  	 */
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		spin_lock(&sb_security_lock);
>  		if (list_empty(&newsbsec->list))
>  			list_add(&newsbsec->list, &superblock_security_head);
> @@ -2618,7 +2618,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  		isec->initialized = 1;
>  	}
>  
> -	if (!ss_initialized || !(sbsec->flags & SE_SBLABELSUPP))
> +	if (!sel_ss_initialized || !(sbsec->flags & SE_SBLABELSUPP))
>  		return -EOPNOTSUPP;
>  
>  	if (name) {
> @@ -5670,7 +5670,7 @@ int selinux_disable(void)
>  {
>  	extern void exit_sel_fs(void);
>  
> -	if (ss_initialized) {
> +	if (sel_ss_initialized) {
>  		/* Not permitted after initial policy load. */
>  		return -EINVAL;
>  	}
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index b5407f1..8eda9bb 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -45,7 +45,7 @@ int mls_compute_context_len(struct context *context)
>  	len = 1; /* for the beginning ":" */
>  	for (l = 0; l < 2; l++) {
>  		int index_sens = context->range.level[l].sens;
> -		len += strlen(policydb.p_sens_val_to_name[index_sens - 1]);
> +		len += strlen(sel_policydb.p_sens_val_to_name[index_sens - 1]);
>  
>  		/* categories */
>  		head = -2;
> @@ -55,17 +55,17 @@ int mls_compute_context_len(struct context *context)
>  			if (i - prev > 1) {
>  				/* one or more negative bits are skipped */
>  				if (head != prev) {
> -					nm = policydb.p_cat_val_to_name[prev];
> +					nm = sel_policydb.p_cat_val_to_name[prev];
>  					len += strlen(nm) + 1;
>  				}
> -				nm = policydb.p_cat_val_to_name[i];
> +				nm = sel_policydb.p_cat_val_to_name[i];
>  				len += strlen(nm) + 1;
>  				head = i;
>  			}
>  			prev = i;
>  		}
>  		if (prev != head) {
> -			nm = policydb.p_cat_val_to_name[prev];
> +			nm = sel_policydb.p_cat_val_to_name[prev];
>  			len += strlen(nm) + 1;
>  		}
>  		if (l == 0) {
> @@ -103,7 +103,7 @@ void mls_sid_to_context(struct context *context,
>  
>  	for (l = 0; l < 2; l++) {
>  		strcpy(scontextp,
> -		       policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
> +		       sel_policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
>  		scontextp += strlen(scontextp);
>  
>  		/* categories */
> @@ -118,7 +118,7 @@ void mls_sid_to_context(struct context *context,
>  						*scontextp++ = '.';
>  					else
>  						*scontextp++ = ',';
> -					nm = policydb.p_cat_val_to_name[prev];
> +					nm = sel_policydb.p_cat_val_to_name[prev];
>  					strcpy(scontextp, nm);
>  					scontextp += strlen(nm);
>  				}
> @@ -126,7 +126,7 @@ void mls_sid_to_context(struct context *context,
>  					*scontextp++ = ':';
>  				else
>  					*scontextp++ = ',';
> -				nm = policydb.p_cat_val_to_name[i];
> +				nm = sel_policydb.p_cat_val_to_name[i];
>  				strcpy(scontextp, nm);
>  				scontextp += strlen(nm);
>  				head = i;
> @@ -139,7 +139,7 @@ void mls_sid_to_context(struct context *context,
>  				*scontextp++ = '.';
>  			else
>  				*scontextp++ = ',';
> -			nm = policydb.p_cat_val_to_name[prev];
> +			nm = sel_policydb.p_cat_val_to_name[prev];
>  			strcpy(scontextp, nm);
>  			scontextp += strlen(nm);
>  		}
> @@ -396,7 +396,7 @@ int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
>  	if (!tmpstr) {
>  		rc = -ENOMEM;
>  	} else {
> -		rc = mls_context_to_sid(&policydb, ':', &tmpstr, context,
> +		rc = mls_context_to_sid(&sel_policydb, ':', &tmpstr, context,
>  					NULL, SECSID_NULL);
>  		kfree(freestr);
>  	}
> @@ -521,7 +521,7 @@ int mls_compute_sid(struct context *scontext,
>  	switch (specified) {
>  	case AVTAB_TRANSITION:
>  		/* Look for a range transition rule. */
> -		for (rtr = policydb.range_tr; rtr; rtr = rtr->next) {
> +		for (rtr = sel_policydb.range_tr; rtr; rtr = rtr->next) {
>  			if (rtr->source_type == scontext->type &&
>  			    rtr->target_type == tcontext->type &&
>  			    rtr->target_class == tclass) {
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 72e4a54..381ee0f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1638,7 +1638,7 @@ static int policydb_bounds_sanity_check(struct policydb *p)
>  	return 0;
>  }
>  
> -extern int ss_initialized;
> +extern int sel_ss_initialized;
>  
>  /*
>   * Read the configuration data from a policy database binary
> @@ -1722,7 +1722,7 @@ int policydb_read(struct policydb *p, void *fp)
>  	}
>  
>  	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
> -		if (ss_initialized && !selinux_mls_enabled) {
> +		if (sel_ss_initialized && !selinux_mls_enabled) {
>  			printk(KERN_ERR "SELinux: Cannot switch between non-MLS"
>  				" and MLS policies\n");
>  			goto bad;
> @@ -1737,7 +1737,7 @@ int policydb_read(struct policydb *p, void *fp)
>  			goto bad;
>  		}
>  	} else {
> -		if (ss_initialized && selinux_mls_enabled) {
> +		if (sel_ss_initialized && selinux_mls_enabled) {
>  			printk(KERN_ERR "SELinux: Cannot switch between MLS and"
>  				" non-MLS policies\n");
>  			goto bad;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 988fef6..ae412ed 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -78,8 +78,8 @@ extern const struct selinux_class_perm selinux_class_perm;
>  static DEFINE_RWLOCK(policy_rwlock);
>  
>  static struct sidtab sidtab;
> -struct policydb policydb;
> -int ss_initialized;
> +struct policydb sel_policydb;
> +int sel_ss_initialized;
>  
>  /*
>   * The largest sequence number that has been used when
> @@ -153,8 +153,8 @@ static int constraint_expr_eval(struct context *scontext,
>  			case CEXPR_ROLE:
>  				val1 = scontext->role;
>  				val2 = tcontext->role;
> -				r1 = policydb.role_val_to_struct[val1 - 1];
> -				r2 = policydb.role_val_to_struct[val2 - 1];
> +				r1 = sel_policydb.role_val_to_struct[val1 - 1];
> +				r2 = sel_policydb.role_val_to_struct[val2 - 1];
>  				switch (e->op) {
>  				case CEXPR_DOM:
>  					s[++sp] = ebitmap_get_bit(&r1->dominates,
> @@ -318,8 +318,8 @@ static void security_dump_masked_av(struct context *scontext,
>  	if (!permissions)
>  		return;
>  
> -	tclass_name = policydb.p_class_val_to_name[tclass - 1];
> -	tclass_dat = policydb.class_val_to_struct[tclass - 1];
> +	tclass_name = sel_policydb.p_class_val_to_name[tclass - 1];
> +	tclass_dat = sel_policydb.class_val_to_struct[tclass - 1];
>  	common_dat = tclass_dat->comdatum;
>  
>  	/* init permission_names */
> @@ -386,9 +386,9 @@ static void type_attribute_bounds_av(struct context *scontext,
>  	struct context lo_tcontext;
>  	struct av_decision lo_avd;
>  	struct type_datum *source
> -		= policydb.type_val_to_struct[scontext->type - 1];
> +		= sel_policydb.type_val_to_struct[scontext->type - 1];
>  	struct type_datum *target
> -		= policydb.type_val_to_struct[tcontext->type - 1];
> +		= sel_policydb.type_val_to_struct[tcontext->type - 1];
>  	u32 masked = 0;
>  
>  	if (source->bounds) {
> @@ -499,26 +499,26 @@ static int context_struct_compute_av(struct context *scontext,
>  	 */
>  	if (unlikely(!tclass))
>  		goto inval_class;
> -	if (unlikely(tclass > policydb.p_classes.nprim))
> +	if (unlikely(tclass > sel_policydb.p_classes.nprim))
>  		if (tclass > kdefs->cts_len ||
>  		    !kdefs->class_to_string[tclass] ||
> -		    !policydb.allow_unknown)
> +		    !sel_policydb.allow_unknown)
>  			goto inval_class;
>  
>  	/*
>  	 * Kernel class and we allow unknown so pad the allow decision
>  	 * the pad will be all 1 for unknown classes.
>  	 */
> -	if (tclass <= kdefs->cts_len && policydb.allow_unknown)
> -		avd->allowed = policydb.undefined_perms[tclass - 1];
> +	if (tclass <= kdefs->cts_len && sel_policydb.allow_unknown)
> +		avd->allowed = sel_policydb.undefined_perms[tclass - 1];
>  
>  	/*
>  	 * Not in policy. Since decision is completed (all 1 or all 0) return.
>  	 */
> -	if (unlikely(tclass > policydb.p_classes.nprim))
> +	if (unlikely(tclass > sel_policydb.p_classes.nprim))
>  		return 0;
>  
> -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +	tclass_datum = sel_policydb.class_val_to_struct[tclass - 1];
>  
>  	/*
>  	 * If a specific type enforcement rule was defined for
> @@ -526,13 +526,13 @@ static int context_struct_compute_av(struct context *scontext,
>  	 */
>  	avkey.target_class = tclass;
>  	avkey.specified = AVTAB_AV;
> -	sattr = &policydb.type_attr_map[scontext->type - 1];
> -	tattr = &policydb.type_attr_map[tcontext->type - 1];
> +	sattr = &sel_policydb.type_attr_map[scontext->type - 1];
> +	tattr = &sel_policydb.type_attr_map[tcontext->type - 1];
>  	ebitmap_for_each_positive_bit(sattr, snode, i) {
>  		ebitmap_for_each_positive_bit(tattr, tnode, j) {
>  			avkey.source_type = i + 1;
>  			avkey.target_type = j + 1;
> -			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
> +			for (node = avtab_search_node(&sel_policydb.te_avtab, &avkey);
>  			     node;
>  			     node = avtab_search_node_next(node, avkey.specified)) {
>  				if (node->key.specified == AVTAB_ALLOWED)
> @@ -544,7 +544,7 @@ static int context_struct_compute_av(struct context *scontext,
>  			}
>  
>  			/* Check conditional av table for additional permissions */
> -			cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
> +			cond_compute_av(&sel_policydb.te_cond_avtab, &avkey, avd);
>  
>  		}
>  	}
> @@ -571,7 +571,7 @@ static int context_struct_compute_av(struct context *scontext,
>  	if (tclass == SECCLASS_PROCESS &&
>  	    (avd->allowed & (PROCESS__TRANSITION | PROCESS__DYNTRANSITION)) &&
>  	    scontext->role != tcontext->role) {
> -		for (ra = policydb.role_allow; ra; ra = ra->next) {
> +		for (ra = sel_policydb.role_allow; ra; ra = ra->next) {
>  			if (scontext->role == ra->role &&
>  			    tcontext->role == ra->new_role)
>  				break;
> @@ -624,7 +624,7 @@ static int security_validtrans_handle_fail(struct context *ocontext,
>  	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
>  		  "sel_validate_transition:  denied for"
>  		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
> -		  o, n, t, policydb.p_class_val_to_name[tclass-1]);
> +		  o, n, t, sel_policydb.p_class_val_to_name[tclass-1]);
>  out:
>  	kfree(o);
>  	kfree(n);
> @@ -645,7 +645,7 @@ int sel_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>  	struct constraint_node *constraint;
>  	int rc = 0;
>  
> -	if (!ss_initialized)
> +	if (!sel_ss_initialized)
>  		return 0;
>  
>  	read_lock(&policy_rwlock);
> @@ -661,13 +661,13 @@ int sel_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
>  			tclass = SECCLASS_NETLINK_SOCKET;
>  
> -	if (!tclass || tclass > policydb.p_classes.nprim) {
> +	if (!tclass || tclass > sel_policydb.p_classes.nprim) {
>  		printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n",
>  			__func__, tclass);
>  		rc = -EINVAL;
>  		goto out;
>  	}
> -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> +	tclass_datum = sel_policydb.class_val_to_struct[tclass - 1];
>  
>  	ocontext = sidtab_search(&sidtab, oldsid);
>  	if (!ocontext) {
> @@ -749,7 +749,7 @@ int sel_bounded_transition(u32 old_sid, u32 new_sid)
>  
>  	index = new_context->type;
>  	while (true) {
> -		type = policydb.type_val_to_struct[index - 1];
> +		type = sel_policydb.type_val_to_struct[index - 1];
>  		BUG_ON(!type);
>  
>  		/* not bounded anymore */
> @@ -814,7 +814,7 @@ int sel_compute_av(u32 ssid,
>  	struct context *scontext = NULL, *tcontext = NULL;
>  	int rc = 0;
>  
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		avd->allowed = 0xffffffff;
>  		avd->auditallow = 0;
>  		avd->auditdeny = 0xffffffff;
> @@ -843,7 +843,7 @@ int sel_compute_av(u32 ssid,
>  				       requested, avd);
>  
>  	/* permissive domain? */
> -	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> +	if (ebitmap_get_bit(&sel_policydb.permissive_map, scontext->type))
>  	    avd->flags |= AVD_FLAGS_PERMISSIVE;
>  out:
>  	read_unlock(&policy_rwlock);
> @@ -873,9 +873,9 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
>  	}
>  
>  	/* Compute the size of the context. */
> -	*scontext_len += strlen(policydb.p_user_val_to_name[context->user - 1]) + 1;
> -	*scontext_len += strlen(policydb.p_role_val_to_name[context->role - 1]) + 1;
> -	*scontext_len += strlen(policydb.p_type_val_to_name[context->type - 1]) + 1;
> +	*scontext_len += strlen(sel_policydb.p_user_val_to_name[context->user - 1]) + 1;
> +	*scontext_len += strlen(sel_policydb.p_role_val_to_name[context->role - 1]) + 1;
> +	*scontext_len += strlen(sel_policydb.p_type_val_to_name[context->type - 1]) + 1;
>  	*scontext_len += mls_compute_context_len(context);
>  
>  	/* Allocate space for the context; caller must free this space. */
> @@ -888,12 +888,12 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
>  	 * Copy the user name, role name and type name into the context.
>  	 */
>  	sprintf(scontextp, "%s:%s:%s",
> -		policydb.p_user_val_to_name[context->user - 1],
> -		policydb.p_role_val_to_name[context->role - 1],
> -		policydb.p_type_val_to_name[context->type - 1]);
> -	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
> -		     1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
> -		     1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
> +		sel_policydb.p_user_val_to_name[context->user - 1],
> +		sel_policydb.p_role_val_to_name[context->role - 1],
> +		sel_policydb.p_type_val_to_name[context->type - 1]);
> +	scontextp += strlen(sel_policydb.p_user_val_to_name[context->user - 1]) +
> +		     1 + strlen(sel_policydb.p_role_val_to_name[context->role - 1]) +
> +		     1 + strlen(sel_policydb.p_type_val_to_name[context->type - 1]);
>  
>  	mls_sid_to_context(context, &scontextp);
>  
> @@ -920,7 +920,7 @@ static int sel_sid_to_context_core(u32 sid, char **scontext,
>  	*scontext = NULL;
>  	*scontext_len  = 0;
>  
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		if (sid <= SECINITSID_NUM) {
>  			char *scontextp;
>  
> @@ -1074,7 +1074,7 @@ static int sel_context_to_sid_core(const char *scontext, u32 scontext_len,
>  	struct context context;
>  	int rc = 0;
>  
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		int i;
>  
>  		for (i = 1; i < SECINITSID_NUM; i++) {
> @@ -1105,7 +1105,7 @@ static int sel_context_to_sid_core(const char *scontext, u32 scontext_len,
>  	}
>  
>  	read_lock(&policy_rwlock);
> -	rc = string_to_context_struct(&policydb, &sidtab,
> +	rc = string_to_context_struct(&sel_policydb, &sidtab,
>  				      scontext2, scontext_len,
>  				      &context, def_sid);
>  	if (rc == -EINVAL && force) {
> @@ -1192,7 +1192,7 @@ static int compute_sid_handle_invalid_context(
>  		  " for scontext=%s"
>  		  " tcontext=%s"
>  		  " tclass=%s",
> -		  n, s, t, policydb.p_class_val_to_name[tclass-1]);
> +		  n, s, t, sel_policydb.p_class_val_to_name[tclass-1]);
>  out:
>  	kfree(s);
>  	kfree(t);
> @@ -1215,7 +1215,7 @@ static int security_compute_sid(u32 ssid,
>  	struct avtab_node *node;
>  	int rc = 0;
>  
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		switch (tclass) {
>  		case SECCLASS_PROCESS:
>  			*out_sid = ssid;
> @@ -1278,11 +1278,11 @@ static int security_compute_sid(u32 ssid,
>  	avkey.target_type = tcontext->type;
>  	avkey.target_class = tclass;
>  	avkey.specified = specified;
> -	avdatum = avtab_search(&policydb.te_avtab, &avkey);
> +	avdatum = avtab_search(&sel_policydb.te_avtab, &avkey);
>  
>  	/* If no permanent rule, also check for enabled conditional rules */
>  	if (!avdatum) {
> -		node = avtab_search_node(&policydb.te_cond_avtab, &avkey);
> +		node = avtab_search_node(&sel_policydb.te_cond_avtab, &avkey);
>  		for (; node; node = avtab_search_node_next(node, specified)) {
>  			if (node->key.specified & AVTAB_ENABLED) {
>  				avdatum = &node->datum;
> @@ -1301,7 +1301,7 @@ static int security_compute_sid(u32 ssid,
>  	case SECCLASS_PROCESS:
>  		if (specified & AVTAB_TRANSITION) {
>  			/* Look for a role transition rule. */
> -			for (roletr = policydb.role_tr; roletr;
> +			for (roletr = sel_policydb.role_tr; roletr;
>  			     roletr = roletr->next) {
>  				if (roletr->role == scontext->role &&
>  				    roletr->type == tcontext->type) {
> @@ -1323,7 +1323,7 @@ static int security_compute_sid(u32 ssid,
>  		goto out_unlock;
>  
>  	/* Check the validity of the context. */
> -	if (!policydb_context_isvalid(&policydb, &newcontext)) {
> +	if (!policydb_context_isvalid(&sel_policydb, &newcontext)) {
>  		rc = compute_sid_handle_invalid_context(scontext,
>  							tcontext,
>  							tclass,
> @@ -1687,9 +1687,9 @@ bad:
>  
>  static void sel_load_policycaps(void)
>  {
> -	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
> +	selinux_policycap_netpeer = ebitmap_get_bit(&sel_policydb.policycaps,
>  						  POLICYDB_CAPABILITY_NETPEER);
> -	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
> +	selinux_policycap_openperm = ebitmap_get_bit(&sel_policydb.policycaps,
>  						  POLICYDB_CAPABILITY_OPENPERM);
>  }
>  
> @@ -1715,29 +1715,29 @@ int sel_load_policy(void *data, size_t len)
>  	int rc = 0;
>  	struct policy_file file = { data, len }, *fp = &file;
>  
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		avtab_cache_init();
> -		if (policydb_read(&policydb, fp)) {
> +		if (policydb_read(&sel_policydb, fp)) {
>  			avtab_cache_destroy();
>  			return -EINVAL;
>  		}
> -		if (policydb_load_isids(&policydb, &sidtab)) {
> -			policydb_destroy(&policydb);
> +		if (policydb_load_isids(&sel_policydb, &sidtab)) {
> +			policydb_destroy(&sel_policydb);
>  			avtab_cache_destroy();
>  			return -EINVAL;
>  		}
>  		/* Verify that the kernel defined classes are correct. */
> -		if (validate_classes(&policydb)) {
> +		if (validate_classes(&sel_policydb)) {
>  			printk(KERN_ERR
>  			       "SELinux:  the definition of a class is incorrect\n");
>  			sidtab_destroy(&sidtab);
> -			policydb_destroy(&policydb);
> +			policydb_destroy(&sel_policydb);
>  			avtab_cache_destroy();
>  			return -EINVAL;
>  		}
>  		sel_load_policycaps();
> -		policydb_loaded_version = policydb.policyvers;
> -		ss_initialized = 1;
> +		policydb_loaded_version = sel_policydb.policyvers;
> +		sel_ss_initialized = 1;
>  		seqno = ++latest_granting;
>  		selinux_complete_init();
>  		avc_ss_reset(seqno);
> @@ -1784,23 +1784,23 @@ int sel_load_policy(void *data, size_t len)
>  	 * Convert the internal representations of contexts
>  	 * in the new SID table.
>  	 */
> -	args.oldp = &policydb;
> +	args.oldp = &sel_policydb;
>  	args.newp = &newpolicydb;
>  	rc = sidtab_map(&newsidtab, convert_context, &args);
>  	if (rc)
>  		goto err;
>  
>  	/* Save the old policydb and SID table to free later. */
> -	memcpy(&oldpolicydb, &policydb, sizeof policydb);
> +	memcpy(&oldpolicydb, &sel_policydb, sizeof sel_policydb);
>  	sidtab_set(&oldsidtab, &sidtab);
>  
>  	/* Install the new policydb and SID table. */
>  	write_lock_irq(&policy_rwlock);
> -	memcpy(&policydb, &newpolicydb, sizeof policydb);
> +	memcpy(&sel_policydb, &newpolicydb, sizeof sel_policydb);
>  	sidtab_set(&sidtab, &newsidtab);
>  	sel_load_policycaps();
>  	seqno = ++latest_granting;
> -	policydb_loaded_version = policydb.policyvers;
> +	policydb_loaded_version = sel_policydb.policyvers;
>  	write_unlock_irq(&policy_rwlock);
>  
>  	/* Free the old policydb and SID table. */
> @@ -1834,7 +1834,7 @@ int sel_port_sid(u8 protocol, u16 port, u32 *out_sid)
>  
>  	read_lock(&policy_rwlock);
>  
> -	c = policydb.ocontexts[OCON_PORT];
> +	c = sel_policydb.ocontexts[OCON_PORT];
>  	while (c) {
>  		if (c->u.port.protocol == protocol &&
>  		    c->u.port.low_port <= port &&
> @@ -1873,7 +1873,7 @@ int sel_netif_sid_by_name(char *name, u32 *if_sid)
>  
>  	read_lock(&policy_rwlock);
>  
> -	c = policydb.ocontexts[OCON_NETIF];
> +	c = sel_policydb.ocontexts[OCON_NETIF];
>  	while (c) {
>  		if (strcmp(name, c->u.name) == 0)
>  			break;
> @@ -1943,7 +1943,7 @@ int sel_node_sid(u16 domain,
>  
>  		addr = *((u32 *)addrp);
>  
> -		c = policydb.ocontexts[OCON_NODE];
> +		c = sel_policydb.ocontexts[OCON_NODE];
>  		while (c) {
>  			if (c->u.node.addr == (addr & c->u.node.mask))
>  				break;
> @@ -1957,7 +1957,7 @@ int sel_node_sid(u16 domain,
>  			rc = -EINVAL;
>  			goto out;
>  		}
> -		c = policydb.ocontexts[OCON_NODE6];
> +		c = sel_policydb.ocontexts[OCON_NODE6];
>  		while (c) {
>  			if (match_ipv6_addrmask(addrp, c->u.node6.addr,
>  						c->u.node6.mask))
> @@ -2021,7 +2021,7 @@ int sel_get_user_sids(u32 fromsid,
>  	*sids = NULL;
>  	*nel = 0;
>  
> -	if (!ss_initialized)
> +	if (!sel_ss_initialized)
>  		goto out;
>  
>  	read_lock(&policy_rwlock);
> @@ -2034,7 +2034,7 @@ int sel_get_user_sids(u32 fromsid,
>  		goto out_unlock;
>  	}
>  
> -	user = hashtab_search(policydb.p_users.table, username);
> +	user = hashtab_search(sel_policydb.p_users.table, username);
>  	if (!user) {
>  		rc = -EINVAL;
>  		goto out_unlock;
> @@ -2048,7 +2048,7 @@ int sel_get_user_sids(u32 fromsid,
>  	}
>  
>  	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
> -		role = policydb.role_val_to_struct[i];
> +		role = sel_policydb.role_val_to_struct[i];
>  		usercon.role = i+1;
>  		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
>  			usercon.type = j+1;
> @@ -2132,7 +2132,7 @@ int sel_genfs_sid(const char *fstype,
>  
>  	read_lock(&policy_rwlock);
>  
> -	for (genfs = policydb.genfs; genfs; genfs = genfs->next) {
> +	for (genfs = sel_policydb.genfs; genfs; genfs = genfs->next) {
>  		cmp = strcmp(fstype, genfs->fstype);
>  		if (cmp <= 0)
>  			break;
> @@ -2187,7 +2187,7 @@ int sel_fs_use(
>  
>  	read_lock(&policy_rwlock);
>  
> -	c = policydb.ocontexts[OCON_FSUSE];
> +	c = sel_policydb.ocontexts[OCON_FSUSE];
>  	while (c) {
>  		if (strcmp(fstype, c->u.name) == 0)
>  			break;
> @@ -2227,7 +2227,7 @@ int security_get_bools(int *len, char ***names, int **values)
>  	*names = NULL;
>  	*values = NULL;
>  
> -	*len = policydb.p_bools.nprim;
> +	*len = sel_policydb.p_bools.nprim;
>  	if (!*len) {
>  		rc = 0;
>  		goto out;
> @@ -2243,12 +2243,12 @@ int security_get_bools(int *len, char ***names, int **values)
>  
>  	for (i = 0; i < *len; i++) {
>  		size_t name_len;
> -		(*values)[i] = policydb.bool_val_to_struct[i]->state;
> -		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
> +		(*values)[i] = sel_policydb.bool_val_to_struct[i]->state;
> +		name_len = strlen(sel_policydb.p_bool_val_to_name[i]) + 1;
>  	       (*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
>  		if (!(*names)[i])
>  			goto err;
> -		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
> +		strncpy((*names)[i], sel_policydb.p_bool_val_to_name[i], name_len);
>  		(*names)[i][name_len - 1] = 0;
>  	}
>  	rc = 0;
> @@ -2273,31 +2273,31 @@ int security_set_bools(int len, int *values)
>  
>  	write_lock_irq(&policy_rwlock);
>  
> -	lenp = policydb.p_bools.nprim;
> +	lenp = sel_policydb.p_bools.nprim;
>  	if (len != lenp) {
>  		rc = -EFAULT;
>  		goto out;
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (!!values[i] != policydb.bool_val_to_struct[i]->state) {
> +		if (!!values[i] != sel_policydb.bool_val_to_struct[i]->state) {
>  			audit_log(current->audit_context, GFP_ATOMIC,
>  				AUDIT_MAC_CONFIG_CHANGE,
>  				"bool=%s val=%d old_val=%d auid=%u ses=%u",
> -				policydb.p_bool_val_to_name[i],
> +				sel_policydb.p_bool_val_to_name[i],
>  				!!values[i],
> -				policydb.bool_val_to_struct[i]->state,
> +				sel_policydb.bool_val_to_struct[i]->state,
>  				audit_get_loginuid(current),
>  				audit_get_sessionid(current));
>  		}
>  		if (values[i])
> -			policydb.bool_val_to_struct[i]->state = 1;
> +			sel_policydb.bool_val_to_struct[i]->state = 1;
>  		else
> -			policydb.bool_val_to_struct[i]->state = 0;
> +			sel_policydb.bool_val_to_struct[i]->state = 0;
>  	}
>  
> -	for (cur = policydb.cond_list; cur; cur = cur->next) {
> -		rc = evaluate_cond_node(&policydb, cur);
> +	for (cur = sel_policydb.cond_list; cur; cur = cur->next) {
> +		rc = evaluate_cond_node(&sel_policydb, cur);
>  		if (rc)
>  			goto out;
>  	}
> @@ -2321,13 +2321,13 @@ int security_get_bool_value(int bool)
>  
>  	read_lock(&policy_rwlock);
>  
> -	len = policydb.p_bools.nprim;
> +	len = sel_policydb.p_bools.nprim;
>  	if (bool >= len) {
>  		rc = -EFAULT;
>  		goto out;
>  	}
>  
> -	rc = policydb.bool_val_to_struct[bool]->state;
> +	rc = sel_policydb.bool_val_to_struct[bool]->state;
>  out:
>  	read_unlock(&policy_rwlock);
>  	return rc;
> @@ -2377,7 +2377,7 @@ int sel_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
>  	u32 len;
>  	int rc = 0;
>  
> -	if (!ss_initialized || !selinux_mls_enabled) {
> +	if (!sel_ss_initialized || !selinux_mls_enabled) {
>  		*new_sid = sid;
>  		goto out;
>  	}
> @@ -2409,7 +2409,7 @@ int sel_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
>  		goto out_unlock;
>  
>  	/* Check the validity of the new context. */
> -	if (!policydb_context_isvalid(&policydb, &newcon)) {
> +	if (!policydb_context_isvalid(&sel_policydb, &newcon)) {
>  		rc = convert_context_handle_invalid_context(&newcon);
>  		if (rc)
>  			goto bad;
> @@ -2475,9 +2475,9 @@ int sel_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
>  		return 0;
>  	}
>  
> -	/* we don't need to check ss_initialized here since the only way both
> +	/* we don't need to check sel_ss_initialized here since the only way both
>  	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
> -	 * security server was initialized and ss_initialized was true */
> +	 * security server was initialized and sel_ss_initialized was true */
>  	if (!selinux_mls_enabled) {
>  		*peer_sid = SECSID_NULL;
>  		return 0;
> @@ -2534,12 +2534,12 @@ int sel_get_classes(char ***classes, int *nclasses)
>  
>  	read_lock(&policy_rwlock);
>  
> -	*nclasses = policydb.p_classes.nprim;
> +	*nclasses = sel_policydb.p_classes.nprim;
>  	*classes = kcalloc(*nclasses, sizeof(*classes), GFP_ATOMIC);
>  	if (!*classes)
>  		goto out;
>  
> -	rc = hashtab_map(policydb.p_classes.table, get_classes_callback,
> +	rc = hashtab_map(sel_policydb.p_classes.table, get_classes_callback,
>  			*classes);
>  	if (rc < 0) {
>  		int i;
> @@ -2573,7 +2573,7 @@ int sel_get_permissions(char *class, char ***perms, int *nperms)
>  
>  	read_lock(&policy_rwlock);
>  
> -	match = hashtab_search(policydb.p_classes.table, class);
> +	match = hashtab_search(sel_policydb.p_classes.table, class);
>  	if (!match) {
>  		printk(KERN_ERR "SELinux: %s:  unrecognized class %s\n",
>  			__func__, class);
> @@ -2612,12 +2612,12 @@ err:
>  
>  int sel_get_reject_unknown(void)
>  {
> -	return policydb.reject_unknown;
> +	return sel_policydb.reject_unknown;
>  }
>  
>  int sel_get_allow_unknown(void)
>  {
> -	return policydb.allow_unknown;
> +	return sel_policydb.allow_unknown;
>  }
>  
>  /**
> @@ -2635,7 +2635,7 @@ int sel_policycap_supported(unsigned int req_cap)
>  	int rc;
>  
>  	read_lock(&policy_rwlock);
> -	rc = ebitmap_get_bit(&policydb.policycaps, req_cap);
> +	rc = ebitmap_get_bit(&sel_policydb.policycaps, req_cap);
>  	read_unlock(&policy_rwlock);
>  
>  	return rc;
> @@ -2667,7 +2667,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  
>  	*rule = NULL;
>  
> -	if (!ss_initialized)
> +	if (!sel_ss_initialized)
>  		return -EOPNOTSUPP;
>  
>  	switch (field) {
> @@ -2707,7 +2707,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  	switch (field) {
>  	case AUDIT_SUBJ_USER:
>  	case AUDIT_OBJ_USER:
> -		userdatum = hashtab_search(policydb.p_users.table, rulestr);
> +		userdatum = hashtab_search(sel_policydb.p_users.table, rulestr);
>  		if (!userdatum)
>  			rc = -EINVAL;
>  		else
> @@ -2715,7 +2715,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  		break;
>  	case AUDIT_SUBJ_ROLE:
>  	case AUDIT_OBJ_ROLE:
> -		roledatum = hashtab_search(policydb.p_roles.table, rulestr);
> +		roledatum = hashtab_search(sel_policydb.p_roles.table, rulestr);
>  		if (!roledatum)
>  			rc = -EINVAL;
>  		else
> @@ -2723,7 +2723,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  		break;
>  	case AUDIT_SUBJ_TYPE:
>  	case AUDIT_OBJ_TYPE:
> -		typedatum = hashtab_search(policydb.p_types.table, rulestr);
> +		typedatum = hashtab_search(sel_policydb.p_types.table, rulestr);
>  		if (!typedatum)
>  			rc = -EINVAL;
>  		else
> @@ -2965,7 +2965,7 @@ int sel_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  	struct context *ctx;
>  	struct context ctx_new;
>  
> -	if (!ss_initialized) {
> +	if (!sel_ss_initialized) {
>  		*sid = SECSID_NULL;
>  		return 0;
>  	}
> @@ -2996,7 +2996,7 @@ int sel_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  			       &ctx_new.range.level[0].cat,
>  			       sizeof(ctx_new.range.level[0].cat));
>  		}
> -		if (mls_context_isvalid(&policydb, &ctx_new) != 1)
> +		if (mls_context_isvalid(&sel_policydb, &ctx_new) != 1)
>  			goto netlbl_secattr_to_sid_return_cleanup;
>  
>  		rc = sidtab_context_to_sid(&sidtab, &ctx_new, sid);
> @@ -3034,7 +3034,7 @@ int sel_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
>  	int rc;
>  	struct context *ctx;
>  
> -	if (!ss_initialized)
> +	if (!sel_ss_initialized)
>  		return 0;
>  
>  	read_lock(&policy_rwlock);
> @@ -3043,7 +3043,7 @@ int sel_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
>  		rc = -ENOENT;
>  		goto netlbl_sid_to_secattr_failure;
>  	}
> -	secattr->domain = kstrdup(policydb.p_type_val_to_name[ctx->type - 1],
> +	secattr->domain = kstrdup(sel_policydb.p_type_val_to_name[ctx->type - 1],
>  				  GFP_ATOMIC);
>  	if (secattr->domain == NULL) {
>  		rc = -ENOMEM;
> diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
> index e8d907e..5ab60e6 100644
> --- a/security/selinux/ss/services.h
> +++ b/security/selinux/ss/services.h
> @@ -9,7 +9,7 @@
>  #include "policydb.h"
>  #include "sidtab.h"
>  
> -extern struct policydb policydb;
> +extern struct policydb sel_policydb;
>  
>  #endif	/* _SS_SERVICES_H_ */
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
