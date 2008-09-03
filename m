Subject: Re: [PATCH -v3] SELinux: memory leak in
	security_context_to_sid_core
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <1220456987.2962.66.camel@localhost.localdomain>
References: <1220390111.2962.19.camel@localhost.localdomain>
	 <1220444041.6034.1.camel@moss-spartans.epoch.ncsc.mil>
	 <alpine.LRH.1.10.0809032245380.21379@tundra.namei.org>
	 <1220447095.6034.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1220456987.2962.66.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 11:55:19 -0400
Message-Id: <1220457319.6034.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-09-03 at 11:49 -0400, Eric Paris wrote:
> Fix a bug and a philosophical decision about who handles errors.
> 
> security_context_to_sid_core() was leaking a context in the common case.
> This was causing problems on fedora systems which recently have started
> making extensive use of this function.
> 
> In discussion it was decided that if string_to_context_struct() had an
> error it was its own responsibility to clean up any mess it created
> along the way.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> ---
> 
>  security/selinux/ss/services.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index b52f923..d11a815 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -811,11 +811,12 @@ static int string_to_context_struct(struct policydb *pol,
>  	/* Check the validity of the new context. */
>  	if (!policydb_context_isvalid(pol, ctx)) {
>  		rc = -EINVAL;
> -		context_destroy(ctx);
>  		goto out;
>  	}
>  	rc = 0;
>  out:
> +	if (rc)
> +		context_destroy(ctx);
>  	return rc;
>  }
>  
> @@ -868,8 +869,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>  	} else if (rc)
>  		goto out;
>  	rc = sidtab_context_to_sid(&sidtab, &context, sid);
> -	if (rc)
> -		context_destroy(&context);
> +	context_destroy(&context);
>  out:
>  	read_unlock(&policy_rwlock);
>  	kfree(scontext2);
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
