Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8OMNiM8003011
 for <selinux@tycho.nsa.gov>; Thu, 24 Sep 2015 18:23:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
References: <1443039368-55445-1-git-send-email-seth.forshee@canonical.com>
 <1443039368-55445-7-git-send-email-seth.forshee@canonical.com>
Date: Thu, 24 Sep 2015 17:16:19 -0500
In-Reply-To: <1443039368-55445-7-git-send-email-seth.forshee@canonical.com>
 (Seth Forshee's message of "Wed, 23 Sep 2015 15:16:06 -0500")
Message-ID: <8737y3o43w.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v4 6/7] Smack: Add support for unprivileged mounts from
 user namespaces
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Seth Forshee <seth.forshee@canonical.com> writes:

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

Casey can I get your ack on this patch?  Or do you still have concerns?

Eric

> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>  security/smack/smack.h     |  8 +++++++-
>  security/smack/smack_lsm.c | 41 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index fff0c612bbb7..f95759015f29 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -90,9 +90,15 @@ struct superblock_smack {
>  	struct smack_known	*smk_floor;
>  	struct smack_known	*smk_hat;
>  	struct smack_known	*smk_default;
> -	int			smk_initialized;
> +	int			smk_flags;
>  };
>  
> +/*
> + * Superblock flags
> + */
> +#define SMK_SB_INITIALIZED	0x01
> +#define SMK_SB_UNTRUSTED	0x02
> +
>  struct socket_smack {
>  	struct smack_known	*smk_out;	/* outbound label */
>  	struct smack_known	*smk_in;	/* inbound label */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 996c88956438..621200f86b56 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -521,7 +521,7 @@ static int smack_sb_alloc_security(struct super_block *sb)
>  	sbsp->smk_floor = &smack_known_floor;
>  	sbsp->smk_hat = &smack_known_hat;
>  	/*
> -	 * smk_initialized will be zero from kzalloc.
> +	 * SMK_SB_INITIALIZED will be zero from kzalloc.
>  	 */
>  	sb->s_security = sbsp;
>  
> @@ -738,10 +738,10 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  	int num_opts = opts->num_mnt_opts;
>  	int transmute = 0;
>  
> -	if (sp->smk_initialized)
> +	if (sp->smk_flags & SMK_SB_INITIALIZED)
>  		return 0;
>  
> -	sp->smk_initialized = 1;
> +	sp->smk_flags |= SMK_SB_INITIALIZED;
>  
>  	for (i = 0; i < num_opts; i++) {
>  		switch (opts->mnt_opts_flags[i]) {
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
