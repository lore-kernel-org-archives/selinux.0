Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07CoNKp031614
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 07:50:23 -0500
Received: from g5t0009.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07CoMWT010691
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:50:22 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH] SELinux: Add network ingress and egress control permission checks
Date: Mon, 7 Jan 2008 07:50:10 -0500
Cc: selinux@tycho.nsa.gov
References: <20080105002920.28482.29256.stgit@flek.americas.hpqcorp.net> <20080105003456.28482.59925.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0801070922120.21625@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0801070922120.21625@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801070750.10686.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 06 January 2008 5:22:25 pm James Morris wrote:
> On Fri, 4 Jan 2008, Paul Moore wrote:
> > This patch implements packet ingress/egress controls for SELinux which
> > allow SELinux security policy to control the flow of all IPv4 and IPv6
> > packets into and out of the system.  Currently SELinux does not have
> > proper control over forwarded packets and this patch corrects this
> > problem.
> >
> > Special thanks to Venkat Yekkirala <vyekkirala@trustedcs.com> whose
> > earlier work on this topic eventually led to this patch.
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> Please send this to netdev for review.

I'll take care of that this morning.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
