Subject: Re: [PATCH] SELinux: 1/3-v3 eliminate inode_security_set_security
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <1154639260.8428.37.camel@localhost.localdomain>
References: <1154639260.8428.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 09:47:55 -0400
Message-Id: <1155736075.18911.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-03 at 17:07 -0400, Eric Paris wrote:
> inode_security_set_sid is only called by security_inode_init_security,
> which is called when a new file is being created and needs to have its
> incore security state initialized and its security xattr set.  This
> helper used to be called other places in the past, no now only has the
> one.  So this patch rolls inode_security_set_sid directly back into
> security_inode_init_security.  There also is no need to help the
> isec->sem while doing this, as the inode is not available to other
> threads at this point in time.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
>  security/selinux/hooks.c |   28 ++++++++--------------------
>  1 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a91c961..a8ff26c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1364,25 +1364,6 @@ static inline u32 file_to_av(struct file
>  	return av;
>  }
>  
> -/* Set an inode's SID to a specified value. */
> -static int inode_security_set_sid(struct inode *inode, u32 sid)
> -{
> -	struct inode_security_struct *isec = inode->i_security;
> -	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> -
> -	if (!sbsec->initialized) {
> -		/* Defer initialization to selinux_complete_init. */
> -		return 0;
> -	}
> -
> -	down(&isec->sem);
> -	isec->sclass = inode_mode_to_security_class(inode->i_mode);
> -	isec->sid = sid;
> -	isec->initialized = 1;
> -	up(&isec->sem);
> -	return 0;
> -}
> -
>  /* Hook functions begin here. */
>  
>  static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
> @@ -2091,7 +2073,13 @@ static int selinux_inode_init_security(s
>  		}
>  	}
>  
> -	inode_security_set_sid(inode, newsid);
> +	/* Possibly defer initialization to selinux_complete_init. */
> +	if (sbsec->initialized) {
> +		struct inode_security_struct *isec = inode->i_security;
> +		isec->sclass = inode_mode_to_security_class(inode->i_mode);
> +		isec->sid = newsid;
> +		isec->initialized = 1;
> +	}
>  
>  	if (!ss_initialized || sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
>  		return -EOPNOTSUPP;
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
