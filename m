Subject: Re: [PATCH 5/5] selinux: use sprintf return value
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-6-git-send-email-linux@rasmusvillemoes.dk>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AD5AF.4070400@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 14:17:19 -0400
MIME-Version: 1.0
In-Reply-To: <1443220459-11042-6-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2015 06:34 PM, Rasmus Villemoes wrote:
> sprintf returns the number of characters printed (excluding '\0'), so
> we can use that and avoid duplicating the length computation.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/services.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index aa2bdcb20848..ebb5eb3c318c 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1218,13 +1218,10 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
>   	/*
>   	 * Copy the user name, role name and type name into the context.
>   	 */
> -	sprintf(scontextp, "%s:%s:%s",
> +	scontextp += sprintf(scontextp, "%s:%s:%s",
>   		sym_name(&policydb, SYM_USERS, context->user - 1),
>   		sym_name(&policydb, SYM_ROLES, context->role - 1),
>   		sym_name(&policydb, SYM_TYPES, context->type - 1));
> -	scontextp += strlen(sym_name(&policydb, SYM_USERS, context->user - 1)) +
> -		     1 + strlen(sym_name(&policydb, SYM_ROLES, context->role - 1)) +
> -		     1 + strlen(sym_name(&policydb, SYM_TYPES, context->type - 1));
>
>   	mls_sid_to_context(context, &scontextp);
>
>
