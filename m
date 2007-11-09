Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9MkHbB000916
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 17:46:17 -0500
Received: from web36615.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id lA9MkFSU008656
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 22:46:15 GMT
Date: Fri, 9 Nov 2007 14:46:14 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH -v3] SELinux: Add get, set, and cloning of superblock security information
To: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc: sds@tycho.nsa.gov, jmorris@namei.org,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1194646937.4627.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <213551.91867.qm@web36615.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Eric Paris <eparis@redhat.com> wrote:

> Adds security_get_sb_mnt_opts, security_set_sb_mnt_opts, and
> security_clont_sb_mnt_opts to the LSM and to SELinux.  This will allow
> filesystems to directly own and control all of their mount options if
> they so choose.

I understand why you would want get_sb_mnt_opts(), but what
is the value for set_sb_mnt_opts() and what is the purpose of
clone_sb_mnt_opts()?

> This interface deals only with option identifiers and
> strings so it should generic enough for any LSM which may come in the
> future.  Filesystems which pass text mount data around in the kernel
> (almost all of them) need not currently make use of this interface for
> SELinux sake since it will still parse those strings as it always has.

If SELinux is still dealing with strings on it's own what is
the point of these hooks?

> An LSM would need to implement these functions only if they had mount
> time options, such as selinux has context= or fscontext=.  If the LSM
> has no mount time options they could simply not implement and let the
> dummy ops take care of things.  

Smack and SELinux currently deal with options in sb_kern_mount(), with
help from sb_copy_data(). Why change the implementation?

> A LSM other than SELinux would need to define new option numbers in
> security.h

I don't think it is a good idea to require that LSM specific
information be stored outside the scope of the LSM.

> (or could reuse if they have the same basic meaning I guess)
> and any FS which decides to own there own security options would need to
> be patched to use this new interface for every possible LSM.  This is
> because it was stated to me very clearly that LSM's should not attempt
> to understand FS mount data and the burdon to understand security should
> be in the FS which owns the options.

Perhaps a mount option prefix then. "Smack.root", "SELinux.context",
that sort of thing. An LSM writer shouldn't have to patch security.h
every time she wants to add a mount option.

> Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> ---
> 
> For now the only forseen user of this interface is NFS.  NFS uses a
> binary blob in kernel for mount data (it uses this blob irrespective of
> the binary vs. text mount options it can get from userspace.)  NFS must
> then set its own mount options explicitly so we need some interface for
> it to do so.
> 
> 
>  include/linux/security.h          |   36 ++
>  security/dummy.c                  |   26 ++
>  security/security.c               |   20 +
>  security/selinux/hooks.c          |  749
> ++++++++++++++++++++++++-------------
>  security/selinux/include/objsec.h |    1 +
>  5 files changed, 578 insertions(+), 254 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ac05083..dcbb792 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -34,6 +34,12 @@
>  #include <linux/xfrm.h>
>  #include <net/flow.h>
>  
> +/* only a char in selinux superblock security struct flags */
> +#define FSCONTEXT_MNT		0x01
> +#define CONTEXT_MNT		0x02
> +#define ROOTCONTEXT_MNT		0x04
> +#define DEFCONTEXT_MNT		0x08
> +
>  /*
>   * Bounding set
>   */
> @@ -261,6 +267,22 @@ struct request_sock;
>   *	Update module state after a successful pivot.
>   *	@old_nd contains the nameidata structure for the old root.
>   *      @new_nd contains the nameidata structure for the new root.
> + * @sb_get_mnt_opts:
> + *      Get the security relevant mount options used for a superblock
> + *      @sb the superblock to get security mount options from
> + *      @mount_options array for pointers to mount options
> + *      @mount_flags array of ints specifying what each mount options is
> + *      @num_opts number of options in the arrays
> + * @sb_set_mnt_opts:
> + *      Set the security relevant mount options used for a superblock
> + *      @sb the superblock to set security mount options for
> + *      @mount_options array for pointers to mount options
> + *      @mount_flags array of ints specifying what each mount options is
> + *      @num_opts number of options in the arrays
> + * @sb_clone_mnt_opts:
> + *	Copy all security options from a given superblock to another
> + *	@oldsb old superblock which contain information to clone
> + *	@newsb new superblock which needs filled in
>   *
>   * Security hooks for inode operations.
>   *
> @@ -1242,6 +1264,13 @@ struct security_operations {
>  			     struct nameidata * new_nd);
>  	void (*sb_post_pivotroot) (struct nameidata * old_nd,
>  				   struct nameidata * new_nd);
> +	int (*sb_get_mnt_opts) (const struct super_block *sb,
> +				char ***mount_options, int **flags,
> +				int *num_opts);
> +	int (*sb_set_mnt_opts) (struct super_block *sb, char **mount_options,
> +				int *flags, int num_opts);
> +	void (*sb_clone_mnt_opts) (const struct super_block *oldsb,
> +				   struct super_block *newsb);
>  
>  	int (*inode_alloc_security) (struct inode *inode);	
>  	void (*inode_free_security) (struct inode *inode);
> @@ -1499,6 +1528,13 @@ void security_sb_post_mountroot(void);
>  void security_sb_post_addmount(struct vfsmount *mnt, struct nameidata
> *mountpoint_nd);
>  int security_sb_pivotroot(struct nameidata *old_nd, struct nameidata
> *new_nd);
>  void security_sb_post_pivotroot(struct nameidata *old_nd, struct nameidata
> *new_nd);
> +int security_sb_get_mnt_opts(const struct super_block *sb, char
> ***mount_options,
> +			     int **flags, int *num_opts);
> +int security_sb_set_mnt_opts(struct super_block *sb, char **mount_options,
> +			     int *flags, int num_opts);
> +void security_sb_clone_mnt_opts(const struct super_block *oldsb,
> +				struct super_block *newsb);
> +
>  int security_inode_alloc(struct inode *inode);
>  void security_inode_free(struct inode *inode);
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
> diff --git a/security/dummy.c b/security/dummy.c
> index 6d895ad..22d9663 100644
> --- a/security/dummy.c
> +++ b/security/dummy.c
> @@ -245,6 +245,29 @@ static void dummy_sb_post_pivotroot (struct nameidata
> *old_nd, struct nameidata
>  	return;
>  }
>  
> +static int dummy_sb_get_mnt_opts(const struct super_block *sb, char
> ***mount_options,
> +				 int **flags, int *num_opts)
> +{
> +	*mount_options = NULL;
> +	*flags = NULL;
> +	*num_opts = 0;
> +	return 0;
> +}
> +
> +static int dummy_sb_set_mnt_opts(struct super_block *sb, char
> **mount_options,
> +				 int *flags, int num_opts)
> +{
> +	if (unlikely(num_opts))
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +static void dummy_sb_clone_mnt_opts(const struct super_block *oldsb,
> +				    struct super_block *newsb)
> +{
> +	return;
> +}
> +
>  static int dummy_inode_alloc_security (struct inode *inode)
>  {
>  	return 0;
> @@ -998,6 +1021,9 @@ void security_fixup_ops (struct security_operations
> *ops)
>  	set_to_dummy_if_null(ops, sb_post_addmount);
>  	set_to_dummy_if_null(ops, sb_pivotroot);
>  	set_to_dummy_if_null(ops, sb_post_pivotroot);
> +	set_to_dummy_if_null(ops, sb_get_mnt_opts);
> +	set_to_dummy_if_null(ops, sb_set_mnt_opts);
> +	set_to_dummy_if_null(ops, sb_clone_mnt_opts);
>  	set_to_dummy_if_null(ops, inode_alloc_security);
>  	set_to_dummy_if_null(ops, inode_free_security);
>  	set_to_dummy_if_null(ops, inode_init_security);
> diff --git a/security/security.c b/security/security.c
> index 0e1f1f1..f48fb30 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -308,6 +308,26 @@ void security_sb_post_pivotroot(struct nameidata
> *old_nd, struct nameidata *new_
>  	security_ops->sb_post_pivotroot(old_nd, new_nd);
>  }
>  
> +int security_sb_get_mnt_opts (const struct super_block *sb,
> +			      char ***mount_options,
> +			      int **flags, int *num_opts)
> +{
> +	return security_ops->sb_get_mnt_opts(sb, mount_options, flags, num_opts);
> +}
> +
> +int security_sb_set_mnt_opts (struct super_block *sb,
> +			      char **mount_options,
> +			      int *flags, int num_opts)
> +{
> +	return security_ops->sb_set_mnt_opts(sb, mount_options, flags, num_opts);
> +}
> +
> +void security_sb_clone_mnt_opts(const struct super_block *oldsb,
> +				struct super_block *newsb)
> +{
> +	security_ops->sb_clone_mnt_opts(oldsb, newsb);
> +}
> +
>  int security_inode_alloc(struct inode *inode)
>  {
>  	inode->i_security = NULL;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9f3124b..e710764 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -82,6 +82,8 @@
>  #define XATTR_SELINUX_SUFFIX "selinux"
>  #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
>  
> +#define NUM_SEL_MNT_OPTS 4
> +
>  extern unsigned int policydb_loaded_version;
>  extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
>  extern int selinux_compat_net;
> @@ -321,8 +323,8 @@ enum {
>  	Opt_error = -1,
>  	Opt_context = 1,
>  	Opt_fscontext = 2,
> -	Opt_defcontext = 4,
> -	Opt_rootcontext = 8,
> +	Opt_defcontext = 3,
> +	Opt_rootcontext = 4,
>  };
>  
>  static match_table_t tokens = {
> @@ -366,150 +368,318 @@ static int may_context_mount_inode_relabel(u32 sid,
>  	return rc;
>  }
>  
> -static int try_context_mount(struct super_block *sb, void *data)
> +static int sb_finish_set_opts(struct super_block *sb)
>  {
> -	char *context = NULL, *defcontext = NULL;
> -	char *fscontext = NULL, *rootcontext = NULL;
> -	const char *name;
> -	u32 sid;
> -	int alloc = 0, rc = 0, seen = 0;
> -	struct task_security_struct *tsec = current->security;
>  	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct dentry *root = sb->s_root;
> +	struct inode *root_inode = root->d_inode;
> +	int rc = 0;
>  
> -	if (!data)
> -		goto out;
> +	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> +		/* Make sure that the xattr handler exists and that no
> +		   error other than -ENODATA is returned by getxattr on
> +		   the root directory.  -ENODATA is ok, as this may be
> +		   the first boot of the SELinux kernel before we have
> +		   assigned xattr values to the filesystem. */
> +		if (!root_inode->i_op->getxattr) {
> +			printk(KERN_WARNING "SELinux: (dev %s, type %s) has no "
> +			       "xattr support\n", sb->s_id, sb->s_type->name);
> +			rc = -EOPNOTSUPP;
> +			goto out;
> +		}
> +		rc = root_inode->i_op->getxattr(root, XATTR_NAME_SELINUX, NULL, 0);
> +		if (rc < 0 && rc != -ENODATA) {
> +			if (rc == -EOPNOTSUPP)
> +				printk(KERN_WARNING "SELinux: (dev %s, type "
> +				       "%s) has no security xattr handler\n",
> +				       sb->s_id, sb->s_type->name);
> +			else
> +				printk(KERN_WARNING "SELinux: (dev %s, type "
> +				       "%s) getxattr errno %d\n", sb->s_id,
> +				       sb->s_type->name, -rc);
> +			goto out;
> +		}
> +	}
>  
> -	name = sb->s_type->name;
> +	sbsec->initialized = 1;
>  
> -	if (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA) {
> +	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
> +		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown
> behavior\n",
> +		       sb->s_id, sb->s_type->name);
> +	}
> +	else {
> +		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
> +		       sb->s_id, sb->s_type->name,
> +		       labeling_behaviors[sbsec->behavior-1]);
> +	}
>  
> -		/* NFS we understand. */
> -		if (!strcmp(name, "nfs")) {
> -			struct nfs_mount_data *d = data;
> +	/* Initialize the root inode. */
> +	rc = inode_doinit_with_dentry(root_inode, root);
>  
> -			if (d->version <  NFS_MOUNT_VERSION)
> -				goto out;
> +	/* Initialize any other inodes associated with the superblock, e.g.
> +	   inodes created prior to initial policy load or inodes created
> +	   during get_sb by a pseudo filesystem that directly
> +	   populates itself. */
> +	spin_lock(&sbsec->isec_lock);
> +next_inode:
> +	if (!list_empty(&sbsec->isec_head)) {
> +		struct inode_security_struct *isec =
> +				list_entry(sbsec->isec_head.next,
> +					   struct inode_security_struct, list);
> +		struct inode *inode = isec->inode;
> +		spin_unlock(&sbsec->isec_lock);
> +		inode = igrab(inode);
> +		if (inode) {
> +			if (!IS_PRIVATE (inode))
> +				inode_doinit(inode);
> +			iput(inode);
> +		}
> +		spin_lock(&sbsec->isec_lock);
> +		list_del_init(&isec->list);
> +		goto next_inode;
> +	}
> +	spin_unlock(&sbsec->isec_lock);
> +out:
> +	return rc;
> +}
>  
> -			if (d->context[0]) {
> -				context = d->context;
> -				seen |= Opt_context;
> -			}
> -		} else
> -			goto out;
> +/*
> + * This function should allow an FS to ask what it's mount security
> + * options were so it can use those later for submounts, displaying
> + * mount options, or whatever.
> + */
> +static int selinux_get_mnt_opts(const struct super_block *sb,
> +				char ***mount_options, int **mnt_opts_flags,
> +				int *num_opts)
> +{
> +	int rc = 0, i;
> +	struct superblock_security_struct *sbsec = sb->s_security;
> +	char *context = NULL;
> +	u32 len;
> +	char tmp; 
>  
> -	} else {
> -		/* Standard string-based options. */
> -		char *p, *options = data;
> +	*num_opts = 0;
> +	*mount_options = NULL;
> +	*mnt_opts_flags = NULL;
>  
> -		while ((p = strsep(&options, "|")) != NULL) {
> -			int token;
> -			substring_t args[MAX_OPT_ARGS];
> +	if (!sbsec->initialized)
> +		return -EINVAL;
>  
> -			if (!*p)
> -				continue;
> +	if (!ss_initialized)
> +		return -EINVAL;
>  
> -			token = match_token(p, tokens, args);
> +	/* 
> +	 * if we ever use sbsec flags for anything other than tracking mount
> +	 * settings this is going to need a mask
> +	 */
> +	tmp = sbsec->flags;
> +	/* count the number of mount options for this sb */
> +	for(i = 0; i < 8; i++) {
> +		if (tmp & 0x01)
> +			(*num_opts)++;
> +		tmp >>= 1;
> +	}
>  
> -			switch (token) {
> -			case Opt_context:
> -				if (seen & (Opt_context|Opt_defcontext)) {
> -					rc = -EINVAL;
> -					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> -					goto out_free;
> -				}
> -				context = match_strdup(&args[0]);
> -				if (!context) {
> -					rc = -ENOMEM;
> -					goto out_free;
> -				}
> -				if (!alloc)
> -					alloc = 1;
> -				seen |= Opt_context;
> -				break;
> +	*mount_options = kcalloc(*num_opts, sizeof(char *), GFP_ATOMIC);
> +	if (!*mount_options) {
> +		rc = -ENOMEM;
> +		goto out_free;
> +	}
>  
> -			case Opt_fscontext:
> -				if (seen & Opt_fscontext) {
> -					rc = -EINVAL;
> -					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> -					goto out_free;
> -				}
> -				fscontext = match_strdup(&args[0]);
> -				if (!fscontext) {
> -					rc = -ENOMEM;
> -					goto out_free;
> -				}
> -				if (!alloc)
> -					alloc = 1;
> -				seen |= Opt_fscontext;
> -				break;
> +	*mnt_opts_flags = kcalloc(*num_opts, sizeof(int), GFP_ATOMIC);
> +	if (!*mnt_opts_flags) {
> +		rc = -ENOMEM;
> +		goto out_free;
> +	}
>  
> -			case Opt_rootcontext:
> -				if (seen & Opt_rootcontext) {
> -					rc = -EINVAL;
> -					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> -					goto out_free;
> -				}
> -				rootcontext = match_strdup(&args[0]);
> -				if (!rootcontext) {
> -					rc = -ENOMEM;
> -					goto out_free;
> -				}
> -				if (!alloc)
> -					alloc = 1;
> -				seen |= Opt_rootcontext;
> -				break;
> +	i = 0;
> +	if (sbsec->flags & FSCONTEXT_MNT) {
> +		rc = security_sid_to_context(sbsec->sid, &context, &len);
> +		if (rc)
> +			goto out_free;
> +		(*mount_options)[i] = context;
> +		(*mnt_opts_flags)[i++] = FSCONTEXT_MNT;
> +	}
> +	if (sbsec->flags & CONTEXT_MNT) {
> +		rc = security_sid_to_context(sbsec->mntpoint_sid, &context, &len);
> +		if (rc)
> +			goto out_free;
> +		(*mount_options)[i] = context;
> +		(*mnt_opts_flags)[i++] = CONTEXT_MNT;
> +	}
> +	if (sbsec->flags & DEFCONTEXT_MNT) {
> +		rc = security_sid_to_context(sbsec->def_sid, &context, &len);
> +		if (rc)
> +			goto out_free;
> +		(*mount_options)[i] = context;
> +		(*mnt_opts_flags)[i++] = DEFCONTEXT_MNT;
> +	}
> +	if (sbsec->flags & ROOTCONTEXT_MNT) {
> +		struct inode *root = sbsec->sb->s_root->d_inode;
> +		struct inode_security_struct *isec = root->i_security;
>  
> -			case Opt_defcontext:
> -				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
> -					rc = -EINVAL;
> -					printk(KERN_WARNING "SELinux:  "
> -					       "defcontext option is invalid "
> -					       "for this filesystem type\n");
> -					goto out_free;
> -				}
> -				if (seen & (Opt_context|Opt_defcontext)) {
> -					rc = -EINVAL;
> -					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> -					goto out_free;
> -				}
> -				defcontext = match_strdup(&args[0]);
> -				if (!defcontext) {
> -					rc = -ENOMEM;
> -					goto out_free;
> -				}
> -				if (!alloc)
> -					alloc = 1;
> -				seen |= Opt_defcontext;
> -				break;
> +		rc = security_sid_to_context(isec->sid, &context, &len);
> +		if (rc)
> +			goto out_free;
> +		(*mount_options)[i] = context;
> +		(*mnt_opts_flags)[i++] = ROOTCONTEXT_MNT;
> +	}
>  
> -			default:
> -				rc = -EINVAL;
> -				printk(KERN_WARNING "SELinux:  unknown mount "
> -				       "option\n");
> -				goto out_free;
> +	BUG_ON(i != *num_opts);
>  
> -			}
> -		}
> -	}
> +	return 0;
> +
> +out_free:
> +	/* don't leak context string if security_sid_to_context had an error */
> +	if(*mount_options && i)
> +		for (; i > 0; i--)
> +			kfree((*mount_options)[i-1]);
> +	kfree(*mount_options);
> +	*mount_options = NULL;
> +	kfree(*mnt_opts_flags);
> +	*mnt_opts_flags = NULL;
> +	*num_opts = 0;
> +	return rc;
> +}
> +
> +static int bad_option(struct superblock_security_struct *sbsec, char flag,
> +		      u32 old_sid, u32 new_sid)
> +{
> +	/* check if the old mount command had the same options */
> +	if (sbsec->initialized)
> +		if (!(sbsec->flags & flag) ||
> +		    (old_sid != new_sid))
> +			return 1;
> +
> +	/* check if we were passed the same options twice,
> +	 * aka someone passed context=a,context=b
> +	 */
> +	if (!sbsec->initialized)
> +		if (sbsec->flags & flag)
> +			return 1;
> +	return 0;
> +}
> +/*
> + * Allow filesystems with binary mount data to explicitly set mount point
> labeling.
> + */
> +int selinux_set_mnt_opts(struct super_block *sb, char **mount_options,
> +				 int *flags, int num_opts)
> +{
> +	int rc = 0, i;
> +	struct task_security_struct *tsec = current->security;
> +	struct superblock_security_struct *sbsec = sb->s_security;
> +	const char *name = sb->s_type->name;
> +	struct inode *inode = sbsec->sb->s_root->d_inode;
> +	struct inode_security_struct *root_isec = inode->i_security;
> +	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
> +	u32 defcontext_sid = 0;
> +
> +	mutex_lock(&sbsec->lock);
>  
> -	if (!seen)
> +	if (!ss_initialized) {
> +		if (!num_opts) {
> +			/* Defer initialization until selinux_complete_init,
> +		   	after the initial policy is loaded and the security
> +		   	server is ready to handle calls. */
> +			spin_lock(&sb_security_lock);
> +			if (list_empty(&sbsec->list))
> +				list_add(&sbsec->list, &superblock_security_head);
> +			spin_unlock(&sb_security_lock);
> +			goto out;
> +		}
> +		rc = -EINVAL;
> +		printk(KERN_WARNING "Unable to set superblock options before "
> +		       "the security server is initialized\n");
>  		goto out;
> +	}
>  
> -	/* sets the context of the superblock for the fs being mounted. */
> -	if (fscontext) {
> -		rc = security_context_to_sid(fscontext, strlen(fscontext), &sid);
> +	/* 
> +	 * parse the mount options, check if they are valid sids.
> +	 * also check if someone is trying to mount the same sb more
> +	 * than once with different security options.
> +	 */
> +	for(i = 0; i < num_opts; i++) {
> +		u32 sid;
> +		rc = security_context_to_sid(mount_options[i],
> +					     strlen(mount_options[i]), &sid);
>  		if (rc) {
>  			printk(KERN_WARNING "SELinux: security_context_to_sid"
>  			       "(%s) failed for (dev %s, type %s) errno=%d\n",
> -			       fscontext, sb->s_id, name, rc);
> -			goto out_free;
> +			       mount_options[i], sb->s_id, name, rc);
> +			goto out;
>  		}
> +		switch(flags[i]) {
> +		case FSCONTEXT_MNT:
> +			fscontext_sid = sid;
> +
> +			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
> +					fscontext_sid))
> +				goto out_double_mount;
> +
> +			sbsec->flags |= FSCONTEXT_MNT;
> +			break;
> +		case CONTEXT_MNT:
> +			context_sid = sid;
> +
> +			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
> +					context_sid))
> +				goto out_double_mount;
> +
> +			sbsec->flags |= CONTEXT_MNT;
> +			break;
> +		case ROOTCONTEXT_MNT:
> +			rootcontext_sid = sid;
> +
> +			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
> +					rootcontext_sid))
> +				goto out_double_mount;
> +
> +			sbsec->flags |= ROOTCONTEXT_MNT;
> +
> +			break;
> +		case DEFCONTEXT_MNT:
> +			defcontext_sid = sid;
> +
> +			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
> +					defcontext_sid))
> +				goto out_double_mount;
>  
> -		rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
> +			sbsec->flags |= DEFCONTEXT_MNT;
> +
> +			break;
> +		default:
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	if (sbsec->initialized) {
> +		/* previously mounted with options, but not on this attempt? */
> +		if (sbsec->flags && !num_opts)
> +			goto out_double_mount;
> +		rc = 0;
> +		goto out;
> +	}
> +
> +	if (strcmp(sb->s_type->name, "proc") == 0)
> +		sbsec->proc = 1;
> +
> +	/* Determine the labeling behavior to use for this filesystem type. */
> +	rc = security_fs_use(sb->s_type->name, &sbsec->behavior, &sbsec->sid);
> +	if (rc) {
> +		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
> +		       __FUNCTION__, sb->s_type->name, rc);
> +		goto out;
> +	}
> +
> +	/* sets the context of the superblock for the fs being mounted. */
> +	if (fscontext_sid) {
> +
> +		rc = may_context_mount_sb_relabel(fscontext_sid, sbsec, tsec);
>  		if (rc)
> -			goto out_free;
> +			goto out;
>  
> -		sbsec->sid = sid;
> +		sbsec->sid = fscontext_sid;
>  	}
>  
>  	/*
> @@ -517,182 +687,250 @@ static int try_context_mount(struct super_block *sb,
> void *data)
>  	 * sets the label used on all file below the mountpoint, and will set
>  	 * the superblock context if not already set.
>  	 */
> -	if (context) {
> -		rc = security_context_to_sid(context, strlen(context), &sid);
> -		if (rc) {
> -			printk(KERN_WARNING "SELinux: security_context_to_sid"
> -			       "(%s) failed for (dev %s, type %s) errno=%d\n",
> -			       context, sb->s_id, name, rc);
> -			goto out_free;
> -		}
> -
> -		if (!fscontext) {
> -			rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
> +	if (context_sid) {
> +		if (!fscontext_sid) {
> +			rc = may_context_mount_sb_relabel(context_sid, sbsec, tsec);
>  			if (rc)
> -				goto out_free;
> -			sbsec->sid = sid;
> +				goto out;
> +			sbsec->sid = context_sid;
>  		} else {
> -			rc = may_context_mount_inode_relabel(sid, sbsec, tsec);
> +			rc = may_context_mount_inode_relabel(context_sid, sbsec, tsec);
>  			if (rc)
> -				goto out_free;
> +				goto out;
>  		}
> -		sbsec->mntpoint_sid = sid;
> +		if (!rootcontext_sid)
> +			rootcontext_sid = context_sid;
>  
> +		sbsec->mntpoint_sid = context_sid;
>  		sbsec->behavior = SECURITY_FS_USE_MNTPOINT;
>  	}
>  
> -	if (rootcontext) {
> -		struct inode *inode = sb->s_root->d_inode;
> -		struct inode_security_struct *isec = inode->i_security;
> -		rc = security_context_to_sid(rootcontext, strlen(rootcontext), &sid);
> -		if (rc) {
> -			printk(KERN_WARNING "SELinux: security_context_to_sid"
> -			       "(%s) failed for (dev %s, type %s) errno=%d\n",
> -			       rootcontext, sb->s_id, name, rc);
> -			goto out_free;
> -		}
> -
> -		rc = may_context_mount_inode_relabel(sid, sbsec, tsec);
> +	if (rootcontext_sid) {
> +		rc = may_context_mount_inode_relabel(rootcontext_sid, sbsec, tsec);
>  		if (rc)
> -			goto out_free;
> +			goto out;
>  
> -		isec->sid = sid;
> -		isec->initialized = 1;
> +		root_isec->sid = rootcontext_sid;
> +		root_isec->initialized = 1;
>  	}
>  
> -	if (defcontext) {
> -		rc = security_context_to_sid(defcontext, strlen(defcontext), &sid);
> -		if (rc) {
> -			printk(KERN_WARNING "SELinux: security_context_to_sid"
> -			       "(%s) failed for (dev %s, type %s) errno=%d\n",
> -			       defcontext, sb->s_id, name, rc);
> -			goto out_free;
> +	if (defcontext_sid) {
> +		if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
> +			rc = -EINVAL;
> +			printk(KERN_WARNING "SELinux: defcontext option is "
> +			       "invalid for this filesystem type\n");
> +			goto out;
>  		}
>  
> -		if (sid == sbsec->def_sid)
> -			goto out_free;
> -
> -		rc = may_context_mount_inode_relabel(sid, sbsec, tsec);
> -		if (rc)
> -			goto out_free;
> +		if (defcontext_sid != sbsec->def_sid) {
> +			rc = may_context_mount_inode_relabel(defcontext_sid,
> +							     sbsec, tsec);
> +			if (rc)
> +				goto out;
> +		}
>  
> -		sbsec->def_sid = sid;
> +		sbsec->def_sid = defcontext_sid;
>  	}
>  
> -out_free:
> -	if (alloc) {
> -		kfree(context);
> -		kfree(defcontext);
> -		kfree(fscontext);
> -		kfree(rootcontext);
> -	}
> +	rc = sb_finish_set_opts(sb);
>  out:
> +	mutex_unlock(&sbsec->lock);
>  	return rc;
> +out_double_mount:
> +	rc = -EINVAL;
> +	printk(KERN_WARNING "SELinux: mount invalid.  Same superblock, different "
> +	       "security settings for (dev %s, type %s)\n", sb->s_id, name);
> +	goto out;
>  }
>  
> -static int superblock_doinit(struct super_block *sb, void *data)
> +static void selinux_sb_clone_mnt_opts (const struct super_block *oldsb,
> +					struct super_block *newsb)
>  {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> -	struct dentry *root = sb->s_root;
> -	struct inode *inode = root->d_inode;
> -	int rc = 0;
> +	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
> +	struct superblock_security_struct *newsbsec = newsb->s_security;
>  
> -	mutex_lock(&sbsec->lock);
> -	if (sbsec->initialized)
> -		goto out;
> +	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
> +	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
> +	int set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
>  
> -	if (!ss_initialized) {
> -		/* Defer initialization until selinux_complete_init,
> -		   after the initial policy is loaded and the security
> -		   server is ready to handle calls. */
> -		spin_lock(&sb_security_lock);
> -		if (list_empty(&sbsec->list))
> -			list_add(&sbsec->list, &superblock_security_head);
> -		spin_unlock(&sb_security_lock);
> -		goto out;
> +	/* we can't error, we can't save the info, this shouldn't get called
> +	 * this early in the boot process. */
> +	BUG_ON(!ss_initialized);
> +
> +	/* this might go away sometime down the line if there is a new user
> +	 * of clone, but for now, nfs better not get here... */
> +	BUG_ON(newsbsec->initialized);
> +
> +	/* how can we clone if the old one wasn't set up?? */
> +	BUG_ON(!oldsbsec->initialized);
> +
> +	mutex_lock(&newsbsec->lock);
> +
> +	newsbsec->flags = oldsbsec->flags;
> +
> +	newsbsec->sid = oldsbsec->sid;
> +	newsbsec->def_sid = oldsbsec->def_sid;
> +	newsbsec->behavior = oldsbsec->behavior;
> +
> +	if (set_context) {
> +		u32 sid = oldsbsec->mntpoint_sid;
> +
> +		if (!set_fscontext)
> +			newsbsec->sid = sid;
> +		if (!set_rootcontext) {
> +			struct inode *newinode = newsb->s_root->d_inode;
> +			struct inode_security_struct *newisec = newinode->i_security;
> +			newisec->sid = sid;
> +		}
> +		newsbsec->mntpoint_sid = sid;
>  	}
> +	if (set_rootcontext) {
> +		const struct inode *oldinode = oldsb->s_root->d_inode;
> +		const struct inode_security_struct *oldisec = oldinode->i_security;
> +		struct inode *newinode = newsb->s_root->d_inode;
> +		struct inode_security_struct *newisec = newinode->i_security;
>  
> -	/* Determine the labeling behavior to use for this filesystem type. */
> -	rc = security_fs_use(sb->s_type->name, &sbsec->behavior, &sbsec->sid);
> -	if (rc) {
> -		printk(KERN_WARNING "%s:  security_fs_use(%s) returned %d\n",
> -		       __FUNCTION__, sb->s_type->name, rc);
> -		goto out;
> +		newisec->sid = oldisec->sid;
>  	}
>  
> -	rc = try_context_mount(sb, data);
> -	if (rc)
> +	sb_finish_set_opts(newsb);
> +	mutex_unlock(&newsbsec->lock);
> +}
> +
> +/*
> + * string mount options parsing and call set the sbsec
> + */
> +static int superblock_doinit(struct super_block *sb, void *data)
> +{
> +	char *context = NULL, *defcontext = NULL;
> +	char *fscontext = NULL, *rootcontext = NULL;
> +	int rc = 0;
> +	char *p, *options = data;
> +	/* selinux only know about a fixed number of mount options */
> +	char *mnt_opts[NUM_SEL_MNT_OPTS];
> +	int mnt_opts_flags[NUM_SEL_MNT_OPTS], num_mnt_opts = 0;
> +
> +	if (!data)
>  		goto out;
>  
> -	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
> -		/* Make sure that the xattr handler exists and that no
> -		   error other than -ENODATA is returned by getxattr on
> -		   the root directory.  -ENODATA is ok, as this may be
> -		   the first boot of the SELinux kernel before we have
> -		   assigned xattr values to the filesystem. */
> -		if (!inode->i_op->getxattr) {
> -			printk(KERN_WARNING "SELinux: (dev %s, type %s) has no "
> -			       "xattr support\n", sb->s_id, sb->s_type->name);
> -			rc = -EOPNOTSUPP;
> -			goto out;
> -		}
> -		rc = inode->i_op->getxattr(root, XATTR_NAME_SELINUX, NULL, 0);
> -		if (rc < 0 && rc != -ENODATA) {
> -			if (rc == -EOPNOTSUPP)
> -				printk(KERN_WARNING "SELinux: (dev %s, type "
> -				       "%s) has no security xattr handler\n",
> -				       sb->s_id, sb->s_type->name);
> -			else
> -				printk(KERN_WARNING "SELinux: (dev %s, type "
> -				       "%s) getxattr errno %d\n", sb->s_id,
> -				       sb->s_type->name, -rc);
> +	/* with the nfs patch this will become a goto out; */
> +	if (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA) {
> +		const char *name = sb->s_type->name;
> +		/* NFS we understand. */
> +		if (!strcmp(name, "nfs")) {
> +			struct nfs_mount_data *d = data;
> +
> +			if (d->version !=  NFS_MOUNT_VERSION)
> +				goto out;
> +
> +			if (d->context[0]) {
> +				context = kstrdup(d->context, GFP_KERNEL);
> +				if (!context) {
> +					rc = -ENOMEM;
> +					goto out;
> +				}
> +			}
> +			goto build_flags;
> +		} else
>  			goto out;
> -		}
>  	}
>  
> -	if (strcmp(sb->s_type->name, "proc") == 0)
> -		sbsec->proc = 1;
> +	/* Standard string-based options. */
> +	while ((p = strsep(&options, "|")) != NULL) {
> +		int token;
> +		substring_t args[MAX_OPT_ARGS];
>  
> -	sbsec->initialized = 1;
> +		if (!*p)
> +			continue;
>  
> -	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
> -		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown
> behavior\n",
> -		       sb->s_id, sb->s_type->name);
> -	}
> -	else {
> -		printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
> -		       sb->s_id, sb->s_type->name,
> -		       labeling_behaviors[sbsec->behavior-1]);
> -	}
> +		token = match_token(p, tokens, args);
>  
> -	/* Initialize the root inode. */
> -	rc = inode_doinit_with_dentry(sb->s_root->d_inode, sb->s_root);
> +		switch (token) {
> +		case Opt_context:
> +			if (context || defcontext) {
> +				rc = -EINVAL;
> +				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +				goto out_err;
> +			}
> +			context = match_strdup(&args[0]);
> +			if (!context) {
> +				rc = -ENOMEM;
> +				goto out_err;
> +			}
> +			break;
> +
> +		case Opt_fscontext:
> +			if (fscontext) {
> +				rc = -EINVAL;
> +				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +				goto out_err;
> +			}
> +			fscontext = match_strdup(&args[0]);
> +			if (!fscontext) {
> +				rc = -ENOMEM;
> +				goto out_err;
> +			}
> +			break;
> +
> +		case Opt_rootcontext:
> +			if (rootcontext) {
> +				rc = -EINVAL;
> +				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +				goto out_err;
> +			}
> +			rootcontext = match_strdup(&args[0]);
> +			if (!rootcontext) {
> +				rc = -ENOMEM;
> +				goto out_err;
> +			}
> +			break;
> +
> +		case Opt_defcontext:
> +			if (context || defcontext) {
> +				rc = -EINVAL;
> +				printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);
> +				goto out_err;
> +			}
> +			defcontext = match_strdup(&args[0]);
> +			if (!defcontext) {
> +				rc = -ENOMEM;
> +				goto out_err;
> +			}
> +			break;
> +
> +		default:
> +			rc = -EINVAL;
> +			printk(KERN_WARNING "SELinux:  unknown mount option\n");
> +			goto out_err;
>  
> -	/* Initialize any other inodes associated with the superblock, e.g.
> -	   inodes created prior to initial policy load or inodes created
> -	   during get_sb by a pseudo filesystem that directly
> -	   populates itself. */
> -	spin_lock(&sbsec->isec_lock);
> -next_inode:
> -	if (!list_empty(&sbsec->isec_head)) {
> -		struct inode_security_struct *isec =
> -				list_entry(sbsec->isec_head.next,
> -				           struct inode_security_struct, list);
> -		struct inode *inode = isec->inode;
> -		spin_unlock(&sbsec->isec_lock);
> -		inode = igrab(inode);
> -		if (inode) {
> -			if (!IS_PRIVATE (inode))
> -				inode_doinit(inode);
> -			iput(inode);
>  		}
> -		spin_lock(&sbsec->isec_lock);
> -		list_del_init(&isec->list);
> -		goto next_inode;
>  	}
> -	spin_unlock(&sbsec->isec_lock);
> +
> +build_flags:
> +	if (fscontext) {
> +		mnt_opts[num_mnt_opts] = fscontext;
> +		mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
> +	}
> +	if (context) {
> +		mnt_opts[num_mnt_opts] = context;
> +		mnt_opts_flags[num_mnt_opts++] = CONTEXT_MNT;
> +	}
> +	if (rootcontext) {
> +		mnt_opts[num_mnt_opts] = rootcontext;
> +		mnt_opts_flags[num_mnt_opts++] = ROOTCONTEXT_MNT;
> +	}
> +	if (defcontext) {
> +		mnt_opts[num_mnt_opts] = defcontext;
> +		mnt_opts_flags[num_mnt_opts++] = DEFCONTEXT_MNT;
> +	}
> +
>  out:
> -	mutex_unlock(&sbsec->lock);
> +	rc = selinux_set_mnt_opts(sb, mnt_opts, mnt_opts_flags, num_mnt_opts);
> +out_err:
> +	kfree(context);
> +	kfree(defcontext);
> +	kfree(fscontext);
> +	kfree(rootcontext);
>  	return rc;
>  }
>  
> @@ -4800,6 +5038,9 @@ static struct security_operations selinux_ops = {
>  	.sb_statfs =			selinux_sb_statfs,
>  	.sb_mount =			selinux_mount,
>  	.sb_umount =			selinux_umount,
> +	.sb_get_mnt_opts =		selinux_get_mnt_opts,
> +	.sb_set_mnt_opts =		selinux_set_mnt_opts,
> +	.sb_clone_mnt_opts = 		selinux_sb_clone_mnt_opts,
>  
>  	.inode_alloc_security =		selinux_inode_alloc_security,
>  	.inode_free_security =		selinux_inode_free_security,
> diff --git a/security/selinux/include/objsec.h
> b/security/selinux/include/objsec.h
> index 642a9fd..4138a80 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -65,6 +65,7 @@ struct superblock_security_struct {
>  	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
>  	unsigned int behavior;          /* labeling behavior */
>  	unsigned char initialized;      /* initialization flag */
> +	unsigned char flags;		/* which mount options were specified */
>  	unsigned char proc;             /* proc fs */
>  	struct mutex lock;
>  	struct list_head isec_head;
> 
> 
> 
> 


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
