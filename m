Subject: Re: [PATCH] quick selinux support for tracefs
To: william.c.roberts@intel.com, nnk@google.com, selinux@tycho.nsa.gov
References: <1481045078-15000-1-git-send-email-william.c.roberts@intel.com>
 <1481045078-15000-2-git-send-email-william.c.roberts@intel.com>
Cc: Yongqin Liu <yongqin.liu@linaro.org>, Paul Moore <paul@paul-moore.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <53b7636e-5abe-0712-1954-b8c77c80c10d@tycho.nsa.gov>
Date: Tue, 6 Dec 2016 12:41:07 -0500
MIME-Version: 1.0
In-Reply-To: <1481045078-15000-2-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/06/2016 12:24 PM, william.c.roberts@intel.com wrote:
> From: Yongqin Liu <yongqin.liu@linaro.org>
> 
> Here is just the quick fix for tracefs with selinux.
> just add tracefs to the list of whitelisted filesystem
> types in selinux_is_sblabel_mnt(), but the right fix would be to
> generalize this logic as described in the last item on the todo list,
> https://bitbucket.org/seandroid/wiki/wiki/ToDo
> 
> Change-Id: I2aa803ccffbcd2802a7287514da7648e6b364157

Please rewrite the subject line and patch description per the kernel's
submission guidelines, drop the Change-Id and the link to the SEAndroid
todo list, and don't say that this is a quick fix but the right fix is
something else if you want this to actually be merged.  Because in that
case, you ought to just implement the right fix.  There is now an
upstream kernel issue for the right fix:
https://github.com/SELinuxProject/selinux-kernel/issues/2

> Signed-off-by: Yongqin Liu <yongqin.liu@linaro.org>
> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 09fd610..24bd84d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -491,6 +491,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>  		!strcmp(sb->s_type->name, "sysfs") ||
>  		!strcmp(sb->s_type->name, "pstore") ||
>  		!strcmp(sb->s_type->name, "debugfs") ||
> +		!strcmp(sb->s_type->name, "tracefs") ||
>  		!strcmp(sb->s_type->name, "rootfs");
>  }
>  
> 
