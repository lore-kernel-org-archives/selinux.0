Subject: Re: [PATCH 1/3] SELinux: Cleanup the secid/secctx conversion
	functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080407231101.8052.68591.stgit@flek.lan>
References: <20080407230647.8052.79603.stgit@flek.lan>
	 <20080407231101.8052.68591.stgit@flek.lan>
Content-Type: text/plain
Date: Tue, 08 Apr 2008 10:43:44 -0400
Message-Id: <1207665824.21223.311.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-04-07 at 19:11 -0400, Paul Moore wrote:
> While looking at the SELinux secid/secctx conversion functions I realized they
> could probably do with a little cleanup to reduce the amount of code and make
> better use of existing string processing functions in the kernel.  Making use
> of the kernel's existing string processing functions is a good idea as many
> architectures have specialized/optimized routines which should be an
> improvement over the generic code in the SELinux security server.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  security/selinux/ss/mls.c      |   61 +++++--------
>  security/selinux/ss/mls.h      |    3 -
>  security/selinux/ss/services.c |  188 ++++++++++++++++------------------------
>  3 files changed, 99 insertions(+), 153 deletions(-)

> @@ -709,73 +697,46 @@ static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *s
>  	   null suffix to the copy to avoid problems with the existing
>  	   attr package, which doesn't view the null terminator as part
>  	   of the attribute value. */
> -	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
> -	if (!scontext2) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	memcpy(scontext2, scontext, scontext_len);
> -	scontext2[scontext_len] = 0;
> +	scontext_dup = kmemdup(scontext, scontext_len + 1, GFP_KERNEL);

Also, in addition to the gfp_flags change, I'm not clear that the above
change is correct.  We are taking a byte array "scontext" of length
"scontext_len" and copying it into a buffer of length "scontext_len+1"
so that we can ensure that it is NUL terminated prior to parsing.  Won't
kmemdup with scontext_len+1 ultimately run off the end of the original
string?

> +	if (!scontext_dup)
> +		return -ENOMEM;
> +	scontext_dup[scontext_len] = 0;

>  
>  	context_init(&context);
> -	*sid = SECSID_NULL;
> +	scontext_next = scontext_dup;
>  
>  	POLICY_RDLOCK;
>  
> -	/* Parse the security context. */
> -
> -	rc = -EINVAL;
> -	scontextp = (char *) scontext2;
> -
>  	/* Extract the user. */
> -	p = scontextp;
> -	while (*p && *p != ':')
> -		p++;
> -
> -	if (*p == 0)
> +	scontext_iter = strsep(&scontext_next, ":");
> +	if (!scontext_next)
>  		goto out_unlock;
> -
> -	*p++ = 0;
> -
> -	usrdatum = hashtab_search(policydb.p_users.table, scontextp);
> +	usrdatum = hashtab_search(policydb.p_users.table, scontext_iter);
>  	if (!usrdatum)
>  		goto out_unlock;
> -
>  	context.user = usrdatum->value;
>  
>  	/* Extract role. */
> -	scontextp = p;
> -	while (*p && *p != ':')
> -		p++;
> -
> -	if (*p == 0)
> +	scontext_iter = strsep(&scontext_next, ":");
> +	if (!scontext_next)
>  		goto out_unlock;
> -
> -	*p++ = 0;
> -
> -	role = hashtab_search(policydb.p_roles.table, scontextp);
> -	if (!role)
> +	roledatum = hashtab_search(policydb.p_roles.table, scontext_iter);
> +	if (!roledatum)
>  		goto out_unlock;
> -	context.role = role->value;
> +	context.role = roledatum->value;
>  
>  	/* Extract type. */
> -	scontextp = p;
> -	while (*p && *p != ':')
> -		p++;
> -	oldc = *p;
> -	*p++ = 0;
> -
> -	typdatum = hashtab_search(policydb.p_types.table, scontextp);
> +	scontext_iter = strsep(&scontext_next, ":");
> +	typdatum = hashtab_search(policydb.p_types.table, scontext_iter);
>  	if (!typdatum)
>  		goto out_unlock;
> -
>  	context.type = typdatum->value;
>  
> -	rc = mls_context_to_sid(oldc, &p, &context, &sidtab, def_sid);
> +	/* Extract MLS range. */
> +	rc = mls_context_to_sid(&scontext_next, &context, &sidtab, def_sid);
>  	if (rc)
>  		goto out_unlock;
> -
> -	if ((p - scontext2) < scontext_len) {
> +	if (scontext_next - scontext_dup < scontext_len) {
>  		rc = -EINVAL;
>  		goto out_unlock;
>  	}
> @@ -785,13 +746,14 @@ static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *s
>  		rc = -EINVAL;
>  		goto out_unlock;
>  	}
> +
>  	/* Obtain the new sid. */
>  	rc = sidtab_context_to_sid(&sidtab, &context, sid);
> +
>  out_unlock:
>  	POLICY_RDUNLOCK;
>  	context_destroy(&context);
> -	kfree(scontext2);
> -out:
> +	kfree(scontext_dup);
>  	return rc;
>  }
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
