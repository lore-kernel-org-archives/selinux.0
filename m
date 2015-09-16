Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8GKXtci029241
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 16:33:55 -0400
Subject: Re: [PATCH v3 6/7] Smack: Add support for unprivileged mounts from
 user namespaces
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
 <1442433764-80826-7-git-send-email-seth.forshee@canonical.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <55F9D22E.8090902@schaufler-ca.com>
Date: Wed, 16 Sep 2015 13:33:50 -0700
MIME-Version: 1.0
In-Reply-To: <1442433764-80826-7-git-send-email-seth.forshee@canonical.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/16/2015 1:02 PM, Seth Forshee wrote:
> Security labels from unprivileged mounts cannot be trusted.
> Ideally for these mounts we would assign the objects in the
> filesystem the same label as the inode for the backing device
> passed to mount. Unfortunately it's currently impossible to
> determine which inode this is from the LSM mount hooks, so we
> settle for the label of the process doing the mount.
>
> This label is assigned to s_root, and also to smk_default to
> ensure that new inodes receive this label. The transmute property
> is also set on s_root to make this behavior more explicit, even
> though it is technically not necessary.
>
> If a filesystem has existing security labels, access to inodes is
> permitted if the label is the same as smk_root, otherwise access
> is denied. The SMACK64EXEC xattr is completely ignored.
>
> Explicit setting of security labels continues to require
> CAP_MAC_ADMIN in init_user_ns.
>
> Altogether, this ensures that filesystem objects are not
> accessible to subjects which cannot already access the backing
> store, that MAC is not violated for any objects in the fileystem
> which are already labeled, and that a user cannot use an
> unprivileged mount to gain elevated MAC privileges.
>
> sysfs, tmpfs, and ramfs are already mountable from user
> namespaces and support security labels. We can't rule out the
> possibility that these filesystems may already be used in mounts
> from user namespaces with security lables set from the init
> namespace, so failing to trust lables in these filesystems may
> introduce regressions. It is safe to trust labels from these
> filesystems, since the unprivileged user does not control the
> backing store and thus cannot supply security labels, so an
> explicit exception is made to trust labels from these
> filesystems.
>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

One coding comment below, otherwise looking good.

> ---
>  security/smack/smack.h     |  6 ++++++
>  security/smack/smack_lsm.c | 35 +++++++++++++++++++++++++++--------
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index fff0c612bbb7..070223960a2c 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -91,8 +91,14 @@ struct superblock_smack {
>  	struct smack_known	*smk_hat;
>  	struct smack_known	*smk_default;
>  	int			smk_initialized;
> +	int			smk_flags;

How about deleting smk_initialized and using a bit
in smk_flags. A whole int for each seems excessive.
The smk_initialized field is only used in two places,
both in smack_set_mnt_opts.

>  };
>  
> +/*
> + * Superblock flags
> + */
> +#define SMK_SB_UNTRUSTED	0x01

+ #define SMK_SB_INITIALIZED	0x02

> +
>  struct socket_smack {
>  	struct smack_known	*smk_out;	/* outbound label */
>  	struct smack_known	*smk_in;	/* inbound label */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 996c88956438..cdfd67b61534 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -793,6 +793,17 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  		skp = smk_of_current();
>  		sp->smk_root = skp;
>  		sp->smk_default = skp;
> +		/*
> +		 * For a handful of fs types with no user-controlled
> +		 * backing store it's okay to trust security labels
> +		 * in the filesystem. The rest are untrusted.
> +		 */
> +		if (sb->s_user_ns != &init_user_ns &&
> +		    sb->s_magic != SYSFS_MAGIC && sb->s_magic != TMPFS_MAGIC &&
> +		    sb->s_magic != RAMFS_MAGIC) {
> +			transmute = 1;
> +			sp->smk_flags |= SMK_SB_UNTRUSTED;
> +		}
>  	}
>  
>  	/*
> @@ -1175,6 +1186,7 @@ static int smack_inode_rename(struct inode *old_inode,
>   */
>  static int smack_inode_permission(struct inode *inode, int mask)
>  {
> +	struct superblock_smack *sbsp = inode->i_sb->s_security;
>  	struct smk_audit_info ad;
>  	int no_block = mask & MAY_NOT_BLOCK;
>  	int rc;
> @@ -1186,6 +1198,11 @@ static int smack_inode_permission(struct inode *inode, int mask)
>  	if (mask == 0)
>  		return 0;
>  
> +	if (sbsp->smk_flags & SMK_SB_UNTRUSTED) {
> +		if (smk_of_inode(inode) != sbsp->smk_root)
> +			return -EACCES;
> +	}
> +
>  	/* May be droppable after audit */
>  	if (no_block)
>  		return -ECHILD;
> @@ -3475,14 +3492,16 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  			if (rc >= 0)
>  				transflag = SMK_INODE_TRANSMUTE;
>  		}
> -		/*
> -		 * Don't let the exec or mmap label be "*" or "@".
> -		 */
> -		skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
> -		if (IS_ERR(skp) || skp == &smack_known_star ||
> -		    skp == &smack_known_web)
> -			skp = NULL;
> -		isp->smk_task = skp;
> +		if (!(sbsp->smk_flags & SMK_SB_UNTRUSTED)) {
> +			/*
> +			 * Don't let the exec or mmap label be "*" or "@".
> +			 */
> +			skp = smk_fetch(XATTR_NAME_SMACKEXEC, inode, dp);
> +			if (IS_ERR(skp) || skp == &smack_known_star ||
> +			    skp == &smack_known_web)
> +				skp = NULL;
> +			isp->smk_task = skp;
> +		}
>  
>  		skp = smk_fetch(XATTR_NAME_SMACKMMAP, inode, dp);
>  		if (IS_ERR(skp) || skp == &smack_known_star ||
