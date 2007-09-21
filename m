From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
Date: Fri, 21 Sep 2007 16:14:52 -0400
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <46F00BAC.8040103@trustedcs.com>
In-Reply-To: <46F00BAC.8040103@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709211614.54212.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, September 18 2007 1:32:28 pm Venkat Yekkirala wrote:
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3694662..5434d7f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3519,6 +3519,124 @@ static int selinux_socket_unix_may_send(struct
> socket *sock, return 0;
>  }
>
> +static int selinux_skb_flow_in(struct sk_buff *skb, struct net_device *in,
> +			       unsigned short family)
> +{
> +	u32 node_sid, if_sid, secid = SECSID_NULL;
> +	int err;
> +	struct avc_audit_data ad;
> +	char *addrp;
> +	int len;
> +
> +	if (!in) {
> +		if (skb->dev && skb->dev->ifindex == skb->iif)

When, if ever, will the skb->dev->ifindex != skb->iif?  Doesn't it have to be 
the same?

> +			in = skb->dev;

Please don't reuse the "in" parameter here (or below), create a new variable 
("dev" perhaps?).  I know this is a nit, but I think it helps make things 
easier to read/debug.

> +		else
> +			in = __dev_get_by_index(skb->iif);

Are you certain it's safe to use __dev_get_by_index() here?  I have a hunch we 
need to use the regular dev_get_by_index() function and the matching 
dev_put() call later.

> +		if (!in) {
> +			err = -EACCES;
> +			goto out;
> +		}
> +	}
> +	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	ad.u.net.netif = in->name;
> +	ad.u.net.family = family;
> +	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
> +	if (err)
> +		goto out;
> +
> +	if (in != &loopback_dev) { /* Non-localhost packet */
> +		err = selinux_xfrm_decode_session(skb, &secid, 0);
> +		BUG_ON(err);
> +		/* TODO: Retrieve and check any NetLabel for agreement with
> +		   any Xfrm; also retrieve fallback if necessary */
> +	}
> +#ifdef TODO
> +	else /* localhost packet */
> +		/* TODO: Retrieve special IP Option set for localhost traffic */
> +#endif

Remove the check for loopback and the #ifdef ... #endif block, this stuff 
should/will be handled in a different set of patches.  Stick with the 
selinux_xfrm_decode_session() call and the TODO comment for right now.

> +	err = security_node_sid(family, addrp, len, &node_sid);
> +	if (err)
> +		goto out;
> +
> +	err = avc_has_perm(secid, node_sid,
> +				  SECCLASS_NODE,
> +				  NODE__FLOW_IN, &ad);
> +	if (err)
> +		goto out;
> +
> +	/* See if skb can flow in thru the interface */
> +	err = sel_netif_sids(in, &if_sid, NULL);
> +	if (err)
> +		goto out;
> +
> +	err = avc_has_perm(secid, if_sid,
> +				  SECCLASS_NETIF,
> +				  NETIF__FLOW_IN, &ad);

Move the NETIF check in front of the NODE check.  I think it makes more sense 
conceptually to check the interface first.

> +out:
> +	return err;
> +};
> +
> +static int selinux_skb_flow_out(struct sk_buff *skb, int family)

If we change the other functions from "flow_out" to "output" it might make 
sense to do the same here and below.

