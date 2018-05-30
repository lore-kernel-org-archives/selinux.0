To: Peter Enderborg <peter.enderborg@sony.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, Daniel Jurgens <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <20180530141104.28569-3-peter.enderborg@sony.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <306e9866-06c0-28ca-44f4-55065828ac3b@gmail.com>
Date: Wed, 30 May 2018 14:15:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180530141104.28569-3-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH V3 2/5 selinux-next] selinux: Introduce
 selinux_ruleset struct
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


(snip)
.
.
.
>   
> -static void security_load_policycaps(struct selinux_state *state)
> +static void security_load_policycaps(struct selinux_state *state,
> +				     struct policydb *p)
>   {
> -	struct policydb *p = &state->ss->policydb;
>   	unsigned int i;
>   	struct ebitmap_node *node;
>   
> @@ -2107,47 +2112,47 @@ static int security_preserve_bools(struct selinux_state *state,
>    */
>   int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   {
> -	struct policydb *policydb;
> -	struct sidtab *sidtab;
> -	struct policydb *oldpolicydb, *newpolicydb;
> -	struct sidtab oldsidtab, newsidtab;
> -	struct selinux_mapping *oldmapping;
>   	struct selinux_map newmap;
>   	struct convert_context_args args;
>   	u32 seqno;
>   	int rc = 0;
> +	struct selinux_ruleset *next_set, *old_set;
>   	struct policy_file file = { data, len }, *fp = &file;
>   
> -	oldpolicydb = kzalloc(2 * sizeof(*oldpolicydb), GFP_KERNEL);
> -	if (!oldpolicydb) {
> +	next_set = kzalloc(sizeof(struct selinux_ruleset), GFP_KERNEL);
> +	if (!next_set) {
>   		rc = -ENOMEM;
>   		goto out;
>   	}
> -	newpolicydb = oldpolicydb + 1;
> -
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	next_set->sidtab = kzalloc(sizeof(struct sidtab), GFP_KERNEL);
> +	if (!next_set->sidtab) {
> +		rc = -ENOMEM;
> +		kfree(next_set);

How about moving these kfree(next_set) into the 'goto out' cleanup?  The 
effort has already been made to have a goto cleanup section in 
security_load_policy).  There is a lot of diff changes in here which is 
hard to follow, and my worry is a kfree(next_set); could get missed, or 
is not as easily maintainable as if the code was restructured to have a 
single kfree(next_set); call for all 'goto out;' cleanup situations.
> +		goto out;
> +	}
>   
>   	if (!state->initialized) {
> -		rc = policydb_read(policydb, fp);
> +		old_set = state->ss->active_set;
> +		rc = policydb_read(&next_set->policydb, fp);
>   		if (rc)
>   			goto out;
>   
> -		policydb->len = len;
> -		rc = selinux_set_mapping(policydb, secclass_map,
> -					 &state->ss->map);
> +		next_set->policydb.len = len;
> +		rc = selinux_set_mapping(&next_set->policydb, secclass_map,
> +					 &next_set->map);
>   		if (rc) {
> -			policydb_destroy(policydb);
> +			policydb_destroy(&next_set->policydb);
>   			goto out;
>   		}
>   
> -		rc = policydb_load_isids(policydb, sidtab);
> +		rc = policydb_load_isids(&next_set->policydb, next_set->sidtab);
>   		if (rc) {
> -			policydb_destroy(policydb);
> +			policydb_destroy(&next_set->policydb);
>   			goto out;
>   		}
>   
> -		security_load_policycaps(state);
> +		security_load_policycaps(state, &next_set->policydb);
> +		state->ss->active_set = next_set;
>   		state->initialized = 1;
>   		seqno = ++state->ss->latest_granting;
>   		selinux_complete_init();
> @@ -2156,45 +2161,48 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		selinux_status_update_policyload(state, seqno);
>   		selinux_netlbl_cache_invalidate();
>   		selinux_xfrm_notify_policyload();
> +		kfree(old_set->sidtab);
> +		kfree(old_set);
>   		goto out;
>   	}
> -
> +	old_set = state->ss->active_set;
>   #if 0
>   	sidtab_hash_eval(sidtab, "sids");
>   #endif
>   
> -	rc = policydb_read(newpolicydb, fp);
> +	rc = policydb_read(&next_set->policydb, fp);
>   	if (rc)
>   		goto out;
>   
> -	newpolicydb->len = len;
> +	next_set->policydb.len = len;
> +
>   	/* If switching between different policy types, log MLS status */
> -	if (policydb->mls_enabled && !newpolicydb->mls_enabled)
> +	if (old_set->policydb.mls_enabled && !next_set->policydb.mls_enabled)
>   		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
> -	else if (!policydb->mls_enabled && newpolicydb->mls_enabled)
> +	else if (!old_set->policydb.mls_enabled
> +		 && next_set->policydb.mls_enabled)
>   		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
> -
> -	rc = policydb_load_isids(newpolicydb, &newsidtab);
> +	rc = policydb_load_isids(&next_set->policydb, next_set->sidtab);
>   	if (rc) {
>   		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
> -		policydb_destroy(newpolicydb);
> +		policydb_destroy(&next_set->policydb);
>   		goto out;
>   	}
>   
> -	rc = selinux_set_mapping(newpolicydb, secclass_map, &newmap);
> +	rc = selinux_set_mapping(&next_set->policydb, secclass_map, &newmap);
>   	if (rc)
>   		goto err;
>   
> -	rc = security_preserve_bools(state, newpolicydb);
> +	rc = security_preserve_bools(state, &next_set->policydb);
>   	if (rc) {
>   		printk(KERN_ERR "SELinux:  unable to preserve booleans\n");
>   		goto err;
>   	}
>   
>   	/* Clone the SID table. */
> -	sidtab_shutdown(sidtab);
> +	sidtab_shutdown(old_set->sidtab);
>   
> -	rc = sidtab_map(sidtab, clone_sid, &newsidtab);
> +	rc = sidtab_map(old_set->sidtab, clone_sid, next_set->sidtab);
>   	if (rc)
>   		goto err;
>   
> @@ -2203,9 +2211,9 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	 * in the new SID table.
>   	 */
>   	args.state = state;
> -	args.oldp = policydb;
> -	args.newp = newpolicydb;
> -	rc = sidtab_map(&newsidtab, convert_context, &args);
> +	args.oldp = &old_set->policydb;
> +	args.newp = &next_set->policydb;
> +	rc = sidtab_map(next_set->sidtab, convert_context, &args);
>   	if (rc) {
>   		printk(KERN_ERR "SELinux:  unable to convert the internal"
>   			" representation of contexts in the new SID"
> @@ -2213,48 +2221,43 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		goto err;
>   	}
>   
> -	/* Save the old policydb and SID table to free later. */
> -	memcpy(oldpolicydb, policydb, sizeof(*policydb));
> -	sidtab_set(&oldsidtab, sidtab);
> +	next_set->map.mapping = newmap.mapping;
> +	next_set->map.size = newmap.size;
>   
>   	/* Install the new policydb and SID table. */
>   	write_lock_irq(&state->ss->policy_rwlock);
> -	memcpy(policydb, newpolicydb, sizeof(*policydb));
> -	sidtab_set(sidtab, &newsidtab);
> -	security_load_policycaps(state);
> -	oldmapping = state->ss->map.mapping;
> -	state->ss->map.mapping = newmap.mapping;
> -	state->ss->map.size = newmap.size;
> +	security_load_policycaps(state, &next_set->policydb);
>   	seqno = ++state->ss->latest_granting;
> +	state->ss->active_set = next_set;
>   	write_unlock_irq(&state->ss->policy_rwlock);
>   
> -	/* Free the old policydb and SID table. */
> -	policydb_destroy(oldpolicydb);
> -	sidtab_destroy(&oldsidtab);
> -	kfree(oldmapping);
> -
>   	avc_ss_reset(state->avc, seqno);
>   	selnl_notify_policyload(seqno);
>   	selinux_status_update_policyload(state, seqno);
>   	selinux_netlbl_cache_invalidate();
>   	selinux_xfrm_notify_policyload();
>   
> +	/* Free the old policydb and SID table. */
> +	policydb_destroy(&old_set->policydb);
> +	sidtab_destroy(old_set->sidtab);
> +	kfree(old_set->sidtab);
> +	kfree(old_set->map.mapping);
> +	kfree(old_set);
>   	rc = 0;
>   	goto out;
>   
>   err:
>   	kfree(newmap.mapping);
> -	sidtab_destroy(&newsidtab);
> -	policydb_destroy(newpolicydb);
> -
> +	sidtab_destroy(next_set->sidtab);
> +	policydb_destroy(&next_set->policydb);
> +	kfree(next_set);
>   out:
> -	kfree(oldpolicydb);
>   	return rc;
>   }
>   
>   size_t security_policydb_len(struct selinux_state *state)
>   {
> -	struct policydb *p = &state->ss->policydb;
> +	struct policydb *p = &state->ss->active_set->policydb;
>   	size_t len;
>   
>   	read_lock(&state->ss->policy_rwlock);
> @@ -2280,8 +2283,8 @@ int security_port_sid(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	policydb = &state->ss->active_set->policydb;
> +	sidtab = state->ss->active_set->sidtab;
>   
>   	c = policydb->ocontexts[OCON_PORT];
>   	while (c) {
> @@ -2326,8 +2329,8 @@ int security_ib_pkey_sid(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	policydb = &state->ss->active_set->policydb;
> +	sidtab = state->ss->active_set->sidtab;
>   
>   	c = policydb->ocontexts[OCON_IBPKEY];
>   	while (c) {
> @@ -2372,8 +2375,8 @@ int security_ib_endport_sid(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	policydb = &state->ss->active_set->policydb;
> +	sidtab = state->ss->active_set->sidtab;
>   
>   	c = policydb->ocontexts[OCON_IBENDPORT];
>   	while (c) {
> @@ -2418,8 +2421,8 @@ int security_netif_sid(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	policydb = &state->ss->active_set->policydb;
> +	sidtab = state->ss->active_set->sidtab;
>   
>   	c = policydb->ocontexts[OCON_NETIF];
>   	while (c) {
> @@ -2483,8 +2486,8 @@ int security_node_sid(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	policydb = &state->ss->active_set->policydb;
> +	sidtab = state->ss->active_set->sidtab;
>   
>   	switch (domain) {
>   	case AF_INET: {
> @@ -2583,8 +2586,8 @@ int security_get_user_sids(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	policydb = &state->ss->active_set->policydb;
> +	sidtab = state->ss->active_set->sidtab;
>   
>   	context_init(&usercon);
>   
> @@ -2685,8 +2688,8 @@ static inline int __security_genfs_sid(struct selinux_state *state,
>   				       u16 orig_sclass,
>   				       u32 *sid)
>   {
> -	struct policydb *policydb = &state->ss->policydb;
> -	struct sidtab *sidtab = &state->ss->sidtab;
> +	struct policydb *policydb = &state->ss->active_set->policydb;
> +	struct sidtab *sidtab = state->ss->active_set->sidtab;
>   	int len;
>   	u16 sclass;
>   	struct genfs *genfs;
> @@ -2696,7 +2699,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
>   	while (path[0] == '/' && path[1] == '/')
>   		path++;
>   
> -	sclass = unmap_class(&state->ss->map, orig_sclass);
> +	sclass = unmap_class(&state->ss->active_set->map, orig_sclass);
>   	*sid = SECINITSID_UNLABELED;
>   
>   	for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
> @@ -2771,8 +2774,8 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> -	sidtab = &state->ss->sidtab;
> +	policydb = &state->ss->active_set->policydb;
> +	sidtab = state->ss->active_set->sidtab;
>   
>   	c = policydb->ocontexts[OCON_FSUSE];
>   	while (c) {
> @@ -2821,7 +2824,7 @@ int security_get_bools(struct selinux_state *state,
>   
>   	read_lock(&state->ss->policy_rwlock);
>   
> -	policydb = &state->ss->policydb;
> +	policydb = &state->ss->active_set->policydb;
>   
>   	*names = NULL;
>   	*values = NULL;
> @@ -2866,53 +2869,86 @@ int security_get_bools(struct selinux_state *state,
>   
>   int security_set_bools(struct selinux_state *state, int len, int *values)
>   {
> -	struct policydb *policydb;
>   	int i, rc;
>   	int lenp, seqno = 0;
>   	struct cond_node *cur;
> +	struct selinux_ruleset *next_set, *old_set = NULL;
> +	void *storage;
> +	size_t size;
>   
> -	write_lock_irq(&state->ss->policy_rwlock);
> +	next_set = kzalloc(sizeof(struct selinux_ruleset), GFP_KERNEL);
> +	if (!next_set) {
> +		rc = -ENOMEM;
> +		goto errout;
> +	}
> +
> +	rc = policydb_flattened_alloc(&state->ss->active_set->policydb,
> +				      &storage, &size);
> +	if (rc) {
> +		kfree(next_set);

I think this function, security_set_bools(), is another case where it 
would be good to restructure the code where there is a single location 
where kfree(next_set); is called for code readability and 
maintainability.  Or at the very least keeping the goto cleanup strategy 
consistent; here, for normal 'goto out;' routines kfree(next_set); is 
there in the 'out' block, but for 'goto errout;' routines it is not 
there and kfree(next_set); must be called before-hand.
> +		goto errout;
> +	}
>   
> -	policydb = &state->ss->policydb;
> +	write_lock_irq(&state->ss->policy_rwlock);
> +	old_set = state->ss->active_set;
> +	memcpy(next_set, old_set, sizeof(struct selinux_ruleset));
> +	rc = policydb_copy(&old_set->policydb, &next_set->policydb,
> +			   &storage, size);
> +	if (rc)
> +		goto out;
>   
>   	rc = -EFAULT;
> -	lenp = policydb->p_bools.nprim;
> +	lenp = next_set->policydb.p_bools.nprim;
>   	if (len != lenp)
>   		goto out;
>   
>   	for (i = 0; i < len; i++) {
> -		if (!!values[i] != policydb->bool_val_to_struct[i]->state) {
> +		if (!!values[i] !=
> +			next_set->policydb.bool_val_to_struct[i]->state) {
>   			audit_log(current->audit_context, GFP_ATOMIC,
>   				AUDIT_MAC_CONFIG_CHANGE,
>   				"bool=%s val=%d old_val=%d auid=%u ses=%u",
> -				sym_name(policydb, SYM_BOOLS, i),
> +				sym_name(&next_set->policydb, SYM_BOOLS, i),
>   				!!values[i],
> -				policydb->bool_val_to_struct[i]->state,
> +				next_set->policydb.bool_val_to_struct[i]->state,
>   				from_kuid(&init_user_ns, audit_get_loginuid(current)),
>   				audit_get_sessionid(current));
>   		}
>   		if (values[i])
> -			policydb->bool_val_to_struct[i]->state = 1;
> +			next_set->policydb.bool_val_to_struct[i]->state = 1;
>   		else
> -			policydb->bool_val_to_struct[i]->state = 0;
> +			next_set->policydb.bool_val_to_struct[i]->state = 0;
>   	}
>   
> -	for (cur = policydb->cond_list; cur; cur = cur->next) {
> -		rc = evaluate_cond_node(policydb, cur);
> +	for (cur = next_set->policydb.cond_list; cur; cur = cur->next) {
> +		rc = evaluate_cond_node(&next_set->policydb, cur);
>   		if (rc)
>   			goto out;
>   	}
>   
>   	seqno = ++state->ss->latest_granting;
> +	state->ss->active_set = next_set;
>   	rc = 0;
>   out:
> -	write_unlock_irq(&state->ss->policy_rwlock);
>   	if (!rc) {
> +		seqno = ++state->ss->latest_granting;
> +		state->ss->active_set = next_set;
> +		rc = 0;

Why would we want to set rc to 0 here and have the return value be 0 
instead of the original rc value evaluated in the if() statement above?
> +		write_unlock_irq(&state->ss->policy_rwlock);
>   		avc_ss_reset(state->avc, seqno);
>   		selnl_notify_policyload(seqno);
>   		selinux_status_update_policyload(state, seqno);
>   		selinux_xfrm_notify_policyload();
> +		policydb_destroy(&old_set->policydb);
> +		kfree(old_set);
> +	} else {
> +		printk(KERN_ERR "SELinux: %s failed %d\n", __func__, rc);
> +		write_unlock_irq(&state->ss->policy_rwlock);
> +		kfree(next_set);
>   	}
> +	policydb_flattened_free(storage);
> +
> + errout:
>   	return rc;
>   }
>   
> @@
Thanks,
Jay
