Message-ID: <1516205656.6979.7.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: peter.enderborg@sony.com, Paul Moore <paul@paul-moore.com>, Eric Paris
 <eparis@parisplace.org>, James Morris <james.l.morris@oracle.com>, Daniel
 Jurgens <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, alsa-devel@alsa-project.org,
 "Serge E . Hallyn" <serge@hallyn.com>
Date: Wed, 17 Jan 2018 11:14:16 -0500
In-Reply-To: <20180117145551.4961-1-peter.enderborg@sony.com>
References: <20180117145551.4961-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux:Significant reduce of preempt_disable holds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2018-01-17 at 15:55 +0100, peter.enderborg@sony.com wrote:
> From: Peter Enderborg <peter.enderborg@sony.com>
> 
> Holding the preempt_disable is very bad for low latency tasks
> as audio and therefore we need to break out the rule-set dependent
> part from this disable. By using a rwsem instead of rwlock we
> have an efficient locking and less preemption interference.
> 
> Selinux uses a lot of read_locks. This patch replaces the rwlock
> with rwsem/percpu_down_read() that does not hold preempt_disable.

Many of these functions are called while holding spinlocks, and some of
them are called from interrupt.  Unless I misunderstand, you can't just
replace read_lock() with percpu_down_read(), which might sleep.

What you might be able to do is to convert the whole thing to RCU, but
this would require reworking how policy booleans are changed and how
policy is reloaded.

You might also try increasing your AVC size via
/sys/fs/selinux/avc/cache_threshold to reduce cache misses and thus
calls to security_compute_av().

