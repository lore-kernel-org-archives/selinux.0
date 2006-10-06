Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96DRxbb024586
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 09:27:59 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96DQk4o011234
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 13:26:46 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFBBB@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: RE: Networking policy patch
Date: Fri, 6 Oct 2006 09:27:36 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > NOTE FOR JOSHUA: This patch also defines the constraints to 
> force context
> > equality for association:sendto.
> 
> I'm starting a labeled networking branch of refpolicy to work 
> with this.
> I'm waiting until the dust settles before adding TE rules, but I have
> some questions:
> 
> > +mlsconstrain association { recvfrom }
> > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > +	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> > +	 ( t1 == mlsnetread ) or
> > +	 ( t2 == unlabeled_t ));
> 
> Don't we want network_t instead of unlabeled_t?

Actually, the above only applies to the compat_net case
and there unlabeled_t is just fine.

So, there are different MLS constraints (and policy) for
the compat_net case as opposed to the new secmark controls.

I guess you are planning to have one policy for compat_net
and another for secmark?

> 
> > +mlsconstrain association { sendto }
> > +	(( l1 eq l2 ) and ( h1 eq h2 ));
> 
> or (t2 == network_t) ?

No. Not in the secmark case.

> 
> > +mlsconstrain association { polmatch }
> > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > +	 ( t2 == unlabeled_t ));
> 
> same thing about network_t

Actually, chuck the t2 == unlabeled_t exception all together.
It doesn't apply to the secmark policy.

> 
> > +constrain association sendto
> > +	( u1 == u2 and r1 == r2 and t1 == t2 );
> 
> I talked with Joshua and we determined that there is a case were we
> don't want this constraint (looking forward to policy management
> server's use of labeled networking), so I've dropped it.

The above constraint is necessary for the kernel portions of SELinux
to work properly. In fact I was going to originally implement it in the
kernel and when Darrel made me aware of the constraint framework and the
benefits with avc caching, etc., I decided to use it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