> +{
> +	u32 node_sid, if_sid, secid = SECSID_NULL;
> +	int err;
> +	struct avc_audit_data ad;
> +	char *addrp;
> +	int len;
> +	struct sock *sk;
> +	struct sk_security_struct *sksec;
> +
> +	if (!skb->dev) {
> +		err = -EACCES;
> +		goto out;
> +	}
> +
> +	AVC_AUDIT_DATA_INIT(&ad, NET);
> +	ad.u.net.netif = skb->dev->name;
> +	ad.u.net.family = family;
> +	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
> +	if (err)
> +		goto out;
> +
> +	/* TODO: Glean the secid for forwarded packets
> +	   from any incoming xfrms, NetLabel/Fallback, etc. */
> +
> +	if (!secid) {

Make use of the #define where possible, change this to:

	if (secid != SECSID_NULL) {

> +		sk = skb->sk;
> +		if (sk) {
> +			sksec = sk->sk_security;
> +			secid = sksec->sid;
> +		}
> +	}
> +
> +	err = security_node_sid(family, addrp, len, &node_sid);
> +	if (err)
> +		goto out;
> +
> +	err = avc_has_perm(secid, node_sid,
> +				  SECCLASS_NODE,
> +				  NODE__FLOW_OUT, &ad);
> +	if (err)
> +		goto out;
> +
> +	/* See if skb can flow out thru the interface */
> +	err = sel_netif_sids(skb->dev, &if_sid, NULL);
> +	if (err)
> +		goto out;
> +
> +	err = avc_has_perm(secid, if_sid,
> +				  SECCLASS_NETIF,
> +				  NETIF__FLOW_OUT, &ad);

Here I think it is "correct" to check the node first as you are currently 
doing.

> +out:
> +	return err;
> +}
> +
>  static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff
> *skb, struct avc_audit_data *ad, u16 family, char *addrp, int len)
>  {
> @@ -3629,10 +3747,14 @@ static int selinux_socket_sock_rcv_skb(struct sock
> *sk, struct sk_buff *skb) if (err)
>  		goto out;
>
> -	if (selinux_compat_net)
> +	if (selinux_compat_net) {
> +		err = selinux_skb_flow_in(skb, NULL, family);
> +		if (err)
> +			goto out;

You just lost me here ... why only do the flow_in check when compat_net == 1?

>  		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
>  						  addrp, len);
> -	else
> +	} else
>  		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
>  				   PACKET__RECV, &ad);
>  	if (err)
> @@ -3924,6 +4046,20 @@ out:
>  	return err;
>  }
>
> +static unsigned int selinux_ip_forward_first(unsigned int hooknum,
> +                                              struct sk_buff **pskb,
> +                                              const struct net_device *in,
> +                                              const struct net_device
> *out, +                                              int (*okfn)(struct
> sk_buff *), +                                              u16 family)
> +{
> +	if (selinux_skb_flow_in(*pskb, (struct net_device *)in, family))
> +		return NF_DROP;
> +
> +	return NF_ACCEPT;
> +}
> +
> +
>  static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
>                                                struct sk_buff **pskb,
>                                                const struct net_device *in,
> @@ -3969,6 +4105,15 @@ out:
>  	return err ? NF_DROP : NF_ACCEPT;
>  }
>
> +static unsigned int selinux_ipv4_forward_first(unsigned int hooknum,
> +                                              struct sk_buff **pskb,
> +                                              const struct net_device *in,
> +                                              const struct net_device
> *out, +                                              int (*okfn)(struct
> sk_buff *)) +{
> +	return selinux_ip_forward_first(hooknum, pskb, in, out, okfn, PF_INET);
> +}
> +
>  static unsigned int selinux_ipv4_postroute_last(unsigned int hooknum,
>  						struct sk_buff **pskb,
>  						const struct net_device *in,
> @@ -3980,6 +4125,15 @@ static unsigned int
> selinux_ipv4_postroute_last(unsigned int hooknum,
>
>  #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
>
> +static unsigned int selinux_ipv6_forward_first(unsigned int hooknum,
> +                                              struct sk_buff **pskb,
> +                                              const struct net_device *in,
> +                                              const struct net_device
> *out, +                                              int (*okfn)(struct
> sk_buff *)) +{
> +	return selinux_ip_forward_first(hooknum, pskb, in, out, okfn, PF_INET6);
> +}
> +
>  static unsigned int selinux_ipv6_postroute_last(unsigned int hooknum,
>  						struct sk_buff **pskb,
>  						const struct net_device *in,
> @@ -4875,6 +5029,7 @@ static struct security_operations selinux_ops = {
>  	.inet_csk_clone =		selinux_inet_csk_clone,
>  	.inet_conn_established =	selinux_inet_conn_established,
>  	.req_classify_flow =		selinux_req_classify_flow,
> +	.skb_flow_out =			selinux_skb_flow_out,
>
>  #ifdef CONFIG_SECURITY_NETWORK_XFRM
>  	.xfrm_policy_alloc_security =	selinux_xfrm_policy_alloc,
> @@ -4978,22 +5133,40 @@ security_initcall(selinux_init);
>
>  #if defined(CONFIG_NETFILTER)
>
> -static struct nf_hook_ops selinux_ipv4_op = {
> +static struct nf_hook_ops selinux_ipv4_ops[] = {
> +	{
>  	.hook =		selinux_ipv4_postroute_last,
>  	.owner =	THIS_MODULE,
>  	.pf =		PF_INET,
>  	.hooknum =	NF_IP_POST_ROUTING,
>  	.priority =	NF_IP_PRI_SELINUX_LAST,
> +	},
> +	{
> +	.hook =		selinux_ipv4_forward_first,
> +	.owner =	THIS_MODULE,
> +	.pf =		PF_INET,
> +	.hooknum =	NF_IP_FORWARD,
> +	.priority =	NF_IP_PRI_SELINUX_FIRST,
> +	}
>  };
>
>  #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
>
> -static struct nf_hook_ops selinux_ipv6_op = {
> +static struct nf_hook_ops selinux_ipv6_ops[] = {
> +	{
>  	.hook =		selinux_ipv6_postroute_last,
>  	.owner =	THIS_MODULE,
>  	.pf =		PF_INET6,
>  	.hooknum =	NF_IP6_POST_ROUTING,
>  	.priority =	NF_IP6_PRI_SELINUX_LAST,
> +	},
> +	{
> +	.hook =		selinux_ipv6_forward_first,
> +	.owner =	THIS_MODULE,
> +	.pf =		PF_INET6,
> +	.hooknum =	NF_IP6_FORWARD,
> +	.priority =	NF_IP6_PRI_SELINUX_FIRST,
> +	}
>  };
>
>  #endif	/* IPV6 */
> @@ -5001,21 +5174,26 @@ static struct nf_hook_ops selinux_ipv6_op = {
>  static int __init selinux_nf_ip_init(void)
>  {
>  	int err = 0;
> +	int i;
>
>  	if (!selinux_enabled)
>  		goto out;
>
>  	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
>
> -	err = nf_register_hook(&selinux_ipv4_op);
> -	if (err)
> -		panic("SELinux: nf_register_hook for IPv4: error %d\n", err);
> +	for (i = 0; i < sizeof(selinux_ipv4_ops)/sizeof(struct nf_hook_ops); i++)
> { +		err = nf_register_hook(&selinux_ipv4_ops[i]);
> +		if (err)
> +			panic("SELinux: nf_register_hook for IPv4: error %d\n", err);
> +	}
>
>  #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
>
> -	err = nf_register_hook(&selinux_ipv6_op);
> -	if (err)
> -		panic("SELinux: nf_register_hook for IPv6: error %d\n", err);
> +	for (i = 0; i < sizeof(selinux_ipv6_ops)/sizeof(struct nf_hook_ops); i++)
> { +		err = nf_register_hook(&selinux_ipv6_ops[i]);
> +		if (err)
> +			panic("SELinux: nf_register_hook for IPv6: error %d\n", err);
> +	}
>
>  #endif	/* IPV6 */
>
> @@ -5028,11 +5206,14 @@ __initcall(selinux_nf_ip_init);
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  static void selinux_nf_ip_exit(void)
>  {
> +	int i;
>  	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
>
> -	nf_unregister_hook(&selinux_ipv4_op);
> +	for (i = 0; i < sizeof(selinux_ipv4_ops)/sizeof(struct nf_hook_ops); i++)
> +		nf_unregister_hook(&selinux_ipv4_ops[i]);
>  #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> -	nf_unregister_hook(&selinux_ipv6_op);
> +	for (i = 0; i < sizeof(selinux_ipv6_ops)/sizeof(struct nf_hook_ops); i++)
> +		nf_unregister_hook(&selinux_ipv6_ops[i]);
>  #endif	/* IPV6 */
>  }
>  #endif

Once we sort these changes/issues out send me a fresh set of patches backed 
against Linus' tree and I'll put them in the lblnet testing tree so we can 
start collecting all of these things in one place.

Thanks for sticking with this.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