> 
> Intel Xeon W3520 2.67 Ghz running FC27 with 4.15.0-rc8git
> (+measurement)
> I get preempt_disable in worst case for 1.2ms in
> security_compute_av().
> With the patch I get 960us as the longest security_compute_av()
> without preempt disabeld. It very much noise in the measurement
> but it is not likely a degrade.
> 
> And the preempt_disable times is also very dependent on the selinux
> rule-set.
> 
> In security_get_user_sids() we have two nested for-loops and the
> inner part calls sittab_context_to_sid() that calls
> sidtab_search_context() that has a for loop() over a while() where
> the loops is dependent on the rules.
> 
> On the test system the average lookup time is 60us and does
> not change with the rwsem usage.
> 
> Reported-by: Björn Davidsson <bjorn.davidsson@sony.com>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/services.c | 134 ++++++++++++++++++++-----------
> ----------
>  1 file changed, 67 insertions(+), 67 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 33cfe5d..a3daaf2 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -87,7 +87,7 @@ int selinux_policycap_alwaysnetwork;
>  int selinux_policycap_cgroupseclabel;
>  int selinux_policycap_nnp_nosuid_transition;
>  
> -static DEFINE_RWLOCK(policy_rwlock);
> +DEFINE_STATIC_PERCPU_RWSEM(policy_rwsem);
>  
>  static struct sidtab sidtab;
>  struct policydb policydb;
> @@ -779,7 +779,7 @@ static int security_compute_validatetrans(u32
> oldsid, u32 newsid, u32 tasksid,
>  	if (!ss_initialized)
>  		return 0;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	if (!user)
>  		tclass = unmap_class(orig_tclass);
> @@ -833,7 +833,7 @@ static int security_compute_validatetrans(u32
> oldsid, u32 newsid, u32 tasksid,
>  	}
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -867,7 +867,7 @@ int security_bounded_transition(u32 old_sid, u32
> new_sid)
>  	int index;
>  	int rc;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	rc = -EINVAL;
>  	old_context = sidtab_search(&sidtab, old_sid);
> @@ -929,7 +929,7 @@ int security_bounded_transition(u32 old_sid, u32
> new_sid)
>  		kfree(old_name);
>  	}
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  
>  	return rc;
>  }
> @@ -1017,7 +1017,7 @@ void security_compute_xperms_decision(u32 ssid,
>  	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow-
> >p));
>  	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit-
> >p));
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	if (!ss_initialized)
>  		goto allow;
>  
> @@ -1070,7 +1070,7 @@ void security_compute_xperms_decision(u32 ssid,
>  		}
>  	}
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return;
>  allow:
>  	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed-
> >p));
> @@ -1097,7 +1097,7 @@ void security_compute_av(u32 ssid,
>  	u16 tclass;
>  	struct context *scontext = NULL, *tcontext = NULL;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	avd_init(avd);
>  	xperms->len = 0;
>  	if (!ss_initialized)
> @@ -1130,7 +1130,7 @@ void security_compute_av(u32 ssid,
>  	context_struct_compute_av(scontext, tcontext, tclass, avd,
> xperms);
>  	map_decision(orig_tclass, avd, policydb.allow_unknown);
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return;
>  allow:
>  	avd->allowed = 0xffffffff;
> @@ -1144,7 +1144,7 @@ void security_compute_av_user(u32 ssid,
>  {
>  	struct context *scontext = NULL, *tcontext = NULL;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	avd_init(avd);
>  	if (!ss_initialized)
>  		goto allow;
> @@ -1175,7 +1175,7 @@ void security_compute_av_user(u32 ssid,
>  
>  	context_struct_compute_av(scontext, tcontext, tclass, avd,
> NULL);
>   out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return;
>  allow:
>  	avd->allowed = 0xffffffff;
> @@ -1277,7 +1277,7 @@ static int security_sid_to_context_core(u32
> sid, char **scontext,
>  		rc = -EINVAL;
>  		goto out;
>  	}
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	if (force)
>  		context = sidtab_search_force(&sidtab, sid);
>  	else
> @@ -1290,7 +1290,7 @@ static int security_sid_to_context_core(u32
> sid, char **scontext,
>  	}
>  	rc = context_struct_to_string(context, scontext,
> scontext_len);
>  out_unlock:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  out:
>  	return rc;
>  
> @@ -1442,7 +1442,7 @@ static int security_context_to_sid_core(const
> char *scontext, u32 scontext_len,
>  			goto out;
>  	}
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	rc = string_to_context_struct(&policydb, &sidtab, scontext2,
>  				      scontext_len, &context,
> def_sid);
>  	if (rc == -EINVAL && force) {
> @@ -1454,7 +1454,7 @@ static int security_context_to_sid_core(const
> char *scontext, u32 scontext_len,
>  	rc = sidtab_context_to_sid(&sidtab, &context, sid);
>  	context_destroy(&context);
>  out_unlock:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  out:
>  	kfree(scontext2);
>  	kfree(str);
> @@ -1604,7 +1604,7 @@ static int security_compute_sid(u32 ssid,
>  
>  	context_init(&newcontext);
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	if (kern) {
>  		tclass = unmap_class(orig_tclass);
> @@ -1738,7 +1738,7 @@ static int security_compute_sid(u32 ssid,
>  	/* Obtain the sid for the context. */
>  	rc = sidtab_context_to_sid(&sidtab, &newcontext, out_sid);
>  out_unlock:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	context_destroy(&newcontext);
>  out:
>  	return rc;
> @@ -2160,7 +2160,7 @@ int security_load_policy(void *data, size_t
> len)
>  	sidtab_set(&oldsidtab, &sidtab);
>  
>  	/* Install the new policydb and SID table. */
> -	write_lock_irq(&policy_rwlock);
> +	percpu_down_write(&policy_rwsem);
>  	memcpy(&policydb, newpolicydb, sizeof(policydb));
>  	sidtab_set(&sidtab, &newsidtab);
>  	security_load_policycaps();
> @@ -2168,7 +2168,7 @@ int security_load_policy(void *data, size_t
> len)
>  	current_mapping = map;
>  	current_mapping_size = map_size;
>  	seqno = ++latest_granting;
> -	write_unlock_irq(&policy_rwlock);
> +	percpu_up_write(&policy_rwsem);
>  
>  	/* Free the old policydb and SID table. */
>  	policydb_destroy(oldpolicydb);
> @@ -2198,9 +2198,9 @@ size_t security_policydb_len(void)
>  {
>  	size_t len;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	len = policydb.len;
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  
>  	return len;
>  }
> @@ -2216,7 +2216,7 @@ int security_port_sid(u8 protocol, u16 port,
> u32 *out_sid)
>  	struct ocontext *c;
>  	int rc = 0;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	c = policydb.ocontexts[OCON_PORT];
>  	while (c) {
> @@ -2241,7 +2241,7 @@ int security_port_sid(u8 protocol, u16 port,
> u32 *out_sid)
>  	}
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -2256,7 +2256,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16
> pkey_num, u32 *out_sid)
>  	struct ocontext *c;
>  	int rc = 0;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	c = policydb.ocontexts[OCON_IBPKEY];
>  	while (c) {
> @@ -2281,7 +2281,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16
> pkey_num, u32 *out_sid)
>  		*out_sid = SECINITSID_UNLABELED;
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -2296,7 +2296,7 @@ int security_ib_endport_sid(const char
> *dev_name, u8 port_num, u32 *out_sid)
>  	struct ocontext *c;
>  	int rc = 0;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	c = policydb.ocontexts[OCON_IBENDPORT];
>  	while (c) {
> @@ -2322,7 +2322,7 @@ int security_ib_endport_sid(const char
> *dev_name, u8 port_num, u32 *out_sid)
>  		*out_sid = SECINITSID_UNLABELED;
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -2336,7 +2336,7 @@ int security_netif_sid(char *name, u32 *if_sid)
>  	int rc = 0;
>  	struct ocontext *c;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	c = policydb.ocontexts[OCON_NETIF];
>  	while (c) {
> @@ -2363,7 +2363,7 @@ int security_netif_sid(char *name, u32 *if_sid)
>  		*if_sid = SECINITSID_NETIF;
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -2395,7 +2395,7 @@ int security_node_sid(u16 domain,
>  	int rc;
>  	struct ocontext *c;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	switch (domain) {
>  	case AF_INET: {
> @@ -2450,7 +2450,7 @@ int security_node_sid(u16 domain,
>  
>  	rc = 0;
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -2489,7 +2489,7 @@ int security_get_user_sids(u32 fromsid,
>  	if (!ss_initialized)
>  		goto out;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	context_init(&usercon);
>  
> @@ -2539,7 +2539,7 @@ int security_get_user_sids(u32 fromsid,
>  	}
>  	rc = 0;
>  out_unlock:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	if (rc || !mynel) {
>  		kfree(mysids);
>  		goto out;
> @@ -2580,7 +2580,7 @@ int security_get_user_sids(u32 fromsid,
>   * cannot support xattr or use a fixed labeling behavior like
>   * transition SIDs or task SIDs.
>   *
> - * The caller must acquire the policy_rwlock before calling this
> function.
> + * The caller must acquire the policy_rwsem before calling this
> function.
>   */
>  static inline int __security_genfs_sid(const char *fstype,
>  				       char *path,
> @@ -2639,7 +2639,7 @@ static inline int __security_genfs_sid(const
> char *fstype,
>   * @sclass: file security class
>   * @sid: SID for path
>   *
> - * Acquire policy_rwlock before calling __security_genfs_sid() and
> release
> + * Acquire policy_rwsem before calling __security_genfs_sid() and
> release
>   * it afterward.
>   */
>  int security_genfs_sid(const char *fstype,
> @@ -2649,9 +2649,9 @@ int security_genfs_sid(const char *fstype,
>  {
>  	int retval;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	retval = __security_genfs_sid(fstype, path, orig_sclass,
> sid);
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return retval;
>  }
>  
> @@ -2666,7 +2666,7 @@ int security_fs_use(struct super_block *sb)
>  	struct superblock_security_struct *sbsec = sb->s_security;
>  	const char *fstype = sb->s_type->name;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	c = policydb.ocontexts[OCON_FSUSE];
>  	while (c) {
> @@ -2696,7 +2696,7 @@ int security_fs_use(struct super_block *sb)
>  	}
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -2704,7 +2704,7 @@ int security_get_bools(int *len, char ***names,
> int **values)
>  {
>  	int i, rc;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	*names = NULL;
>  	*values = NULL;
>  
> @@ -2733,7 +2733,7 @@ int security_get_bools(int *len, char ***names,
> int **values)
>  	}
>  	rc = 0;
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  err:
>  	if (*names) {
> @@ -2751,7 +2751,7 @@ int security_set_bools(int len, int *values)
>  	int lenp, seqno = 0;
>  	struct cond_node *cur;
>  
> -	write_lock_irq(&policy_rwlock);
> +	percpu_down_write(&policy_rwsem);
>  
>  	rc = -EFAULT;
>  	lenp = policydb.p_bools.nprim;
> @@ -2784,7 +2784,7 @@ int security_set_bools(int len, int *values)
>  	seqno = ++latest_granting;
>  	rc = 0;
>  out:
> -	write_unlock_irq(&policy_rwlock);
> +	percpu_up_write(&policy_rwsem);
>  	if (!rc) {
>  		avc_ss_reset(seqno);
>  		selnl_notify_policyload(seqno);
> @@ -2799,7 +2799,7 @@ int security_get_bool_value(int index)
>  	int rc;
>  	int len;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	rc = -EFAULT;
>  	len = policydb.p_bools.nprim;
> @@ -2808,7 +2808,7 @@ int security_get_bool_value(int index)
>  
>  	rc = policydb.bool_val_to_struct[index]->state;
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -2864,7 +2864,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid,
> u32 *new_sid)
>  
>  	context_init(&newcon);
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	rc = -EINVAL;
>  	context1 = sidtab_search(&sidtab, sid);
> @@ -2906,7 +2906,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid,
> u32 *new_sid)
>  
>  	rc = sidtab_context_to_sid(&sidtab, &newcon, new_sid);
>  out_unlock:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	context_destroy(&newcon);
>  out:
>  	return rc;
> @@ -2963,7 +2963,7 @@ int security_net_peersid_resolve(u32 nlbl_sid,
> u32 nlbl_type,
>  	if (!policydb.mls_enabled)
>  		return 0;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	rc = -EINVAL;
>  	nlbl_ctx = sidtab_search(&sidtab, nlbl_sid);
> @@ -2990,7 +2990,7 @@ int security_net_peersid_resolve(u32 nlbl_sid,
> u32 nlbl_type,
>  	 * expressive */
>  	*peer_sid = xfrm_sid;
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -3011,7 +3011,7 @@ int security_get_classes(char ***classes, int
> *nclasses)
>  {
>  	int rc;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	rc = -ENOMEM;
>  	*nclasses = policydb.p_classes.nprim;
> @@ -3029,7 +3029,7 @@ int security_get_classes(char ***classes, int
> *nclasses)
>  	}
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -3051,7 +3051,7 @@ int security_get_permissions(char *class, char
> ***perms, int *nperms)
>  	int rc, i;
>  	struct class_datum *match;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	rc = -EINVAL;
>  	match = hashtab_search(policydb.p_classes.table, class);
> @@ -3080,11 +3080,11 @@ int security_get_permissions(char *class,
> char ***perms, int *nperms)
>  		goto err;
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  
>  err:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	for (i = 0; i < *nperms; i++)
>  		kfree((*perms)[i]);
>  	kfree(*perms);
> @@ -3115,9 +3115,9 @@ int security_policycap_supported(unsigned int
> req_cap)
>  {
>  	int rc;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	rc = ebitmap_get_bit(&policydb.policycaps, req_cap);
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  
>  	return rc;
>  }
> @@ -3181,7 +3181,7 @@ int selinux_audit_rule_init(u32 field, u32 op,
> char *rulestr, void **vrule)
>  
>  	context_init(&tmprule->au_ctxt);
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	tmprule->au_seqno = latest_granting;
>  
> @@ -3221,7 +3221,7 @@ int selinux_audit_rule_init(u32 field, u32 op,
> char *rulestr, void **vrule)
>  	}
>  	rc = 0;
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  
>  	if (rc) {
>  		selinux_audit_rule_free(tmprule);
> @@ -3271,7 +3271,7 @@ int selinux_audit_rule_match(u32 sid, u32
> field, u32 op, void *vrule,
>  		return -ENOENT;
>  	}
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	if (rule->au_seqno < latest_granting) {
>  		match = -ESTALE;
> @@ -3362,7 +3362,7 @@ int selinux_audit_rule_match(u32 sid, u32
> field, u32 op, void *vrule,
>  	}
>  
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return match;
>  }
>  
> @@ -3448,7 +3448,7 @@ int security_netlbl_secattr_to_sid(struct
> netlbl_lsm_secattr *secattr,
>  		return 0;
>  	}
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	if (secattr->flags & NETLBL_SECATTR_CACHE)
>  		*sid = *(u32 *)secattr->cache->data;
> @@ -3484,12 +3484,12 @@ int security_netlbl_secattr_to_sid(struct
> netlbl_lsm_secattr *secattr,
>  	} else
>  		*sid = SECSID_NULL;
>  
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return 0;
>  out_free:
>  	ebitmap_destroy(&ctx_new.range.level[0].cat);
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  
> @@ -3511,7 +3511,7 @@ int security_netlbl_sid_to_secattr(u32 sid,
> struct netlbl_lsm_secattr *secattr)
>  	if (!ss_initialized)
>  		return 0;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  
>  	rc = -ENOENT;
>  	ctx = sidtab_search(&sidtab, sid);
> @@ -3529,7 +3529,7 @@ int security_netlbl_sid_to_secattr(u32 sid,
> struct netlbl_lsm_secattr *secattr)
>  	mls_export_netlbl_lvl(ctx, secattr);
>  	rc = mls_export_netlbl_cat(ctx, secattr);
>  out:
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  	return rc;
>  }
>  #endif /* CONFIG_NETLABEL */
> @@ -3557,9 +3557,9 @@ int security_read_policy(void **data, size_t
> *len)
>  	fp.data = *data;
>  	fp.len = *len;
>  
> -	read_lock(&policy_rwlock);
> +	percpu_down_read(&policy_rwsem);
>  	rc = policydb_write(&policydb, &fp);
> -	read_unlock(&policy_rwlock);
> +	percpu_up_read(&policy_rwsem);
>  
>  	if (rc)
>  		return rc;
