Date: Wed, 28 Apr 2010 08:50:31 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/2] selinux: place open in the common file perms
In-Reply-To: <20100412231947.21118.77411.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1004280849550.24297@tundra.namei.org>
References: <20100412231947.21118.77411.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Apr 2010, Eric Paris wrote:

> kernel can dynamically remap perms.  Drop the open lookup table and put open
> in the common file perms.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

This does not apply to my tree -- looks like the audit_access patch is a 
pre-req.


> ---
> 
>  security/selinux/hooks.c            |   24 +++---------------------
>  security/selinux/include/classmap.h |   15 ++++++++-------
>  2 files changed, 11 insertions(+), 28 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 34e9d1b..c1ed9db 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1828,27 +1828,9 @@ static inline u32 open_file_to_av(struct file *file)
>  {
>  	u32 av = file_to_av(file);
>  
> -	if (selinux_policycap_openperm) {
> -		mode_t mode = file->f_path.dentry->d_inode->i_mode;
> -		/*
> -		 * lnk files and socks do not really have an 'open'
> -		 */
> -		if (S_ISREG(mode))
> -			av |= FILE__OPEN;
> -		else if (S_ISCHR(mode))
> -			av |= CHR_FILE__OPEN;
> -		else if (S_ISBLK(mode))
> -			av |= BLK_FILE__OPEN;
> -		else if (S_ISFIFO(mode))
> -			av |= FIFO_FILE__OPEN;
> -		else if (S_ISDIR(mode))
> -			av |= DIR__OPEN;
> -		else if (S_ISSOCK(mode))
> -			av |= SOCK_FILE__OPEN;
> -		else
> -			printk(KERN_ERR "SELinux: WARNING: inside %s with "
> -				"unknown mode:%o\n", __func__, mode);
> -	}
> +	if (selinux_policycap_openperm)
> +		av |= FILE__OPEN;
> +
>  	return av;
>  }
>  
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index d64603e..41990cb 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -2,7 +2,8 @@
>      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
>  
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
> -    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access"
> +    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access", \
> +    "open"
>  
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> @@ -43,22 +44,22 @@ struct security_class_mapping secclass_map[] = {
>  	    "quotaget", NULL } },
>  	{ "file",
>  	  { COMMON_FILE_PERMS,
> -	    "execute_no_trans", "entrypoint", "execmod", "open", NULL } },
> +	    "execute_no_trans", "entrypoint", "execmod", NULL } },
>  	{ "dir",
>  	  { COMMON_FILE_PERMS, "add_name", "remove_name",
> -	    "reparent", "search", "rmdir", "open", NULL } },
> +	    "reparent", "search", "rmdir", NULL } },
>  	{ "fd", { "use", NULL } },
>  	{ "lnk_file",
>  	  { COMMON_FILE_PERMS, NULL } },
>  	{ "chr_file",
>  	  { COMMON_FILE_PERMS,
> -	    "execute_no_trans", "entrypoint", "execmod", "open", NULL } },
> +	    "execute_no_trans", "entrypoint", "execmod", NULL } },
>  	{ "blk_file",
> -	  { COMMON_FILE_PERMS, "open", NULL } },
> +	  { COMMON_FILE_PERMS, NULL } },
>  	{ "sock_file",
> -	  { COMMON_FILE_PERMS, "open", NULL } },
> +	  { COMMON_FILE_PERMS, NULL } },
>  	{ "fifo_file",
> -	  { COMMON_FILE_PERMS, "open", NULL } },
> +	  { COMMON_FILE_PERMS, NULL } },
>  	{ "socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "tcp_socket",
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
