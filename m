Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81Ec9kp009914
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 10:38:09 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81EbmrI005801
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 14:37:49 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k81Ec7St007441
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 10:38:07 -0400 (EDT)
Message-ID: <36282A1733C57546BE392885C061859201512D15@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: FW: [serue@us.ibm.com: Re: [redhat-lspp] LSPP Development Telecon
	 08/21/2006 Minutes]
Date: Fri, 1 Sep 2006 10:37:54 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI-

-----Original Message-----
From: Serge E. Hallyn [mailto:serue@us.ibm.com]
Sent: Thursday, August 31, 2006 9:11 AM
To: Venkat Yekkirala
Cc: Serge E. Hallyn; Chad Hanson; Trent Jaeger; Joy Latten; George
Wilson
Subject: Re: [serue@us.ibm.com: Re: [redhat-lspp] LSPP Development
Telecon 08/21/2006 Minutes]


It started by us looking at what cipso provides.  My idea was that
algorithm would identify the LSM, and doi would identify some policy
domain.  I.e. you could clearly separate hosts within a network based
on policy properties by using distinct doi's.

Whether that's useful or not is pretty much up to you guys, who actually
use this stuff :)  If it's not going to be useful, I'm not sure it's too
late to rip it out and save a few bytes on the network.

-serge

Quoting Venkat Yekkirala (vyekkirala@TrustedCS.com):
> In resolving the immediate bug at hand this patch seems reasonable.
> 
> However I never quite understood the full purport/use of ctx_doi (what
> they were envisioning), so it would be great if someone (who put
> it in there in the first place I guess) could explain it for our benefit.
> Thanks.
> 
> > -----Original Message-----
> > From: Serge E. Hallyn [mailto:serue@us.ibm.com]
> > Sent: Thursday, August 31, 2006 8:07 AM
> > To: Venkat Yekkirala
> > Subject: [serue@us.ibm.com: Re: [redhat-lspp] LSPP Development Telecon
> > 08/21/2006 Minutes]
> > 
> > 
> > Do you agree with this patch?  Should it be fwded to netdev?
> > 
> > thanks,
> > -serge
> > 
> > ----- Forwarded message from "Serge E. Hallyn" 
> > <serue@us.ibm.com> -----
> > 
> > Date: Tue, 29 Aug 2006 15:33:19 -0500
> > From: "Serge E. Hallyn" <serue@us.ibm.com>
> > To: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Paul Moore 
> > <paul.moore@hp.com>,
> > 	KaiGai Kohei <kaigai@kaigai.gr.jp>, redhat-lspp@redhat.com,
> > 	Venkat Yekkirala <vyekkirala@TrustedCS.com>,
> > 	Trent Jaeger <tjaeger@cse.psu.edu>,
> > 	Joy Latten <latten@austin.ibm.com>
> > Subject: Re: [redhat-lspp] LSPP Development Telecon 08/21/2006 Minutes
> > 
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > Venkat's mls xfrm patches (already in the net-2.6.19 tree) 
> > replace this
> > > BUG_ON with an if statement that returns -EINVAL, as this represents
> > > invalid data from userspace rather than a kernel bug.  so 
> > you'll need to
> > > re-base at least.
> > 
> > Ok, yeah, BUG_ON seemed unreasonable :)  Following patch is against
> > net-2.6.19.  Do we prefer to stop checking doi (as my previous spatch
> > did)?
> > 
> > thanks,
> > -serge
> > 
> > >From 0937ecab92f76f0f378b711abb6db34f7cb97f35 Mon Sep 17 
> > 00:00:00 2001
> > From: Serge E. Hallyn <serue@us.ibm.com>
> > Date: Tue, 29 Aug 2006 15:28:37 -0500
> > Subject: [PATCH 1/1] nethook: two trivial fixes
> > 
> > ctx_doi was being compared against XFRM_SC_ALG_SELINUX.  This 
> > is wrong.
> > Additionally, if we're going to use XFRM_SC_DOI_LSM as the "lsm doi",
> > then add a check for it.  A (likeable) alternative is to 
> > remove the check
> > for
> > 	(ctx->ctx_doi == XFRM_SC_DOI_LSM)
> > in selinux_authorizable_ctx().
> > 
> > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> > ---
> >  security/selinux/xfrm.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> > index 3e742b8..b071c0d 100644
> > --- a/security/selinux/xfrm.c
> > +++ b/security/selinux/xfrm.c
> > @@ -211,7 +211,9 @@ static int selinux_xfrm_sec_ctx_alloc(st
> >  	if (!uctx)
> >  		goto not_from_user;
> >  
> > -	if (uctx->ctx_doi != XFRM_SC_ALG_SELINUX)
> > +	if (uctx->ctx_doi != XFRM_SC_DOI_LSM)
> > +		return -EINVAL;
> > +	if (uctx->ctx_alg != XFRM_SC_ALG_SELINUX)
> >  		return -EINVAL;
> >  
> >  	if (uctx->ctx_len >= PAGE_SIZE)
> > -- 
> > 1.4.2
> > 
> > ----- End forwarded message -----
> > 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
