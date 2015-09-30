Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8UGbL2J004577
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 12:37:21 -0400
Received: by qgez77 with SMTP id z77so40347321qge.1
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 09:37:19 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] selinux: use kmemdup in security_sid_to_context_core()
Date: Wed, 30 Sep 2015 12:37:18 -0400
Message-ID: <3866077.CzkZjXbNak@sifl>
In-Reply-To: <1443220459-11042-4-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-4-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Saturday, September 26, 2015 12:34:17 AM Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  security/selinux/ss/services.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index c550df0e0ff1..994c824a34c6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1259,12 +1259,12 @@ static int security_sid_to_context_core(u32 sid,
> char **scontext, *scontext_len = strlen(initial_sid_to_string[sid]) + 1;
>  			if (!scontext)
>  				goto out;
> -			scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
> +			scontextp = kmemdup(initial_sid_to_string[sid],
> +					    *scontext_len, GFP_ATOMIC);
>  			if (!scontextp) {
>  				rc = -ENOMEM;
>  				goto out;
>  			}
> -			strcpy(scontextp, initial_sid_to_string[sid]);
>  			*scontext = scontextp;
>  			goto out;
>  		}

-- 
paul moore
www.paul-moore.com
