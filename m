Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95IIHC1029146
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 14:18:17 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k95IHfZv000875
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 18:17:41 GMT
Subject: Re: Networking policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <45232276.2080105@trustedcs.com>
References: <45232276.2080105@trustedcs.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 14:18:07 -0400
Message-Id: <1160072287.26418.18.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-03 at 21:54 -0500, Venkat Yekkirala wrote:
> FYI- I have posted the following patches separate from this one.
> 
> 1. A patch to address the "leask" issue. Once verified, it needs
> to be rolled in with James' patch and sent on after verification.
> 
> 2. A fix for flow_in and flow_out where we were using the unlabeled
>    init sid. We would now use a new network_t with a range of (s0-s15...)
>    to allow for mls traffic to flow out/in, in the absence of explicit secmark
>    rules.
> 
> 
> The following is a sample patch for networking using the new controls
> in conjunction with secmark.
> 
> NOTE FOR JOSHUA: This patch also defines the constraints to force context
> equality for association:sendto.

I'm starting a labeled networking branch of refpolicy to work with this.
I'm waiting until the dust settles before adding TE rules, but I have
some questions:

> +mlsconstrain association { recvfrom }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> +	 ( t1 == mlsnetread ) or
> +	 ( t2 == unlabeled_t ));

Don't we want network_t instead of unlabeled_t?

> +mlsconstrain association { sendto }
> +	(( l1 eq l2 ) and ( h1 eq h2 ));

or (t2 == network_t) ?

> +mlsconstrain association { polmatch }
> +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> +	 ( t2 == unlabeled_t ));

same thing about network_t

> +constrain association sendto
> +	( u1 == u2 and r1 == r2 and t1 == t2 );

I talked with Joshua and we determined that there is a case were we
don't want this constraint (looking forward to policy management
server's use of labeled networking), so I've dropped it.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
