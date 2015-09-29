Subject: Re: [PATCH 2/5] selinux: remove pointless cast in
 selinux_inode_setsecurity()
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-3-git-send-email-linux@rasmusvillemoes.dk>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AD3AF.3060304@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 14:08:47 -0400
MIME-Version: 1.0
In-Reply-To: <1443220459-11042-3-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2015 06:34 PM, Rasmus Villemoes wrote:
> security_context_to_sid() expects a const char* argument, so there's
> no point in casting away the const qualifier of value.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fd50cd5ac2ec..5edb57df86f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3162,7 +3162,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>   	if (!value || !size)
>   		return -EACCES;
>
> -	rc = security_context_to_sid((void *)value, size, &newsid, GFP_KERNEL);
> +	rc = security_context_to_sid(value, size, &newsid, GFP_KERNEL);
>   	if (rc)
>   		return rc;
>
>
