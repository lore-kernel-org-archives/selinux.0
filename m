From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: Networking Patch (outline)
Date: Wed, 5 Sep 2007 18:27:11 -0400
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
References: <46D898D3.7020400@trustedcs.com>
In-Reply-To: <46D898D3.7020400@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709051827.11946.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some more thoughts on the patch as I keep looking at it and thinking ...

On Friday, August 31 2007 6:40:19 pm Venkat Yekkirala wrote:
> Specifically, the following are the primary areas that
> have not been addressed here:
>
> 4. Currently this patch modifies xfrm_policy_check()
>    to also perform the flow_in checks. This is awkward and
>    a separate call into LSM right after the xfrm_policy_check
>    invocations would be cleaner.

It would be great if we could do something with a netfilter PRE_ROUTING hook 
similar to how we handle outbound packets with a POST_ROUTING hook.  I just 
spent some time looking at the XFRM input code path and it looks like AH/ESP 
transport packets make two trips through the PRE_ROUTING hook, once before 
the transformation (skb->sp == NULL) and once afterwards (skb->sp != NULL).  
Tunnel mode transforms should be handled because they run back through the 
stack starting with the initial IP receive routine so they will be caught the 
second time around.  However, I haven't spent as much time looking at either 
the labeled IPsec or flow control bits as you so I might be overlooking some 
important things.  Does this sound like it might work from a labeled IPsec 
point of view?

The only real gotcha I can see to this approach is CIPSO, or any other IP 
options based labeling protocol, because the ip_rcv_options() routine is not 
called until after the PRE_ROUTING hooks have been called.  We need this as 
the ip_options_compile() routine is the one which parses/validates the IP 
options.  If this is the only problem we can probably work around it by 
calling it (or ip_options_compile() directly) in our hook and making it 
smarter so that it doesn't run a second time if IPCB(skb)->opt is not NULL.

> --- linux-2.6.orig/security/selinux/hooks.c	2007-08-30 09:18:01.000000000
> -0500 +++ linux-2.6/security/selinux/hooks.c	2007-08-31 15:35:54.000000000
> -0500 @@ -3146,6 +3146,11 @@ static void selinux_skb_extlbl_sid(struc
>  	u32 xfrm_sid;
>  	u32 nlbl_sid;
>
> +	if (skb->secid) {
> +		*sid = skb->secid;
> +		return;
> +	}
> +
>  	selinux_skb_xfrm_sid(skb, &xfrm_sid);
>  	if (selinux_netlbl_skbuff_getsid(skb,
>  					 (xfrm_sid == SECSID_NULL ?
> @@ -3629,9 +3634,28 @@ static int selinux_socket_sock_rcv_skb(s
>  	if (selinux_compat_net)
>  		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
>  						  addrp, len);
> -	else
> +	else {
> +		u32 recv_perm;
> +
>  		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
>  				   PACKET__RECV, &ad);
> +		if (err)
> +			goto out;
> +
> +		switch (sksec->sclass) {
> +		case SECCLASS_UDP_SOCKET:
> +			recv_perm = UDP_SOCKET__RECVFROM;
> +			break;
> +		case SECCLASS_TCP_SOCKET:
> +			recv_perm = TCP_SOCKET__RECVFROM;
> +			break;
> +		default:
> +			recv_perm = RAWIP_SOCKET__RECVFROM;
> +		}
> +
> +		err = avc_has_perm(sksec->sid, skb->secid, sksec->sclass,
> +				   recv_perm, &ad);
> +	}
>  	if (err)
>  		goto out;

One thing I've been wondering about lately - is the distinction between 
different types of sockets useful?  From discussions which Chris, the policy 
guys seem not to care, which makes me think we are needlessly making life 
difficult for ourselves.  However, if other third-parties see a need for the 
distinction ...

> @@ -3804,6 +3828,62 @@ static void selinux_req_classify_flow(co
>  	fl->secid = req->secid;
>  }
>
> +void selinux_igmp_classify_skb(struct sk_buff *skb)
> +{
> +	skb->secid = SECINITSID_IGMP_PACKET;
> +}
> +
> +static int selinux_skb_flow_in(struct sk_buff *skb, unsigned short family)
> +{
> +	u32 if_sid;
> +	int err;
> +	struct avc_audit_data ad;
> +	char *addrp;
> +	int len;
> +
> +	if (selinux_compat_net)
> +		return 1;
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
> +	if (skb->dev != &loopback_dev) { /* Non-localhost packet */
> +		err = selinux_xfrm_decode_session(skb, &skb->secid, 0);
> +		BUG_ON(err);
> +		/* TODO: Retrieve and check any NetLabel for agreement with
> +		   any Xfrm; also retrieve fallback if necessary */
> +	}
> +#ifdef TODO
> +	else /* localhost packet */
> +		/* TODO: Retrieve special IP Option set for localhost traffic */
> +
> +	err = avc_has_perm(skb->secid, NODE /* TODO */, SECCLASS_PACKET,
> PACKET__FLOW_IN, &ad); +	if (err)
> +		goto out;
> +#endif
> +
> +	/* See if skb can flow in thru the interface */
> +	err = sel_netif_sids(skb->dev, &if_sid, NULL);
> +	if (err)
> +		goto out;
> +
> +	err = avc_has_perm(skb->secid, if_sid,
> +					SECCLASS_NETIF,
> +					NETIF__FLOW_IN, &ad);

I assume this is where the host/node check would go?  Would it make sense to 
create a combined interface/network label and check so that we could do one 
lookup and one access check instead of two?

Same applies to postroute().

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
