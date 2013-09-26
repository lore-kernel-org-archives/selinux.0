Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8QK3tHL009147
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2013 16:03:57 -0400
Received: by mail-qe0-f48.google.com with SMTP id nd7so1169700qeb.7
        for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2013 13:03:54 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Cc: sds@tycho.nsa.gov, james.l.morris@oracle.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Use kmemdup instead of kmalloc + memcpy
Date: Thu, 26 Sep 2013 16:03:47 -0400
Message-ID: <9522974.jAp9Aa4L2I@sifl>
In-Reply-To: <5243A058.2090104@cn.fujitsu.com>
References: <5243A058.2090104@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, September 26, 2013 10:47:52 AM Duan Jiong wrote:
> Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> ---
>  security/selinux/xfrm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

FYI: SELinux patches should be sent to the SELinux mailing list (I added it to 
the CC list).  You can also CC the LSM list if you like, but they *need* to be 
sent to the SELinux list in the future.

I did some minor whitespace/alignment fixup and merged your patch; it is 
queued up for 3.13.

 * git://git.infradead.org/users/pcmoore/selinux

> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 425b9f9..5c809c1 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -268,10 +268,10 @@ int selinux_xfrm_policy_clone(struct xfrm_sec_ctx
> *old_ctx, if (!old_ctx)
>  		return 0;
> 
> -	new_ctx = kmalloc(sizeof(*old_ctx) + old_ctx->ctx_len, GFP_ATOMIC);
> +	new_ctx = kmemdup(old_ctx, sizeof(*old_ctx) + old_ctx->ctx_len,
> +			GFP_ATOMIC);
>  	if (!new_ctx)
>  		return -ENOMEM;
> -	memcpy(new_ctx, old_ctx, sizeof(*old_ctx) + old_ctx->ctx_len);
>  	atomic_inc(&selinux_xfrm_refcount);
>  	*new_ctxp = new_ctx;

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
