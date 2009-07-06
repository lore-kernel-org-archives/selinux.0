Subject: Re: [PATCH 1/4] Namespacing of security/selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1246568103.2480.27.camel@Ares>
References: <1246568103.2480.27.camel@Ares>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 09:13:16 -0400
Message-Id: <1246885996.28321.2.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-02 at 16:55 -0400, Thomas Liu wrote:
> This patch namespaces the functions in security/selinux, prefixing 
> with selinux_ and prefixing items in security/selinux/ss with
> selinux_ss.

Hmm...my original suggestion here (from:
http://selinuxproject.org/page/Kernel_Development) was as follows:

We have a lot of global functions and variables, some with no prefix at
all, some with prefixes that are not clearly scoped to selinux.

I'd at least:
- rename the security server functions from security_ to selinux_ to
avoid confusion/conflicts with LSM.
- rename ss_initialized to selinux_ss_initialized.
- rename the policydb and sidtab variables to selinux_policydb and
selinux_sidtab (and/or wrap them in a single container structure with a
single active policy pointer to it, with the intent of ultimately
refcounting it and introducing _get and _put functions).

Then you've got the generic data structures and their functions, like
hashtab_, symtab_, etc, which could either be taken to lib/ or given
selinux_ prefixes.

But I wouldn't blindly rename everything under ss/ with selinux_ss - if
possible I'd just use selinux_ everywhere unless there is an actual
conflict.  And I wouldn't rename the avc_ functions unless there is
truly a conflict - they already have a perfectly good prefix (avc_) and
one that has to date been unique.

checkpatch.pl complains that a lot of lines end up over 80 chars from
the patches, which would be reduced if you omitted the _ss_ part and
didn't rename the avc_ functions.

> 
> Patch 1 includes namespacing of the security/selinux folder, not 
> including security/selinux/ss.
> 
> Added selinux_ as a prefix to non static functions, and
> swapped security_ with selinux_ss_.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>
> ---
>  security/selinux/avc.c                 |   36 +++---
>  security/selinux/exports.c             |    4 +-
>  security/selinux/hooks.c               |  242 ++++++++++++++++----------------
>  security/selinux/include/avc.h         |   16 +-
>  security/selinux/include/avc_ss.h      |    2 +-
>  security/selinux/include/conditional.h |    6 +-
>  security/selinux/include/netnode.h     |    2 +-
>  security/selinux/include/netport.h     |    2 +-
>  security/selinux/include/security.h    |   60 ++++----
>  security/selinux/netif.c               |    6 +-
>  security/selinux/netlabel.c            |   12 +-
>  security/selinux/netnode.c             |   20 ++--
>  security/selinux/netport.c             |    8 +-
>  security/selinux/selinuxfs.c           |   68 +++++-----
>  security/selinux/ss/services.c         |   90 ++++++------
>  security/selinux/xfrm.c                |   18 ++--
>  16 files changed, 296 insertions(+), 296 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 236aaa2..33dd9b5 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -203,7 +203,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  	char *scontext;
>  	u32 scontext_len;
>  
> -	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
> +	rc = selinux_ss_sid_to_context(ssid, &scontext, &scontext_len);
>  	if (rc)
>  		audit_log_format(ab, "ssid=%d", ssid);
>  	else {
> @@ -211,7 +211,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  		kfree(scontext);
>  	}
>  
> -	rc = security_sid_to_context(tsid, &scontext, &scontext_len);
> +	rc = selinux_ss_sid_to_context(tsid, &scontext, &scontext_len);
>  	if (rc)
>  		audit_log_format(ab, " tsid=%d", tsid);
>  	else {
> @@ -228,7 +228,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>   *
>   * Initialize the access vector cache.
>   */
> -void __init avc_init(void)
> +void __init selinux_avc_init(void)
>  {
>  	int i;
>  
> @@ -245,7 +245,7 @@ void __init avc_init(void)
>  	audit_log(current->audit_context, GFP_KERNEL, AUDIT_KERNEL, "AVC INITIALIZED\n");
>  }
>  
> -int avc_get_hash_stats(char *page)
> +int selinux_avc_get_hash_stats(char *page)
>  {
>  	int i, chain_len, max_chain_len, slots_used;
>  	struct avc_node *node;
> @@ -448,7 +448,7 @@ static int avc_latest_notif_update(int seqno, int is_insert)
>   * (@ssid, @tsid) and class @tclass.
>   * The access vectors and the sequence number are
>   * normally provided by the security server in
> - * response to a security_compute_av() call.  If the
> + * response to a selinux_ss_compute_av() call.  If the
>   * sequence number @avd->seqno is not less than the latest
>   * revocation notification, then the function copies
>   * the access vectors into a cache entry, returns
> @@ -523,14 +523,14 @@ static inline void avc_print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>   *
>   * Audit the granting or denial of permissions in accordance
>   * with the policy.  This function is typically called by
> - * avc_has_perm() after a permission check, but can also be
> - * called directly by callers who use avc_has_perm_noaudit()
> + * selinux_avc_has_perm() after a permission check, but can also be
> + * called directly by callers who use selinux_avc_has_perm_noaudit()
>   * in order to separate the permission check from the auditing.
>   * For example, this separation is useful when the permission check must
>   * be performed under a lock, to allow the lock to be released
>   * before calling the auditing code.
>   */
> -void avc_audit(u32 ssid, u32 tsid,
> +void selinux_avc_audit(u32 ssid, u32 tsid,
>  	       u16 tclass, u32 requested,
>  	       struct av_decision *avd, int result, struct avc_audit_data *a)
>  {
> @@ -706,7 +706,7 @@ void avc_audit(u32 ssid, u32 tsid,
>   * @perms based on @tclass.  Returns %0 on success or
>   * -%ENOMEM if insufficient memory exists to add the callback.
>   */
> -int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
> +int selinux_avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
>  				     u16 tclass, u32 perms,
>  				     u32 *out_retained),
>  		     u32 events, u32 ssid, u32 tsid,
> @@ -827,7 +827,7 @@ out:
>   * avc_ss_reset - Flush the cache and revalidate migrated permissions.
>   * @seqno: policy sequence number
>   */
> -int avc_ss_reset(u32 seqno)
> +int selinux_avc_ss_reset(u32 seqno)
>  {
>  	struct avc_callback_node *c;
>  	int i, rc = 0, tmprc;
> @@ -883,12 +883,12 @@ int avc_ss_reset(u32 seqno)
>   * a new decision and add it to the cache.  Return a copy of the decisions
>   * in @avd.  Return %0 if all @requested permissions are granted,
>   * -%EACCES if any permissions are denied, or another -errno upon
> - * other errors.  This function is typically called by avc_has_perm(),
> + * other errors.  This function is typically called by selinux_avc_has_perm(),
>   * but may also be called directly to separate permission checking from
>   * auditing, e.g. in cases where a lock must be held for the check but
>   * should be released for the auditing.
>   */
> -int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> +int selinux_avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  			 u16 tclass, u32 requested,
>  			 unsigned flags,
>  			 struct av_decision *in_avd)
> @@ -911,7 +911,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  		else
>  			avd = &avd_entry;
>  
> -		rc = security_compute_av(ssid, tsid, tclass, requested, avd);
> +		rc = selinux_ss_compute_av(ssid, tsid, tclass, requested, avd);
>  		if (rc)
>  			goto out;
>  		rcu_read_lock();
> @@ -955,23 +955,23 @@ out:
>   * permissions are granted, -%EACCES if any permissions are denied, or
>   * another -errno upon other errors.
>   */
> -int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
> +int selinux_avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
>  		 u32 requested, struct avc_audit_data *auditdata)
>  {
>  	struct av_decision avd;
>  	int rc;
>  
> -	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, 0, &avd);
> -	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
> +	rc = selinux_avc_has_perm_noaudit(ssid, tsid, tclass, requested, 0, &avd);
> +	selinux_avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
>  	return rc;
>  }
>  
> -u32 avc_policy_seqno(void)
> +u32 selinux_avc_policy_seqno(void)
>  {
>  	return avc_cache.latest_notif;
>  }
>  
> -void avc_disable(void)
> +void selinux_avc_disable(void)
>  {
>  	if (avc_node_cachep)
>  		kmem_cache_destroy(avc_node_cachep);
> diff --git a/security/selinux/exports.c b/security/selinux/exports.c
> index c73aeaa..aad7bc5 100644
> --- a/security/selinux/exports.c
> +++ b/security/selinux/exports.c
> @@ -28,7 +28,7 @@ extern atomic_t selinux_secmark_refcount;
>  int selinux_string_to_sid(char *str, u32 *sid)
>  {
>  	if (selinux_enabled)
> -		return security_context_to_sid(str, strlen(str), sid);
> +		return selinux_ss_context_to_sid(str, strlen(str), sid);
>  	else {
>  		*sid = 0;
>  		return 0;
> @@ -45,7 +45,7 @@ int selinux_secmark_relabel_packet_permission(u32 sid)
>  		__tsec = current_security();
>  		tsid = __tsec->sid;
>  
> -		return avc_has_perm(tsid, sid, SECCLASS_PACKET,
> +		return selinux_avc_has_perm(tsid, sid, SECCLASS_PACKET,
>  				    PACKET__RELABELTO, NULL);
>  	}
>  	return 0;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2081055..b1c409a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -373,12 +373,12 @@ static int may_context_mount_sb_relabel(u32 sid,
>  	const struct task_security_struct *tsec = cred->security;
>  	int rc;
>  
> -	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> +	rc = selinux_avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
>  			  FILESYSTEM__RELABELFROM, NULL);
>  	if (rc)
>  		return rc;
>  
> -	rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
> +	rc = selinux_avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
>  			  FILESYSTEM__RELABELTO, NULL);
>  	return rc;
>  }
> @@ -389,12 +389,12 @@ static int may_context_mount_inode_relabel(u32 sid,
>  {
>  	const struct task_security_struct *tsec = cred->security;
>  	int rc;
> -	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
> +	rc = selinux_avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
>  			  FILESYSTEM__RELABELFROM, NULL);
>  	if (rc)
>  		return rc;
>  
> -	rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
> +	rc = selinux_avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
>  			  FILESYSTEM__ASSOCIATE, NULL);
>  	return rc;
>  }
> @@ -525,21 +525,21 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
>  
>  	i = 0;
>  	if (sbsec->flags & FSCONTEXT_MNT) {
> -		rc = security_sid_to_context(sbsec->sid, &context, &len);
> +		rc = selinux_ss_sid_to_context(sbsec->sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
>  		opts->mnt_opts_flags[i++] = FSCONTEXT_MNT;
>  	}
>  	if (sbsec->flags & CONTEXT_MNT) {
> -		rc = security_sid_to_context(sbsec->mntpoint_sid, &context, &len);
> +		rc = selinux_ss_sid_to_context(sbsec->mntpoint_sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
>  		opts->mnt_opts_flags[i++] = CONTEXT_MNT;
>  	}
>  	if (sbsec->flags & DEFCONTEXT_MNT) {
> -		rc = security_sid_to_context(sbsec->def_sid, &context, &len);
> +		rc = selinux_ss_sid_to_context(sbsec->def_sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
> @@ -549,7 +549,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
>  		struct inode *root = sbsec->sb->s_root->d_inode;
>  		struct inode_security_struct *isec = root->i_security;
>  
> -		rc = security_sid_to_context(isec->sid, &context, &len);
> +		rc = selinux_ss_sid_to_context(isec->sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
> @@ -652,7 +652,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  
>  		if (flags[i] == SE_SBLABELSUPP)
>  			continue;
> -		rc = security_context_to_sid(mount_options[i],
> +		rc = selinux_ss_context_to_sid(mount_options[i],
>  					     strlen(mount_options[i]), &sid);
>  		if (rc) {
>  			printk(KERN_WARNING "SELinux: security_context_to_sid"
> @@ -717,9 +717,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  		sbsec->flags |= SE_SBPROC;
>  
>  	/* Determine the labeling behavior to use for this filesystem type. */
> -	rc = security_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
> +	rc = selinux_ss_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
>  	if (rc) {
> -		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
> +		printk(KERN_WARNING "%s: selinux_ss_fs_use(%s) returned %d\n",
>  		       __func__, sb->s_type->name, rc);
>  		goto out;
>  	}
> @@ -1201,7 +1201,7 @@ static int selinux_proc_get_sid(struct proc_dir_entry *de,
>  		path = end;
>  		de = de->parent;
>  	}
> -	rc = security_genfs_sid("proc", path, tclass, sid);
> +	rc = selinux_ss_genfs_sid("proc", path, tclass, sid);
>  	free_page((unsigned long)buffer);
>  	return rc;
>  }
> @@ -1318,7 +1318,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  			sid = sbsec->def_sid;
>  			rc = 0;
>  		} else {
> -			rc = security_context_to_sid_default(context, rc, &sid,
> +			rc = selinux_ss_context_to_sid_default(context, rc, &sid,
>  							     sbsec->def_sid,
>  							     GFP_NOFS);
>  			if (rc) {
> @@ -1353,7 +1353,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  
>  		/* Try to obtain a transition SID. */
>  		isec->sclass = inode_mode_to_security_class(inode->i_mode);
> -		rc = security_transition_sid(isec->task_sid,
> +		rc = selinux_ss_transition_sid(isec->task_sid,
>  					     sbsec->sid,
>  					     isec->sclass,
>  					     &sid);
> @@ -1430,7 +1430,7 @@ static int cred_has_perm(const struct cred *actor,
>  {
>  	u32 asid = cred_sid(actor), tsid = cred_sid(target);
>  
> -	return avc_has_perm(asid, tsid, SECCLASS_PROCESS, perms, NULL);
> +	return selinux_avc_has_perm(asid, tsid, SECCLASS_PROCESS, perms, NULL);
>  }
>  
>  /*
> @@ -1450,7 +1450,7 @@ static int task_has_perm(const struct task_struct *tsk1,
>  	__tsec1 = __task_cred(tsk1)->security;	sid1 = __tsec1->sid;
>  	__tsec2 = __task_cred(tsk2)->security;	sid2 = __tsec2->sid;
>  	rcu_read_unlock();
> -	return avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms, NULL);
> +	return selinux_avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms, NULL);
>  }
>  
>  /*
> @@ -1466,7 +1466,7 @@ static int current_has_perm(const struct task_struct *tsk,
>  
>  	sid = current_sid();
>  	tsid = task_sid(tsk);
> -	return avc_has_perm(sid, tsid, SECCLASS_PROCESS, perms, NULL);
> +	return selinux_avc_has_perm(sid, tsid, SECCLASS_PROCESS, perms, NULL);
>  }
>  
>  #if CAP_LAST_CAP > 63
> @@ -1502,9 +1502,9 @@ static int task_has_capability(struct task_struct *tsk,
>  		BUG();
>  	}
>  
> -	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
> +	rc = selinux_avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
>  	if (audit == SECURITY_CAP_AUDIT)
> -		avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
> +		selinux_avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
>  	return rc;
>  }
>  
> @@ -1514,7 +1514,7 @@ static int task_has_system(struct task_struct *tsk,
>  {
>  	u32 sid = task_sid(tsk);
>  
> -	return avc_has_perm(sid, SECINITSID_KERNEL,
> +	return selinux_avc_has_perm(sid, SECINITSID_KERNEL,
>  			    SECCLASS_SYSTEM, perms, NULL);
>  }
>  
> @@ -1542,7 +1542,7 @@ static int inode_has_perm(const struct cred *cred,
>  		ad.u.fs.inode = inode;
>  	}
>  
> -	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
> +	return selinux_avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
>  }
>  
>  /* Same as inode_has_perm, but pass explicit audit data containing
> @@ -1584,7 +1584,7 @@ static int file_has_perm(const struct cred *cred,
>  	ad.u.fs.path = file->f_path;
>  
>  	if (sid != fsec->sid) {
> -		rc = avc_has_perm(sid, fsec->sid,
> +		rc = selinux_avc_has_perm(sid, fsec->sid,
>  				  SECCLASS_FD,
>  				  FD__USE,
>  				  &ad);
> @@ -1623,23 +1623,23 @@ static int may_create(struct inode *dir,
>  	AVC_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.dentry = dentry;
>  
> -	rc = avc_has_perm(sid, dsec->sid, SECCLASS_DIR,
> +	rc = selinux_avc_has_perm(sid, dsec->sid, SECCLASS_DIR,
>  			  DIR__ADD_NAME | DIR__SEARCH,
>  			  &ad);
>  	if (rc)
>  		return rc;
>  
>  	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
> -		rc = security_transition_sid(sid, dsec->sid, tclass, &newsid);
> +		rc = selinux_ss_transition_sid(sid, dsec->sid, tclass, &newsid);
>  		if (rc)
>  			return rc;
>  	}
>  
> -	rc = avc_has_perm(sid, newsid, tclass, FILE__CREATE, &ad);
> +	rc = selinux_avc_has_perm(sid, newsid, tclass, FILE__CREATE, &ad);
>  	if (rc)
>  		return rc;
>  
> -	return avc_has_perm(newsid, sbsec->sid,
> +	return selinux_avc_has_perm(newsid, sbsec->sid,
>  			    SECCLASS_FILESYSTEM,
>  			    FILESYSTEM__ASSOCIATE, &ad);
>  }
> @@ -1650,7 +1650,7 @@ static int may_create_key(u32 ksid,
>  {
>  	u32 sid = task_sid(ctx);
>  
> -	return avc_has_perm(sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
> +	return selinux_avc_has_perm(sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
>  }
>  
>  #define MAY_LINK	0
> @@ -1677,7 +1677,7 @@ static int may_link(struct inode *dir,
>  
>  	av = DIR__SEARCH;
>  	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
> -	rc = avc_has_perm(sid, dsec->sid, SECCLASS_DIR, av, &ad);
> +	rc = selinux_avc_has_perm(sid, dsec->sid, SECCLASS_DIR, av, &ad);
>  	if (rc)
>  		return rc;
>  
> @@ -1697,7 +1697,7 @@ static int may_link(struct inode *dir,
>  		return 0;
>  	}
>  
> -	rc = avc_has_perm(sid, isec->sid, isec->sclass, av, &ad);
> +	rc = selinux_avc_has_perm(sid, isec->sid, isec->sclass, av, &ad);
>  	return rc;
>  }
>  
> @@ -1721,16 +1721,16 @@ static inline int may_rename(struct inode *old_dir,
>  	AVC_AUDIT_DATA_INIT(&ad, FS);
>  
>  	ad.u.fs.path.dentry = old_dentry;
> -	rc = avc_has_perm(sid, old_dsec->sid, SECCLASS_DIR,
> +	rc = selinux_avc_has_perm(sid, old_dsec->sid, SECCLASS_DIR,
>  			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
>  	if (rc)
>  		return rc;
> -	rc = avc_has_perm(sid, old_isec->sid,
> +	rc = selinux_avc_has_perm(sid, old_isec->sid,
>  			  old_isec->sclass, FILE__RENAME, &ad);
>  	if (rc)
>  		return rc;
>  	if (old_is_dir && new_dir != old_dir) {
> -		rc = avc_has_perm(sid, old_isec->sid,
> +		rc = selinux_avc_has_perm(sid, old_isec->sid,
>  				  old_isec->sclass, DIR__REPARENT, &ad);
>  		if (rc)
>  			return rc;
> @@ -1740,13 +1740,13 @@ static inline int may_rename(struct inode *old_dir,
>  	av = DIR__ADD_NAME | DIR__SEARCH;
>  	if (new_dentry->d_inode)
>  		av |= DIR__REMOVE_NAME;
> -	rc = avc_has_perm(sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
> +	rc = selinux_avc_has_perm(sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
>  	if (rc)
>  		return rc;
>  	if (new_dentry->d_inode) {
>  		new_isec = new_dentry->d_inode->i_security;
>  		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
> -		rc = avc_has_perm(sid, new_isec->sid,
> +		rc = selinux_avc_has_perm(sid, new_isec->sid,
>  				  new_isec->sclass,
>  				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
>  		if (rc)
> @@ -1766,7 +1766,7 @@ static int superblock_has_perm(const struct cred *cred,
>  	u32 sid = cred_sid(cred);
>  
>  	sbsec = sb->s_security;
> -	return avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
> +	return selinux_avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
>  }
>  
>  /* Convert a Linux mode and permission mask to an access vector. */
> @@ -1866,7 +1866,7 @@ static int selinux_ptrace_access_check(struct task_struct *child,
>  	if (mode == PTRACE_MODE_READ) {
>  		u32 sid = current_sid();
>  		u32 csid = task_sid(child);
> -		return avc_has_perm(sid, csid, SECCLASS_FILE, FILE__READ, NULL);
> +		return selinux_avc_has_perm(sid, csid, SECCLASS_FILE, FILE__READ, NULL);
>  	}
>  
>  	return current_has_perm(child, PROCESS__PTRACE);
> @@ -1966,7 +1966,7 @@ static int selinux_sysctl_get_sid(ctl_table *table, u16 tclass, u32 *sid)
>  	end -= 4;
>  	memcpy(end, "/sys", 4);
>  	path = end;
> -	rc = security_genfs_sid("proc", path, tclass, sid);
> +	rc = selinux_ss_genfs_sid("proc", path, tclass, sid);
>  out_free:
>  	free_page((unsigned long)buffer);
>  out:
> @@ -1992,7 +1992,7 @@ static int selinux_sysctl(ctl_table *table, int op)
>  	/* The op values are "defined" in sysctl.c, thereby creating
>  	 * a bad coupling between this module and sysctl.c */
>  	if (op == 001) {
> -		error = avc_has_perm(sid, tsid,
> +		error = selinux_avc_has_perm(sid, tsid,
>  				     SECCLASS_DIR, DIR__SEARCH, NULL);
>  	} else {
>  		av = 0;
> @@ -2001,7 +2001,7 @@ static int selinux_sysctl(ctl_table *table, int op)
>  		if (op & 002)
>  			av |= FILE__WRITE;
>  		if (av)
> -			error = avc_has_perm(sid, tsid,
> +			error = selinux_avc_has_perm(sid, tsid,
>  					     SECCLASS_FILE, av, NULL);
>  	}
>  
> @@ -2132,7 +2132,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  		new_tsec->exec_sid = 0;
>  	} else {
>  		/* Check for a default transition on this program. */
> -		rc = security_transition_sid(old_tsec->sid, isec->sid,
> +		rc = selinux_ss_transition_sid(old_tsec->sid, isec->sid,
>  					     SECCLASS_PROCESS, &new_tsec->sid);
>  		if (rc)
>  			return rc;
> @@ -2145,25 +2145,25 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  		new_tsec->sid = old_tsec->sid;
>  
>  	if (new_tsec->sid == old_tsec->sid) {
> -		rc = avc_has_perm(old_tsec->sid, isec->sid,
> +		rc = selinux_avc_has_perm(old_tsec->sid, isec->sid,
>  				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
>  		if (rc)
>  			return rc;
>  	} else {
>  		/* Check permissions for the transition. */
> -		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
> +		rc = selinux_avc_has_perm(old_tsec->sid, new_tsec->sid,
>  				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
>  		if (rc)
>  			return rc;
>  
> -		rc = avc_has_perm(new_tsec->sid, isec->sid,
> +		rc = selinux_avc_has_perm(new_tsec->sid, isec->sid,
>  				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
>  		if (rc)
>  			return rc;
>  
>  		/* Check for shared state */
>  		if (bprm->unsafe & LSM_UNSAFE_SHARE) {
> -			rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
> +			rc = selinux_avc_has_perm(old_tsec->sid, new_tsec->sid,
>  					  SECCLASS_PROCESS, PROCESS__SHARE,
>  					  NULL);
>  			if (rc)
> @@ -2187,7 +2187,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  			rcu_read_unlock();
>  
>  			if (ptsid != 0) {
> -				rc = avc_has_perm(ptsid, new_tsec->sid,
> +				rc = selinux_avc_has_perm(ptsid, new_tsec->sid,
>  						  SECCLASS_PROCESS,
>  						  PROCESS__PTRACE, NULL);
>  				if (rc)
> @@ -2216,7 +2216,7 @@ static int selinux_bprm_secureexec(struct linux_binprm *bprm)
>  		/* Enable secure mode for SIDs transitions unless
>  		   the noatsecure permission is granted between
>  		   the two SIDs, i.e. ahp returns 0. */
> -		atsecure = avc_has_perm(osid, sid,
> +		atsecure = selinux_avc_has_perm(osid, sid,
>  					SECCLASS_PROCESS,
>  					PROCESS__NOATSECURE, NULL);
>  	}
> @@ -2351,7 +2351,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
>  	 * higher than the default soft limit for cases where the default is
>  	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
>  	 */
> -	rc = avc_has_perm(new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
> +	rc = selinux_avc_has_perm(new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
>  			  PROCESS__RLIMITINH, NULL);
>  	if (rc) {
>  		for (i = 0; i < RLIM_NLIMITS; i++) {
> @@ -2387,7 +2387,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>  	 * This must occur _after_ the task SID has been updated so that any
>  	 * kill done after the flush will be checked against the new SID.
>  	 */
> -	rc = avc_has_perm(osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
> +	rc = selinux_avc_has_perm(osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
>  	if (rc) {
>  		memset(&itimer, 0, sizeof itimer);
>  		for (i = 0; i < 3; i++)
> @@ -2595,7 +2595,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	newsid = tsec->create_sid;
>  
>  	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
> -		rc = security_transition_sid(sid, dsec->sid,
> +		rc = selinux_ss_transition_sid(sid, dsec->sid,
>  					     inode_mode_to_security_class(inode->i_mode),
>  					     &newsid);
>  		if (rc) {
> @@ -2627,7 +2627,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	}
>  
>  	if (value && len) {
> -		rc = security_sid_to_context_force(newsid, &context, &clen);
> +		rc = selinux_ss_sid_to_context_force(newsid, &context, &clen);
>  		if (rc) {
>  			kfree(namep);
>  			return rc;
> @@ -2772,31 +2772,31 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	AVC_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.dentry = dentry;
>  
> -	rc = avc_has_perm(sid, isec->sid, isec->sclass,
> +	rc = selinux_avc_has_perm(sid, isec->sid, isec->sclass,
>  			  FILE__RELABELFROM, &ad);
>  	if (rc)
>  		return rc;
>  
> -	rc = security_context_to_sid(value, size, &newsid);
> +	rc = selinux_ss_context_to_sid(value, size, &newsid);
>  	if (rc == -EINVAL) {
>  		if (!capable(CAP_MAC_ADMIN))
>  			return rc;
> -		rc = security_context_to_sid_force(value, size, &newsid);
> +		rc = selinux_ss_context_to_sid_force(value, size, &newsid);
>  	}
>  	if (rc)
>  		return rc;
>  
> -	rc = avc_has_perm(sid, newsid, isec->sclass,
> +	rc = selinux_avc_has_perm(sid, newsid, isec->sclass,
>  			  FILE__RELABELTO, &ad);
>  	if (rc)
>  		return rc;
>  
> -	rc = security_validate_transition(isec->sid, newsid, sid,
> +	rc = selinux_ss_validate_transition(isec->sid, newsid, sid,
>  					  isec->sclass);
>  	if (rc)
>  		return rc;
>  
> -	return avc_has_perm(newsid,
> +	return selinux_avc_has_perm(newsid,
>  			    sbsec->sid,
>  			    SECCLASS_FILESYSTEM,
>  			    FILESYSTEM__ASSOCIATE,
> @@ -2817,7 +2817,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>  		return;
>  	}
>  
> -	rc = security_context_to_sid_force(value, size, &newsid);
> +	rc = selinux_ss_context_to_sid_force(value, size, &newsid);
>  	if (rc) {
>  		printk(KERN_ERR "SELinux:  unable to map context to SID"
>  		       "for (%s, %lu), rc=%d\n",
> @@ -2880,10 +2880,10 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
>  	error = selinux_capable(current, current_cred(), CAP_MAC_ADMIN,
>  				SECURITY_CAP_NOAUDIT);
>  	if (!error)
> -		error = security_sid_to_context_force(isec->sid, &context,
> +		error = selinux_ss_sid_to_context_force(isec->sid, &context,
>  						      &size);
>  	else
> -		error = security_sid_to_context(isec->sid, &context, &size);
> +		error = selinux_ss_sid_to_context(isec->sid, &context, &size);
>  	if (error)
>  		return error;
>  	error = size;
> @@ -2909,7 +2909,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  	if (!value || !size)
>  		return -EACCES;
>  
> -	rc = security_context_to_sid((void *)value, size, &newsid);
> +	rc = selinux_ss_context_to_sid((void *)value, size, &newsid);
>  	if (rc)
>  		return rc;
>  
> @@ -2958,7 +2958,7 @@ static int selinux_file_permission(struct file *file, int mask)
>  		return 0;
>  
>  	if (sid == fsec->sid && fsec->isid == isec->sid &&
> -	    fsec->pseqno == avc_policy_seqno())
> +	    fsec->pseqno == selinux_avc_policy_seqno())
>  		/* No change since dentry_open check. */
>  		return 0;
>  
> @@ -3035,7 +3035,7 @@ static int selinux_file_mmap(struct file *file, unsigned long reqprot,
>  	u32 sid = current_sid();
>  
>  	if (addr < mmap_min_addr)
> -		rc = avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
> +		rc = selinux_avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
>  				  MEMPROTECT__MMAP_ZERO, NULL);
>  	if (rc || addr_only)
>  		return rc;
> @@ -3164,7 +3164,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
>  	else
>  		perm = signal_to_av(signum);
>  
> -	return avc_has_perm(fsec->fown_sid, sid,
> +	return selinux_avc_has_perm(fsec->fown_sid, sid,
>  			    SECCLASS_PROCESS, perm, NULL);
>  }
>  
> @@ -3192,7 +3192,7 @@ static int selinux_dentry_open(struct file *file, const struct cred *cred)
>  	 * struct as its SID.
>  	 */
>  	fsec->isid = isec->sid;
> -	fsec->pseqno = avc_policy_seqno();
> +	fsec->pseqno = selinux_avc_policy_seqno();
>  	/*
>  	 * Since the inode label or policy seqno may have changed
>  	 * between the selinux_inode_permission check and the saving
> @@ -3250,7 +3250,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
>  	u32 sid = current_sid();
>  	int ret;
>  
> -	ret = avc_has_perm(sid, secid,
> +	ret = selinux_avc_has_perm(sid, secid,
>  			   SECCLASS_KERNEL_SERVICE,
>  			   KERNEL_SERVICE__USE_AS_OVERRIDE,
>  			   NULL);
> @@ -3274,7 +3274,7 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
>  	u32 sid = current_sid();
>  	int ret;
>  
> -	ret = avc_has_perm(sid, isec->sid,
> +	ret = selinux_avc_has_perm(sid, isec->sid,
>  			   SECCLASS_KERNEL_SERVICE,
>  			   KERNEL_SERVICE__CREATE_FILES_AS,
>  			   NULL);
> @@ -3377,7 +3377,7 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
>  	else
>  		perm = signal_to_av(sig);
>  	if (secid)
> -		rc = avc_has_perm(secid, task_sid(p),
> +		rc = selinux_avc_has_perm(secid, task_sid(p),
>  				  SECCLASS_PROCESS, perm, NULL);
>  	else
>  		rc = current_has_perm(p, perm);
> @@ -3619,7 +3619,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
>  	selinux_skb_xfrm_sid(skb, &xfrm_sid);
>  	selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
>  
> -	err = security_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
> +	err = selinux_ss_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
>  	if (unlikely(err)) {
>  		printk(KERN_WARNING
>  		       "SELinux: failure in selinux_skb_peerlbl_sid(),"
> @@ -3647,7 +3647,7 @@ static int socket_has_perm(struct task_struct *task, struct socket *sock,
>  
>  	AVC_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.sk = sock->sk;
> -	err = avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
> +	err = selinux_avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
>  
>  out:
>  	return err;
> @@ -3669,7 +3669,7 @@ static int selinux_socket_create(int family, int type,
>  	newsid = tsec->sockcreate_sid ?: sid;
>  
>  	secclass = socket_type_to_security_class(family, type, protocol);
> -	err = avc_has_perm(sid, newsid, secclass, SOCKET__CREATE, NULL);
> +	err = selinux_avc_has_perm(sid, newsid, secclass, SOCKET__CREATE, NULL);
>  
>  out:
>  	return err;
> @@ -3757,14 +3757,14 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  			inet_get_local_port_range(&low, &high);
>  
>  			if (snum < max(PROT_SOCK, low) || snum > high) {
> -				err = sel_netport_sid(sk->sk_protocol,
> +				err = selinux_netport_sid(sk->sk_protocol,
>  						      snum, &sid);
>  				if (err)
>  					goto out;
>  				AVC_AUDIT_DATA_INIT(&ad, NET);
>  				ad.u.net.sport = htons(snum);
>  				ad.u.net.family = family;
> -				err = avc_has_perm(isec->sid, sid,
> +				err = selinux_avc_has_perm(isec->sid, sid,
>  						   isec->sclass,
>  						   SOCKET__NAME_BIND, &ad);
>  				if (err)
> @@ -3790,7 +3790,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  			break;
>  		}
>  
> -		err = sel_netnode_sid(addrp, family, &sid);
> +		err = selinux_netnode_sid(addrp, family, &sid);
>  		if (err)
>  			goto out;
>  
> @@ -3803,7 +3803,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  		else
>  			ipv6_addr_copy(&ad.u.net.v6info.saddr, &addr6->sin6_addr);
>  
> -		err = avc_has_perm(isec->sid, sid,
> +		err = selinux_avc_has_perm(isec->sid, sid,
>  				   isec->sclass, node_perm, &ad);
>  		if (err)
>  			goto out;
> @@ -3846,7 +3846,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
>  			snum = ntohs(addr6->sin6_port);
>  		}
>  
> -		err = sel_netport_sid(sk->sk_protocol, snum, &sid);
> +		err = selinux_netport_sid(sk->sk_protocol, snum, &sid);
>  		if (err)
>  			goto out;
>  
> @@ -3856,7 +3856,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
>  		AVC_AUDIT_DATA_INIT(&ad, NET);
>  		ad.u.net.dport = htons(snum);
>  		ad.u.net.family = sk->sk_family;
> -		err = avc_has_perm(isec->sid, sid, isec->sclass, perm, &ad);
> +		err = selinux_avc_has_perm(isec->sid, sid, isec->sclass, perm, &ad);
>  		if (err)
>  			goto out;
>  	}
> @@ -3952,7 +3952,7 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
>  	AVC_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.sk = other->sk;
>  
> -	err = avc_has_perm(isec->sid, other_isec->sid,
> +	err = selinux_avc_has_perm(isec->sid, other_isec->sid,
>  			   isec->sclass,
>  			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
>  	if (err)
> @@ -3965,7 +3965,7 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
>  	/* server child socket */
>  	ssec = newsk->sk_security;
>  	ssec->peer_sid = isec->sid;
> -	err = security_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
> +	err = selinux_ss_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
>  
>  	return err;
>  }
> @@ -3984,7 +3984,7 @@ static int selinux_socket_unix_may_send(struct socket *sock,
>  	AVC_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.sk = other->sk;
>  
> -	err = avc_has_perm(isec->sid, other_isec->sid,
> +	err = selinux_avc_has_perm(isec->sid, other_isec->sid,
>  			   isec->sclass, SOCKET__SENDTO, &ad);
>  	if (err)
>  		return err;
> @@ -4003,15 +4003,15 @@ static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16 family,
>  	err = sel_netif_sid(ifindex, &if_sid);
>  	if (err)
>  		return err;
> -	err = avc_has_perm(peer_sid, if_sid,
> +	err = selinux_avc_has_perm(peer_sid, if_sid,
>  			   SECCLASS_NETIF, NETIF__INGRESS, ad);
>  	if (err)
>  		return err;
>  
> -	err = sel_netnode_sid(addrp, family, &node_sid);
> +	err = selinux_netnode_sid(addrp, family, &node_sid);
>  	if (err)
>  		return err;
> -	return avc_has_perm(peer_sid, node_sid,
> +	return selinux_avc_has_perm(peer_sid, node_sid,
>  			    SECCLASS_NODE, NODE__RECVFROM, ad);
>  }
>  
> @@ -4033,7 +4033,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>  		return err;
>  
>  	if (selinux_secmark_enabled()) {
> -		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
> +		err = selinux_avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
>  				   PACKET__RECV, &ad);
>  		if (err)
>  			return err;
> @@ -4043,7 +4043,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>  		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
>  		if (err)
>  			return err;
> -		err = avc_has_perm(sk_sid, peer_sid,
> +		err = selinux_avc_has_perm(sk_sid, peer_sid,
>  				   SECCLASS_PEER, PEER__RECV, &ad);
>  		if (err)
>  			selinux_netlbl_err(skb, err, 0);
> @@ -4106,14 +4106,14 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  			selinux_netlbl_err(skb, err, 0);
>  			return err;
>  		}
> -		err = avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER,
> +		err = selinux_avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER,
>  				   PEER__RECV, &ad);
>  		if (err)
>  			selinux_netlbl_err(skb, err, 0);
>  	}
>  
>  	if (secmark_active) {
> -		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
> +		err = selinux_avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
>  				   PACKET__RECV, &ad);
>  		if (err)
>  			return err;
> @@ -4144,7 +4144,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
>  		goto out;
>  	}
>  
> -	err = security_sid_to_context(peer_sid, &scontext, &scontext_len);
> +	err = selinux_ss_sid_to_context(peer_sid, &scontext, &scontext_len);
>  
>  	if (err)
>  		goto out;
> @@ -4256,7 +4256,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>  		req->secid = sksec->sid;
>  		req->peer_secid = SECSID_NULL;
>  	} else {
> -		err = security_sid_mls_copy(sksec->sid, peersid, &newsid);
> +		err = selinux_ss_sid_mls_copy(sksec->sid, peersid, &newsid);
>  		if (err)
>  			return err;
>  		req->secid = newsid;
> @@ -4322,7 +4322,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
>  				  "SELinux:  unrecognized netlink message"
>  				  " type=%hu for sclass=%hu\n",
>  				  nlh->nlmsg_type, isec->sclass);
> -			if (!selinux_enforcing || security_get_allow_unknown())
> +			if (!selinux_enforcing || selinux_ss_get_allow_unknown())
>  				err = 0;
>  		}
>  
> @@ -4378,7 +4378,7 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb, int ifindex,
>  	}
>  
>  	if (secmark_active)
> -		if (avc_has_perm(peer_sid, skb->secmark,
> +		if (selinux_avc_has_perm(peer_sid, skb->secmark,
>  				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
>  			return NF_DROP;
>  
> @@ -4465,7 +4465,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
>  		return NF_DROP;
>  
>  	if (selinux_secmark_enabled())
> -		if (avc_has_perm(sksec->sid, skb->secmark,
> +		if (selinux_avc_has_perm(sksec->sid, skb->secmark,
>  				 SECCLASS_PACKET, PACKET__SEND, &ad))
>  			return NF_DROP;
>  
> @@ -4548,7 +4548,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  		return NF_DROP;
>  
>  	if (secmark_active)
> -		if (avc_has_perm(peer_sid, skb->secmark,
> +		if (selinux_avc_has_perm(peer_sid, skb->secmark,
>  				 SECCLASS_PACKET, secmark_perm, &ad))
>  			return NF_DROP;
>  
> @@ -4558,13 +4558,13 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  
>  		if (sel_netif_sid(ifindex, &if_sid))
>  			return NF_DROP;
> -		if (avc_has_perm(peer_sid, if_sid,
> +		if (selinux_avc_has_perm(peer_sid, if_sid,
>  				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
>  			return NF_DROP;
>  
> -		if (sel_netnode_sid(addrp, family, &node_sid))
> +		if (selinux_netnode_sid(addrp, family, &node_sid))
>  			return NF_DROP;
> -		if (avc_has_perm(peer_sid, node_sid,
> +		if (selinux_avc_has_perm(peer_sid, node_sid,
>  				 SECCLASS_NODE, NODE__SENDTO, &ad))
>  			return NF_DROP;
>  	}
> @@ -4620,7 +4620,7 @@ static int selinux_netlink_recv(struct sk_buff *skb, int capability)
>  	AVC_AUDIT_DATA_INIT(&ad, CAP);
>  	ad.u.cap = capability;
>  
> -	return avc_has_perm(NETLINK_CB(skb).sid, NETLINK_CB(skb).sid,
> +	return selinux_avc_has_perm(NETLINK_CB(skb).sid, NETLINK_CB(skb).sid,
>  			    SECCLASS_CAPABILITY, CAP_TO_MASK(capability), &ad);
>  }
>  
> @@ -4684,7 +4684,7 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = ipc_perms->key;
>  
> -	return avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
> +	return selinux_avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
>  }
>  
>  static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
> @@ -4714,7 +4714,7 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = msq->q_perm.key;
>  
> -	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
> +	rc = selinux_avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
>  			  MSGQ__CREATE, &ad);
>  	if (rc) {
>  		ipc_free_security(&msq->q_perm);
> @@ -4739,7 +4739,7 @@ static int selinux_msg_queue_associate(struct msg_queue *msq, int msqflg)
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = msq->q_perm.key;
>  
> -	return avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
> +	return selinux_avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
>  			    MSGQ__ASSOCIATE, &ad);
>  }
>  
> @@ -4790,7 +4790,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  		 * Compute new sid based on current process and
>  		 * message queue this message will be stored in
>  		 */
> -		rc = security_transition_sid(sid, isec->sid, SECCLASS_MSG,
> +		rc = selinux_ss_transition_sid(sid, isec->sid, SECCLASS_MSG,
>  					     &msec->sid);
>  		if (rc)
>  			return rc;
> @@ -4800,15 +4800,15 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  	ad.u.ipc_id = msq->q_perm.key;
>  
>  	/* Can this process write to the queue? */
> -	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
> +	rc = selinux_avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
>  			  MSGQ__WRITE, &ad);
>  	if (!rc)
>  		/* Can this process send the message */
> -		rc = avc_has_perm(sid, msec->sid, SECCLASS_MSG,
> +		rc = selinux_avc_has_perm(sid, msec->sid, SECCLASS_MSG,
>  				  MSG__SEND, &ad);
>  	if (!rc)
>  		/* Can the message be put in the queue? */
> -		rc = avc_has_perm(msec->sid, isec->sid, SECCLASS_MSGQ,
> +		rc = selinux_avc_has_perm(msec->sid, isec->sid, SECCLASS_MSGQ,
>  				  MSGQ__ENQUEUE, &ad);
>  
>  	return rc;
> @@ -4830,10 +4830,10 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = msq->q_perm.key;
>  
> -	rc = avc_has_perm(sid, isec->sid,
> +	rc = selinux_avc_has_perm(sid, isec->sid,
>  			  SECCLASS_MSGQ, MSGQ__READ, &ad);
>  	if (!rc)
> -		rc = avc_has_perm(sid, msec->sid,
> +		rc = selinux_avc_has_perm(sid, msec->sid,
>  				  SECCLASS_MSG, MSG__RECEIVE, &ad);
>  	return rc;
>  }
> @@ -4855,7 +4855,7 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = shp->shm_perm.key;
>  
> -	rc = avc_has_perm(sid, isec->sid, SECCLASS_SHM,
> +	rc = selinux_avc_has_perm(sid, isec->sid, SECCLASS_SHM,
>  			  SHM__CREATE, &ad);
>  	if (rc) {
>  		ipc_free_security(&shp->shm_perm);
> @@ -4880,7 +4880,7 @@ static int selinux_shm_associate(struct shmid_kernel *shp, int shmflg)
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = shp->shm_perm.key;
>  
> -	return avc_has_perm(sid, isec->sid, SECCLASS_SHM,
> +	return selinux_avc_has_perm(sid, isec->sid, SECCLASS_SHM,
>  			    SHM__ASSOCIATE, &ad);
>  }
>  
> @@ -4947,7 +4947,7 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = sma->sem_perm.key;
>  
> -	rc = avc_has_perm(sid, isec->sid, SECCLASS_SEM,
> +	rc = selinux_avc_has_perm(sid, isec->sid, SECCLASS_SEM,
>  			  SEM__CREATE, &ad);
>  	if (rc) {
>  		ipc_free_security(&sma->sem_perm);
> @@ -4972,7 +4972,7 @@ static int selinux_sem_associate(struct sem_array *sma, int semflg)
>  	AVC_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = sma->sem_perm.key;
>  
> -	return avc_has_perm(sid, isec->sid, SECCLASS_SEM,
> +	return selinux_avc_has_perm(sid, isec->sid, SECCLASS_SEM,
>  			    SEM__ASSOCIATE, &ad);
>  }
>  
> @@ -5095,7 +5095,7 @@ static int selinux_getprocattr(struct task_struct *p,
>  	if (!sid)
>  		return 0;
>  
> -	error = security_sid_to_context(sid, value, &len);
> +	error = selinux_ss_sid_to_context(sid, value, &len);
>  	if (error)
>  		return error;
>  	return len;
> @@ -5147,11 +5147,11 @@ static int selinux_setprocattr(struct task_struct *p,
>  			str[size-1] = 0;
>  			size--;
>  		}
> -		error = security_context_to_sid(value, size, &sid);
> +		error = selinux_ss_context_to_sid(value, size, &sid);
>  		if (error == -EINVAL && !strcmp(name, "fscreate")) {
>  			if (!capable(CAP_MAC_ADMIN))
>  				return error;
> -			error = security_context_to_sid_force(value, size,
> +			error = selinux_ss_context_to_sid_force(value, size,
>  							      &sid);
>  		}
>  		if (error)
> @@ -5188,13 +5188,13 @@ static int selinux_setprocattr(struct task_struct *p,
>  		/* Only allow single threaded processes to change context */
>  		error = -EPERM;
>  		if (!is_single_threaded(p)) {
> -			error = security_bounded_transition(tsec->sid, sid);
> +			error = selinux_ss_bounded_transition(tsec->sid, sid);
>  			if (error)
>  				goto abort_change;
>  		}
>  
>  		/* Check permissions for the transition. */
> -		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
> +		error = selinux_avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
>  				     PROCESS__DYNTRANSITION, NULL);
>  		if (error)
>  			goto abort_change;
> @@ -5209,7 +5209,7 @@ static int selinux_setprocattr(struct task_struct *p,
>  		task_unlock(p);
>  
>  		if (tracer) {
> -			error = avc_has_perm(ptsid, sid, SECCLASS_PROCESS,
> +			error = selinux_avc_has_perm(ptsid, sid, SECCLASS_PROCESS,
>  					     PROCESS__PTRACE, NULL);
>  			if (error)
>  				goto abort_change;
> @@ -5231,12 +5231,12 @@ abort_change:
>  
>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
> -	return security_sid_to_context(secid, secdata, seclen);
> +	return selinux_ss_sid_to_context(secid, secdata, seclen);
>  }
>  
>  static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  {
> -	return security_context_to_sid(secdata, seclen, secid);
> +	return selinux_ss_context_to_sid(secdata, seclen, secid);
>  }
>  
>  static void selinux_release_secctx(char *secdata, u32 seclen)
> @@ -5293,7 +5293,7 @@ static int selinux_key_permission(key_ref_t key_ref,
>  	key = key_ref_to_ptr(key_ref);
>  	ksec = key->security;
>  
> -	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
> +	return selinux_avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
>  }
>  
>  static int selinux_key_getsecurity(struct key *key, char **_buffer)
> @@ -5303,7 +5303,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  	unsigned len;
>  	int rc;
>  
> -	rc = security_sid_to_context(ksec->sid, &context, &len);
> +	rc = selinux_ss_sid_to_context(ksec->sid, &context, &len);
>  	if (!rc)
>  		rc = len;
>  	*_buffer = context;
> @@ -5518,7 +5518,7 @@ static __init int selinux_init(void)
>  	sel_inode_cache = kmem_cache_create("selinux_inode_security",
>  					    sizeof(struct inode_security_struct),
>  					    0, SLAB_PANIC, NULL);
> -	avc_init();
> +	selinux_avc_init();
>  
>  	secondary_ops = security_ops;
>  	if (!secondary_ops)
> @@ -5684,7 +5684,7 @@ int selinux_disable(void)
>  	selinux_enabled = 0;
>  
>  	/* Try to destroy the avc node cache */
> -	avc_disable();
> +	selinux_avc_disable();
>  
>  	/* Reset security_ops to the secondary module, dummy or capability. */
>  	security_ops = secondary_ops;
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index ae4c3a0..3979cb4 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -94,23 +94,23 @@ struct avc_cache_stats {
>   * AVC operations
>   */
>  
> -void __init avc_init(void);
> +void __init selinux_avc_init(void);
>  
> -void avc_audit(u32 ssid, u32 tsid,
> +void selinux_avc_audit(u32 ssid, u32 tsid,
>  	       u16 tclass, u32 requested,
>  	       struct av_decision *avd, int result, struct avc_audit_data *auditdata);
>  
>  #define AVC_STRICT 1 /* Ignore permissive mode. */
> -int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> +int selinux_avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  			 u16 tclass, u32 requested,
>  			 unsigned flags,
>  			 struct av_decision *avd);
>  
> -int avc_has_perm(u32 ssid, u32 tsid,
> +int selinux_avc_has_perm(u32 ssid, u32 tsid,
>  		 u16 tclass, u32 requested,
>  		 struct avc_audit_data *auditdata);
>  
> -u32 avc_policy_seqno(void);
> +u32 selinux_avc_policy_seqno(void);
>  
>  #define AVC_CALLBACK_GRANT		1
>  #define AVC_CALLBACK_TRY_REVOKE		2
> @@ -121,18 +121,18 @@ u32 avc_policy_seqno(void);
>  #define AVC_CALLBACK_AUDITDENY_ENABLE	64
>  #define AVC_CALLBACK_AUDITDENY_DISABLE	128
>  
> -int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
> +int selinux_avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
>  				     u16 tclass, u32 perms,
>  				     u32 *out_retained),
>  		     u32 events, u32 ssid, u32 tsid,
>  		     u16 tclass, u32 perms);
>  
>  /* Exported to selinuxfs */
> -int avc_get_hash_stats(char *page);
> +int selinux_avc_get_hash_stats(char *page);
>  extern unsigned int avc_cache_threshold;
>  
>  /* Attempt to free avc node cache */
> -void avc_disable(void);
> +void selinux_avc_disable(void);
>  
>  #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
>  DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
> diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
> index bb1ec80..330bcf8 100644
> --- a/security/selinux/include/avc_ss.h
> +++ b/security/selinux/include/avc_ss.h
> @@ -8,7 +8,7 @@
>  
>  #include "flask.h"
>  
> -int avc_ss_reset(u32 seqno);
> +int selinux_avc_ss_reset(u32 seqno);
>  
>  struct av_perm_to_string {
>  	u16 tclass;
> diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
> index 67ce7a8..821a4a0 100644
> --- a/security/selinux/include/conditional.h
> +++ b/security/selinux/include/conditional.h
> @@ -13,10 +13,10 @@
>  #ifndef _SELINUX_CONDITIONAL_H_
>  #define _SELINUX_CONDITIONAL_H_
>  
> -int security_get_bools(int *len, char ***names, int **values);
> +int selinux_get_bools(int *len, char ***names, int **values);
>  
> -int security_set_bools(int len, int *values);
> +int selinux_set_bools(int len, int *values);
>  
> -int security_get_bool_value(int bool);
> +int selinux_get_bool_value(int bool);
>  
>  #endif
> diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
> index 1b94450..a31c65e 100644
> --- a/security/selinux/include/netnode.h
> +++ b/security/selinux/include/netnode.h
> @@ -27,6 +27,6 @@
>  #ifndef _SELINUX_NETNODE_H
>  #define _SELINUX_NETNODE_H
>  
> -int sel_netnode_sid(void *addr, u16 family, u32 *sid);
> +int selinux_netnode_sid(void *addr, u16 family, u32 *sid);
>  
>  #endif
> diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
> index 8991752..9d56bfb 100644
> --- a/security/selinux/include/netport.h
> +++ b/security/selinux/include/netport.h
> @@ -26,6 +26,6 @@
>  #ifndef _SELINUX_NETPORT_H
>  #define _SELINUX_NETPORT_H
>  
> -int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
> +int selinux_netport_sid(u8 protocol, u16 pnum, u32 *sid);
>  
>  #endif
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ca83579..b7bd2f4 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -80,9 +80,9 @@ extern int selinux_policycap_openperm;
>  /* limitation of boundary depth  */
>  #define POLICYDB_BOUNDS_MAXDEPTH	4
>  
> -int security_load_policy(void *data, size_t len);
> +int selinux_ss_load_policy(void *data, size_t len);
>  
> -int security_policycap_supported(unsigned int req_cap);
> +int selinux_ss_policycap_supported(unsigned int req_cap);
>  
>  #define SEL_VEC_MAX 32
>  struct av_decision {
> @@ -96,58 +96,58 @@ struct av_decision {
>  /* definitions of av_decision.flags */
>  #define AVD_FLAGS_PERMISSIVE	0x0001
>  
> -int security_compute_av(u32 ssid, u32 tsid,
> +int selinux_ss_compute_av(u32 ssid, u32 tsid,
>  	u16 tclass, u32 requested,
>  	struct av_decision *avd);
>  
> -int security_transition_sid(u32 ssid, u32 tsid,
> +int selinux_ss_transition_sid(u32 ssid, u32 tsid,
>  	u16 tclass, u32 *out_sid);
>  
> -int security_member_sid(u32 ssid, u32 tsid,
> +int selinux_ss_member_sid(u32 ssid, u32 tsid,
>  	u16 tclass, u32 *out_sid);
>  
> -int security_change_sid(u32 ssid, u32 tsid,
> +int selinux_ss_change_sid(u32 ssid, u32 tsid,
>  	u16 tclass, u32 *out_sid);
>  
> -int security_sid_to_context(u32 sid, char **scontext,
> +int selinux_ss_sid_to_context(u32 sid, char **scontext,
>  	u32 *scontext_len);
>  
> -int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
> +int selinux_ss_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
>  
> -int security_context_to_sid(const char *scontext, u32 scontext_len,
> +int selinux_ss_context_to_sid(const char *scontext, u32 scontext_len,
>  	u32 *out_sid);
>  
> -int security_context_to_sid_default(const char *scontext, u32 scontext_len,
> +int selinux_ss_context_to_sid_default(const char *scontext, u32 scontext_len,
>  				    u32 *out_sid, u32 def_sid, gfp_t gfp_flags);
>  
> -int security_context_to_sid_force(const char *scontext, u32 scontext_len,
> +int selinux_ss_context_to_sid_force(const char *scontext, u32 scontext_len,
>  				  u32 *sid);
>  
> -int security_get_user_sids(u32 callsid, char *username,
> +int selinux_ss_get_user_sids(u32 callsid, char *username,
>  			   u32 **sids, u32 *nel);
>  
> -int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
> +int selinux_ss_port_sid(u8 protocol, u16 port, u32 *out_sid);
>  
> -int security_netif_sid(char *name, u32 *if_sid);
> +int selinux_ss_netif_sid(char *name, u32 *if_sid);
>  
> -int security_node_sid(u16 domain, void *addr, u32 addrlen,
> +int selinux_ss_node_sid(u16 domain, void *addr, u32 addrlen,
>  	u32 *out_sid);
>  
> -int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> +int selinux_ss_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>  				 u16 tclass);
>  
> -int security_bounded_transition(u32 oldsid, u32 newsid);
> +int selinux_ss_bounded_transition(u32 oldsid, u32 newsid);
>  
> -int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
> +int selinux_ss_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
>  
> -int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
> +int selinux_ss_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
>  				 u32 xfrm_sid,
>  				 u32 *peer_sid);
>  
> -int security_get_classes(char ***classes, int *nclasses);
> -int security_get_permissions(char *class, char ***perms, int *nperms);
> -int security_get_reject_unknown(void);
> -int security_get_allow_unknown(void);
> +int selinux_ss_get_classes(char ***classes, int *nclasses);
> +int selinux_ss_get_permissions(char *class, char ***perms, int *nperms);
> +int selinux_ss_get_reject_unknown(void);
> +int selinux_ss_get_allow_unknown(void);
>  
>  #define SECURITY_FS_USE_XATTR		1 /* use xattr */
>  #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
> @@ -156,34 +156,34 @@ int security_get_allow_unknown(void);
>  #define SECURITY_FS_USE_NONE		5 /* no labeling support */
>  #define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
>  
> -int security_fs_use(const char *fstype, unsigned int *behavior,
> +int selinux_ss_fs_use(const char *fstype, unsigned int *behavior,
>  	u32 *sid);
>  
> -int security_genfs_sid(const char *fstype, char *name, u16 sclass,
> +int selinux_ss_genfs_sid(const char *fstype, char *name, u16 sclass,
>  	u32 *sid);
>  
>  #ifdef CONFIG_NETLABEL
> -int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
> +int selinux_ss_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  				   u32 *sid);
>  
> -int security_netlbl_sid_to_secattr(u32 sid,
> +int selinux_ss_netlbl_sid_to_secattr(u32 sid,
>  				   struct netlbl_lsm_secattr *secattr);
>  #else
> -static inline int security_netlbl_secattr_to_sid(
> +static inline int selinux_ss_netlbl_secattr_to_sid(
>  					    struct netlbl_lsm_secattr *secattr,
>  					    u32 *sid)
>  {
>  	return -EIDRM;
>  }
>  
> -static inline int security_netlbl_sid_to_secattr(u32 sid,
> +static inline int selinux_ss_netlbl_sid_to_secattr(u32 sid,
>  					   struct netlbl_lsm_secattr *secattr)
>  {
>  	return -ENOENT;
>  }
>  #endif /* CONFIG_NETLABEL */
>  
> -const char *security_get_initial_sid_context(u32 sid);
> +const char *selinux_ss_get_initial_sid_context(u32 sid);
>  
>  #endif /* _SELINUX_SECURITY_H_ */
>  
> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index b4e14bc..23fc05a 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -175,7 +175,7 @@ static int sel_netif_sid_slow(int ifindex, u32 *sid)
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	ret = security_netif_sid(dev->name, &new->nsec.sid);
> +	ret = selinux_ss_netif_sid(dev->name, &new->nsec.sid);
>  	if (ret != 0)
>  		goto out;
>  	new->nsec.ifindex = ifindex;
> @@ -307,10 +307,10 @@ static __init int sel_netif_init(void)
>  
>  	register_netdevice_notifier(&sel_netif_netdev_notifier);
>  
> -	err = avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET,
> +	err = selinux_avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET,
>  			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
>  	if (err)
> -		panic("avc_add_callback() failed, error %d\n", err);
> +		panic("selinux_avc_add_callback() failed, error %d\n", err);
>  
>  	return err;
>  }
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 2e98441..0a8a0ce 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -58,7 +58,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
>  {
>  	int rc;
>  
> -	rc = security_netlbl_secattr_to_sid(secattr, sid);
> +	rc = selinux_ss_netlbl_secattr_to_sid(secattr, sid);
>  	if (rc == 0 &&
>  	    (secattr->flags & NETLBL_SECATTR_CACHEABLE) &&
>  	    (secattr->flags & NETLBL_SECATTR_CACHE))
> @@ -89,7 +89,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
>  	secattr = netlbl_secattr_alloc(GFP_ATOMIC);
>  	if (secattr == NULL)
>  		return NULL;
> -	rc = security_netlbl_sid_to_secattr(sksec->sid, secattr);
> +	rc = selinux_ss_netlbl_sid_to_secattr(sksec->sid, secattr);
>  	if (rc != 0) {
>  		netlbl_secattr_free(secattr);
>  		return NULL;
> @@ -118,7 +118,7 @@ void selinux_netlbl_cache_invalidate(void)
>   * @gateway: true if host is acting as a gateway, false otherwise
>   *
>   * Description:
> - * When a packet is dropped due to a call to avc_has_perm() pass the error
> + * When a packet is dropped due to a call to selinux_avc_has_perm() pass the error
>   * code to the NetLabel subsystem so any protocol specific processing can be
>   * done.  This is safe to call even if you are unsure if NetLabel labeling is
>   * present on the packet, NetLabel is smart enough to only act when it should.
> @@ -228,7 +228,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
>  	if (secattr == NULL) {
>  		secattr = &secattr_storage;
>  		netlbl_secattr_init(secattr);
> -		rc = security_netlbl_sid_to_secattr(sid, secattr);
> +		rc = selinux_ss_netlbl_sid_to_secattr(sid, secattr);
>  		if (rc != 0)
>  			goto skbuff_setsid_return;
>  	}
> @@ -261,7 +261,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
>  		return 0;
>  
>  	netlbl_secattr_init(&secattr);
> -	rc = security_netlbl_sid_to_secattr(req->secid, &secattr);
> +	rc = selinux_ss_netlbl_sid_to_secattr(req->secid, &secattr);
>  	if (rc != 0)
>  		goto inet_conn_request_return;
>  	rc = netlbl_req_setattr(req, &secattr);
> @@ -373,7 +373,7 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
>  		perm = RAWIP_SOCKET__RECVFROM;
>  	}
>  
> -	rc = avc_has_perm(sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
> +	rc = selinux_avc_has_perm(sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
>  	if (rc == 0)
>  		return 0;
>  
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 7100072..5e7593f 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -199,7 +199,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
>  }
>  
>  /**
> - * sel_netnode_sid_slow - Lookup the SID of a network address using the policy
> + * selinux_netnode_sid_slow - Lookup the SID of a network address using the policy
>   * @addr: the IP address
>   * @family: the address family
>   * @sid: node SID
> @@ -211,7 +211,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
>   * failure.
>   *
>   */
> -static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
> +static int selinux_netnode_sid_slow(void *addr, u16 family, u32 *sid)
>  {
>  	int ret = -ENOMEM;
>  	struct sel_netnode *node;
> @@ -229,12 +229,12 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
>  		goto out;
>  	switch (family) {
>  	case PF_INET:
> -		ret = security_node_sid(PF_INET,
> +		ret = selinux_ss_node_sid(PF_INET,
>  					addr, sizeof(struct in_addr), sid);
>  		new->nsec.addr.ipv4 = *(__be32 *)addr;
>  		break;
>  	case PF_INET6:
> -		ret = security_node_sid(PF_INET6,
> +		ret = selinux_ss_node_sid(PF_INET6,
>  					addr, sizeof(struct in6_addr), sid);
>  		ipv6_addr_copy(&new->nsec.addr.ipv6, addr);
>  		break;
> @@ -252,7 +252,7 @@ out:
>  	spin_unlock_bh(&sel_netnode_lock);
>  	if (unlikely(ret)) {
>  		printk(KERN_WARNING
> -		       "SELinux: failure in sel_netnode_sid_slow(),"
> +		       "SELinux: failure in selinux_netnode_sid_slow(),"
>  		       " unable to determine network node label\n");
>  		kfree(new);
>  	}
> @@ -260,7 +260,7 @@ out:
>  }
>  
>  /**
> - * sel_netnode_sid - Lookup the SID of a network address
> + * selinux_netnode_sid - Lookup the SID of a network address
>   * @addr: the IP address
>   * @family: the address family
>   * @sid: node SID
> @@ -273,7 +273,7 @@ out:
>   * on failure.
>   *
>   */
> -int sel_netnode_sid(void *addr, u16 family, u32 *sid)
> +int selinux_netnode_sid(void *addr, u16 family, u32 *sid)
>  {
>  	struct sel_netnode *node;
>  
> @@ -286,7 +286,7 @@ int sel_netnode_sid(void *addr, u16 family, u32 *sid)
>  	}
>  	rcu_read_unlock();
>  
> -	return sel_netnode_sid_slow(addr, family, sid);
> +	return selinux_netnode_sid_slow(addr, family, sid);
>  }
>  
>  /**
> @@ -336,10 +336,10 @@ static __init int sel_netnode_init(void)
>  		sel_netnode_hash[iter].size = 0;
>  	}
>  
> -	ret = avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET,
> +	ret = selinux_avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET,
>  			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
>  	if (ret != 0)
> -		panic("avc_add_callback() failed, error %d\n", ret);
> +		panic("selinux_avc_add_callback() failed, error %d\n", ret);
>  
>  	return ret;
>  }
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index fe7fba6..61c4cc6 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -174,7 +174,7 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  	new = kzalloc(sizeof(*new), GFP_ATOMIC);
>  	if (new == NULL)
>  		goto out;
> -	ret = security_port_sid(protocol, pnum, sid);
> +	ret = selinux_ss_port_sid(protocol, pnum, sid);
>  	if (ret != 0)
>  		goto out;
>  
> @@ -207,7 +207,7 @@ out:
>   * future queries.  Returns zero on success, negative values on failure.
>   *
>   */
> -int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
> +int selinux_netport_sid(u8 protocol, u16 pnum, u32 *sid)
>  {
>  	struct sel_netport *port;
>  
> @@ -270,10 +270,10 @@ static __init int sel_netport_init(void)
>  		sel_netport_hash[iter].size = 0;
>  	}
>  
> -	ret = avc_add_callback(sel_netport_avc_callback, AVC_CALLBACK_RESET,
> +	ret = selinux_avc_add_callback(sel_netport_avc_callback, AVC_CALLBACK_RESET,
>  			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
>  	if (ret != 0)
> -		panic("avc_add_callback() failed, error %d\n", ret);
> +		panic("selinux_avc_add_callback() failed, error %d\n", ret);
>  
>  	return ret;
>  }
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index b4fc506..78c6e82 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -88,7 +88,7 @@ static int task_has_security(struct task_struct *tsk,
>  	if (!tsec)
>  		return -EACCES;
>  
> -	return avc_has_perm(sid, SECINITSID_SECURITY,
> +	return selinux_avc_has_perm(sid, SECINITSID_SECURITY,
>  			    SECCLASS_SECURITY, perms, NULL);
>  }
>  
> @@ -169,7 +169,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>  			audit_get_sessionid(current));
>  		selinux_enforcing = new_value;
>  		if (selinux_enforcing)
> -			avc_ss_reset(0);
> +			selinux_avc_ss_reset(0);
>  		selnl_notify_setenforce(selinux_enforcing);
>  	}
>  	length = count;
> @@ -193,7 +193,7 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
>  	ssize_t length;
>  	ino_t ino = filp->f_path.dentry->d_inode->i_ino;
>  	int handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
> -		security_get_reject_unknown() : !security_get_allow_unknown();
> +		selinux_ss_get_reject_unknown() : !selinux_ss_get_allow_unknown();
>  
>  	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> @@ -320,7 +320,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>  	if (copy_from_user(data, buf, count) != 0)
>  		goto out;
>  
> -	length = security_load_policy(data, count);
> +	length = selinux_ss_load_policy(data, count);
>  	if (length)
>  		goto out;
>  
> @@ -367,11 +367,11 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
>  	if (length)
>  		return length;
>  
> -	length = security_context_to_sid(buf, size, &sid);
> +	length = selinux_ss_context_to_sid(buf, size, &sid);
>  	if (length < 0)
>  		return length;
>  
> -	length = security_sid_to_context(sid, &canon, &len);
> +	length = selinux_ss_sid_to_context(sid, &canon, &len);
>  	if (length < 0)
>  		return length;
>  
> @@ -515,14 +515,14 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu %x", scon, tcon, &tclass, &req) != 4)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = selinux_ss_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = selinux_ss_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_compute_av(ssid, tsid, tclass, req, &avd);
> +	length = selinux_ss_compute_av(ssid, tsid, tclass, req, &avd);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -564,18 +564,18 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = selinux_ss_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = selinux_ss_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_transition_sid(ssid, tsid, tclass, &newsid);
> +	length = selinux_ss_transition_sid(ssid, tsid, tclass, &newsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_sid_to_context(newsid, &newcon, &len);
> +	length = selinux_ss_sid_to_context(newsid, &newcon, &len);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -623,18 +623,18 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = selinux_ss_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = selinux_ss_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_change_sid(ssid, tsid, tclass, &newsid);
> +	length = selinux_ss_change_sid(ssid, tsid, tclass, &newsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_sid_to_context(newsid, &newcon, &len);
> +	length = selinux_ss_sid_to_context(newsid, &newcon, &len);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -680,18 +680,18 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s", con, user) != 2)
>  		goto out2;
>  
> -	length = security_context_to_sid(con, strlen(con)+1, &sid);
> +	length = selinux_ss_context_to_sid(con, strlen(con)+1, &sid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_get_user_sids(sid, user, &sids, &nsids);
> +	length = selinux_ss_get_user_sids(sid, user, &sids, &nsids);
>  	if (length < 0)
>  		goto out2;
>  
>  	length = sprintf(buf, "%u", nsids) + 1;
>  	ptr = buf + length;
>  	for (i = 0; i < nsids; i++) {
> -		rc = security_sid_to_context(sids[i], &newcon, &len);
> +		rc = selinux_ss_sid_to_context(sids[i], &newcon, &len);
>  		if (rc) {
>  			length = rc;
>  			goto out3;
> @@ -741,18 +741,18 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = selinux_ss_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = selinux_ss_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_member_sid(ssid, tsid, tclass, &newsid);
> +	length = selinux_ss_member_sid(ssid, tsid, tclass, &newsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_sid_to_context(newsid, &newcon, &len);
> +	length = selinux_ss_sid_to_context(newsid, &newcon, &len);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -809,7 +809,7 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
>  		goto out;
>  	}
>  
> -	cur_enforcing = security_get_bool_value(index);
> +	cur_enforcing = selinux_get_bool_value(index);
>  	if (cur_enforcing < 0) {
>  		ret = cur_enforcing;
>  		goto out;
> @@ -924,7 +924,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
>  		goto out;
>  
>  	if (new_value && bool_pending_values)
> -		security_set_bools(bool_num, bool_pending_values);
> +		selinux_set_bools(bool_num, bool_pending_values);
>  
>  	length = count;
>  
> @@ -990,7 +990,7 @@ static int sel_make_bools(void)
>  	if (!page)
>  		return -ENOMEM;
>  
> -	ret = security_get_bools(&num, &names, &values);
> +	ret = selinux_get_bools(&num, &names, &values);
>  	if (ret != 0)
>  		goto out;
>  
> @@ -1015,7 +1015,7 @@ static int sel_make_bools(void)
>  			goto err;
>  		}
>  		isec = (struct inode_security_struct *)inode->i_security;
> -		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
> +		ret = selinux_ss_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
>  		if (ret)
>  			goto err;
>  		isec->sid = sid;
> @@ -1116,7 +1116,7 @@ static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	ret = avc_get_hash_stats(page);
> +	ret = selinux_avc_get_hash_stats(page);
>  	if (ret >= 0)
>  		ret = simple_read_from_buffer(buf, count, ppos, page, ret);
>  	free_page((unsigned long)page);
> @@ -1244,7 +1244,7 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
>  
>  	inode = file->f_path.dentry->d_inode;
>  	sid = inode->i_ino&SEL_INO_MASK;
> -	ret = security_sid_to_context(sid, &con, &len);
> +	ret = selinux_ss_sid_to_context(sid, &con, &len);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1264,7 +1264,7 @@ static int sel_make_initcon_files(struct dentry *dir)
>  	for (i = 1; i <= SECINITSID_NUM; i++) {
>  		struct inode *inode;
>  		struct dentry *dentry;
> -		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
> +		dentry = d_alloc_name(dir, selinux_ss_get_initial_sid_context(i));
>  		if (!dentry) {
>  			ret = -ENOMEM;
>  			goto out;
> @@ -1364,7 +1364,7 @@ static ssize_t sel_read_policycap(struct file *file, char __user *buf,
>  	ssize_t length;
>  	unsigned long i_ino = file->f_path.dentry->d_inode->i_ino;
>  
> -	value = security_policycap_supported(i_ino & SEL_INO_MASK);
> +	value = selinux_ss_policycap_supported(i_ino & SEL_INO_MASK);
>  	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
>  
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> @@ -1380,7 +1380,7 @@ static int sel_make_perm_files(char *objclass, int classvalue,
>  	int i, rc = 0, nperms;
>  	char **perms;
>  
> -	rc = security_get_permissions(objclass, &perms, &nperms);
> +	rc = selinux_ss_get_permissions(objclass, &perms, &nperms);
>  	if (rc)
>  		goto out;
>  
> @@ -1484,7 +1484,7 @@ static int sel_make_classes(void)
>  	/* delete any existing entries */
>  	sel_remove_classes();
>  
> -	rc = security_get_classes(&classes, &nclasses);
> +	rc = selinux_ss_get_classes(&classes, &nclasses);
>  	if (rc < 0)
>  		goto out;
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ff17820..11fc12f 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -635,7 +635,7 @@ out:
>  	return -EPERM;
>  }
>  
> -int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> +int selinux_ss_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>  				 u16 tclass)
>  {
>  	struct context *ocontext;
> @@ -718,7 +718,7 @@ out:
>   * @oldsid : current security identifier
>   * @newsid : destinated security identifier
>   */
> -int security_bounded_transition(u32 old_sid, u32 new_sid)
> +int selinux_ss_bounded_transition(u32 old_sid, u32 new_sid)
>  {
>  	struct context *old_context, *new_context;
>  	struct type_datum *type;
> @@ -805,7 +805,7 @@ out:
>   * Return -%EINVAL if any of the parameters are invalid or %0
>   * if the access vector decisions were computed successfully.
>   */
> -int security_compute_av(u32 ssid,
> +int selinux_ss_compute_av(u32 ssid,
>  			u32 tsid,
>  			u16 tclass,
>  			u32 requested,
> @@ -904,7 +904,7 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
>  
>  #include "initial_sid_to_string.h"
>  
> -const char *security_get_initial_sid_context(u32 sid)
> +const char *selinux_ss_get_initial_sid_context(u32 sid)
>  {
>  	if (unlikely(sid > SECINITSID_NUM))
>  		return NULL;
> @@ -968,12 +968,12 @@ out:
>   * into a dynamically allocated string of the correct size.  Set @scontext
>   * to point to this string and set @scontext_len to the length of the string.
>   */
> -int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
> +int selinux_ss_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
>  {
>  	return security_sid_to_context_core(sid, scontext, scontext_len, 0);
>  }
>  
> -int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
> +int selinux_ss_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
>  {
>  	return security_sid_to_context_core(sid, scontext, scontext_len, 1);
>  }
> @@ -1134,7 +1134,7 @@ out:
>   * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
>   * memory is available, or 0 on success.
>   */
> -int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
> +int selinux_ss_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
>  {
>  	return security_context_to_sid_core(scontext, scontext_len,
>  					    sid, SECSID_NULL, GFP_KERNEL, 0);
> @@ -1158,14 +1158,14 @@ int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
>   * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
>   * memory is available, or 0 on success.
>   */
> -int security_context_to_sid_default(const char *scontext, u32 scontext_len,
> +int selinux_ss_context_to_sid_default(const char *scontext, u32 scontext_len,
>  				    u32 *sid, u32 def_sid, gfp_t gfp_flags)
>  {
>  	return security_context_to_sid_core(scontext, scontext_len,
>  					    sid, def_sid, gfp_flags, 1);
>  }
>  
> -int security_context_to_sid_force(const char *scontext, u32 scontext_len,
> +int selinux_ss_context_to_sid_force(const char *scontext, u32 scontext_len,
>  				  u32 *sid)
>  {
>  	return security_context_to_sid_core(scontext, scontext_len,
> @@ -1353,7 +1353,7 @@ out:
>   * if insufficient memory is available, or %0 if the new SID was
>   * computed successfully.
>   */
> -int security_transition_sid(u32 ssid,
> +int selinux_ss_transition_sid(u32 ssid,
>  			    u32 tsid,
>  			    u16 tclass,
>  			    u32 *out_sid)
> @@ -1374,7 +1374,7 @@ int security_transition_sid(u32 ssid,
>   * if insufficient memory is available, or %0 if the SID was
>   * computed successfully.
>   */
> -int security_member_sid(u32 ssid,
> +int selinux_ss_member_sid(u32 ssid,
>  			u32 tsid,
>  			u16 tclass,
>  			u32 *out_sid)
> @@ -1395,7 +1395,7 @@ int security_member_sid(u32 ssid,
>   * if insufficient memory is available, or %0 if the SID was
>   * computed successfully.
>   */
> -int security_change_sid(u32 ssid,
> +int selinux_ss_change_sid(u32 ssid,
>  			u32 tsid,
>  			u16 tclass,
>  			u32 *out_sid)
> @@ -1536,7 +1536,7 @@ static int validate_classes(struct policydb *p)
>  	}
>  	if (print_unknown_handle)
>  		printk(KERN_INFO "SELinux: the above unknown classes and permissions will be %s\n",
> -			(security_get_allow_unknown() ? "allowed" : "denied"));
> +			(selinux_ss_get_allow_unknown() ? "allowed" : "denied"));
>  	return 0;
>  }
>  
> @@ -1685,7 +1685,7 @@ bad:
>  	goto out;
>  }
>  
> -static void security_load_policycaps(void)
> +static void selinux_load_policycaps(void)
>  {
>  	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
>  						  POLICYDB_CAPABILITY_NETPEER);
> @@ -1697,7 +1697,7 @@ extern void selinux_complete_init(void);
>  static int security_preserve_bools(struct policydb *p);
>  
>  /**
> - * security_load_policy - Load a security policy configuration.
> + * selinux_load_policy - Load a security policy configuration.
>   * @data: binary policy data
>   * @len: length of data in bytes
>   *
> @@ -1706,7 +1706,7 @@ static int security_preserve_bools(struct policydb *p);
>   * This function will flush the access vector cache after
>   * loading the new policy.
>   */
> -int security_load_policy(void *data, size_t len)
> +int selinux_ss_load_policy(void *data, size_t len)
>  {
>  	struct policydb oldpolicydb, newpolicydb;
>  	struct sidtab oldsidtab, newsidtab;
> @@ -1735,12 +1735,12 @@ int security_load_policy(void *data, size_t len)
>  			avtab_cache_destroy();
>  			return -EINVAL;
>  		}
> -		security_load_policycaps();
> +		selinux_load_policycaps();
>  		policydb_loaded_version = policydb.policyvers;
>  		ss_initialized = 1;
>  		seqno = ++latest_granting;
>  		selinux_complete_init();
> -		avc_ss_reset(seqno);
> +		selinux_avc_ss_reset(seqno);
>  		selnl_notify_policyload(seqno);
>  		selinux_netlbl_cache_invalidate();
>  		selinux_xfrm_notify_policyload();
> @@ -1798,7 +1798,7 @@ int security_load_policy(void *data, size_t len)
>  	write_lock_irq(&policy_rwlock);
>  	memcpy(&policydb, &newpolicydb, sizeof policydb);
>  	sidtab_set(&sidtab, &newsidtab);
> -	security_load_policycaps();
> +	selinux_load_policycaps();
>  	seqno = ++latest_granting;
>  	policydb_loaded_version = policydb.policyvers;
>  	write_unlock_irq(&policy_rwlock);
> @@ -1807,7 +1807,7 @@ int security_load_policy(void *data, size_t len)
>  	policydb_destroy(&oldpolicydb);
>  	sidtab_destroy(&oldsidtab);
>  
> -	avc_ss_reset(seqno);
> +	selinux_avc_ss_reset(seqno);
>  	selnl_notify_policyload(seqno);
>  	selinux_netlbl_cache_invalidate();
>  	selinux_xfrm_notify_policyload();
> @@ -1827,7 +1827,7 @@ err:
>   * @port: port number
>   * @out_sid: security identifier
>   */
> -int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
> +int selinux_ss_port_sid(u8 protocol, u16 port, u32 *out_sid)
>  {
>  	struct ocontext *c;
>  	int rc = 0;
> @@ -1866,7 +1866,7 @@ out:
>   * @name: interface name
>   * @if_sid: interface SID
>   */
> -int security_netif_sid(char *name, u32 *if_sid)
> +int selinux_ss_netif_sid(char *name, u32 *if_sid)
>  {
>  	int rc = 0;
>  	struct ocontext *c;
> @@ -1922,7 +1922,7 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
>   * @addrlen: address length in bytes
>   * @out_sid: security identifier
>   */
> -int security_node_sid(u16 domain,
> +int selinux_ss_node_sid(u16 domain,
>  		      void *addrp,
>  		      u32 addrlen,
>  		      u32 *out_sid)
> @@ -2005,7 +2005,7 @@ out:
>   * number of elements in the array.
>   */
>  
> -int security_get_user_sids(u32 fromsid,
> +int selinux_ss_get_user_sids(u32 fromsid,
>  			   char *username,
>  			   u32 **sids,
>  			   u32 *nel)
> @@ -2090,7 +2090,7 @@ out_unlock:
>  		goto out;
>  	}
>  	for (i = 0, j = 0; i < mynel; i++) {
> -		rc = avc_has_perm_noaudit(fromsid, mysids[i],
> +		rc = selinux_avc_has_perm_noaudit(fromsid, mysids[i],
>  					  SECCLASS_PROCESS,
>  					  PROCESS__TRANSITION, AVC_STRICT,
>  					  NULL);
> @@ -2117,7 +2117,7 @@ out:
>   * cannot support xattr or use a fixed labeling behavior like
>   * transition SIDs or task SIDs.
>   */
> -int security_genfs_sid(const char *fstype,
> +int selinux_ss_genfs_sid(const char *fstype,
>  		       char *path,
>  		       u16 sclass,
>  		       u32 *sid)
> @@ -2177,7 +2177,7 @@ out:
>   * @behavior: labeling behavior
>   * @sid: SID for filesystem (superblock)
>   */
> -int security_fs_use(
> +int selinux_ss_fs_use(
>  	const char *fstype,
>  	unsigned int *behavior,
>  	u32 *sid)
> @@ -2205,7 +2205,7 @@ int security_fs_use(
>  		}
>  		*sid = c->sid[0];
>  	} else {
> -		rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
> +		rc = selinux_ss_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
>  		if (rc) {
>  			*behavior = SECURITY_FS_USE_NONE;
>  			rc = 0;
> @@ -2219,7 +2219,7 @@ out:
>  	return rc;
>  }
>  
> -int security_get_bools(int *len, char ***names, int **values)
> +int selinux_get_bools(int *len, char ***names, int **values)
>  {
>  	int i, rc = -ENOMEM;
>  
> @@ -2265,7 +2265,7 @@ err:
>  }
>  
> 
> -int security_set_bools(int len, int *values)
> +int selinux_set_bools(int len, int *values)
>  {
>  	int i, rc = 0;
>  	int lenp, seqno = 0;
> @@ -2307,14 +2307,14 @@ int security_set_bools(int len, int *values)
>  out:
>  	write_unlock_irq(&policy_rwlock);
>  	if (!rc) {
> -		avc_ss_reset(seqno);
> +		selinux_avc_ss_reset(seqno);
>  		selnl_notify_policyload(seqno);
>  		selinux_xfrm_notify_policyload();
>  	}
>  	return rc;
>  }
>  
> -int security_get_bool_value(int bool)
> +int selinux_get_bool_value(int bool)
>  {
>  	int rc = 0;
>  	int len;
> @@ -2340,7 +2340,7 @@ static int security_preserve_bools(struct policydb *p)
>  	struct cond_bool_datum *booldatum;
>  	struct cond_node *cur;
>  
> -	rc = security_get_bools(&nbools, &bnames, &bvalues);
> +	rc = selinux_get_bools(&nbools, &bnames, &bvalues);
>  	if (rc)
>  		goto out;
>  	for (i = 0; i < nbools; i++) {
> @@ -2365,10 +2365,10 @@ out:
>  }
>  
>  /*
> - * security_sid_mls_copy() - computes a new sid based on the given
> + * selinux_ss_sid_mls_copy() - computes a new sid based on the given
>   * sid and the mls portion of mls_sid.
>   */
> -int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
> +int selinux_ss_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
>  {
>  	struct context *context1;
>  	struct context *context2;
> @@ -2452,7 +2452,7 @@ out:
>   *   multiple, inconsistent labels |    -<errno>     |    SECSID_NULL
>   *
>   */
> -int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
> +int selinux_ss_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
>  				 u32 xfrm_sid,
>  				 u32 *peer_sid)
>  {
> @@ -2528,7 +2528,7 @@ static int get_classes_callback(void *k, void *d, void *args)
>  	return 0;
>  }
>  
> -int security_get_classes(char ***classes, int *nclasses)
> +int selinux_ss_get_classes(char ***classes, int *nclasses)
>  {
>  	int rc = -ENOMEM;
>  
> @@ -2566,7 +2566,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
>  	return 0;
>  }
>  
> -int security_get_permissions(char *class, char ***perms, int *nperms)
> +int selinux_ss_get_permissions(char *class, char ***perms, int *nperms)
>  {
>  	int rc = -ENOMEM, i;
>  	struct class_datum *match;
> @@ -2610,12 +2610,12 @@ err:
>  	return rc;
>  }
>  
> -int security_get_reject_unknown(void)
> +int selinux_ss_get_reject_unknown(void)
>  {
>  	return policydb.reject_unknown;
>  }
>  
> -int security_get_allow_unknown(void)
> +int selinux_ss_get_allow_unknown(void)
>  {
>  	return policydb.allow_unknown;
>  }
> @@ -2630,7 +2630,7 @@ int security_get_allow_unknown(void)
>   * supported, false (0) if it isn't supported.
>   *
>   */
> -int security_policycap_supported(unsigned int req_cap)
> +int selinux_ss_policycap_supported(unsigned int req_cap)
>  {
>  	int rc;
>  
> @@ -2902,10 +2902,10 @@ static int __init aurule_init(void)
>  {
>  	int err;
>  
> -	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET,
> +	err = selinux_avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET,
>  			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
>  	if (err)
> -		panic("avc_add_callback() failed, error %d\n", err);
> +		panic("selinux_avc_add_callback() failed, error %d\n", err);
>  
>  	return err;
>  }
> @@ -2958,7 +2958,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
>   * failure.
>   *
>   */
> -int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
> +int selinux_ss_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  				   u32 *sid)
>  {
>  	int rc = -EIDRM;
> @@ -3029,7 +3029,7 @@ netlbl_secattr_to_sid_return_cleanup:
>   * Returns zero on success, negative values on failure.
>   *
>   */
> -int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
> +int selinux_ss_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
>  {
>  	int rc;
>  	struct context *ctx;
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 72b1845..37fb280 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -95,7 +95,7 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
>  		 */
>  		return 0;
>  
> -	rc = avc_has_perm(fl_secid, sel_sid, SECCLASS_ASSOCIATION,
> +	rc = selinux_avc_has_perm(fl_secid, sel_sid, SECCLASS_ASSOCIATION,
>  			  ASSOCIATION__POLMATCH,
>  			  NULL);
>  
> @@ -137,7 +137,7 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
>  	if (fl->secid != state_sid)
>  		return 0;
>  
> -	rc = avc_has_perm(fl->secid, state_sid, SECCLASS_ASSOCIATION,
> +	rc = selinux_avc_has_perm(fl->secid, state_sid, SECCLASS_ASSOCIATION,
>  			  ASSOCIATION__SENDTO,
>  			  NULL)? 0:1;
>  
> @@ -229,7 +229,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
>  	       uctx+1,
>  	       str_len);
>  	ctx->ctx_str[str_len] = 0;
> -	rc = security_context_to_sid(ctx->ctx_str,
> +	rc = selinux_ss_context_to_sid(ctx->ctx_str,
>  				     str_len,
>  				     &ctx->ctx_sid);
>  
> @@ -239,7 +239,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
>  	/*
>  	 * Does the subject have permission to set security context?
>  	 */
> -	rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
> +	rc = selinux_avc_has_perm(tsec->sid, ctx->ctx_sid,
>  			  SECCLASS_ASSOCIATION,
>  			  ASSOCIATION__SETCONTEXT, NULL);
>  	if (rc)
> @@ -248,7 +248,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
>  	return rc;
>  
>  not_from_user:
> -	rc = security_sid_to_context(sid, &ctx_str, &str_len);
> +	rc = selinux_ss_sid_to_context(sid, &ctx_str, &str_len);
>  	if (rc)
>  		goto out;
>  
> @@ -337,7 +337,7 @@ int selinux_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
>  	int rc = 0;
>  
>  	if (ctx) {
> -		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
> +		rc = selinux_avc_has_perm(tsec->sid, ctx->ctx_sid,
>  				  SECCLASS_ASSOCIATION,
>  				  ASSOCIATION__SETCONTEXT, NULL);
>  		if (rc == 0)
> @@ -383,7 +383,7 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
>  	int rc = 0;
>  
>  	if (ctx) {
> -		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
> +		rc = selinux_avc_has_perm(tsec->sid, ctx->ctx_sid,
>  				  SECCLASS_ASSOCIATION,
>  				  ASSOCIATION__SETCONTEXT, NULL);
>  		if (rc == 0)
> @@ -428,7 +428,7 @@ int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
>  	 * explicitly allowed by policy.
>  	 */
>  
> -	rc = avc_has_perm(isec_sid, sel_sid, SECCLASS_ASSOCIATION,
> +	rc = selinux_avc_has_perm(isec_sid, sel_sid, SECCLASS_ASSOCIATION,
>  			  ASSOCIATION__RECVFROM, ad);
>  
>  	return rc;
> @@ -482,7 +482,7 @@ int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
>  	 * explicitly allowed by policy.
>  	 */
>  
> -	rc = avc_has_perm(isec_sid, SECINITSID_UNLABELED, SECCLASS_ASSOCIATION,
> +	rc = selinux_avc_has_perm(isec_sid, SECINITSID_UNLABELED, SECCLASS_ASSOCIATION,
>  			  ASSOCIATION__SENDTO, ad);
>  out:
>  	return rc;
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
