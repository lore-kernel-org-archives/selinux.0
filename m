Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2KF8Zft015262
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2008 11:08:36 -0400
Received: from g5t0007.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2KF8WO6004554
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2008 15:08:32 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 1/5] REFPOL: Add new labeled networking permissions
Date: Thu, 20 Mar 2008 11:08:29 -0400
Cc: selinux@tycho.nsa.gov
References: <20080226184032.834798290@hp.com> <200803191424.16724.paul.moore@hp.com> <1206017456.16113.86.camel@gorn>
In-Reply-To: <1206017456.16113.86.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803201108.29948.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 20 March 2008 8:50:56 am Christopher J. PeBenito wrote:
> On Wed, 2008-03-19 at 14:24 -0400, Paul Moore wrote:
> > On Wednesday 19 March 2008 9:19:53 am Christopher J. PeBenito wrote:
> > > > refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
> > > > +++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
> > > > @@ -2380,6 +2392,27 @@ interface(`corenet_sendrecv_unlabeled_pa
> > > >
> > > >  ########################################
> > > >  ## <summary>
> > > > +##	Receive packets from an unlabeled peer.
> > > > +## </summary>
> > > > +## <desc>
> > > > +##	<p>
> > > > +##	Receive packets from an unlabeled peer,
> > > > +##      these packets do not have any peer labeling
> > > > +##      information present.
> > > > +##	</p>
> > > > +## </desc>
> > > > +## <param name="domain">
> > > > +##	<summary>
> > > > +##	Domain allowed access.
> > > > +##	</summary>
> > > > +## </param>
> > > > +#
> > > > +interface(`corenet_recvfrom_unlabeled_peer',`
> > > > +	kernel_recvfrom_unlabeled_peer($1)
> > > > +')
> > >
> > > Seems unnecessary since it seems like it should be called from
> > > corenet_(tcp|udp|raw)_recvfrom_unlabeled?
> >
> > Okay, would you prefer to add kernel_recvfrom_unlabeled_peer() to
> > corenet_{tcp,udp,raw}_recvfrom_unlabeled() or simply add the new
> > allow rule to kernel_{tcp,udp,raw}_recvfrom_unlabeled()?
>
> The latter seems the best choice.

Okey dokey, I'm kinda swamped right now but I'll get an updated 
patch[set] out next week.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
