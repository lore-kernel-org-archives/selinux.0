Subject: Re: [PATCH] security: selinux: Use a kmem_cache for allocation struct
 file_security_struct
To: Sangwoo <sangwoo2.park@lge.com>, paul@paul-moore.com,
 eparis@parisplace.org, james.l.morris@oracle.com, serge@hallyn.com
References: <1444023941-6482-1-git-send-email-sangwoo2.park@lge.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56156461.3080000@tycho.nsa.gov>
Date: Wed, 7 Oct 2015 14:28:49 -0400
MIME-Version: 1.0
In-Reply-To: <1444023941-6482-1-git-send-email-sangwoo2.park@lge.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/05/2015 01:45 AM, Sangwoo wrote:
> The size of struct file_security_struct is 16byte at my setup.
> But, the real allocation size for per each file_security_struct
> is 64bytes in my setup that kmalloc min size is 64bytes
> because ARCH_DMA_MINALIGN is 64.
> 
> This allocation is called every times at file allocation(alloc_file()).
> So, the total slack memory size(allocated size - request size)
> is increased exponentially.
> 
> E.g) Min Kmalloc Size : 64bytes, Unit : bytes
>       Allocated Size | Request Size | Slack Size | Allocation Count
>     ---------------------------------------------------------------
>          770048      |    192512    |   577536   |      12032
> 
> At the result, this change reduce memory usage 42bytes per each
> file_security_struct
> 
> Signed-off-by: Sangwoo <sangwoo2.park@lge.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/hooks.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3f8d567..c20e082 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -126,6 +126,7 @@ int selinux_enabled = 1;
>  #endif
>  
>  static struct kmem_cache *sel_inode_cache;
> +static struct kmem_cache *file_security_cache;
>  
>  /**
>   * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
> @@ -287,7 +288,7 @@ static int file_alloc_security(struct file *file)
>  	struct file_security_struct *fsec;
>  	u32 sid = current_sid();
>  
> -	fsec = kzalloc(sizeof(struct file_security_struct), GFP_KERNEL);
> +	fsec = kmem_cache_zalloc(file_security_cache, GFP_KERNEL);
>  	if (!fsec)
>  		return -ENOMEM;
>  
> @@ -302,7 +303,7 @@ static void file_free_security(struct file *file)
>  {
>  	struct file_security_struct *fsec = file->f_security;
>  	file->f_security = NULL;
> -	kfree(fsec);
> +	kmem_cache_free(file_security_cache, fsec);
>  }
>  
>  static int superblock_alloc_security(struct super_block *sb)
> @@ -6086,6 +6087,9 @@ static __init int selinux_init(void)
>  	sel_inode_cache = kmem_cache_create("selinux_inode_security",
>  					    sizeof(struct inode_security_struct),
>  					    0, SLAB_PANIC, NULL);
> +	file_security_cache = kmem_cache_create("selinux_file_security",
> +					    sizeof(struct file_security_struct),
> +					    0, SLAB_PANIC, NULL);
>  	avc_init();
>  
>  	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
> 
