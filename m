Subject: Re: [PATCH 4/4] selinux: rework security_netlbl_secattr_to_sid
From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20101027173205.22048.13742.stgit@paris.rdu.redhat.com>
References: <20101027173146.22048.82500.stgit@paris.rdu.redhat.com>
	 <20101027173205.22048.13742.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 29 Oct 2010 11:57:27 -0400
Message-ID: <1288367847.8117.24.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-10-27 at 13:32 -0400, Eric Paris wrote:
> security_netlbl_secattr_to_sid is difficult to follow, especially the
> return codes.  Try to make the function obvious.

Pfft!

Some bracing nits below ...

> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/ss/services.c |   33 +++++++++++++++++----------------
>  1 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 84e2a98..6cb1f4d 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3041,7 +3041,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
>  int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  				   u32 *sid)
>  {
> -	int rc = -EIDRM;
> +	int rc;
>  	struct context *ctx;
>  	struct context ctx_new;
>  
> @@ -3054,14 +3054,13 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  
>  	if (secattr->flags & NETLBL_SECATTR_CACHE) {
>  		*sid = *(u32 *)secattr->cache->data;
> -		rc = 0;

Since we're now down to one statement in the body of the if-then you can
probably drop the braces.

>  	} else if (secattr->flags & NETLBL_SECATTR_SECID) {
>  		*sid = secattr->attr.secid;
> -		rc = 0;

Same here.  Just say "no" to excess braces.

>  	} else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
> +		rc = -EIDRM;
>  		ctx = sidtab_search(&sidtab, SECINITSID_NETMSG);
>  		if (ctx == NULL)
> -			goto netlbl_secattr_to_sid_return;
> +			goto out;
>  
>  		context_init(&ctx_new);
>  		ctx_new.user = ctx->user;
> @@ -3069,34 +3068,36 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
>  		ctx_new.type = ctx->type;
>  		mls_import_netlbl_lvl(&ctx_new, secattr);
>  		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
> -			if (ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
> -						  secattr->attr.mls.cat) != 0)
> -				goto netlbl_secattr_to_sid_return;
> +			rc = ebitmap_netlbl_import(&ctx_new.range.level[0].cat,
> +						   secattr->attr.mls.cat);
> +			if (rc)
> +				goto out;
>  			memcpy(&ctx_new.range.level[1].cat,
>  			       &ctx_new.range.level[0].cat,
>  			       sizeof(ctx_new.range.level[0].cat));
>  		}
> -		if (mls_context_isvalid(&policydb, &ctx_new) != 1)
> -			goto netlbl_secattr_to_sid_return_cleanup;
> +		rc = -EIDRM;
> +		if (!mls_context_isvalid(&policydb, &ctx_new))
> +			goto out_free;
>  
>  		rc = sidtab_context_to_sid(&sidtab, &ctx_new, sid);
> -		if (rc != 0)
> -			goto netlbl_secattr_to_sid_return_cleanup;
> +		if (rc)
> +			goto out_free;
>  
>  		security_netlbl_cache_add(secattr, *sid);
>  
>  		ebitmap_destroy(&ctx_new.range.level[0].cat);
>  	} else {
>  		*sid = SECSID_NULL;
> -		rc = 0;
>  	}
>  
> -netlbl_secattr_to_sid_return:
>  	read_unlock(&policy_rwlock);
> -	return rc;
> -netlbl_secattr_to_sid_return_cleanup:
> +	return 0;
> +out_free:
>  	ebitmap_destroy(&ctx_new.range.level[0].cat);
> -	goto netlbl_secattr_to_sid_return;
> +out:
> +	read_unlock(&policy_rwlock);
> +	return rc;
>  }
>  
>  /**
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
