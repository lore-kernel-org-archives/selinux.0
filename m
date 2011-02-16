Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GJIUYo030609
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 14:18:30 -0500
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GJISCG018692
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 19:18:28 GMT
Subject: Re: [PATCH 01/10] selinux: Fix check for xfrm selinux context
 algorithm
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214131739.GB15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214131739.GB15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 14:18:25 -0500
Message-ID: <1297883905.25079.1.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:17 +0100, Steffen Klassert wrote:
> selinux_xfrm_sec_ctx_alloc accidentally checks the xfrm domain of
> interpretation against the selinux context algorithm. This patch
> fixes this by checking ctx_alg against the selinux context algorithm.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Might also be a good candidate for stable.

Acked-by: Paul Moore <paul.moore@hp.com>

> ---
>  security/selinux/xfrm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index fff78d3..728c57e 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -208,7 +208,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
>  	if (!uctx)
>  		goto not_from_user;
>  
> -	if (uctx->ctx_doi != XFRM_SC_ALG_SELINUX)
> +	if (uctx->ctx_alg != XFRM_SC_ALG_SELINUX)
>  		return -EINVAL;
>  
>  	str_len = uctx->ctx_len;

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
