Date: Fri, 5 Dec 2008 12:02:44 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH 3/3] SELinux: Unify context mount and genfs behavior
In-Reply-To: <1228421890-9467-4-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <alpine.LRH.1.10.0812051202340.11818@tundra.namei.org>
References: <1228421890-9467-1-git-send-email-dpquigl@tycho.nsa.gov> <1228421890-9467-4-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Dec 2008, David P. Quigley wrote:

> Context mounts and genfs labeled file systems behave differently with respect to
> setting file system labels. This patch brings genfs labeled file systems in line
> with context mounts in that setxattr calls to them should return EOPNOTSUPP and
> fscreate calls will be ignored.
> 
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>

Looks ok, too.

> ---
>  security/selinux/hooks.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 03c9258..9c92669 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1536,7 +1536,7 @@ static int may_create(struct inode *dir,
>  	if (rc)
>  		return rc;
>  
> -	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
> +	if (tsec->create_sid && sbsec->flags & SBLABELSUPP) {
>  		newsid = tsec->create_sid;
>  	} else {
>  		rc = security_transition_sid(tsec->sid, dsec->sid, tclass,
> @@ -2543,7 +2543,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	dsec = dir->i_security;
>  	sbsec = dir->i_sb->s_security;
>  
> -	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
> +	if (tsec->create_sid && sbsec->flags & SBLABELSUPP) {
>  		newsid = tsec->create_sid;
>  	} else {
>  		rc = security_transition_sid(tsec->sid, dsec->sid,
> @@ -2567,7 +2567,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  		isec->initialized = 1;
>  	}
>  
> -	if (!ss_initialized || sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
> +	if (!ss_initialized || !(sbsec->flags & SBLABELSUPP))
>  		return -EOPNOTSUPP;
>  
>  	if (name) {
> @@ -2736,7 +2736,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  		return selinux_inode_setotherxattr(dentry, name);
>  
>  	sbsec = inode->i_sb->s_security;
> -	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
> +	if (!(sbsec->flags & SBLABELSUPP))
>  		return -EOPNOTSUPP;
>  
>  	if (!is_owner_or_cap(inode))
> -- 
> 1.5.6.5
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
