Subject: Re: [PATCH 1/3] SELinux: fix selinux to safely handle any bugs
 even when not CONFIG_BUG
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 09:00:20 -0500
Message-Id: <1234274420.4642.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-02-09 at 16:37 -0500, Eric Paris wrote:
> If CONFIG_BUG is not set places in the code where BUG is called will not
> end execution.  Look for places where this might result is system problems
> and keep the system running.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  kernel/capability.c            |    1 +
>  security/selinux/avc.c         |   13 +++++++++++--
>  security/selinux/hooks.c       |    9 ++++++++-
>  security/selinux/netnode.c     |    3 +++
>  security/selinux/ss/ebitmap.h  |   15 ++++++++++++---
>  security/selinux/ss/services.c |   38 +++++++++++++++++++++++++++++++-------
>  security/selinux/xfrm.c        |   15 ++++++++++++---
>  7 files changed, 78 insertions(+), 16 deletions(-)
> 
<snip>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index eb41f43..c22db1e 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -202,6 +202,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  {
>  	int rc;
>  	char *scontext;
> +	const char *class_string;
>  	u32 scontext_len;
>  
>  	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
> @@ -220,8 +221,16 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>  		kfree(scontext);
>  	}
>  
> -	BUG_ON(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass]);
> -	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
> +	if (unlikely(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass])) {
> +		class_string = "unknown";
> +		if (tclass >= ARRAY_SIZE(class_to_string))
> +			BUG();
> +		else
> +			BUG();

Reduce that if statement to just BUG().
A possible alternative to logging the "unknown" string would be to log
the value of tclass; that would provide more information for debugging.

> +	} else {
> +		class_string = class_to_string[tclass];
> +	}
> +	audit_log_format(ab, " tclass=%s", class_string);
>  }
>  
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ae5bb64..6e6847d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -995,7 +995,11 @@ static int superblock_doinit(struct super_block *sb, void *data)
>  	if (!data)
>  		goto out;
>  
> -	BUG_ON(sb->s_type->fs_flags & FS_BINARY_MOUNTDATA);
> +	if (unlikely(sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)) {
> +		BUG();
> +		rc = -EINVAL;
> +		goto out_err;

Why out_err vs. out?  No allocation yet, right?  Or alternatively, if
all calls to security_init_mnt_opts() should be balanced with calls to
security_free_mnt_opts(), why don't we goto out_err in the prior error
path?

> @@ -1500,6 +1505,8 @@ static int task_has_capability(struct task_struct *tsk,
>  		printk(KERN_ERR
>  		       "SELinux:  out of range capability %d\n", cap);
>  		BUG();
> +		/* should I audit somehow? */
> +		return -EPERM;

I think the printk KERN_ERR suffices, or turn it into a audit_log
AUDIT_SELINUX_ERR call.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index c65e4fe..cfb0769 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -120,16 +120,25 @@ static int constraint_expr_eval(struct context *scontext,
>  	for (e = cexpr; e; e = e->next) {
>  		switch (e->expr_type) {
>  		case CEXPR_NOT:
> -			BUG_ON(sp < 0);
> +			if (unlikely(sp < 0)) {
> +				BUG();
> +				return 0;
> +			}

General question:  Should we in fact be panic'ing in these cases where
we cannot return a value that will in fact abort the computation and
guarantee that the operation will not proceed?  Same applies to the
ebitmap code.  Just returning 0 (false) doesn't necessarily mean that we
won't grant a permission, as the result may get negated.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
