Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8UGVgSd004207
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 12:31:43 -0400
Received: by qgt47 with SMTP id 47so40055186qgt.2
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 09:31:41 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] selinux: remove pointless cast in
 selinux_inode_setsecurity()
Date: Wed, 30 Sep 2015 12:31:39 -0400
Message-ID: <2233926.skpAMzzEuY@sifl>
In-Reply-To: <1443220459-11042-3-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
 <1443220459-11042-3-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Saturday, September 26, 2015 12:34:16 AM Rasmus Villemoes wrote:
> security_context_to_sid() expects a const char* argument, so there's
> no point in casting away the const qualifier of value.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fd50cd5ac2ec..5edb57df86f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3162,7 +3162,7 @@ static int selinux_inode_setsecurity(struct inode
> *inode, const char *name, if (!value || !size)
>  		return -EACCES;
> 
> -	rc = security_context_to_sid((void *)value, size, &newsid, GFP_KERNEL);
> +	rc = security_context_to_sid(value, size, &newsid, GFP_KERNEL);
>  	if (rc)
>  		return rc;

-- 
paul moore
www.paul-moore.com
