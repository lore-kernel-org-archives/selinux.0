Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8II53F8016245
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 14:05:03 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8II4XuA025967
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 18:04:34 GMT
Date: Mon, 18 Sep 2006 14:05:00 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [PATCH 3/7] secid reconciliation-v02: Invoke LSM hook for inbound
 traffic
In-Reply-To: <45019F62.7000305@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609181404050.5976@d.namei>
References: <45019F62.7000305@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Sep 2006, Venkat Yekkirala wrote:

> -static inline int xfrm6_policy_check(struct sock *sk, int dir, struct sk_buff
> *skb)
> -{
> -	return xfrm_policy_check(sk, dir, skb, AF_INET6);
> +	if (sk && sk->sk_policy[XFRM_POLICY_IN])
> +		ret = __xfrm_policy_check(sk, dir, skb, family);
> +	else
> +		ret = (!xfrm_policy_count[dir] && !skb->sp) ||
> +		      (skb->dst->flags & DST_NOPOLICY) ||
> +		      __xfrm_policy_check(sk, dir, skb, family);
> +
> +#ifdef CONFIG_SECURITY_NETWORK
> +	if (ret)
> +		ret = security_skb_policy_check(skb, family);
> +#endif /* CONFIG_SECURITY_NETWORK */

Why is this code ifdef'd when the function is conditionally compiled?

> {
> +#ifdef CONFIG_SECURITY_NETWORK
> +	return security_skb_policy_check(skb, family);
> +#else
> 	return 1;
> +#endif /* CONFIG_SECURITY_NETWORK */

Ditto.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
