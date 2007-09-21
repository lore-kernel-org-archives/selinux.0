From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC] [PATCH 3/4] Core networking changes
Date: Fri, 21 Sep 2007 15:40:20 -0400
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <46F00B88.1080801@trustedcs.com>
In-Reply-To: <46F00B88.1080801@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709211540.21452.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, September 18 2007 1:31:52 pm Venkat Yekkirala wrote:
> This calls into the skb_flow_out LSM hook for flow-controlling
> all traffic on their way out. The existing postroute_last LSM
> netfilter hook couldn't be used since it would be invoked for
> each xfrm as it is applied to a packet.
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 0f1d7be..37a05a2 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -204,6 +204,7 @@ static inline int ip_skb_dst_mtu(struct sk_buff *skb)
>
>  static inline int ip_finish_output(struct sk_buff *skb)
>  {
> +	int err;
>  #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
>  	/* Policy lookup after SNAT yielded a new policy */
>  	if (skb->dst->xfrm != NULL) {
> @@ -211,6 +212,10 @@ static inline int ip_finish_output(struct sk_buff
> *skb) return dst_output(skb);
>  	}
>  #endif
> +	err = security_skb_flow_out(skb, AF_INET);
> +	if (err)
> +		return err;
> +
>  	if (skb->len > ip_skb_dst_mtu(skb) && !skb_is_gso(skb))
>  		return ip_fragment(skb, ip_finish_output2);
>  	else
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 26de3c0..d682e8a 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -73,6 +73,11 @@ static __inline__ void ipv6_select_ident(struct sk_buff
> *skb, struct frag_hdr *f static inline int ip6_output_finish(struct sk_buff
> *skb)
>  {
>  	struct dst_entry *dst = skb->dst;
> +	int err;
> +
> +	err = security_skb_flow_out(skb, AF_INET6);
> +	if (err)
> +		return err;
>
>  	if (dst->hh)
>  		return neigh_hh_output(dst->hh, skb);

Other than the hook name this looks good to me.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
