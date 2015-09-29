Subject: Re: [PATCH 4/5] selinux: use kstrdup() in security_get_bools()
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-5-git-send-email-linux@rasmusvillemoes.dk>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AD49E.8090405@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 14:12:46 -0400
MIME-Version: 1.0
In-Reply-To: <1443220459-11042-5-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2015 06:34 PM, Rasmus Villemoes wrote:
> This is much simpler.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/services.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 994c824a34c6..aa2bdcb20848 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2609,18 +2609,12 @@ int security_get_bools(int *len, char ***names, int **values)
>   		goto err;
>
>   	for (i = 0; i < *len; i++) {
> -		size_t name_len;
> -
>   		(*values)[i] = policydb.bool_val_to_struct[i]->state;
> -		name_len = strlen(sym_name(&policydb, SYM_BOOLS, i)) + 1;
>
>   		rc = -ENOMEM;
> -		(*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
> +		(*names)[i] = kstrdup(sym_name(&policydb, SYM_BOOLS, i), GFP_ATOMIC);
>   		if (!(*names)[i])
>   			goto err;
> -
> -		strncpy((*names)[i], sym_name(&policydb, SYM_BOOLS, i), name_len);
> -		(*names)[i][name_len - 1] = 0;
>   	}
>   	rc = 0;
>   out:
>
