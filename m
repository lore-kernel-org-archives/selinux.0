Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GJkjad032679
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 14:46:52 -0500
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GJkpCG024394
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 19:46:51 GMT
Subject: Re: [PATCH 04/10] selinux: Fix wrong checks for
 selinux_policycap_netpeer
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214131934.GE15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214131934.GE15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 14:46:48 -0500
Message-ID: <1297885608.25079.15.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:19 +0100, Steffen Klassert wrote:
> selinux_sock_rcv_skb_compat and selinux_ip_postroute_compat are just
> called if selinux_policycap_netpeer is not set. However in these
> functions we check if selinux_policycap_netpeer is set. This leads
> to some dead code and to the fact that selinux_xfrm_postroute_last
> is never executed. This patch removes the dead code and the checks
> for selinux_policycap_netpeer in the compatibility functions.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Nice cleanup.

Acked-by: Paul Moore <paul.moore@hp.com>

> ---
>  security/selinux/hooks.c |   24 ++++++------------------
>  1 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3bf855a..2b594de 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4002,7 +4002,6 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>  {
>  	int err = 0;
>  	struct sk_security_struct *sksec = sk->sk_security;
> -	u32 peer_sid;
>  	u32 sk_sid = sksec->sid;
>  	struct common_audit_data ad;
>  	char *addrp;
> @@ -4021,20 +4020,10 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
>  			return err;
>  	}
>  
> -	if (selinux_policycap_netpeer) {
> -		err = selinux_skb_peerlbl_sid(skb, family, &peer_sid);
> -		if (err)
> -			return err;
> -		err = avc_has_perm(sk_sid, peer_sid,
> -				   SECCLASS_PEER, PEER__RECV, &ad);
> -		if (err)
> -			selinux_netlbl_err(skb, err, 0);
> -	} else {
> -		err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
> -		if (err)
> -			return err;
> -		err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
> -	}
> +	err = selinux_netlbl_sock_rcv_skb(sksec, skb, family, &ad);
> +	if (err)
> +		return err;
> +	err = selinux_xfrm_sock_rcv_skb(sksec->sid, skb, &ad);
>  
>  	return err;
>  }
> @@ -4529,9 +4518,8 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
>  				 SECCLASS_PACKET, PACKET__SEND, &ad))
>  			return NF_DROP_ERR(-ECONNREFUSED);
>  
> -	if (selinux_policycap_netpeer)
> -		if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
> -			return NF_DROP_ERR(-ECONNREFUSED);
> +	if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
> +		return NF_DROP_ERR(-ECONNREFUSED);
>  
>  	return NF_ACCEPT;
>  }

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
