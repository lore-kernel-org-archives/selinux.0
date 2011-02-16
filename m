Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GKJdOO002646
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 15:19:39 -0500
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GKJcvO001231
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 20:19:38 GMT
Subject: Re: [PATCH 06/10] selinux: Fix packet forwarding checks on
 postrouting
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214132049.GG15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214132049.GG15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 15:19:35 -0500
Message-ID: <1297887575.25079.26.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:20 +0100, Steffen Klassert wrote:
> The IPSKB_FORWARDED and IP6SKB_FORWARDED flags are used only in the
> multicast forwarding case to indicate that a packet looped back after
> forward. So these flags are not a good indicator for packet forwarding.
> A better indicator is the incoming interface. If we have no socket context,
> but an incoming interface and we see the packet in the ip postroute hook,
> the packet is going to be forwarded.
> 
> With this patch we use the incoming interface as an indicator on packet
> forwarding.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Nice fix.  I could have sworn that IP{6}SKB_FORWARDED was more universal
when this code was written ... but then again, I'm easily confused :)

Acked-by: Paul Moore <paul.moore@hp.com>

> ---
>  security/selinux/hooks.c |   23 +++++------------------
>  1 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2b594de..1aeae26 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4564,27 +4564,14 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  	 * from the sending socket, otherwise use the kernel's sid */
>  	sk = skb->sk;
>  	if (sk == NULL) {
> -		switch (family) {
> -		case PF_INET:
> -			if (IPCB(skb)->flags & IPSKB_FORWARDED)
> -				secmark_perm = PACKET__FORWARD_OUT;
> -			else
> -				secmark_perm = PACKET__SEND;
> -			break;
> -		case PF_INET6:
> -			if (IP6CB(skb)->flags & IP6SKB_FORWARDED)
> -				secmark_perm = PACKET__FORWARD_OUT;
> -			else
> -				secmark_perm = PACKET__SEND;
> -			break;
> -		default:
> -			return NF_DROP_ERR(-ECONNREFUSED);
> -		}
> -		if (secmark_perm == PACKET__FORWARD_OUT) {
> +		if (skb->skb_iif) {
> +			secmark_perm = PACKET__FORWARD_OUT;
>  			if (selinux_skb_peerlbl_sid(skb, family, &peer_sid))
>  				return NF_DROP;
> -		} else
> +		} else {
> +			secmark_perm = PACKET__SEND;
>  			peer_sid = SECINITSID_KERNEL;
> +		}
>  	} else {
>  		struct sk_security_struct *sksec = sk->sk_security;
>  		peer_sid = sksec->sid;

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
