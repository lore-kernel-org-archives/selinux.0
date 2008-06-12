Subject: Re: [PATCH] SELinux: allow fstype unknown to policy to use xattrs
	if present
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1213291584.3029.1.camel@localhost.localdomain>
References: <1213291584.3029.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 13:33:44 -0400
Message-Id: <1213292024.17842.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 13:26 -0400, Eric Paris wrote:
> Currently if a fs is mounted for which selinux policy does not define an
> fs_use_* or a genfscon statement that FS will not support labeling of
> any kind.  This patch allows the kernel to check if the filesystem
> supports security xattrs and if so will use those if there is no
> fs_use_* rule in policy.  An fstype with a genfs rule will use xattrs if
> available and will follow the genfs rule if they are not.
> 
> This can be particularly interesting for things like ecryptfs which
> actually overlays a real underlying FS.  If we define excryptfs in
> policy to use xattrs we will likely get this wrong at times, so with
> this path we just don't need to define it!
> 
> Overlay ecryptfs on top of NFS with no xattr support:
> SELinux: initialized (dev ecryptfs, type ecryptfs), uses genfs_contexts
> Overlay ecryptfs on top of ext4 with xattr support:
> SELinux: initialized (dev ecryptfs, type ecryptfs), uses xattr
> 
> Its also useful as the kernel adds new FS's we don't need to add them in
> policy if they support xattrs and that's how we want to handle them.

<pedantic>

"Its" -> "It is", "that's" => "That is"

Signed-off-by?

Need a "---" here to prevent diffstat from leaking into the changelog ;)

</pedantic>

> 
>  security/selinux/hooks.c            |   22 +++++++++++++++++-----
>  security/selinux/include/security.h |    2 +-
>  security/selinux/ss/services.c      |   27 +++++++++++++++++++--------
>  3 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1c864c0..1844966 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -554,13 +554,15 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  	struct task_security_struct *tsec = current->security;
>  	struct superblock_security_struct *sbsec = sb->s_security;
>  	const char *name = sb->s_type->name;
> -	struct inode *inode = sbsec->sb->s_root->d_inode;
> -	struct inode_security_struct *root_isec = inode->i_security;
> +	struct dentry *root = sb->s_root;
> +	struct inode *root_inode = root->d_inode;
> +	struct inode_security_struct *root_isec = root_inode->i_security;
>  	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
>  	u32 defcontext_sid = 0;
>  	char **mount_options = opts->mnt_opts;
>  	int *flags = opts->mnt_opts_flags;
>  	int num_opts = opts->num_mnt_opts;
> +	char can_xattr = 0;

bool instead of char since it exists these days.

>  
>  	mutex_lock(&sbsec->lock);
>  
> @@ -664,14 +666,24 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  		goto out;
>  	}
>  
> -	if (strcmp(sb->s_type->name, "proc") == 0)
> +	if (strcmp(name, "proc") == 0)
>  		sbsec->proc = 1;
>  
> +	/*
> +	 * test if the fs supports xattrs, fs_use might make use of this if the
> +	 * fs has no definition in policy.
> +	 */
> +	if (root_inode->i_op->getxattr) {
> +		rc = root_inode->i_op->getxattr(root, XATTR_NAME_SELINUX, NULL, 0);
> +		if (rc >= 0 || rc == -ENODATA)
> +			can_xattr = 1;
> +	}
> +
>  	/* Determine the labeling behavior to use for this filesystem type. */
> -	rc = security_fs_use(sb->s_type->name, &sbsec->behavior, &sbsec->sid);
> +	rc = security_fs_use(name, &sbsec->behavior, &sbsec->sid, can_xattr);
>  	if (rc) {
>  		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
> -		       __func__, sb->s_type->name, rc);
> +		       __func__, name, rc);
>  		goto out;
>  	}
>  
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ad30ac4..eb6da47 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -131,7 +131,7 @@ int security_get_allow_unknown(void);
>  #define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
>  
>  int security_fs_use(const char *fstype, unsigned int *behavior,
> -	u32 *sid);
> +	u32 *sid, char can_xattr);
>  
>  int security_genfs_sid(const char *fstype, char *name, u16 sclass,
>  	u32 *sid);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index dcc2e1c..5af3aab 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1825,7 +1825,8 @@ out:
>  int security_fs_use(
>  	const char *fstype,
>  	unsigned int *behavior,
> -	u32 *sid)
> +	u32 *sid,
> +	char can_xattr)
>  {
>  	int rc = 0;
>  	struct ocontext *c;
> @@ -1839,6 +1840,7 @@ int security_fs_use(
>  		c = c->next;
>  	}
>  
> +	/* look for labeling behavior defined in policy */
>  	if (c) {
>  		*behavior = c->v.behavior;
>  		if (!c->sid[0]) {
> @@ -1849,14 +1851,23 @@ int security_fs_use(
>  				goto out;
>  		}
>  		*sid = c->sid[0];
> +		goto out;
> +	}
> +
> +	/* labeling behavior not in policy, use xattrs if possible */
> +	if (can_xattr) {
> +		*behavior = SECURITY_FS_USE_XATTR;
> +		*sid = SECINITSID_FS;
> +		goto out;
> +	}
> +
> +	/* no behavior in policy and can't use xattrs, try GENFS */
> +	rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
> +	if (rc) {
> +		*behavior = SECURITY_FS_USE_NONE;
> +		rc = 0;
>  	} else {
> -		rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
> -		if (rc) {
> -			*behavior = SECURITY_FS_USE_NONE;
> -			rc = 0;
> -		} else {
> -			*behavior = SECURITY_FS_USE_GENFS;
> -		}
> +		*behavior = SECURITY_FS_USE_GENFS;
>  	}
>  
>  out:
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
