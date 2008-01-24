Subject: Re: [PATCH] selinux: make mls_compute_sid always polyinstantiate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>
In-Reply-To: <4798F57C.8090300@tycho.nsa.gov>
References: <4798F57C.8090300@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 15:36:18 -0500
Message-Id: <1201206978.21288.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 15:30 -0500, Eamon Walsh wrote:
> This patch removes the requirement that the new and related object types 
> differ in order to polyinstantiate by MLS level.  This allows MLS 
> polyinstantiation to occur in the absence of explicit type_member rules 
> or when the type has not changed.
> 
> Potential users of this support include pam_namespace.so (directory 
> polyinstantiation) and the SELinux X support (property polyinstantiation).
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
>  mls.c |   11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

(nit:  use diffstat -p1 in the future)

> 
> diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> index fb5d70a..3bbcb53 100644
> --- a/security/selinux/ss/mls.c
> +++ b/security/selinux/ss/mls.c
> @@ -537,15 +537,8 @@ int mls_compute_sid(struct context *scontext,
>  			/* Use the process effective MLS attributes. */
>  			return mls_context_cpy_low(newcontext, scontext);
>  	case AVTAB_MEMBER:
> -		/* Only polyinstantiate the MLS attributes if
> -		   the type is being polyinstantiated */
> -		if (newcontext->type != tcontext->type) {
> -			/* Use the process effective MLS attributes. */
> -			return mls_context_cpy_low(newcontext, scontext);
> -		} else {
> -			/* Use the related object MLS attributes. */
> -			return mls_context_cpy(newcontext, tcontext);
> -		}
> +		/* Use the process effective MLS attributes. */
> +		return mls_context_cpy_low(newcontext, scontext);
>  	default:
>  		return -EINVAL;
>  	}
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
