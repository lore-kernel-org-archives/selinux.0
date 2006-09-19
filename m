Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8JLxRjK025115
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 17:59:27 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8JLwT0H020731
	for <selinux@tycho.nsa.gov>; Tue, 19 Sep 2006 21:58:30 GMT
Message-ID: <36282A1733C57546BE392885C0618592015730EF@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joy Latten <latten@austin.ibm.com>, netdev@vger.kernel.org,
        redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Cc: davem@davemloft.net, jmorris@namei.org
Subject: RE: [redhat-lspp] ipsec acquire has security context although I a
	m not using it.
Date: Tue, 19 Sep 2006 17:58:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This doesn't look right since kzalloc would already have zeroed the
structure out. Are you sure you are getting garbage in the acquire
from the kernel? If you are, I strongly doubt that this would be the
one causing it (unless kzalloc on this arch misbehaved).
Or is this a racoon bug?

> -----Original Message-----
> From: Joy Latten [mailto:latten@austin.ibm.com]
> Sent: Tuesday, September 19, 2006 4:17 PM
> To: netdev@vger.kernel.org; redhat-lspp@redhat.com;
> selinux@tycho.nsa.gov
> Cc: davem@davemloft.net; jmorris@namei.org
> Subject: [redhat-lspp] ipsec acquire has security context 
> although I am
> not using it.
> 
> 
> 
> When using ipsec while selinux is enabled in my kernel, 
> my racoon daemon fails to establish an SA. I believe the
> ACQUIRE sent from kernel has a security context although I 
> am not using this feature with ipsec. As a result, racoon
> fails to establish the SA, because it is looking for a policy
> with security context. I noticed the security context 
> contains garbage. 
> 
> I am using a pseries, power5, ppc64 box, and it appears
> that since policy->security structure is not really initialized
> or zero'd out when not using, it is possible it may contain garbage
> on my pseries and a call such as "if (policy->security)" may 
> come back as true such that security context is included in
> my acquire message although I believe it should not be. 
> 
> Hopefully, the below patch is acceptable. I have compiled and
> tested it.
> 
> Regards,
> Joy Latten
> 
> 
> diff -urpN linux-2.6.17.orig/net/xfrm/xfrm_policy.c 
> linux-2.6.17.patch/net/xfrm/xfrm_policy.c
> --- linux-2.6.17.orig/net/xfrm/xfrm_policy.c	2006-09-19 
> 02:11:33.000000000 -0500
> +++ linux-2.6.17.patch/net/xfrm/xfrm_policy.c	2006-09-19 
> 04:33:50.000000000 -0500
> @@ -319,6 +319,7 @@ struct xfrm_policy *xfrm_policy_alloc(gf
>  		init_timer(&policy->timer);
>  		policy->timer.data = (unsigned long)policy;
>  		policy->timer.function = xfrm_policy_timer;
> +		policy->security = NULL;
>  	}
>  	return policy;
>  }
> 
> --
> redhat-lspp mailing list
> redhat-lspp@redhat.com
> https://www.redhat.com/mailman/listinfo/redhat-lspp
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
