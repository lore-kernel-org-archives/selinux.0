Message-ID: <1497978728.12069.13.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: enable genfscon labeling for tracefs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
Date: Tue, 20 Jun 2017 13:12:08 -0400
In-Reply-To: <20170620163533.2558-1-jeffv@google.com>
References: <20170620163533.2558-1-jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-06-20 at 09:35 -0700, Jeff Vander Stoep wrote:
> In kernel version 4.1, tracefs was separated from debugfs into its
> own filesystem. Prior to this split, files in
> /sys/kernel/debug/tracing could be labeled during filesystem
> creation using genfscon or later from userspace using setxattr. This
> change re-enables support for genfscon labeling.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

I don't suppose we could get you to tackle
https://github.com/SELinuxProject/selinux-kernel/issues/2
so that we don't have to keep patching these filesystem type
whitelists?

That said, given that this is a user-visible regression, I'm ok with
this as the short term fix.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/hooks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 820c16e36af8..33fd061305c4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -813,6 +813,7 @@ static int selinux_set_mnt_opts(struct
> super_block *sb,
>  		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
>  
>  	if (!strcmp(sb->s_type->name, "debugfs") ||
> +	    !strcmp(sb->s_type->name, "tracefs") ||
>  	    !strcmp(sb->s_type->name, "sysfs") ||
>  	    !strcmp(sb->s_type->name, "pstore"))
>  		sbsec->flags |= SE_SBGENFS;
