Subject: Re: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion
	functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net>
References: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net>
Content-Type: text/plain
Date: Fri, 29 Feb 2008 08:54:33 -0500
Message-Id: <1204293273.31790.251.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-28 at 16:41 -0500, Paul Moore wrote:
> While looking at the SELinux secid/secctx conversion functions I realized they
> could probably do with a little cleanup to reduce the amount of code and make
> better use of existing string processing functions in the kernel.  Making use
> of the kernel's existing string processing functions is a good idea as many
> architectures have specialized/optimized routines which should be an
> improvement over the generic code in the SELinux security server.
> ---
> 
>  security/selinux/ss/mls.c      |   61 +++++--------
>  security/selinux/ss/mls.h      |    3 -
>  security/selinux/ss/services.c |  194 ++++++++++++++++------------------------
>  3 files changed, 103 insertions(+), 155 deletions(-)
> 

The snippet below looks like a step backward rather than an improvement
- single sprintf replaced by series of strcat calls.  That can't be more
efficient.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index f374186..4aab8a5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
<snip>
> -	/*
> -	 * Copy the user name, role name and type name into the context.
> -	 */
> -	sprintf(scontextp, "%s:%s:%s",
> -		policydb.p_user_val_to_name[context->user - 1],
> -		policydb.p_role_val_to_name[context->role - 1],
> -		policydb.p_type_val_to_name[context->type - 1]);
> -	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
> -	             1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
> -	             1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
> -
> -	mls_sid_to_context(context, &scontextp);
> -
> -	*scontextp = 0;
> +	ctx = *scontext;
> +	strcpy(ctx, policydb.p_user_val_to_name[context->user - 1]);
> +	strcat(ctx, ":");
> +	strcat(ctx, policydb.p_role_val_to_name[context->role - 1]);
> +	strcat(ctx, ":");
> +	strcat(ctx, policydb.p_type_val_to_name[context->type - 1]);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
