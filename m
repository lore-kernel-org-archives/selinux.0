Subject: Re: [PATCH 1/2 -v3] Namespacing of security/selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1247003355.2149.2.camel@Ares>
References: <1246906718.2460.12.camel@Ares>
	 <1246909386.28321.148.camel@moss-pluto.epoch.ncsc.mil>
	 <1246968394.28321.171.camel@moss-pluto.epoch.ncsc.mil>
	 <1247003355.2149.2.camel@Ares>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 11:20:20 -0400
Message-Id: <1250263220.3629.34.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-07 at 17:49 -0400, Thomas Liu wrote:
> This includes namespacing of all items originally labeled
> security_ with sel_.
> 
> In addition, the functions sel_netif_sid and security_netif_sid
> have been renamed because the namespacing would cause a conflict.
> 
> sel_netif_sid has been renamed to sel_netif_sid_by_index, and
> security_netif_sid has been renamed to sel_netif_sid_by_name

This patch has a minor reject against the current security-testing tree.

However, I'm having second thoughts about the renaming idea.  There are
a rather large number of documents, not to mention the userspace API,
that talk about security_compute_av() and friends, and thus I'm a bit
hesitant to render them all obsolete.

> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>
> ---
>  security/selinux/avc.c              |    8 +-
>  security/selinux/exports.c          |    2 +-
>  security/selinux/hooks.c            |   80 +++++++++++-----------
>  security/selinux/include/netif.h    |    2 +-
>  security/selinux/include/security.h |   60 ++++++++--------
>  security/selinux/netif.c            |    6 +-
>  security/selinux/netlabel.c         |    8 +-
>  security/selinux/netnode.c          |    4 +-
>  security/selinux/netport.c          |    2 +-
>  security/selinux/selinuxfs.c        |   56 ++++++++--------
>  security/selinux/ss/services.c      |  130 +++++++++++++++++-----------------
>  security/selinux/xfrm.c             |    4 +-
>  12 files changed, 182 insertions(+), 180 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 236aaa2..d0dfee0 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -203,7 +203,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  	char *scontext;
>  	u32 scontext_len;
>  
> -	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
> +	rc = sel_sid_to_context(ssid, &scontext, &scontext_len);
>  	if (rc)
>  		audit_log_format(ab, "ssid=%d", ssid);
>  	else {
> @@ -211,7 +211,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  		kfree(scontext);
>  	}
>  
> -	rc = security_sid_to_context(tsid, &scontext, &scontext_len);
> +	rc = sel_sid_to_context(tsid, &scontext, &scontext_len);
>  	if (rc)
>  		audit_log_format(ab, " tsid=%d", tsid);
>  	else {
> @@ -448,7 +448,7 @@ static int avc_latest_notif_update(int seqno, int is_insert)
>   * (@ssid, @tsid) and class @tclass.
>   * The access vectors and the sequence number are
>   * normally provided by the security server in
> - * response to a security_compute_av() call.  If the
> + * response to a sel_compute_av() call.  If the
>   * sequence number @avd->seqno is not less than the latest
>   * revocation notification, then the function copies
>   * the access vectors into a cache entry, returns
> @@ -911,7 +911,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  		else
>  			avd = &avd_entry;
>  
> -		rc = security_compute_av(ssid, tsid, tclass, requested, avd);
> +		rc = sel_compute_av(ssid, tsid, tclass, requested, avd);
>  		if (rc)
>  			goto out;
>  		rcu_read_lock();
> diff --git a/security/selinux/exports.c b/security/selinux/exports.c
> index c73aeaa..ba1f91d 100644
> --- a/security/selinux/exports.c
> +++ b/security/selinux/exports.c
> @@ -28,7 +28,7 @@ extern atomic_t selinux_secmark_refcount;
>  int selinux_string_to_sid(char *str, u32 *sid)
>  {
>  	if (selinux_enabled)
> -		return security_context_to_sid(str, strlen(str), sid);
> +		return sel_context_to_sid(str, strlen(str), sid);
>  	else {
>  		*sid = 0;
>  		return 0;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2081055..9d27178 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -525,21 +525,21 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
>  
>  	i = 0;
>  	if (sbsec->flags & FSCONTEXT_MNT) {
> -		rc = security_sid_to_context(sbsec->sid, &context, &len);
> +		rc = sel_sid_to_context(sbsec->sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
>  		opts->mnt_opts_flags[i++] = FSCONTEXT_MNT;
>  	}
>  	if (sbsec->flags & CONTEXT_MNT) {
> -		rc = security_sid_to_context(sbsec->mntpoint_sid, &context, &len);
> +		rc = sel_sid_to_context(sbsec->mntpoint_sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
>  		opts->mnt_opts_flags[i++] = CONTEXT_MNT;
>  	}
>  	if (sbsec->flags & DEFCONTEXT_MNT) {
> -		rc = security_sid_to_context(sbsec->def_sid, &context, &len);
> +		rc = sel_sid_to_context(sbsec->def_sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
> @@ -549,7 +549,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
>  		struct inode *root = sbsec->sb->s_root->d_inode;
>  		struct inode_security_struct *isec = root->i_security;
>  
> -		rc = security_sid_to_context(isec->sid, &context, &len);
> +		rc = sel_sid_to_context(isec->sid, &context, &len);
>  		if (rc)
>  			goto out_free;
>  		opts->mnt_opts[i] = context;
> @@ -652,10 +652,10 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  
>  		if (flags[i] == SE_SBLABELSUPP)
>  			continue;
> -		rc = security_context_to_sid(mount_options[i],
> +		rc = sel_context_to_sid(mount_options[i],
>  					     strlen(mount_options[i]), &sid);
>  		if (rc) {
> -			printk(KERN_WARNING "SELinux: security_context_to_sid"
> +			printk(KERN_WARNING "SELinux: sel_context_to_sid"
>  			       "(%s) failed for (dev %s, type %s) errno=%d\n",
>  			       mount_options[i], sb->s_id, name, rc);
>  			goto out;
> @@ -717,9 +717,11 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  		sbsec->flags |= SE_SBPROC;
>  
>  	/* Determine the labeling behavior to use for this filesystem type. */
> -	rc = security_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
> +	rc = sel_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name,
> +							      &sbsec->behavior,
> +							      &sbsec->sid);
>  	if (rc) {
> -		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
> +		printk(KERN_WARNING "%s: sel_fs_use(%s) returned %d\n",
>  		       __func__, sb->s_type->name, rc);
>  		goto out;
>  	}
> @@ -1201,7 +1203,7 @@ static int selinux_proc_get_sid(struct proc_dir_entry *de,
>  		path = end;
>  		de = de->parent;
>  	}
> -	rc = security_genfs_sid("proc", path, tclass, sid);
> +	rc = sel_genfs_sid("proc", path, tclass, sid);
>  	free_page((unsigned long)buffer);
>  	return rc;
>  }
> @@ -1318,7 +1320,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  			sid = sbsec->def_sid;
>  			rc = 0;
>  		} else {
> -			rc = security_context_to_sid_default(context, rc, &sid,
> +			rc = sel_context_to_sid_default(context, rc, &sid,
>  							     sbsec->def_sid,
>  							     GFP_NOFS);
>  			if (rc) {
> @@ -1353,7 +1355,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  
>  		/* Try to obtain a transition SID. */
>  		isec->sclass = inode_mode_to_security_class(inode->i_mode);
> -		rc = security_transition_sid(isec->task_sid,
> +		rc = sel_transition_sid(isec->task_sid,
>  					     sbsec->sid,
>  					     isec->sclass,
>  					     &sid);
> @@ -1630,7 +1632,7 @@ static int may_create(struct inode *dir,
>  		return rc;
>  
>  	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
> -		rc = security_transition_sid(sid, dsec->sid, tclass, &newsid);
> +		rc = sel_transition_sid(sid, dsec->sid, tclass, &newsid);
>  		if (rc)
>  			return rc;
>  	}
> @@ -1966,7 +1968,7 @@ static int selinux_sysctl_get_sid(ctl_table *table, u16 tclass, u32 *sid)
>  	end -= 4;
>  	memcpy(end, "/sys", 4);
>  	path = end;
> -	rc = security_genfs_sid("proc", path, tclass, sid);
> +	rc = sel_genfs_sid("proc", path, tclass, sid);
>  out_free:
>  	free_page((unsigned long)buffer);
>  out:
> @@ -2132,7 +2134,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  		new_tsec->exec_sid = 0;
>  	} else {
>  		/* Check for a default transition on this program. */
> -		rc = security_transition_sid(old_tsec->sid, isec->sid,
> +		rc = sel_transition_sid(old_tsec->sid, isec->sid,
>  					     SECCLASS_PROCESS, &new_tsec->sid);
>  		if (rc)
>  			return rc;
> @@ -2595,12 +2597,12 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	newsid = tsec->create_sid;
>  
>  	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
> -		rc = security_transition_sid(sid, dsec->sid,
> +		rc = sel_transition_sid(sid, dsec->sid,
>  					     inode_mode_to_security_class(inode->i_mode),
>  					     &newsid);
>  		if (rc) {
>  			printk(KERN_WARNING "%s:  "
> -			       "security_transition_sid failed, rc=%d (dev=%s "
> +			       "sel_transition_sid failed, rc=%d (dev=%s "
>  			       "ino=%ld)\n",
>  			       __func__,
>  			       -rc, inode->i_sb->s_id, inode->i_ino);
> @@ -2627,7 +2629,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	}
>  
>  	if (value && len) {
> -		rc = security_sid_to_context_force(newsid, &context, &clen);
> +		rc = sel_sid_to_context_force(newsid, &context, &clen);
>  		if (rc) {
>  			kfree(namep);
>  			return rc;
> @@ -2777,11 +2779,11 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	if (rc)
>  		return rc;
>  
> -	rc = security_context_to_sid(value, size, &newsid);
> +	rc = sel_context_to_sid(value, size, &newsid);
>  	if (rc == -EINVAL) {
>  		if (!capable(CAP_MAC_ADMIN))
>  			return rc;
> -		rc = security_context_to_sid_force(value, size, &newsid);
> +		rc = sel_context_to_sid_force(value, size, &newsid);
>  	}
>  	if (rc)
>  		return rc;
> @@ -2791,7 +2793,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	if (rc)
>  		return rc;
>  
> -	rc = security_validate_transition(isec->sid, newsid, sid,
> +	rc = sel_validate_transition(isec->sid, newsid, sid,
>  					  isec->sclass);
>  	if (rc)
>  		return rc;
> @@ -2817,7 +2819,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>  		return;
>  	}
>  
> -	rc = security_context_to_sid_force(value, size, &newsid);
> +	rc = sel_context_to_sid_force(value, size, &newsid);
>  	if (rc) {
>  		printk(KERN_ERR "SELinux:  unable to map context to SID"
>  		       "for (%s, %lu), rc=%d\n",
> @@ -2880,10 +2882,10 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
>  	error = selinux_capable(current, current_cred(), CAP_MAC_ADMIN,
>  				SECURITY_CAP_NOAUDIT);
>  	if (!error)
> -		error = security_sid_to_context_force(isec->sid, &context,
> +		error = sel_sid_to_context_force(isec->sid, &context,
>  						      &size);
>  	else
> -		error = security_sid_to_context(isec->sid, &context, &size);
> +		error = sel_sid_to_context(isec->sid, &context, &size);
>  	if (error)
>  		return error;
>  	error = size;
> @@ -2909,7 +2911,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  	if (!value || !size)
>  		return -EACCES;
>  
> -	rc = security_context_to_sid((void *)value, size, &newsid);
> +	rc = sel_context_to_sid((void *)value, size, &newsid);
>  	if (rc)
>  		return rc;
>  
> @@ -3619,7 +3621,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
>  	selinux_skb_xfrm_sid(skb, &xfrm_sid);
>  	selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
>  
> -	err = security_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
> +	err = sel_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
>  	if (unlikely(err)) {
>  		printk(KERN_WARNING
>  		       "SELinux: failure in selinux_skb_peerlbl_sid(),"
> @@ -3965,7 +3967,7 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
>  	/* server child socket */
>  	ssec = newsk->sk_security;
>  	ssec->peer_sid = isec->sid;
> -	err = security_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
> +	err = sel_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
>  
>  	return err;
>  }
> @@ -4000,7 +4002,7 @@ static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16 family,
>  	u32 if_sid;
>  	u32 node_sid;
>  
> -	err = sel_netif_sid(ifindex, &if_sid);
> +	err = sel_netif_sid_by_index(ifindex, &if_sid);
>  	if (err)
>  		return err;
>  	err = avc_has_perm(peer_sid, if_sid,
> @@ -4144,7 +4146,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
>  		goto out;
>  	}
>  
> -	err = security_sid_to_context(peer_sid, &scontext, &scontext_len);
> +	err = sel_sid_to_context(peer_sid, &scontext, &scontext_len);
>  
>  	if (err)
>  		goto out;
> @@ -4256,7 +4258,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>  		req->secid = sksec->sid;
>  		req->peer_secid = SECSID_NULL;
>  	} else {
> -		err = security_sid_mls_copy(sksec->sid, peersid, &newsid);
> +		err = sel_sid_mls_copy(sksec->sid, peersid, &newsid);
>  		if (err)
>  			return err;
>  		req->secid = newsid;
> @@ -4322,7 +4324,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
>  				  "SELinux:  unrecognized netlink message"
>  				  " type=%hu for sclass=%hu\n",
>  				  nlh->nlmsg_type, isec->sclass);
> -			if (!selinux_enforcing || security_get_allow_unknown())
> +			if (!selinux_enforcing || sel_get_allow_unknown())
>  				err = 0;
>  		}
>  
> @@ -4556,7 +4558,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  		u32 if_sid;
>  		u32 node_sid;
>  
> -		if (sel_netif_sid(ifindex, &if_sid))
> +		if (sel_netif_sid_by_index(ifindex, &if_sid))
>  			return NF_DROP;
>  		if (avc_has_perm(peer_sid, if_sid,
>  				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
> @@ -4790,7 +4792,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  		 * Compute new sid based on current process and
>  		 * message queue this message will be stored in
>  		 */
> -		rc = security_transition_sid(sid, isec->sid, SECCLASS_MSG,
> +		rc = sel_transition_sid(sid, isec->sid, SECCLASS_MSG,
>  					     &msec->sid);
>  		if (rc)
>  			return rc;
> @@ -5095,7 +5097,7 @@ static int selinux_getprocattr(struct task_struct *p,
>  	if (!sid)
>  		return 0;
>  
> -	error = security_sid_to_context(sid, value, &len);
> +	error = sel_sid_to_context(sid, value, &len);
>  	if (error)
>  		return error;
>  	return len;
> @@ -5147,11 +5149,11 @@ static int selinux_setprocattr(struct task_struct *p,
>  			str[size-1] = 0;
>  			size--;
>  		}
> -		error = security_context_to_sid(value, size, &sid);
> +		error = sel_context_to_sid(value, size, &sid);
>  		if (error == -EINVAL && !strcmp(name, "fscreate")) {
>  			if (!capable(CAP_MAC_ADMIN))
>  				return error;
> -			error = security_context_to_sid_force(value, size,
> +			error = sel_context_to_sid_force(value, size,
>  							      &sid);
>  		}
>  		if (error)
> @@ -5188,7 +5190,7 @@ static int selinux_setprocattr(struct task_struct *p,
>  		/* Only allow single threaded processes to change context */
>  		error = -EPERM;
>  		if (!is_single_threaded(p)) {
> -			error = security_bounded_transition(tsec->sid, sid);
> +			error = sel_bounded_transition(tsec->sid, sid);
>  			if (error)
>  				goto abort_change;
>  		}
> @@ -5231,12 +5233,12 @@ abort_change:
>  
>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
> -	return security_sid_to_context(secid, secdata, seclen);
> +	return sel_sid_to_context(secid, secdata, seclen);
>  }
>  
>  static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  {
> -	return security_context_to_sid(secdata, seclen, secid);
> +	return sel_context_to_sid(secdata, seclen, secid);
>  }
>  
>  static void selinux_release_secctx(char *secdata, u32 seclen)
> @@ -5303,7 +5305,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  	unsigned len;
>  	int rc;
>  
> -	rc = security_sid_to_context(ksec->sid, &context, &len);
> +	rc = sel_sid_to_context(ksec->sid, &context, &len);
>  	if (!rc)
>  		rc = len;
>  	*_buffer = context;
> diff --git a/security/selinux/include/netif.h b/security/selinux/include/netif.h
> index ce23edd..b6c3b43 100644
> --- a/security/selinux/include/netif.h
> +++ b/security/selinux/include/netif.h
> @@ -17,7 +17,7 @@
>  #ifndef _SELINUX_NETIF_H_
>  #define _SELINUX_NETIF_H_
>  
> -int sel_netif_sid(int ifindex, u32 *sid);
> +int sel_netif_sid_by_index(int ifindex, u32 *sid);
>  
>  #endif	/* _SELINUX_NETIF_H_ */
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ca83579..373e672 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -80,9 +80,9 @@ extern int selinux_policycap_openperm;
>  /* limitation of boundary depth  */
>  #define POLICYDB_BOUNDS_MAXDEPTH	4
>  
> -int security_load_policy(void *data, size_t len);
> +int sel_load_policy(void *data, size_t len);
>  
> -int security_policycap_supported(unsigned int req_cap);
> +int sel_policycap_supported(unsigned int req_cap);
>  
>  #define SEL_VEC_MAX 32
>  struct av_decision {
> @@ -96,58 +96,58 @@ struct av_decision {
>  /* definitions of av_decision.flags */
>  #define AVD_FLAGS_PERMISSIVE	0x0001
>  
> -int security_compute_av(u32 ssid, u32 tsid,
> +int sel_compute_av(u32 ssid, u32 tsid,
>  	u16 tclass, u32 requested,
>  	struct av_decision *avd);
>  
> -int security_transition_sid(u32 ssid, u32 tsid,
> +int sel_transition_sid(u32 ssid, u32 tsid,
>  	u16 tclass, u32 *out_sid);
>  
> -int security_member_sid(u32 ssid, u32 tsid,
> +int sel_member_sid(u32 ssid, u32 tsid,
>  	u16 tclass, u32 *out_sid);
>  
> -int security_change_sid(u32 ssid, u32 tsid,
> +int sel_change_sid(u32 ssid, u32 tsid,
>  	u16 tclass, u32 *out_sid);
>  
> -int security_sid_to_context(u32 sid, char **scontext,
> +int sel_sid_to_context(u32 sid, char **scontext,
>  	u32 *scontext_len);
>  
> -int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
> +int sel_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
>  
> -int security_context_to_sid(const char *scontext, u32 scontext_len,
> +int sel_context_to_sid(const char *scontext, u32 scontext_len,
>  	u32 *out_sid);
>  
> -int security_context_to_sid_default(const char *scontext, u32 scontext_len,
> +int sel_context_to_sid_default(const char *scontext, u32 scontext_len,
>  				    u32 *out_sid, u32 def_sid, gfp_t gfp_flags);
>  
> -int security_context_to_sid_force(const char *scontext, u32 scontext_len,
> +int sel_context_to_sid_force(const char *scontext, u32 scontext_len,
>  				  u32 *sid);
>  
> -int security_get_user_sids(u32 callsid, char *username,
> +int sel_get_user_sids(u32 callsid, char *username,
>  			   u32 **sids, u32 *nel);
>  
> -int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
> +int sel_port_sid(u8 protocol, u16 port, u32 *out_sid);
>  
> -int security_netif_sid(char *name, u32 *if_sid);
> +int sel_netif_sid_by_name(char *name, u32 *if_sid);
>  
> -int security_node_sid(u16 domain, void *addr, u32 addrlen,
> +int sel_node_sid(u16 domain, void *addr, u32 addrlen,
>  	u32 *out_sid);
>  
> -int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> +int sel_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>  				 u16 tclass);
>  
> -int security_bounded_transition(u32 oldsid, u32 newsid);
> +int sel_bounded_transition(u32 oldsid, u32 newsid);
>  
> -int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
> +int sel_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
>  
> -int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
> +int sel_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
>  				 u32 xfrm_sid,
>  				 u32 *peer_sid);
>  
> -int security_get_classes(char ***classes, int *nclasses);
> -int security_get_permissions(char *class, char ***perms, int *nperms);
> -int security_get_reject_unknown(void);
> -int security_get_allow_unknown(void);
> +int sel_get_classes(char ***classes, int *nclasses);
> +int sel_get_permissions(char *class, char ***perms, int *nperms);
> +int sel_get_reject_unknown(void);
> +int sel_get_allow_unknown(void);
>  
>  #define SECURITY_FS_USE_XATTR		1 /* use xattr */
>  #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
> @@ -156,34 +156,34 @@ int security_get_allow_unknown(void);
>  #define SECURITY_FS_USE_NONE		5 /* no labeling support */
>  #define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
>  
> -int security_fs_use(const char *fstype, unsigned int *behavior,
> +int sel_fs_use(const char *fstype, unsigned int *behavior,
>  	u32 *sid);
>  
> -int security_genfs_sid(const char *fstype, char *name, u16 sclass,
> +int sel_genfs_sid(const char *fstype, char *name, u16 sclass,
>  	u32 *sid);
>  
>  #ifdef CONFIG_NETLABEL
> -int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
> +int sel_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  				   u32 *sid);
>  
> -int security_netlbl_sid_to_secattr(u32 sid,
> +int sel_netlbl_sid_to_secattr(u32 sid,
>  				   struct netlbl_lsm_secattr *secattr);
>  #else
> -static inline int security_netlbl_secattr_to_sid(
> +static inline int sel_netlbl_secattr_to_sid(
>  					    struct netlbl_lsm_secattr *secattr,
>  					    u32 *sid)
>  {
>  	return -EIDRM;
>  }
>  
> -static inline int security_netlbl_sid_to_secattr(u32 sid,
> +static inline int sel_netlbl_sid_to_secattr(u32 sid,
>  					   struct netlbl_lsm_secattr *secattr)
>  {
>  	return -ENOENT;
>  }
>  #endif /* CONFIG_NETLABEL */
>  
> -const char *security_get_initial_sid_context(u32 sid);
> +const char *sel_get_initial_sid_context(u32 sid);
>  
>  #endif /* _SELINUX_SECURITY_H_ */
>  
> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index b4e14bc..3aae049 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -175,7 +175,7 @@ static int sel_netif_sid_slow(int ifindex, u32 *sid)
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	ret = security_netif_sid(dev->name, &new->nsec.sid);
> +	ret = sel_netif_sid_by_name(dev->name, &new->nsec.sid);
>  	if (ret != 0)
>  		goto out;
>  	new->nsec.ifindex = ifindex;
> @@ -198,7 +198,7 @@ out:
>  }
>  
>  /**
> - * sel_netif_sid - Lookup the SID of a network interface
> + * sel_netif_sid_by_index - Lookup the SID of a network interface
>   * @ifindex: the network interface
>   * @sid: interface SID
>   *
> @@ -210,7 +210,7 @@ out:
>   * on failure.
>   *
>   */
> -int sel_netif_sid(int ifindex, u32 *sid)
> +int sel_netif_sid_by_index(int ifindex, u32 *sid)
>  {
>  	struct sel_netif *netif;
>  
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 2e98441..26aa550 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -58,7 +58,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
>  {
>  	int rc;
>  
> -	rc = security_netlbl_secattr_to_sid(secattr, sid);
> +	rc = sel_netlbl_secattr_to_sid(secattr, sid);
>  	if (rc == 0 &&
>  	    (secattr->flags & NETLBL_SECATTR_CACHEABLE) &&
>  	    (secattr->flags & NETLBL_SECATTR_CACHE))
> @@ -89,7 +89,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
>  	secattr = netlbl_secattr_alloc(GFP_ATOMIC);
>  	if (secattr == NULL)
>  		return NULL;
> -	rc = security_netlbl_sid_to_secattr(sksec->sid, secattr);
> +	rc = sel_netlbl_sid_to_secattr(sksec->sid, secattr);
>  	if (rc != 0) {
>  		netlbl_secattr_free(secattr);
>  		return NULL;
> @@ -228,7 +228,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
>  	if (secattr == NULL) {
>  		secattr = &secattr_storage;
>  		netlbl_secattr_init(secattr);
> -		rc = security_netlbl_sid_to_secattr(sid, secattr);
> +		rc = sel_netlbl_sid_to_secattr(sid, secattr);
>  		if (rc != 0)
>  			goto skbuff_setsid_return;
>  	}
> @@ -261,7 +261,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
>  		return 0;
>  
>  	netlbl_secattr_init(&secattr);
> -	rc = security_netlbl_sid_to_secattr(req->secid, &secattr);
> +	rc = sel_netlbl_sid_to_secattr(req->secid, &secattr);
>  	if (rc != 0)
>  		goto inet_conn_request_return;
>  	rc = netlbl_req_setattr(req, &secattr);
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 7100072..894a4f0 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -229,12 +229,12 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
>  		goto out;
>  	switch (family) {
>  	case PF_INET:
> -		ret = security_node_sid(PF_INET,
> +		ret = sel_node_sid(PF_INET,
>  					addr, sizeof(struct in_addr), sid);
>  		new->nsec.addr.ipv4 = *(__be32 *)addr;
>  		break;
>  	case PF_INET6:
> -		ret = security_node_sid(PF_INET6,
> +		ret = sel_node_sid(PF_INET6,
>  					addr, sizeof(struct in6_addr), sid);
>  		ipv6_addr_copy(&new->nsec.addr.ipv6, addr);
>  		break;
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index fe7fba6..8724815 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -174,7 +174,7 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  	new = kzalloc(sizeof(*new), GFP_ATOMIC);
>  	if (new == NULL)
>  		goto out;
> -	ret = security_port_sid(protocol, pnum, sid);
> +	ret = sel_port_sid(protocol, pnum, sid);
>  	if (ret != 0)
>  		goto out;
>  
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index b4fc506..4129d90 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -193,7 +193,7 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
>  	ssize_t length;
>  	ino_t ino = filp->f_path.dentry->d_inode->i_ino;
>  	int handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
> -		security_get_reject_unknown() : !security_get_allow_unknown();
> +		sel_get_reject_unknown() : !sel_get_allow_unknown();
>  
>  	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> @@ -320,7 +320,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>  	if (copy_from_user(data, buf, count) != 0)
>  		goto out;
>  
> -	length = security_load_policy(data, count);
> +	length = sel_load_policy(data, count);
>  	if (length)
>  		goto out;
>  
> @@ -367,11 +367,11 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
>  	if (length)
>  		return length;
>  
> -	length = security_context_to_sid(buf, size, &sid);
> +	length = sel_context_to_sid(buf, size, &sid);
>  	if (length < 0)
>  		return length;
>  
> -	length = security_sid_to_context(sid, &canon, &len);
> +	length = sel_sid_to_context(sid, &canon, &len);
>  	if (length < 0)
>  		return length;
>  
> @@ -515,14 +515,14 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu %x", scon, tcon, &tclass, &req) != 4)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = sel_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = sel_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_compute_av(ssid, tsid, tclass, req, &avd);
> +	length = sel_compute_av(ssid, tsid, tclass, req, &avd);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -564,18 +564,18 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = sel_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = sel_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_transition_sid(ssid, tsid, tclass, &newsid);
> +	length = sel_transition_sid(ssid, tsid, tclass, &newsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_sid_to_context(newsid, &newcon, &len);
> +	length = sel_sid_to_context(newsid, &newcon, &len);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -623,18 +623,18 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = sel_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = sel_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_change_sid(ssid, tsid, tclass, &newsid);
> +	length = sel_change_sid(ssid, tsid, tclass, &newsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_sid_to_context(newsid, &newcon, &len);
> +	length = sel_sid_to_context(newsid, &newcon, &len);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -680,18 +680,18 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s", con, user) != 2)
>  		goto out2;
>  
> -	length = security_context_to_sid(con, strlen(con)+1, &sid);
> +	length = sel_context_to_sid(con, strlen(con)+1, &sid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_get_user_sids(sid, user, &sids, &nsids);
> +	length = sel_get_user_sids(sid, user, &sids, &nsids);
>  	if (length < 0)
>  		goto out2;
>  
>  	length = sprintf(buf, "%u", nsids) + 1;
>  	ptr = buf + length;
>  	for (i = 0; i < nsids; i++) {
> -		rc = security_sid_to_context(sids[i], &newcon, &len);
> +		rc = sel_sid_to_context(sids[i], &newcon, &len);
>  		if (rc) {
>  			length = rc;
>  			goto out3;
> @@ -741,18 +741,18 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
>  	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
>  		goto out2;
>  
> -	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
> +	length = sel_context_to_sid(scon, strlen(scon)+1, &ssid);
>  	if (length < 0)
>  		goto out2;
> -	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
> +	length = sel_context_to_sid(tcon, strlen(tcon)+1, &tsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_member_sid(ssid, tsid, tclass, &newsid);
> +	length = sel_member_sid(ssid, tsid, tclass, &newsid);
>  	if (length < 0)
>  		goto out2;
>  
> -	length = security_sid_to_context(newsid, &newcon, &len);
> +	length = sel_sid_to_context(newsid, &newcon, &len);
>  	if (length < 0)
>  		goto out2;
>  
> @@ -1015,7 +1015,7 @@ static int sel_make_bools(void)
>  			goto err;
>  		}
>  		isec = (struct inode_security_struct *)inode->i_security;
> -		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
> +		ret = sel_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
>  		if (ret)
>  			goto err;
>  		isec->sid = sid;
> @@ -1244,7 +1244,7 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
>  
>  	inode = file->f_path.dentry->d_inode;
>  	sid = inode->i_ino&SEL_INO_MASK;
> -	ret = security_sid_to_context(sid, &con, &len);
> +	ret = sel_sid_to_context(sid, &con, &len);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1264,7 +1264,7 @@ static int sel_make_initcon_files(struct dentry *dir)
>  	for (i = 1; i <= SECINITSID_NUM; i++) {
>  		struct inode *inode;
>  		struct dentry *dentry;
> -		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
> +		dentry = d_alloc_name(dir, sel_get_initial_sid_context(i));
>  		if (!dentry) {
>  			ret = -ENOMEM;
>  			goto out;
> @@ -1364,7 +1364,7 @@ static ssize_t sel_read_policycap(struct file *file, char __user *buf,
>  	ssize_t length;
>  	unsigned long i_ino = file->f_path.dentry->d_inode->i_ino;
>  
> -	value = security_policycap_supported(i_ino & SEL_INO_MASK);
> +	value = sel_policycap_supported(i_ino & SEL_INO_MASK);
>  	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
>  
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
> @@ -1380,7 +1380,7 @@ static int sel_make_perm_files(char *objclass, int classvalue,
>  	int i, rc = 0, nperms;
>  	char **perms;
>  
> -	rc = security_get_permissions(objclass, &perms, &nperms);
> +	rc = sel_get_permissions(objclass, &perms, &nperms);
>  	if (rc)
>  		goto out;
>  
> @@ -1484,7 +1484,7 @@ static int sel_make_classes(void)
>  	/* delete any existing entries */
>  	sel_remove_classes();
>  
> -	rc = security_get_classes(&classes, &nclasses);
> +	rc = sel_get_classes(&classes, &nclasses);
>  	if (rc < 0)
>  		goto out;
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ff17820..988fef6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -285,7 +285,7 @@ mls_ops:
>  
>  /*
>   * security_dump_masked_av - dumps masked permissions during
> - * security_compute_av due to RBAC, MLS/Constraint and Type bounds.
> + * sel_compute_av due to RBAC, MLS/Constraint and Type bounds.
>   */
>  static int dump_masked_av_helper(void *k, void *d, void *args)
>  {
> @@ -347,7 +347,7 @@ static void security_dump_masked_av(struct context *scontext,
>  	if (!ab)
>  		goto out;
>  
> -	audit_log_format(ab, "op=security_compute_av reason=%s "
> +	audit_log_format(ab, "op=sel_compute_av reason=%s "
>  			 "scontext=%s tcontext=%s tclass=%s perms=",
>  			 reason, scontext_name, tcontext_name, tclass_name);
>  
> @@ -622,7 +622,7 @@ static int security_validtrans_handle_fail(struct context *ocontext,
>  	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
>  		goto out;
>  	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -		  "security_validate_transition:  denied for"
> +		  "sel_validate_transition:  denied for"
>  		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
>  		  o, n, t, policydb.p_class_val_to_name[tclass-1]);
>  out:
> @@ -635,7 +635,7 @@ out:
>  	return -EPERM;
>  }
>  
> -int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
> +int sel_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>  				 u16 tclass)
>  {
>  	struct context *ocontext;
> @@ -710,7 +710,7 @@ out:
>  }
>  
>  /*
> - * security_bounded_transition - check whether the given
> + * sel_bounded_transition - check whether the given
>   * transition is directed to bounded, or not.
>   * It returns 0, if @newsid is bounded by @oldsid.
>   * Otherwise, it returns error code.
> @@ -718,7 +718,7 @@ out:
>   * @oldsid : current security identifier
>   * @newsid : destinated security identifier
>   */
> -int security_bounded_transition(u32 old_sid, u32 new_sid)
> +int sel_bounded_transition(u32 old_sid, u32 new_sid)
>  {
>  	struct context *old_context, *new_context;
>  	struct type_datum *type;
> @@ -777,7 +777,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
>  					      &new_name, &length)) {
>  			audit_log(current->audit_context,
>  				  GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -				  "op=security_bounded_transition "
> +				  "op=sel_bounded_transition "
>  				  "result=denied "
>  				  "oldcontext=%s newcontext=%s",
>  				  old_name, new_name);
> @@ -793,7 +793,7 @@ out:
>  
> 
>  /**
> - * security_compute_av - Compute access vector decisions.
> + * sel_compute_av - Compute access vector decisions.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
> @@ -805,7 +805,7 @@ out:
>   * Return -%EINVAL if any of the parameters are invalid or %0
>   * if the access vector decisions were computed successfully.
>   */
> -int security_compute_av(u32 ssid,
> +int sel_compute_av(u32 ssid,
>  			u32 tsid,
>  			u16 tclass,
>  			u32 requested,
> @@ -904,14 +904,14 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
>  
>  #include "initial_sid_to_string.h"
>  
> -const char *security_get_initial_sid_context(u32 sid)
> +const char *sel_get_initial_sid_context(u32 sid)
>  {
>  	if (unlikely(sid > SECINITSID_NUM))
>  		return NULL;
>  	return initial_sid_to_string[sid];
>  }
>  
> -static int security_sid_to_context_core(u32 sid, char **scontext,
> +static int sel_sid_to_context_core(u32 sid, char **scontext,
>  					u32 *scontext_len, int force)
>  {
>  	struct context *context;
> @@ -959,7 +959,7 @@ out:
>  }
>  
>  /**
> - * security_sid_to_context - Obtain a context for a given SID.
> + * sel_sid_to_context - Obtain a context for a given SID.
>   * @sid: security identifier, SID
>   * @scontext: security context
>   * @scontext_len: length in bytes
> @@ -968,14 +968,14 @@ out:
>   * into a dynamically allocated string of the correct size.  Set @scontext
>   * to point to this string and set @scontext_len to the length of the string.
>   */
> -int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
> +int sel_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
>  {
> -	return security_sid_to_context_core(sid, scontext, scontext_len, 0);
> +	return sel_sid_to_context_core(sid, scontext, scontext_len, 0);
>  }
>  
> -int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
> +int sel_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
>  {
> -	return security_sid_to_context_core(sid, scontext, scontext_len, 1);
> +	return sel_sid_to_context_core(sid, scontext, scontext_len, 1);
>  }
>  
>  /*
> @@ -1066,7 +1066,7 @@ out:
>  	return rc;
>  }
>  
> -static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
> +static int sel_context_to_sid_core(const char *scontext, u32 scontext_len,
>  					u32 *sid, u32 def_sid, gfp_t gfp_flags,
>  					int force)
>  {
> @@ -1124,7 +1124,7 @@ out:
>  }
>  
>  /**
> - * security_context_to_sid - Obtain a SID for a given security context.
> + * sel_context_to_sid - Obtain a SID for a given security context.
>   * @scontext: security context
>   * @scontext_len: length in bytes
>   * @sid: security identifier, SID
> @@ -1134,14 +1134,14 @@ out:
>   * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
>   * memory is available, or 0 on success.
>   */
> -int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
> +int sel_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
>  {
> -	return security_context_to_sid_core(scontext, scontext_len,
> +	return sel_context_to_sid_core(scontext, scontext_len,
>  					    sid, SECSID_NULL, GFP_KERNEL, 0);
>  }
>  
>  /**
> - * security_context_to_sid_default - Obtain a SID for a given security context,
> + * sel_context_to_sid_default - Obtain a SID for a given security context,
>   * falling back to specified default if needed.
>   *
>   * @scontext: security context
> @@ -1158,17 +1158,17 @@ int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
>   * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
>   * memory is available, or 0 on success.
>   */
> -int security_context_to_sid_default(const char *scontext, u32 scontext_len,
> +int sel_context_to_sid_default(const char *scontext, u32 scontext_len,
>  				    u32 *sid, u32 def_sid, gfp_t gfp_flags)
>  {
> -	return security_context_to_sid_core(scontext, scontext_len,
> +	return sel_context_to_sid_core(scontext, scontext_len,
>  					    sid, def_sid, gfp_flags, 1);
>  }
>  
> -int security_context_to_sid_force(const char *scontext, u32 scontext_len,
> +int sel_context_to_sid_force(const char *scontext, u32 scontext_len,
>  				  u32 *sid)
>  {
> -	return security_context_to_sid_core(scontext, scontext_len,
> +	return sel_context_to_sid_core(scontext, scontext_len,
>  					    sid, SECSID_NULL, GFP_KERNEL, 1);
>  }
>  
> @@ -1341,7 +1341,7 @@ out:
>  }
>  
>  /**
> - * security_transition_sid - Compute the SID for a new subject/object.
> + * sel_transition_sid - Compute the SID for a new subject/object.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
> @@ -1353,7 +1353,7 @@ out:
>   * if insufficient memory is available, or %0 if the new SID was
>   * computed successfully.
>   */
> -int security_transition_sid(u32 ssid,
> +int sel_transition_sid(u32 ssid,
>  			    u32 tsid,
>  			    u16 tclass,
>  			    u32 *out_sid)
> @@ -1362,7 +1362,7 @@ int security_transition_sid(u32 ssid,
>  }
>  
>  /**
> - * security_member_sid - Compute the SID for member selection.
> + * sel_member_sid - Compute the SID for member selection.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
> @@ -1374,7 +1374,7 @@ int security_transition_sid(u32 ssid,
>   * if insufficient memory is available, or %0 if the SID was
>   * computed successfully.
>   */
> -int security_member_sid(u32 ssid,
> +int sel_member_sid(u32 ssid,
>  			u32 tsid,
>  			u16 tclass,
>  			u32 *out_sid)
> @@ -1383,7 +1383,7 @@ int security_member_sid(u32 ssid,
>  }
>  
>  /**
> - * security_change_sid - Compute the SID for object relabeling.
> + * sel_change_sid - Compute the SID for object relabeling.
>   * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
> @@ -1395,7 +1395,7 @@ int security_member_sid(u32 ssid,
>   * if insufficient memory is available, or %0 if the SID was
>   * computed successfully.
>   */
> -int security_change_sid(u32 ssid,
> +int sel_change_sid(u32 ssid,
>  			u32 tsid,
>  			u16 tclass,
>  			u32 *out_sid)
> @@ -1536,7 +1536,7 @@ static int validate_classes(struct policydb *p)
>  	}
>  	if (print_unknown_handle)
>  		printk(KERN_INFO "SELinux: the above unknown classes and permissions will be %s\n",
> -			(security_get_allow_unknown() ? "allowed" : "denied"));
> +			(sel_get_allow_unknown() ? "allowed" : "denied"));
>  	return 0;
>  }
>  
> @@ -1685,7 +1685,7 @@ bad:
>  	goto out;
>  }
>  
> -static void security_load_policycaps(void)
> +static void sel_load_policycaps(void)
>  {
>  	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
>  						  POLICYDB_CAPABILITY_NETPEER);
> @@ -1697,7 +1697,7 @@ extern void selinux_complete_init(void);
>  static int security_preserve_bools(struct policydb *p);
>  
>  /**
> - * security_load_policy - Load a security policy configuration.
> + * sel_load_policy - Load a security policy configuration.
>   * @data: binary policy data
>   * @len: length of data in bytes
>   *
> @@ -1706,7 +1706,7 @@ static int security_preserve_bools(struct policydb *p);
>   * This function will flush the access vector cache after
>   * loading the new policy.
>   */
> -int security_load_policy(void *data, size_t len)
> +int sel_load_policy(void *data, size_t len)
>  {
>  	struct policydb oldpolicydb, newpolicydb;
>  	struct sidtab oldsidtab, newsidtab;
> @@ -1735,7 +1735,7 @@ int security_load_policy(void *data, size_t len)
>  			avtab_cache_destroy();
>  			return -EINVAL;
>  		}
> -		security_load_policycaps();
> +		sel_load_policycaps();
>  		policydb_loaded_version = policydb.policyvers;
>  		ss_initialized = 1;
>  		seqno = ++latest_granting;
> @@ -1798,7 +1798,7 @@ int security_load_policy(void *data, size_t len)
>  	write_lock_irq(&policy_rwlock);
>  	memcpy(&policydb, &newpolicydb, sizeof policydb);
>  	sidtab_set(&sidtab, &newsidtab);
> -	security_load_policycaps();
> +	sel_load_policycaps();
>  	seqno = ++latest_granting;
>  	policydb_loaded_version = policydb.policyvers;
>  	write_unlock_irq(&policy_rwlock);
> @@ -1822,12 +1822,12 @@ err:
>  }
>  
>  /**
> - * security_port_sid - Obtain the SID for a port.
> + * sel_port_sid - Obtain the SID for a port.
>   * @protocol: protocol number
>   * @port: port number
>   * @out_sid: security identifier
>   */
> -int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
> +int sel_port_sid(u8 protocol, u16 port, u32 *out_sid)
>  {
>  	struct ocontext *c;
>  	int rc = 0;
> @@ -1862,11 +1862,11 @@ out:
>  }
>  
>  /**
> - * security_netif_sid - Obtain the SID for a network interface.
> + * sel_netif_sid_by_name - Obtain the SID for a network interface.
>   * @name: interface name
>   * @if_sid: interface SID
>   */
> -int security_netif_sid(char *name, u32 *if_sid)
> +int sel_netif_sid_by_name(char *name, u32 *if_sid)
>  {
>  	int rc = 0;
>  	struct ocontext *c;
> @@ -1916,13 +1916,13 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
>  }
>  
>  /**
> - * security_node_sid - Obtain the SID for a node (host).
> + * sel_node_sid - Obtain the SID for a node (host).
>   * @domain: communication domain aka address family
>   * @addrp: address
>   * @addrlen: address length in bytes
>   * @out_sid: security identifier
>   */
> -int security_node_sid(u16 domain,
> +int sel_node_sid(u16 domain,
>  		      void *addrp,
>  		      u32 addrlen,
>  		      u32 *out_sid)
> @@ -1992,7 +1992,7 @@ out:
>  #define SIDS_NEL 25
>  
>  /**
> - * security_get_user_sids - Obtain reachable SIDs for a user.
> + * sel_get_user_sids - Obtain reachable SIDs for a user.
>   * @fromsid: starting SID
>   * @username: username
>   * @sids: array of reachable SIDs for user
> @@ -2005,7 +2005,7 @@ out:
>   * number of elements in the array.
>   */
>  
> -int security_get_user_sids(u32 fromsid,
> +int sel_get_user_sids(u32 fromsid,
>  			   char *username,
>  			   u32 **sids,
>  			   u32 *nel)
> @@ -2107,7 +2107,7 @@ out:
>  }
>  
>  /**
> - * security_genfs_sid - Obtain a SID for a file in a filesystem
> + * sel_genfs_sid - Obtain a SID for a file in a filesystem
>   * @fstype: filesystem type
>   * @path: path from root of mount
>   * @sclass: file security class
> @@ -2117,7 +2117,7 @@ out:
>   * cannot support xattr or use a fixed labeling behavior like
>   * transition SIDs or task SIDs.
>   */
> -int security_genfs_sid(const char *fstype,
> +int sel_genfs_sid(const char *fstype,
>  		       char *path,
>  		       u16 sclass,
>  		       u32 *sid)
> @@ -2172,12 +2172,12 @@ out:
>  }
>  
>  /**
> - * security_fs_use - Determine how to handle labeling for a filesystem.
> + * sel_fs_use - Determine how to handle labeling for a filesystem.
>   * @fstype: filesystem type
>   * @behavior: labeling behavior
>   * @sid: SID for filesystem (superblock)
>   */
> -int security_fs_use(
> +int sel_fs_use(
>  	const char *fstype,
>  	unsigned int *behavior,
>  	u32 *sid)
> @@ -2205,7 +2205,7 @@ int security_fs_use(
>  		}
>  		*sid = c->sid[0];
>  	} else {
> -		rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
> +		rc = sel_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
>  		if (rc) {
>  			*behavior = SECURITY_FS_USE_NONE;
>  			rc = 0;
> @@ -2365,10 +2365,10 @@ out:
>  }
>  
>  /*
> - * security_sid_mls_copy() - computes a new sid based on the given
> + * sel_sid_mls_copy() - computes a new sid based on the given
>   * sid and the mls portion of mls_sid.
>   */
> -int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
> +int sel_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
>  {
>  	struct context *context1;
>  	struct context *context2;
> @@ -2421,7 +2421,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
>  bad:
>  	if (!context_struct_to_string(&newcon, &s, &len)) {
>  		audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
> -			  "security_sid_mls_copy: invalid context %s", s);
> +			  "sel_sid_mls_copy: invalid context %s", s);
>  		kfree(s);
>  	}
>  
> @@ -2433,7 +2433,7 @@ out:
>  }
>  
>  /**
> - * security_net_peersid_resolve - Compare and resolve two network peer SIDs
> + * sel_net_peersid_resolve - Compare and resolve two network peer SIDs
>   * @nlbl_sid: NetLabel SID
>   * @nlbl_type: NetLabel labeling protocol type
>   * @xfrm_sid: XFRM SID
> @@ -2452,7 +2452,7 @@ out:
>   *   multiple, inconsistent labels |    -<errno>     |    SECSID_NULL
>   *
>   */
> -int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
> +int sel_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
>  				 u32 xfrm_sid,
>  				 u32 *peer_sid)
>  {
> @@ -2528,7 +2528,7 @@ static int get_classes_callback(void *k, void *d, void *args)
>  	return 0;
>  }
>  
> -int security_get_classes(char ***classes, int *nclasses)
> +int sel_get_classes(char ***classes, int *nclasses)
>  {
>  	int rc = -ENOMEM;
>  
> @@ -2566,7 +2566,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
>  	return 0;
>  }
>  
> -int security_get_permissions(char *class, char ***perms, int *nperms)
> +int sel_get_permissions(char *class, char ***perms, int *nperms)
>  {
>  	int rc = -ENOMEM, i;
>  	struct class_datum *match;
> @@ -2610,18 +2610,18 @@ err:
>  	return rc;
>  }
>  
> -int security_get_reject_unknown(void)
> +int sel_get_reject_unknown(void)
>  {
>  	return policydb.reject_unknown;
>  }
>  
> -int security_get_allow_unknown(void)
> +int sel_get_allow_unknown(void)
>  {
>  	return policydb.allow_unknown;
>  }
>  
>  /**
> - * security_policycap_supported - Check for a specific policy capability
> + * sel_policycap_supported - Check for a specific policy capability
>   * @req_cap: capability
>   *
>   * Description:
> @@ -2630,7 +2630,7 @@ int security_get_allow_unknown(void)
>   * supported, false (0) if it isn't supported.
>   *
>   */
> -int security_policycap_supported(unsigned int req_cap)
> +int sel_policycap_supported(unsigned int req_cap)
>  {
>  	int rc;
>  
> @@ -2944,7 +2944,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
>  }
>  
>  /**
> - * security_netlbl_secattr_to_sid - Convert a NetLabel secattr to a SELinux SID
> + * sel_netlbl_secattr_to_sid - Convert a NetLabel secattr to a SELinux SID
>   * @secattr: the NetLabel packet security attributes
>   * @sid: the SELinux SID
>   *
> @@ -2958,7 +2958,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
>   * failure.
>   *
>   */
> -int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
> +int sel_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  				   u32 *sid)
>  {
>  	int rc = -EIDRM;
> @@ -3020,7 +3020,7 @@ netlbl_secattr_to_sid_return_cleanup:
>  }
>  
>  /**
> - * security_netlbl_sid_to_secattr - Convert a SELinux SID to a NetLabel secattr
> + * sel_netlbl_sid_to_secattr - Convert a SELinux SID to a NetLabel secattr
>   * @sid: the SELinux SID
>   * @secattr: the NetLabel packet security attributes
>   *
> @@ -3029,7 +3029,7 @@ netlbl_secattr_to_sid_return_cleanup:
>   * Returns zero on success, negative values on failure.
>   *
>   */
> -int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
> +int sel_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
>  {
>  	int rc;
>  	struct context *ctx;
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 72b1845..8e292ad 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -229,7 +229,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
>  	       uctx+1,
>  	       str_len);
>  	ctx->ctx_str[str_len] = 0;
> -	rc = security_context_to_sid(ctx->ctx_str,
> +	rc = sel_context_to_sid(ctx->ctx_str,
>  				     str_len,
>  				     &ctx->ctx_sid);
>  
> @@ -248,7 +248,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
>  	return rc;
>  
>  not_from_user:
> -	rc = security_sid_to_context(sid, &ctx_str, &str_len);
> +	rc = sel_sid_to_context(sid, &ctx_str, &str_len);
>  	if (rc)
>  		goto out;
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
