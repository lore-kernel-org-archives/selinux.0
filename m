Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8T7Wq9a010164
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 03:32:52 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8T7WIaq008594
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 07:32:18 GMT
Date: Fri, 29 Sep 2006 03:32:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        paul.moore@hp.com
Subject: Re: [PATCH 4/7] secid reconciliation-v03: Invoke LSM hook for outbound
 traffic
In-Reply-To: <451C85E2.2030201@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609290324050.1650@d.namei>
References: <451C85E2.2030201@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Sep 2006, Venkat Yekkirala wrote:

> +		if (connsecmark)
> +			if (*connsecmark != skb->secmark) {
>  				*connsecmark = skb->secmark;
> +			}

Please remove the braces if re-submitting.

> +printk(KERN_ERR "IN HOOK (%d) (%u) (%u)\n", hooknum, skb->secmark, *psecmark);\

Please remove debugging (here and elsewhere).



> +		/* Set secmark on inbound and filter it on outbound */
> +		if ((target->family == AF_INET &&
> +			(hooknum == NF_IP_POST_ROUTING ||
> +			 hooknum == NF_IP_LOCAL_OUT ||
> +			 hooknum == NF_IP_FORWARD)) ||
> +		    (target->family == AF_INET6 &&
> +			(hooknum == NF_IP6_POST_ROUTING ||
> +			 hooknum == NF_IP6_LOCAL_OUT ||
> +			 hooknum == NF_IP6_FORWARD))) {

I think this should be a separate helper function, so the logic can be 
changed/evaluated in isolation (preferred, but not a blocker).

> +		secmark_save(skb, hooknum, target);

It seems that the target parameter is not needed.


> +		return secmark_restore(skb, hooknum, in, target);

Please pass a family parameter instead of target.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
