Subject: Re: [PATCH] SELinux: 1/3 eliminate inode_security_set_security
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <1154021365.5028.46.camel@localhost.localdomain>
References: <1154021365.5028.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 14:34:23 -0400
Message-Id: <1154025263.27604.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-27 at 13:29 -0400, Eric Paris wrote:
> This patch completely eliminates the inode_security_set_security. It was
> only being called from superblock_doinit.  Since there was only 1 caller
> I rolled it back into superblock_doinit.  Also since superblock_doinit
> is called while mounting, and before the root inode is available to
> anything else we don't need to worry about locking the isec->sem.  So
> the locking was completely dropped.

The description doesn't match the code.  inode_security_set_sid is
called by security_inode_init_security, which is called when a new file
is being created and needs to have its incore security state initialized
and its security xattr set.  I agree however that a) the helper function
is no longer useful (it used to be called by more functions), and b)
there is no need to take the semaphore there; the new inode isn't yet
visible to other threads.

On an unrelated topic, we likely do need to address the cifs problem
since the upstream cifs maintainers don't seem to care.  That just means
that we need to recheck the inode sclass against the inode mode on each
check, or at least upon inode_permission, to see whether it has migrated
from being a regular file to being a directory (lovely).

> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
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
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
