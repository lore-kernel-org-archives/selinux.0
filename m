Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8UGhAoW005203
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 12:43:11 -0400
Received: by qkcf65 with SMTP id f65so20195150qkc.3
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 09:43:09 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] selinux: use sprintf return value
Date: Wed, 30 Sep 2015 12:43:07 -0400
Message-ID: <1536993.anFU3vzeka@sifl>
In-Reply-To: <1443220459-11042-6-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-6-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Saturday, September 26, 2015 12:34:19 AM Rasmus Villemoes wrote:
> sprintf returns the number of characters printed (excluding '\0'), so
> we can use that and avoid duplicating the length computation.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  security/selinux/ss/services.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied, thank you.

I just pushed all five of your patches to the SELinux next branch so they 
should be included in the next linux-next release.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index aa2bdcb20848..ebb5eb3c318c 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1218,13 +1218,10 @@ static int context_struct_to_string(struct context
> *context, char **scontext, u3 /*
>  	 * Copy the user name, role name and type name into the context.
>  	 */
> -	sprintf(scontextp, "%s:%s:%s",
> +	scontextp += sprintf(scontextp, "%s:%s:%s",
>  		sym_name(&policydb, SYM_USERS, context->user - 1),
>  		sym_name(&policydb, SYM_ROLES, context->role - 1),
>  		sym_name(&policydb, SYM_TYPES, context->type - 1));
> -	scontextp += strlen(sym_name(&policydb, SYM_USERS, context->user - 1)) +
> -		     1 + strlen(sym_name(&policydb, SYM_ROLES, context->role - 1)) +
> -		     1 + strlen(sym_name(&policydb, SYM_TYPES, context->type - 1));
> 
>  	mls_sid_to_context(context, &scontextp);

-- 
paul moore
www.paul-moore.com
