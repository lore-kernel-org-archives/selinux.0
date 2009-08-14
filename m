Subject: Re: [PATCH -v3] SELinux: Convert avc_audit to use lsm_audit.h
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        linux-audit@redhat.com
In-Reply-To: <1247588049.2164.22.camel@Ares>
References: <1247588049.2164.22.camel@Ares>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 10:51:41 -0400
Message-Id: <1250261501.3629.5.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-14 at 12:14 -0400, Thomas Liu wrote:
> Convert avc_audit in security/selinux/avc.c to use lsm_audit.h,
> for better maintainability.
> 
>  - changed selinux to use common_audit_data instead of
>     avc_audit_data
>  - eliminated code in avc.c and used code from lsm_audit.h instead.
> 
> Had to add a LSM_AUDIT_NO_AUDIT to lsm_audit.h so that avc_audit
> can call common_lsm_audit and do the pre and post callbacks without
> doing the actual dump.  This makes it so that the patched version
> behaves the same way as the unpatched version.
> 
> Also added a denied field to the selinux_audit_data private space,
> once again to make it so that the patched version behaves like the
> unpatched.
> 
> I've tested and confirmed that AVCs look the same before and after
> this patch.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Looks like there is also further room for consolidation, e.g. the skb
parsing routines.

BTW, it looks to my untrained eye as if dump_common_audit_data() allows
one to pass a separate target task in the union, in which case we'll get
two sets of pid= and comm=  data in the same record, one for the subject
and one for the target/object.  It appears that Smack is already using
that facility for things like ptrace, kill, etc, whereas SELinux is not.
Two questions:
1) Will the multiple pid= comm= entries get handled correctly by auditd
and the audit tools? Do we need separate names for the target vs source
pid/comm values?
2) Should we start using ad.u.tsk in SELinux as well to capture the
target of a ptrace, kill, wait, ... in the avc audit record?

