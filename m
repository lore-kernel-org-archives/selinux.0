Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8UGeGTW005023
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 12:40:16 -0400
Received: by qkap81 with SMTP id p81so20227804qka.2
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 09:40:14 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] selinux: use kstrdup() in security_get_bools()
Date: Wed, 30 Sep 2015 12:40:13 -0400
Message-ID: <1624521.andICT3hTI@sifl>
In-Reply-To: <1443220459-11042-5-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-5-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Saturday, September 26, 2015 12:34:18 AM Rasmus Villemoes wrote:
> This is much simpler.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  security/selinux/ss/services.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Applied.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 994c824a34c6..aa2bdcb20848 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2609,18 +2609,12 @@ int security_get_bools(int *len, char ***names, int
> **values) goto err;
> 
>  	for (i = 0; i < *len; i++) {
> -		size_t name_len;
> -
>  		(*values)[i] = policydb.bool_val_to_struct[i]->state;
> -		name_len = strlen(sym_name(&policydb, SYM_BOOLS, i)) + 1;
> 
>  		rc = -ENOMEM;
> -		(*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
> +		(*names)[i] = kstrdup(sym_name(&policydb, SYM_BOOLS, i), GFP_ATOMIC);
>  		if (!(*names)[i])
>  			goto err;
> -
> -		strncpy((*names)[i], sym_name(&policydb, SYM_BOOLS, i), name_len);
> -		(*names)[i][name_len - 1] = 0;
>  	}
>  	rc = 0;
>  out:

-- 
paul moore
www.paul-moore.com
