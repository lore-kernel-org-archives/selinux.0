Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GJdCXa032191
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 14:39:12 -0500
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GJdBqY007432
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 19:39:11 GMT
Subject: Re: [PATCH 03/10] selinux: Remove checks for xfrm transformations
 from selinux_xfrm_postroute_last
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214131855.GD15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214131855.GD15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 14:39:09 -0500
Message-ID: <1297885149.25079.14.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:18 +0100, Steffen Klassert wrote:
> Postroute access control checks are just performed on the packets final
> way out, so there is no need to check for further transformations
> in the xfrm state bundle.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

For similar reasons as patch 2/10 I have to NACK this patch.  The
selinux_xfrm_postroute_last() function is a holdout from the previous
network access controls.  If you want the new behavior, use a modern
SELinux policy on a modern kernel.

> ---
>  security/selinux/xfrm.c |   15 ---------------
>  1 files changed, 0 insertions(+), 15 deletions(-)
> 
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 728c57e..62f3b26 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -445,23 +445,8 @@ int selinux_xfrm_sock_rcv_skb(u32 isec_sid, struct sk_buff *skb,
>  int selinux_xfrm_postroute_last(u32 isec_sid, struct sk_buff *skb,
>  					struct common_audit_data *ad, u8 proto)
>  {
> -	struct dst_entry *dst;
>  	int rc = 0;
>  
> -	dst = skb_dst(skb);
> -
> -	if (dst) {
> -		struct dst_entry *dst_test;
> -
> -		for (dst_test = dst; dst_test != NULL;
> -		     dst_test = dst_test->child) {
> -			struct xfrm_state *x = dst_test->xfrm;
> -
> -			if (x && selinux_authorizable_xfrm(x))
> -				goto out;
> -		}
> -	}
> -
>  	switch (proto) {
>  	case IPPROTO_AH:
>  	case IPPROTO_ESP:

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