> ---
> Sorry about the previous version!
> 
>  include/linux/lsm_audit.h           |    2 
>  security/Makefile                   |    4 -
>  security/lsm_audit.c                |    2 
>  security/selinux/avc.c              |  197 +++++++----------------------------
>  security/selinux/hooks.c            |  142 +++++++++++++------------
>  security/selinux/include/avc.h      |   49 +--------
>  security/selinux/include/netlabel.h |    4 -
>  security/selinux/include/xfrm.h     |    8 +
>  security/selinux/netlabel.c         |    2 
>  security/selinux/xfrm.c             |    4 -
>  10 files changed, 131 insertions(+), 283 deletions(-)
> 
> 
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index a5514a3..190c378 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -33,6 +33,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_IPC     4
>  #define LSM_AUDIT_DATA_TASK    5
>  #define LSM_AUDIT_DATA_KEY     6
> +#define LSM_AUDIT_NO_AUDIT     7
>  	struct task_struct *tsk;
>  	union 	{
>  		struct {
> @@ -86,6 +87,7 @@ struct common_audit_data {
>  			u16 tclass;
>  			u32 requested;
>  			u32 audited;
> +			u32 denied;
>  			struct av_decision *avd;
>  			int result;
>  		} selinux_audit_data;
> diff --git a/security/Makefile b/security/Makefile
> index c67557c..8dcc1fd 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -16,9 +16,7 @@ obj-$(CONFIG_SECURITYFS)		+= inode.o
>  # Must precede capability.o in order to stack properly.
>  obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
>  obj-$(CONFIG_SECURITY_SMACK)		+= smack/built-in.o
> -ifeq ($(CONFIG_AUDIT),y)
> -obj-$(CONFIG_SECURITY_SMACK)		+= lsm_audit.o
> -endif
> +obj-$(CONFIG_AUDIT)			+= lsm_audit.o
>  obj-$(CONFIG_SECURITY_TOMOYO)		+= tomoyo/built-in.o
>  obj-$(CONFIG_SECURITY_ROOTPLUG)		+= root_plug.o
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 94b8684..500aad0 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -220,6 +220,8 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>  	}
>  
>  	switch (a->type) {
> +	case LSM_AUDIT_NO_AUDIT:
> +		return;
>  	case LSM_AUDIT_DATA_IPC:
>  		audit_log_format(ab, " key=%d ", a->u.ipc_id);
>  		break;
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 236aaa2..e3d1901 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -492,23 +492,35 @@ out:
>  	return node;
>  }
>  
> -static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
> -				       struct in6_addr *addr, __be16 port,
> -				       char *name1, char *name2)
> +/**
> + * avc_audit_pre_callback - SELinux specific information
> + * will be called by generic audit code
> + * @ab: the audit buffer
> + * @a: audit_data
> + */
> +static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>  {
> -	if (!ipv6_addr_any(addr))
> -		audit_log_format(ab, " %s=%pI6", name1, addr);
> -	if (port)
> -		audit_log_format(ab, " %s=%d", name2, ntohs(port));
> +	struct common_audit_data *ad = a;
> +	audit_log_format(ab, "avc:  %s ",
> +			 ad->selinux_audit_data.denied ? "denied" : "granted");
> +	avc_dump_av(ab, ad->selinux_audit_data.tclass,
> +			ad->selinux_audit_data.audited);
> +	audit_log_format(ab, " for ");
>  }
>  
> -static inline void avc_print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
> -				       __be16 port, char *name1, char *name2)
> +/**
> + * avc_audit_post_callback - SELinux specific information
> + * will be called by generic audit code
> + * @ab: the audit buffer
> + * @a: audit_data
> + */
> +static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>  {
> -	if (addr)
> -		audit_log_format(ab, " %s=%pI4", name1, &addr);
> -	if (port)
> -		audit_log_format(ab, " %s=%d", name2, ntohs(port));
> +	struct common_audit_data *ad = a;
> +	audit_log_format(ab, " ");
> +	avc_dump_query(ab, ad->selinux_audit_data.ssid,
> +			   ad->selinux_audit_data.tsid,
> +			   ad->selinux_audit_data.tclass);
>  }
>  
>  /**
> @@ -532,13 +544,10 @@ static inline void avc_print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>   */
>  void avc_audit(u32 ssid, u32 tsid,
>  	       u16 tclass, u32 requested,
> -	       struct av_decision *avd, int result, struct avc_audit_data *a)
> +	       struct av_decision *avd, int result, struct common_audit_data *a)
>  {
> -	struct task_struct *tsk = current;
> -	struct inode *inode = NULL;
> +	struct common_audit_data stack_data;
>  	u32 denied, audited;
> -	struct audit_buffer *ab;
> -
>  	denied = requested & ~avd->allowed;
>  	if (denied) {
>  		audited = denied;
> @@ -551,144 +560,20 @@ void avc_audit(u32 ssid, u32 tsid,
>  		if (!(audited & avd->auditallow))
>  			return;
>  	}
> -
> -	ab = audit_log_start(current->audit_context, GFP_ATOMIC, AUDIT_AVC);
> -	if (!ab)
> -		return;		/* audit_panic has been called */
> -	audit_log_format(ab, "avc:  %s ", denied ? "denied" : "granted");
> -	avc_dump_av(ab, tclass, audited);
> -	audit_log_format(ab, " for ");
> -	if (a && a->tsk)
> -		tsk = a->tsk;
> -	if (tsk && tsk->pid) {
> -		audit_log_format(ab, " pid=%d comm=", tsk->pid);
> -		audit_log_untrustedstring(ab, tsk->comm);
> -	}
> -	if (a) {
> -		switch (a->type) {
> -		case AVC_AUDIT_DATA_IPC:
> -			audit_log_format(ab, " key=%d", a->u.ipc_id);
> -			break;
> -		case AVC_AUDIT_DATA_CAP:
> -			audit_log_format(ab, " capability=%d", a->u.cap);
> -			break;
> -		case AVC_AUDIT_DATA_FS:
> -			if (a->u.fs.path.dentry) {
> -				struct dentry *dentry = a->u.fs.path.dentry;
> -				if (a->u.fs.path.mnt) {
> -					audit_log_d_path(ab, "path=",
> -							 &a->u.fs.path);
> -				} else {
> -					audit_log_format(ab, " name=");
> -					audit_log_untrustedstring(ab, dentry->d_name.name);
> -				}
> -				inode = dentry->d_inode;
> -			} else if (a->u.fs.inode) {
> -				struct dentry *dentry;
> -				inode = a->u.fs.inode;
> -				dentry = d_find_alias(inode);
> -				if (dentry) {
> -					audit_log_format(ab, " name=");
> -					audit_log_untrustedstring(ab, dentry->d_name.name);
> -					dput(dentry);
> -				}
> -			}
> -			if (inode)
> -				audit_log_format(ab, " dev=%s ino=%lu",
> -						 inode->i_sb->s_id,
> -						 inode->i_ino);
> -			break;
> -		case AVC_AUDIT_DATA_NET:
> -			if (a->u.net.sk) {
> -				struct sock *sk = a->u.net.sk;
> -				struct unix_sock *u;
> -				int len = 0;
> -				char *p = NULL;
> -
> -				switch (sk->sk_family) {
> -				case AF_INET: {
> -					struct inet_sock *inet = inet_sk(sk);
> -
> -					avc_print_ipv4_addr(ab, inet->rcv_saddr,
> -							    inet->sport,
> -							    "laddr", "lport");
> -					avc_print_ipv4_addr(ab, inet->daddr,
> -							    inet->dport,
> -							    "faddr", "fport");
> -					break;
> -				}
> -				case AF_INET6: {
> -					struct inet_sock *inet = inet_sk(sk);
> -					struct ipv6_pinfo *inet6 = inet6_sk(sk);
> -
> -					avc_print_ipv6_addr(ab, &inet6->rcv_saddr,
> -							    inet->sport,
> -							    "laddr", "lport");
> -					avc_print_ipv6_addr(ab, &inet6->daddr,
> -							    inet->dport,
> -							    "faddr", "fport");
> -					break;
> -				}
> -				case AF_UNIX:
> -					u = unix_sk(sk);
> -					if (u->dentry) {
> -						struct path path = {
> -							.dentry = u->dentry,
> -							.mnt = u->mnt
> -						};
> -						audit_log_d_path(ab, "path=",
> -								 &path);
> -						break;
> -					}
> -					if (!u->addr)
> -						break;
> -					len = u->addr->len-sizeof(short);
> -					p = &u->addr->name->sun_path[0];
> -					audit_log_format(ab, " path=");
> -					if (*p)
> -						audit_log_untrustedstring(ab, p);
> -					else
> -						audit_log_n_hex(ab, p, len);
> -					break;
> -				}
> -			}
> -
> -			switch (a->u.net.family) {
> -			case AF_INET:
> -				avc_print_ipv4_addr(ab, a->u.net.v4info.saddr,
> -						    a->u.net.sport,
> -						    "saddr", "src");
> -				avc_print_ipv4_addr(ab, a->u.net.v4info.daddr,
> -						    a->u.net.dport,
> -						    "daddr", "dest");
> -				break;
> -			case AF_INET6:
> -				avc_print_ipv6_addr(ab, &a->u.net.v6info.saddr,
> -						    a->u.net.sport,
> -						    "saddr", "src");
> -				avc_print_ipv6_addr(ab, &a->u.net.v6info.daddr,
> -						    a->u.net.dport,
> -						    "daddr", "dest");
> -				break;
> -			}
> -			if (a->u.net.netif > 0) {
> -				struct net_device *dev;
> -
> -				/* NOTE: we always use init's namespace */
> -				dev = dev_get_by_index(&init_net,
> -						       a->u.net.netif);
> -				if (dev) {
> -					audit_log_format(ab, " netif=%s",
> -							 dev->name);
> -					dev_put(dev);
> -				}
> -			}
> -			break;
> -		}
> +	if (!a) {
> +		a = &stack_data;
> +		memset(a, 0, sizeof(*a));
> +		a->type = LSM_AUDIT_NO_AUDIT;
>  	}
> -	audit_log_format(ab, " ");
> -	avc_dump_query(ab, ssid, tsid, tclass);
> -	audit_log_end(ab);
> +	a->selinux_audit_data.tclass = tclass;
> +	a->selinux_audit_data.requested = requested;
> +	a->selinux_audit_data.ssid = ssid;
> +	a->selinux_audit_data.tsid = tsid;
> +	a->selinux_audit_data.audited = audited;
> +	a->selinux_audit_data.denied = denied;
> +	a->lsm_pre_audit = avc_audit_pre_callback;
> +	a->lsm_post_audit = avc_audit_post_callback;
> +	common_lsm_audit(a);
>  }
>  
>  /**
> @@ -956,7 +841,7 @@ out:
>   * another -errno upon other errors.
>   */
>  int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
> -		 u32 requested, struct avc_audit_data *auditdata)
> +		 u32 requested, struct common_audit_data *auditdata)
>  {
>  	struct av_decision avd;
>  	int rc;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2081055..a7de261 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1478,14 +1478,14 @@ static int task_has_capability(struct task_struct *tsk,
>  			       const struct cred *cred,
>  			       int cap, int audit)
>  {
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	struct av_decision avd;
>  	u16 sclass;
>  	u32 sid = cred_sid(cred);
>  	u32 av = CAP_TO_MASK(cap);
>  	int rc;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, CAP);
> +	COMMON_AUDIT_DATA_INIT(&ad, CAP);
>  	ad.tsk = tsk;
>  	ad.u.cap = cap;
>  
> @@ -1524,10 +1524,10 @@ static int task_has_system(struct task_struct *tsk,
>  static int inode_has_perm(const struct cred *cred,
>  			  struct inode *inode,
>  			  u32 perms,
> -			  struct avc_audit_data *adp)
> +			  struct common_audit_data *adp)
>  {
>  	struct inode_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid;
>  
>  	if (unlikely(IS_PRIVATE(inode)))
> @@ -1538,7 +1538,7 @@ static int inode_has_perm(const struct cred *cred,
>  
>  	if (!adp) {
>  		adp = &ad;
> -		AVC_AUDIT_DATA_INIT(&ad, FS);
> +		COMMON_AUDIT_DATA_INIT(&ad, FS);
>  		ad.u.fs.inode = inode;
>  	}
>  
> @@ -1554,9 +1554,9 @@ static inline int dentry_has_perm(const struct cred *cred,
>  				  u32 av)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.mnt = mnt;
>  	ad.u.fs.path.dentry = dentry;
>  	return inode_has_perm(cred, inode, av, &ad);
> @@ -1576,11 +1576,11 @@ static int file_has_perm(const struct cred *cred,
>  {
>  	struct file_security_struct *fsec = file->f_security;
>  	struct inode *inode = file->f_path.dentry->d_inode;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = cred_sid(cred);
>  	int rc;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path = file->f_path;
>  
>  	if (sid != fsec->sid) {
> @@ -1611,7 +1611,7 @@ static int may_create(struct inode *dir,
>  	struct inode_security_struct *dsec;
>  	struct superblock_security_struct *sbsec;
>  	u32 sid, newsid;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	int rc;
>  
>  	dsec = dir->i_security;
> @@ -1620,7 +1620,7 @@ static int may_create(struct inode *dir,
>  	sid = tsec->sid;
>  	newsid = tsec->create_sid;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.dentry = dentry;
>  
>  	rc = avc_has_perm(sid, dsec->sid, SECCLASS_DIR,
> @@ -1664,7 +1664,7 @@ static int may_link(struct inode *dir,
>  
>  {
>  	struct inode_security_struct *dsec, *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	u32 av;
>  	int rc;
> @@ -1672,7 +1672,7 @@ static int may_link(struct inode *dir,
>  	dsec = dir->i_security;
>  	isec = dentry->d_inode->i_security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.dentry = dentry;
>  
>  	av = DIR__SEARCH;
> @@ -1707,7 +1707,7 @@ static inline int may_rename(struct inode *old_dir,
>  			     struct dentry *new_dentry)
>  {
>  	struct inode_security_struct *old_dsec, *new_dsec, *old_isec, *new_isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	u32 av;
>  	int old_is_dir, new_is_dir;
> @@ -1718,7 +1718,7 @@ static inline int may_rename(struct inode *old_dir,
>  	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
>  	new_dsec = new_dir->i_security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  
>  	ad.u.fs.path.dentry = old_dentry;
>  	rc = avc_has_perm(sid, old_dsec->sid, SECCLASS_DIR,
> @@ -1760,7 +1760,7 @@ static inline int may_rename(struct inode *old_dir,
>  static int superblock_has_perm(const struct cred *cred,
>  			       struct super_block *sb,
>  			       u32 perms,
> -			       struct avc_audit_data *ad)
> +			       struct common_audit_data *ad)
>  {
>  	struct superblock_security_struct *sbsec;
>  	u32 sid = cred_sid(cred);
> @@ -2100,7 +2100,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  	const struct task_security_struct *old_tsec;
>  	struct task_security_struct *new_tsec;
>  	struct inode_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	struct inode *inode = bprm->file->f_path.dentry->d_inode;
>  	int rc;
>  
> @@ -2138,7 +2138,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  			return rc;
>  	}
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path = bprm->file->f_path;
>  
>  	if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
> @@ -2231,7 +2231,7 @@ extern struct dentry *selinux_null;
>  static inline void flush_unauthorized_files(const struct cred *cred,
>  					    struct files_struct *files)
>  {
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	struct file *file, *devnull = NULL;
>  	struct tty_struct *tty;
>  	struct fdtable *fdt;
> @@ -2265,7 +2265,7 @@ static inline void flush_unauthorized_files(const struct cred *cred,
>  
>  	/* Revalidate access to inherited open files. */
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  
>  	spin_lock(&files->file_lock);
>  	for (;;) {
> @@ -2514,7 +2514,7 @@ out:
>  static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
>  {
>  	const struct cred *cred = current_cred();
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	int rc;
>  
>  	rc = superblock_doinit(sb, data);
> @@ -2525,7 +2525,7 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
>  	if (flags & MS_KERNMOUNT)
>  		return 0;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.dentry = sb->s_root;
>  	return superblock_has_perm(cred, sb, FILESYSTEM__MOUNT, &ad);
>  }
> @@ -2533,9 +2533,9 @@ static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data)
>  static int selinux_sb_statfs(struct dentry *dentry)
>  {
>  	const struct cred *cred = current_cred();
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.dentry = dentry->d_sb->s_root;
>  	return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATTR, &ad);
>  }
> @@ -2755,7 +2755,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	struct inode *inode = dentry->d_inode;
>  	struct inode_security_struct *isec = inode->i_security;
>  	struct superblock_security_struct *sbsec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 newsid, sid = current_sid();
>  	int rc = 0;
>  
> @@ -2769,7 +2769,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	if (!is_owner_or_cap(inode))
>  		return -EPERM;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, FS);
> +	COMMON_AUDIT_DATA_INIT(&ad, FS);
>  	ad.u.fs.path.dentry = dentry;
>  
>  	rc = avc_has_perm(sid, isec->sid, isec->sclass,
> @@ -3401,7 +3401,7 @@ static void selinux_task_to_inode(struct task_struct *p,
>  
>  /* Returns error only if unable to parse addresses */
>  static int selinux_parse_skb_ipv4(struct sk_buff *skb,
> -			struct avc_audit_data *ad, u8 *proto)
> +			struct common_audit_data *ad, u8 *proto)
>  {
>  	int offset, ihlen, ret = -EINVAL;
>  	struct iphdr _iph, *ih;
> @@ -3482,7 +3482,7 @@ out:
>  
>  /* Returns error only if unable to parse addresses */
>  static int selinux_parse_skb_ipv6(struct sk_buff *skb,
> -			struct avc_audit_data *ad, u8 *proto)
> +			struct common_audit_data *ad, u8 *proto)
>  {
>  	u8 nexthdr;
>  	int ret = -EINVAL, offset;
> @@ -3553,7 +3553,7 @@ out:
>  
>  #endif /* IPV6 */
>  
> -static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
> +static int selinux_parse_skb(struct sk_buff *skb, struct common_audit_data *ad,
>  			     char **_addrp, int src, u8 *proto)
>  {
>  	char *addrp;
> @@ -3635,7 +3635,7 @@ static int socket_has_perm(struct task_struct *task, struct socket *sock,
>  			   u32 perms)
>  {
>  	struct inode_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid;
>  	int err = 0;
>  
> @@ -3645,7 +3645,7 @@ static int socket_has_perm(struct task_struct *task, struct socket *sock,
>  		goto out;
>  	sid = task_sid(task);
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.sk = sock->sk;
>  	err = avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
>  
> @@ -3732,7 +3732,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  	if (family == PF_INET || family == PF_INET6) {
>  		char *addrp;
>  		struct inode_security_struct *isec;
> -		struct avc_audit_data ad;
> +		struct common_audit_data ad;
>  		struct sockaddr_in *addr4 = NULL;
>  		struct sockaddr_in6 *addr6 = NULL;
>  		unsigned short snum;
> @@ -3761,7 +3761,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  						      snum, &sid);
>  				if (err)
>  					goto out;
> -				AVC_AUDIT_DATA_INIT(&ad, NET);
> +				COMMON_AUDIT_DATA_INIT(&ad, NET);
>  				ad.u.net.sport = htons(snum);
>  				ad.u.net.family = family;
>  				err = avc_has_perm(isec->sid, sid,
> @@ -3794,7 +3794,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  		if (err)
>  			goto out;
>  
> -		AVC_AUDIT_DATA_INIT(&ad, NET);
> +		COMMON_AUDIT_DATA_INIT(&ad, NET);
>  		ad.u.net.sport = htons(snum);
>  		ad.u.net.family = family;
>  
> @@ -3828,7 +3828,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
>  	isec = SOCK_INODE(sock)->i_security;
>  	if (isec->sclass == SECCLASS_TCP_SOCKET ||
>  	    isec->sclass == SECCLASS_DCCP_SOCKET) {
> -		struct avc_audit_data ad;
> +		struct common_audit_data ad;
>  		struct sockaddr_in *addr4 = NULL;
>  		struct sockaddr_in6 *addr6 = NULL;
>  		unsigned short snum;
> @@ -3853,7 +3853,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
>  		perm = (isec->sclass == SECCLASS_TCP_SOCKET) ?
>  		       TCP_SOCKET__NAME_CONNECT : DCCP_SOCKET__NAME_CONNECT;
>  
> -		AVC_AUDIT_DATA_INIT(&ad, NET);
> +		COMMON_AUDIT_DATA_INIT(&ad, NET);
>  		ad.u.net.dport = htons(snum);
>  		ad.u.net.family = sk->sk_family;
>  		err = avc_has_perm(isec->sid, sid, isec->sclass, perm, &ad);
> @@ -3943,13 +3943,13 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
>  	struct sk_security_struct *ssec;
>  	struct inode_security_struct *isec;
>  	struct inode_security_struct *other_isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	int err;
>  
>  	isec = SOCK_INODE(sock)->i_security;
>  	other_isec = SOCK_INODE(other)->i_security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.sk = other->sk;
>  
>  	err = avc_has_perm(isec->sid, other_isec->sid,
> @@ -3975,13 +3975,13 @@ static int selinux_socket_unix_may_send(struct socket *sock,
>  {
>  	struct inode_security_struct *isec;
>  	struct inode_security_struct *other_isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	int err;
>  
>  	isec = SOCK_INODE(sock)->i_security;
>  	other_isec = SOCK_INODE(other)->i_security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.sk = other->sk;
>  
>  	err = avc_has_perm(isec->sid, other_isec->sid,
> @@ -3994,7 +3994,7 @@ static int selinux_socket_unix_may_send(struct socket *sock,
>  
>  static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16 family,
>  				    u32 peer_sid,
> -				    struct avc_audit_data *ad)
> +				    struct common_audit_data *ad)
>  {
>  	int err;
>  	u32 if_sid;
> @@ -4022,10 +4022,10 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>  	struct sk_security_struct *sksec = sk->sk_security;
>  	u32 peer_sid;
>  	u32 sk_sid = sksec->sid;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	char *addrp;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.netif = skb->iif;
>  	ad.u.net.family = family;
>  	err = selinux_parse_skb(skb, &ad, &addrp, 1, NULL);
> @@ -4063,7 +4063,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	struct sk_security_struct *sksec = sk->sk_security;
>  	u16 family = sk->sk_family;
>  	u32 sk_sid = sksec->sid;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	char *addrp;
>  	u8 secmark_active;
>  	u8 peerlbl_active;
> @@ -4087,7 +4087,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	if (!secmark_active && !peerlbl_active)
>  		return 0;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.netif = skb->iif;
>  	ad.u.net.family = family;
>  	err = selinux_parse_skb(skb, &ad, &addrp, 1, NULL);
> @@ -4345,7 +4345,7 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb, int ifindex,
>  	int err;
>  	char *addrp;
>  	u32 peer_sid;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u8 secmark_active;
>  	u8 netlbl_active;
>  	u8 peerlbl_active;
> @@ -4362,7 +4362,7 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb, int ifindex,
>  	if (selinux_skb_peerlbl_sid(skb, family, &peer_sid) != 0)
>  		return NF_DROP;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.netif = ifindex;
>  	ad.u.net.family = family;
>  	if (selinux_parse_skb(skb, &ad, &addrp, 1, NULL) != 0)
> @@ -4450,7 +4450,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
>  {
>  	struct sock *sk = skb->sk;
>  	struct sk_security_struct *sksec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	char *addrp;
>  	u8 proto;
>  
> @@ -4458,7 +4458,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
>  		return NF_ACCEPT;
>  	sksec = sk->sk_security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.netif = ifindex;
>  	ad.u.net.family = family;
>  	if (selinux_parse_skb(skb, &ad, &addrp, 0, &proto))
> @@ -4482,7 +4482,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  	u32 secmark_perm;
>  	u32 peer_sid;
>  	struct sock *sk;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	char *addrp;
>  	u8 secmark_active;
>  	u8 peerlbl_active;
> @@ -4541,7 +4541,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  		secmark_perm = PACKET__SEND;
>  	}
>  
> -	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.netif = ifindex;
>  	ad.u.net.family = family;
>  	if (selinux_parse_skb(skb, &ad, &addrp, 0, NULL))
> @@ -4611,13 +4611,13 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>  static int selinux_netlink_recv(struct sk_buff *skb, int capability)
>  {
>  	int err;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  
>  	err = cap_netlink_recv(skb, capability);
>  	if (err)
>  		return err;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, CAP);
> +	COMMON_AUDIT_DATA_INIT(&ad, CAP);
>  	ad.u.cap = capability;
>  
>  	return avc_has_perm(NETLINK_CB(skb).sid, NETLINK_CB(skb).sid,
> @@ -4676,12 +4676,12 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
>  			u32 perms)
>  {
>  	struct ipc_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  
>  	isec = ipc_perms->security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = ipc_perms->key;
>  
>  	return avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
> @@ -4701,7 +4701,7 @@ static void selinux_msg_msg_free_security(struct msg_msg *msg)
>  static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
>  {
>  	struct ipc_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	int rc;
>  
> @@ -4711,7 +4711,7 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
>  
>  	isec = msq->q_perm.security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = msq->q_perm.key;
>  
>  	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
> @@ -4731,12 +4731,12 @@ static void selinux_msg_queue_free_security(struct msg_queue *msq)
>  static int selinux_msg_queue_associate(struct msg_queue *msq, int msqflg)
>  {
>  	struct ipc_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  
>  	isec = msq->q_perm.security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = msq->q_perm.key;
>  
>  	return avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
> @@ -4775,7 +4775,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  {
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	int rc;
>  
> @@ -4796,7 +4796,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
>  			return rc;
>  	}
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = msq->q_perm.key;
>  
>  	/* Can this process write to the queue? */
> @@ -4820,14 +4820,14 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
>  {
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = task_sid(target);
>  	int rc;
>  
>  	isec = msq->q_perm.security;
>  	msec = msg->security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = msq->q_perm.key;
>  
>  	rc = avc_has_perm(sid, isec->sid,
> @@ -4842,7 +4842,7 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
>  static int selinux_shm_alloc_security(struct shmid_kernel *shp)
>  {
>  	struct ipc_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	int rc;
>  
> @@ -4852,7 +4852,7 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
>  
>  	isec = shp->shm_perm.security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = shp->shm_perm.key;
>  
>  	rc = avc_has_perm(sid, isec->sid, SECCLASS_SHM,
> @@ -4872,12 +4872,12 @@ static void selinux_shm_free_security(struct shmid_kernel *shp)
>  static int selinux_shm_associate(struct shmid_kernel *shp, int shmflg)
>  {
>  	struct ipc_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  
>  	isec = shp->shm_perm.security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = shp->shm_perm.key;
>  
>  	return avc_has_perm(sid, isec->sid, SECCLASS_SHM,
> @@ -4934,7 +4934,7 @@ static int selinux_shm_shmat(struct shmid_kernel *shp,
>  static int selinux_sem_alloc_security(struct sem_array *sma)
>  {
>  	struct ipc_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  	int rc;
>  
> @@ -4944,7 +4944,7 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
>  
>  	isec = sma->sem_perm.security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = sma->sem_perm.key;
>  
>  	rc = avc_has_perm(sid, isec->sid, SECCLASS_SEM,
> @@ -4964,12 +4964,12 @@ static void selinux_sem_free_security(struct sem_array *sma)
>  static int selinux_sem_associate(struct sem_array *sma, int semflg)
>  {
>  	struct ipc_security_struct *isec;
> -	struct avc_audit_data ad;
> +	struct common_audit_data ad;
>  	u32 sid = current_sid();
>  
>  	isec = sma->sem_perm.security;
>  
> -	AVC_AUDIT_DATA_INIT(&ad, IPC);
> +	COMMON_AUDIT_DATA_INIT(&ad, IPC);
>  	ad.u.ipc_id = sma->sem_perm.key;
>  
>  	return avc_has_perm(sid, isec->sid, SECCLASS_SEM,
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index ae4c3a0..e94e82f 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -13,6 +13,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/init.h>
>  #include <linux/audit.h>
> +#include <linux/lsm_audit.h>
>  #include <linux/in6.h>
>  #include <linux/path.h>
>  #include <asm/system.h>
> @@ -36,48 +37,6 @@ struct inode;
>  struct sock;
>  struct sk_buff;
>  
> -/* Auxiliary data to use in generating the audit record. */
> -struct avc_audit_data {
> -	char    type;
> -#define AVC_AUDIT_DATA_FS   1
> -#define AVC_AUDIT_DATA_NET  2
> -#define AVC_AUDIT_DATA_CAP  3
> -#define AVC_AUDIT_DATA_IPC  4
> -	struct task_struct *tsk;
> -	union 	{
> -		struct {
> -			struct path path;
> -			struct inode *inode;
> -		} fs;
> -		struct {
> -			int netif;
> -			struct sock *sk;
> -			u16 family;
> -			__be16 dport;
> -			__be16 sport;
> -			union {
> -				struct {
> -					__be32 daddr;
> -					__be32 saddr;
> -				} v4;
> -				struct {
> -					struct in6_addr daddr;
> -					struct in6_addr saddr;
> -				} v6;
> -			} fam;
> -		} net;
> -		int cap;
> -		int ipc_id;
> -	} u;
> -};
> -
> -#define v4info fam.v4
> -#define v6info fam.v6
> -
> -/* Initialize an AVC audit data structure. */
> -#define AVC_AUDIT_DATA_INIT(_d,_t) \
> -	{ memset((_d), 0, sizeof(struct avc_audit_data)); (_d)->type = AVC_AUDIT_DATA_##_t; }
> -
>  /*
>   * AVC statistics
>   */
> @@ -98,7 +57,9 @@ void __init avc_init(void);
>  
>  void avc_audit(u32 ssid, u32 tsid,
>  	       u16 tclass, u32 requested,
> -	       struct av_decision *avd, int result, struct avc_audit_data *auditdata);
> +	       struct av_decision *avd,
> +	       int result,
> +	       struct common_audit_data *a);
>  
>  #define AVC_STRICT 1 /* Ignore permissive mode. */
>  int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> @@ -108,7 +69,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  
>  int avc_has_perm(u32 ssid, u32 tsid,
>  		 u16 tclass, u32 requested,
> -		 struct avc_audit_data *auditdata);
> +		 struct common_audit_data *auditdata);
>  
>  u32 avc_policy_seqno(void);
>  
> diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
> index b4b5b9b..8d73842 100644
> --- a/security/selinux/include/netlabel.h
> +++ b/security/selinux/include/netlabel.h
> @@ -59,7 +59,7 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family);
>  int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
>  				struct sk_buff *skb,
>  				u16 family,
> -				struct avc_audit_data *ad);
> +				struct common_audit_data *ad);
>  int selinux_netlbl_socket_setsockopt(struct socket *sock,
>  				     int level,
>  				     int optname);
> @@ -129,7 +129,7 @@ static inline int selinux_netlbl_socket_post_create(struct sock *sk,
>  static inline int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
>  					      struct sk_buff *skb,
>  					      u16 family,
> -					      struct avc_audit_data *ad)
> +					      struct common_audit_data *ad)
>  {
>  	return 0;
>  }
> diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
> index 289e24b..13128f9 100644
> --- a/security/selinux/include/xfrm.h
> +++ b/security/selinux/include/xfrm.h
> @@ -41,9 +41,9 @@ static inline int selinux_xfrm_enabled(void)
>  }
>  
>  int selinux_xfrm_sock_rcv_skb(u32 sid, struct sk_buff *skb,
> -			struct avc_audit_data *ad);
> +			struct common_audit_data *ad);
>  int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
> -			struct avc_audit_data *ad, u8 proto);
> +			struct common_audit_data *ad, u8 proto);
>  int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall);
>  
>  static inline void selinux_xfrm_notify_policyload(void)
> @@ -57,13 +57,13 @@ static inline int selinux_xfrm_enabled(void)
>  }
>  
>  static inline int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
> -			struct avc_audit_data *ad)
> +			struct common_audit_data *ad)
>  {
>  	return 0;
>  }
>  
>  static inline int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
> -			struct avc_audit_data *ad, u8 proto)
> +			struct common_audit_data *ad, u8 proto)
>  {
>  	return 0;
>  }
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 2e98441..e688237 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -342,7 +342,7 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
>  int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
>  				struct sk_buff *skb,
>  				u16 family,
> -				struct avc_audit_data *ad)
> +				struct common_audit_data *ad)
>  {
>  	int rc;
>  	u32 nlbl_sid;
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 72b1845..f3cb9ed 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -401,7 +401,7 @@ int selinux_xfrm_state_delete(struct xfrm_state *x)
>   * gone thru the IPSec process.
>   */
>  int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
> -				struct avc_audit_data *ad)
> +				struct common_audit_data *ad)
>  {
>  	int i, rc = 0;
>  	struct sec_path *sp;
> @@ -442,7 +442,7 @@ int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
>   * checked in the selinux_xfrm_state_pol_flow_match hook above.
>   */
>  int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
> -					struct avc_audit_data *ad, u8 proto)
> +					struct common_audit_data *ad, u8 proto)
>  {
>  	struct dst_entry *dst;
>  	int rc = 0;
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
