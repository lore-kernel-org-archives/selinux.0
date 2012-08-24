Message-ID: <1345839146.28180.12.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 4/7] SELinux: pass a sbsec to security_fs_use
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 24 Aug 2012 16:12:26 -0400
In-Reply-To: <20120824195907.22970.73327.stgit@paris.rdu.redhat.com>
References: <20120824195845.22970.54641.stgit@paris.rdu.redhat.com>
	 <20120824195907.22970.73327.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-24 at 15:59 -0400, Eric Paris wrote:
> Rather than passing pointers to memory locations inside security_fs_use just
> pass the struct itself.  As we need more fields later, this cuts down on
> future argument lists.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Not a hard NAK, but we originally tried to maintain a clean separation
between the hook function implementations and the security server, and
the security server had no knowledge of the security structures or other
kernel-internal data structures. I think that line has blurred over time
with the netlabel and audit support, and perhaps it has limited
usefulness now, but wanted to note it.

> ---
>  security/selinux/hooks.c            |    2 +-
>  security/selinux/include/security.h |    4 ++--
>  security/selinux/ss/services.c      |   18 +++++++-----------
>  3 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e55ff04..8d2bff9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -677,7 +677,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  		sbsec->flags |= SE_SBPROC;
>  
>  	/* Determine the labeling behavior to use for this filesystem type. */
> -	rc = security_fs_use(sb->s_type->name, &sbsec->behavior, &sbsec->sid);
> +	rc = security_fs_use(sb->s_type->name, sbsec);
>  	if (rc) {
>  		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
>  		       __func__, sb->s_type->name, rc);
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 335753b..7142995 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -173,8 +173,8 @@ int security_get_allow_unknown(void);
>  #define SECURITY_FS_USE_NONE		5 /* no labeling support */
>  #define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
>  
> -int security_fs_use(const char *fstype, unsigned int *behavior,
> -	u32 *sid);
> +struct superblock_security_struct;
> +int security_fs_use(const char *fstype, struct superblock_security_struct *sbsec);
>  
>  int security_genfs_sid(const char *fstype, char *name, u16 sclass,
>  	u32 *sid);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index d12eaf8..295e937 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2327,13 +2327,9 @@ out:
>  /**
>   * security_fs_use - Determine how to handle labeling for a filesystem.
>   * @fstype: filesystem type
> - * @behavior: labeling behavior
> - * @sid: SID for filesystem (superblock)
> + * @sbsec: security structure for the superblock in question
>   */
> -int security_fs_use(
> -	const char *fstype,
> -	unsigned int *behavior,
> -	u32 *sid)
> +int security_fs_use(const char *fstype, struct superblock_security_struct *sbsec)
>  {
>  	int rc = 0;
>  	struct ocontext *c;
> @@ -2348,21 +2344,21 @@ int security_fs_use(
>  	}
>  
>  	if (c) {
> -		*behavior = c->v.behavior;
> +		sbsec->behavior = c->v.behavior;
>  		if (!c->sid[0]) {
>  			rc = sidtab_context_to_sid(&sidtab, &c->context[0],
>  						   &c->sid[0]);
>  			if (rc)
>  				goto out;
>  		}
> -		*sid = c->sid[0];
> +		sbsec->sid = c->sid[0];
>  	} else {
> -		rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
> +		rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, &sbsec->sid);
>  		if (rc) {
> -			*behavior = SECURITY_FS_USE_NONE;
> +			sbsec->behavior = SECURITY_FS_USE_NONE;
>  			rc = 0;
>  		} else {
> -			*behavior = SECURITY_FS_USE_GENFS;
> +			sbsec->behavior = SECURITY_FS_USE_GENFS;
>  		}
>  	}
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
