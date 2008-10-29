Subject: Re: [PATCH 1/2] SELinux: do not check open on dir path walk
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1225290845.23553.2.camel@localhost.localdomain>
References: <1225290845.23553.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 29 Oct 2008 10:42:58 -0400
Message-Id: <1225291378.6588.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-29 at 10:34 -0400, Eric Paris wrote:
> Things like link_path_walk check for MAY_EXEC on directories as it walks path
> names.  The open perms checking was actually checking open on these as well.
> This patch excludes checking open when the only requested permission on the
> dir was MAY_EXEC.  open and opendir both still require open perms.

Would these issues (both directory search and unix socket) have been
avoided if you had put the open check in the dentry_open hook instead of
the inode_permission hook?

> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/hooks.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3e3fde7..188284f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1707,11 +1707,12 @@ static inline u32 open_file_mask_to_av(int mode, int mask)
>  			av |= BLK_FILE__OPEN;
>  		else if (S_ISFIFO(mode))
>  			av |= FIFO_FILE__OPEN;
> -		else if (S_ISDIR(mode))
> -			av |= DIR__OPEN;
> -		else
> +		else if (S_ISDIR(mode)) {
> +			if (mask != MAY_EXEC)
> +				av |= DIR__OPEN;
> +		} else
>  			printk(KERN_ERR "SELinux: WARNING: inside %s with "
> -				"unknown mode:%x\n", __func__, mode);
> +				"unknown mode:%o mask:%x\n", __func__, mode, mask);
>  	}
>  	return av;
>  }
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
