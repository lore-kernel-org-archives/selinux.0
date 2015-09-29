Subject: Re: [PATCH 3/5] selinux: use kmemdup in security_sid_to_context_core()
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-4-git-send-email-linux@rasmusvillemoes.dk>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AD436.1070005@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 14:11:02 -0400
MIME-Version: 1.0
In-Reply-To: <1443220459-11042-4-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2015 06:34 PM, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/services.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index c550df0e0ff1..994c824a34c6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1259,12 +1259,12 @@ static int security_sid_to_context_core(u32 sid, char **scontext,
>   			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
>   			if (!scontext)
>   				goto out;
> -			scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
> +			scontextp = kmemdup(initial_sid_to_string[sid],
> +					    *scontext_len, GFP_ATOMIC);
>   			if (!scontextp) {
>   				rc = -ENOMEM;
>   				goto out;
>   			}
> -			strcpy(scontextp, initial_sid_to_string[sid]);
>   			*scontext = scontextp;
>   			goto out;
>   		}
>
