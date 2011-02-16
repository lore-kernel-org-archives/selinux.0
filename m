Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GL8J8I006248
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 16:08:23 -0500
Received: from g1t0029.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GL8MMK003728
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 21:08:22 GMT
Subject: Re: [PATCH 10/10] selinux: Perform xfrm checks for unlabeled
 access in any case
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214132312.GK15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214132312.GK15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 16:08:18 -0500
Message-ID: <1297890498.25079.53.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:23 +0100, Steffen Klassert wrote:
> We do the checks for unlabeled access with selinux_xfrm_postroute_last
> and selinux_xfrm_sock_rcv_skb just in compatibility mode.
> However these checks are required in any case as we have to ensure
> that a packet is allowed to be send to (or received from) an unlabeled
> destination if we have no security association configured.
> 
> This patch fixes this by calling selinux_xfrm_postroute_last and
> selinux_xfrm_sock_rcv_skb in any case.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Big NACK on this patch.

While it may seem odd to bail out on the labeled network access checks,
we should only do this when the admin has not configured any of the
labeled networking bits in the kernel (labeled IPsec, NetLabel,
Secmark).  The idea is that if the admin hasn't configured anything, all
you are going to end up checking is if unlabeled packets can be sent up,
down and around the network stack.  Not a very interesting access
control, and when you consider the policy headache and performance
impact it was causing we decided that dynamic access controls would be
okay for networking.

All you have to do to enable the dynamic access controls is configure
the system and viola, you get back all your unlabeled_t AVCs.

> ---
>  security/selinux/hooks.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1aeae26..85c7667 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4055,8 +4055,6 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  
>  	secmark_active = selinux_secmark_enabled();
>  	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
> -	if (!secmark_active && !peerlbl_active)
> -		return 0;
>  
>  	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.netif = skb->skb_iif;
> @@ -4090,6 +4088,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  			return err;
>  	}
>  
> +	err = selinux_xfrm_sock_rcv_skb(sk_sid, skb, &ad);
> +
>  	return err;
>  }
>  
> @@ -4532,6 +4532,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  	struct sock *sk;
>  	struct common_audit_data ad;
>  	char *addrp;
> +	u8 proto;
>  	u8 secmark_active;
>  	u8 peerlbl_active;
>  
> @@ -4555,8 +4556,6 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  
>  	secmark_active = selinux_secmark_enabled();
>  	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
> -	if (!secmark_active && !peerlbl_active)
> -		return NF_ACCEPT;
>  
>  	/* if the packet is being forwarded then get the peer label from the
>  	 * packet itself; otherwise check to see if it is from a local
> @@ -4581,7 +4580,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  	COMMON_AUDIT_DATA_INIT(&ad, NET);
>  	ad.u.net.netif = ifindex;
>  	ad.u.net.family = family;
> -	if (selinux_parse_skb(skb, &ad, &addrp, 0, NULL))
> +	if (selinux_parse_skb(skb, &ad, &addrp, 0, &proto))
>  		return NF_DROP;
>  
>  	if (secmark_active)
> @@ -4606,6 +4605,9 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  			return NF_DROP_ERR(-ECONNREFUSED);
>  	}
>  
> +	if (selinux_xfrm_postroute_last(peer_sid, skb, &ad, proto))
> +		return NF_DROP_ERR(-ECONNREFUSED);
> +
>  	return NF_ACCEPT;
>  }
>  

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
