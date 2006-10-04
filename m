Message-ID: <36282A1733C57546BE392885C0618592015CF8A5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: paul.moore@hp.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: eparis@redhat.com, jmorris@namei.org, sds@tycho.nsa.gov,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: RE: [PATCH v4 1/2] NetLabel: secid reconciliation support
Date: Wed, 4 Oct 2006 12:59:41 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> @@ -3714,19 +3714,34 @@ static int selinux_skb_flow_in(struct sk
>  	if (skb->dev == &loopback_dev)
>  		return 1;
>  
> +	if (skb->secmark)
> +		loc_sid = skb->secmark;
> +	else
> +		loc_sid = SECINITSID_NETMSG;
> +
>  	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
>  	BUG_ON(err);
> -
> -	err = avc_has_perm(xfrm_sid, skb->secmark? : SECINITSID_NETMSG,
> -					SECCLASS_PACKET,
> -					PACKET__FLOW_IN, NULL);
> +	err = selinux_netlbl_skb_sid(skb,
> +				     xfrm_sid ? xfrm_sid : loc_sid,
> +				     &nlbl_sid);
>  	if (err)
>  		goto out;
>  
> -	if (xfrm_sid)
> -		skb->secmark = xfrm_sid;
> +	if (nlbl_sid)
> +		ext_sid = nlbl_sid;
> +	else
> +		ext_sid = xfrm_sid;

There's a problem here in that it would require 2 different policies
depending on whether one is using netlabel or xfrm. Specifically, in
the absence of matching iptables contexts (secmark), the skb here
will get:

- 0 (xfrm case)
- network_t (netlabel)

This has implications for getpeercon() where it would

- fail with ENOPROTOOPT (xfrm case)
- returns network_t (netlabel)

I would still argue that the nature of the domain being carried by
the packet is still unlabeled_t as implied by the null secmark. While
I view secmark/point as specifying BOTH a flow control point and a
default domain (incidentally using the same label more because of
implementation constrainst), I view network_t as purely a flow control
point.

But I also realize there can be equally forceful arguments for what this
patch does.

What does the community think? We need to resolve it one way or the
other unless the above differences in behavior are desired or somehow
accounted for in policy and apps.

> +
> +	err = avc_has_perm(ext_sid,
> +			   loc_sid,
> +			   SECCLASS_PACKET,
> +			   PACKET__FLOW_IN,
> +			   NULL);
> +	if (err)
> +		goto out;
>  
> -	/* See if NetLabel can flow in thru the current secmark here */
> +	if (ext_sid)
> +		skb->secmark = ext_sid;
>  
>  out:
>  	return err ? 0 : 1;
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
