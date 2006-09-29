Message-ID: <36282A1733C57546BE392885C0618592015CF3A5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: paul.moore@hp.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, method@gentoo.org,
        kmacmillan@mentalrootkit.com
Subject: RE: [PATCH 1/1] NetLabel: secid reconciliation support
Date: Fri, 29 Sep 2006 17:20:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> @@ -3672,16 +3674,20 @@ static int selinux_skb_flow_in(struct sk
>  	if (err)
>  		goto out;
>  
> -	if (xfrm_sid) {
> -		err = security_transition_sid(xfrm_sid, skb->secmark,
> -						
> SECCLASS_PACKET, &trans_sid);
> -		if (err)
> -			goto out;
> +	if (xfrm_sid)
> +		skb->secmark = xfrm_sid;
>  
> -		skb->secmark = trans_sid;
> -	}
> +	err = selinux_netlbl_skb_sid(skb, skb->secmark, &nlbl_sid);

I take it nlbl_sid here will be 0 if netlabel is NOT configured
for the traffic correct?

> --- net-2.6.orig/security/selinux/ss/mls.c
> +++ net-2.6/security/selinux/ss/mls.c
> @@ -547,7 +547,7 @@ int mls_compute_sid(struct context *scon
>  				                     
&rtr->target_range);
>  			}
>  		}
> -		else if (tclass == SECCLASS_PACKET)
> +		if (tclass == SECCLASS_PACKET)

What's the purpose of getting rid of "else" above?

I haven't reviewed the netlbl native changes, but the hooks.c changes
seem ok to me.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
