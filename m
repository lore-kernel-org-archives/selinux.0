Subject: Re: [PATCH -v2] SELinux: Add get, set, and cloning of superblock
	security information
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1190402973.3451.151.camel@localhost.localdomain>
References: <1190402973.3451.151.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 Oct 2007 10:49:25 -0400
Message-Id: <1193237365.11178.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-21 at 15:29 -0400, Eric Paris wrote:
> Adds security_get_sb_mnt_opts, security_set_sb_mnt_opts, and
> security_clont_sb_mnt_opts to the LSM and to SELinux.  This is in
> preparation for filesystems (like NFS) to be able to own their own mount
> options.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

I think this should be queued up for -mm.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> ---
> 
> I know this is really hard to review, if needed/wanted I'd be willing to
> make one patch that just rips all the guts of mounting FS out and then
> another patch which puts all this new stuff back....
> 
>  include/linux/security.h          |   72 ++++
>  security/dummy.c                  |   26 ++
>  security/selinux/hooks.c          |  753 ++++++++++++++++++++++++-------------
>  security/selinux/include/objsec.h |    1 +
>  4 files changed, 597 insertions(+), 255 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1a15526..ed3d336 100644
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
>  struct ctl_table;
>  
>  /*
> @@ -248,6 +254,22 @@ struct request_sock;
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
> @@ -1201,6 +1223,13 @@ struct security_operations {
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
> @@ -1594,6 +1623,26 @@ static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
>  	security_ops->sb_post_pivotroot (old_nd, new_nd);
>  }
>  
> +static inline int security_sb_get_mnt_opts (const struct super_block *sb,
> +					    char ***mount_options,
> +					    int **flags, int *num_opts)
> +{
> +	return security_ops->sb_get_mnt_opts(sb, mount_options, flags, num_opts);
> +}
> +
> +static inline int security_sb_set_mnt_opts (struct super_block *sb,
> +					    char **mount_options,
> +					    int *flags, int num_opts)
> +{
> +	return security_ops->sb_set_mnt_opts(sb, mount_options, flags, num_opts);
> +}
> +
> +static inline void security_sb_clone_mnt_opts(const struct super_block *oldsb,
> +					      struct super_block *newsb)
> +{
> +	security_ops->sb_clone_mnt_opts(oldsb, newsb);
> +}
> +
>  static inline int security_inode_alloc (struct inode *inode)
>  {
>  	inode->i_security = NULL;
> @@ -2334,6 +2383,29 @@ static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
>  					       struct nameidata *new_nd)
>  { }
>  
> +static inline int security_sb_get_mnt_opts (const struct super_block *sb,
> +					    char ***mount_options,
> +					    int **flags, int *num_opts)
> +{
> +	*mount_options = NULL;
> +	*flags = NULL;
> +	*num_opts = 0;
> +	return 0;
> +}
> +
> +static inline int security_sb_set_mnt_opts (struct super_block *sb,
> +					    char **mount_options,
> +					    int *flags, int num_opts)
> +{
> +	if (unlikely(num_opts))
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +static inline void security_sb_clone_mnt_opts(const struct super_block *oldsb,
> +					     struct super_block *newsb)
> +{ }
> +
>  static inline int security_inode_alloc (struct inode *inode)
>  {
>  	return 0;
> diff --git a/security/dummy.c b/security/dummy.c
> index 853ec22..c3ac361 100644
> --- a/security/dummy.c
> +++ b/security/dummy.c
> @@ -248,6 +248,29 @@ static void dummy_sb_post_pivotroot (struct nameidata *old_nd, struct nameidata
>  	return;
>  }
>  
> +static int dummy_sb_get_mnt_opts(const struct super_block *sb, char ***mount_options,
> +				 int **flags, int *num_opts)
> +{
> +	*mount_options = NULL;
> +	*flags = NULL;
> +	*num_opts = 0;
> +	return 0;
> +}
> +
> +static int dummy_sb_set_mnt_opts(struct super_block *sb, char **mount_options,
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
> @@ -996,6 +1019,9 @@ void security_fixup_ops (struct security_operations *ops)
>  	set_to_dummy_if_null(ops, sb_post_addmount);
>  	set_to_dummy_if_null(ops, sb_pivotroot);
>  	set_to_dummy_if_null(ops, sb_post_pivotroot);
> +	set_to_dummy_if_null(ops, sb_get_mnt_opts);
> +	set_to_dummy_if_null(ops, sb_set_mnt_opts);
> +	set_to_dummy_if_null(ops, sb_clone_mnt_opts);
>  	set_to_dummy_if_null(ops, inode_alloc_security);
>  	set_to_dummy_if_null(ops, inode_free_security);
>  	set_to_dummy_if_null(ops, inode_init_security);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0753b20..0a0e5a2 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -81,6 +81,8 @@
>  #define XATTR_SELINUX_SUFFIX "selinux"
>  #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
>  
> +#define NUM_SEL_MNT_OPTS 4
> +
>  extern unsigned int policydb_loaded_version;
>  extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
>  extern int selinux_compat_net;
> @@ -319,8 +321,8 @@ enum {
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
> @@ -364,150 +366,318 @@ static int may_context_mount_inode_relabel(u32 sid,
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
> +		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
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
> + * Allow filesystems with binary mount data to explicitly set mount point labeling.
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
> +
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
>  
> -		rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
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
> @@ -515,182 +685,252 @@ static int try_context_mount(struct super_block *sb, void *data)
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
> +				size_t len = strlen(d->context) + 1;
> +				context = kmalloc(len, GFP_KERNEL);
> +				if (!context) {
> +					rc = -ENOMEM;
> +					goto out;
> +				}
> +				strncpy(context, d->context, len);
> +				context[len-1] = '\0';
> +			}
> +		} else
>  			goto out;
> -		}
> -	}
> +	} else {
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
> -		printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
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
> +	} // else for binary mount data.  delete with nfs patch
> +
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
> @@ -4751,6 +4991,9 @@ static struct security_operations selinux_ops = {
>  	.sb_statfs =			selinux_sb_statfs,
>  	.sb_mount =			selinux_mount,
>  	.sb_umount =			selinux_umount,
> +	.sb_get_mnt_opts =		selinux_get_mnt_opts,
> +	.sb_set_mnt_opts =		selinux_set_mnt_opts,
> +	.sb_clone_mnt_opts = 		selinux_sb_clone_mnt_opts,
>  
>  	.inode_alloc_security =		selinux_inode_alloc_security,
>  	.inode_free_security =		selinux_inode_free_security,
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 91b88f0..fc4768e 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -63,6 +63,7 @@ struct superblock_security_struct {
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
