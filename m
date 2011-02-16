Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GJYwZr031892
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 14:34:58 -0500
Received: from g1t0026.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GJYvCG022368
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 19:34:58 GMT
Subject: Re: [PATCH 02/10] selinux: Perform postroute access control checks
 after IPsec transfomations
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214131815.GC15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214131815.GC15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 14:34:54 -0500
Message-ID: <1297884894.25079.12.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:18 +0100, Steffen Klassert wrote:
> If selinux_policycap_netpeer is not set, we do the access control checks
> whenever a packet enters the postrouting hook. This can happen mulitiple
> times if IPsec transformations are involved. If we do packet labeling
> with secmark and we allow the sending socket just to send e.g. esp
> packets, we can't check for that. If a packet is seen by the postrouting
> hook for the first time, it is not transformed yet and rejected because it
> is not labeled as an esp packet.
> 
> Fix this by doing the access control checks just if the packet is on it's
> final way out. This is the same behaviour that we have already if
> selinux_policycap_netpeer is set.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Believe it or not, this code you are changing was done that way for a
reason: compatibility, bug-for-bug compatibility :)

When the new ingress/egress controls were first introduced (check the
archives, the patches were merged Jan 2008) the existing SELinux
postroute code ran for every transform; this was obviously a bug that
had persisted for some time, but considering the very strong desire to
preserve any user/admin visible behavior, I did not fix this when I
moved the old code up into selinux_ip_postroute_compat().  The good
news, is that I didn't carryover this bug into the new egress controls
as the IPsec transform check occurs before the egress controls are
executed.

So, a big NACK on this patch for compatibility reasons.  In order to get
the behavior you are looking for, make sure your policy enables the
"network_peer_controls" policy capability.

> ---
>  security/selinux/hooks.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c8d6992..3bf855a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4547,12 +4547,6 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  	u8 secmark_active;
>  	u8 peerlbl_active;
>  
> -	/* If any sort of compatibility mode is enabled then handoff processing
> -	 * to the selinux_ip_postroute_compat() function to deal with the
> -	 * special handling.  We do this in an attempt to keep this function
> -	 * as fast and as clean as possible. */
> -	if (!selinux_policycap_netpeer)
> -		return selinux_ip_postroute_compat(skb, ifindex, family);
>  #ifdef CONFIG_XFRM
>  	/* If skb->dst->xfrm is non-NULL then the packet is undergoing an IPsec
>  	 * packet transformation so allow the packet to pass without any checks
> @@ -4563,6 +4557,14 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  	if (skb_dst(skb) != NULL && skb_dst(skb)->xfrm != NULL)
>  		return NF_ACCEPT;
>  #endif
> +
> +	/* If any sort of compatibility mode is enabled then handoff processing
> +	 * to the selinux_ip_postroute_compat() function to deal with the
> +	 * special handling.  We do this in an attempt to keep this function
> +	 * as fast and as clean as possible. */
> +	if (!selinux_policycap_netpeer)
> +		return selinux_ip_postroute_compat(skb, ifindex, family);
> +
>  	secmark_active = selinux_secmark_enabled();
>  	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
>  	if (!secmark_active && !peerlbl_active)

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
