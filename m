Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2JIwNp7014072
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 14:58:24 -0400
Received: from g4t0016.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2JIwMXR003266
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 18:58:23 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 1/5] REFPOL: Add new labeled networking permissions
Date: Wed, 19 Mar 2008 14:24:16 -0400
Cc: selinux@tycho.nsa.gov
References: <20080226184032.834798290@hp.com> <20080226184404.862575664@hp.com> <1205932793.16113.42.camel@gorn>
In-Reply-To: <1205932793.16113.42.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803191424.16724.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 19 March 2008 9:19:53 am Christopher J. PeBenito wrote:
> On Tue, 2008-02-26 at 13:40 -0500, paul.moore@hp.com wrote:
> > The 2.6.25 kernel will introduce a new set of labeled networking
> > controls to SELinux and this patch makes the necessary changes to
> > the Reference Policy to support unlabeled network traffic with the
> > new controls.
> >
> > A description of the new/improved labeled networking controls was
> > posted to the SELinux list back in early January 2008.
> >
> >  * http://marc.info/?l=selinux&m=119991234501200&w=2
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > ---
> >  policy/modules/kernel/corenetwork.if.in |   69
> > +++++++++++++++++++++++---------
>
> Is there a reason why you skipped adding ingress/egress to the "all"
> interfaces (e.g. corenet_udp_receive_all_if)?

Nope, or at least not one that I can remember right now.  I just went 
through and added ingress/egress to the netif permissions as well as 
sendto/recvfrom to the node permissions.  Thanks.

> > --- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
> > +++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
> > @@ -2380,6 +2392,27 @@ interface(`corenet_sendrecv_unlabeled_pa
> >
> >  ########################################
> >  ## <summary>
> > +##	Receive packets from an unlabeled peer.
> > +## </summary>
> > +## <desc>
> > +##	<p>
> > +##	Receive packets from an unlabeled peer,
> > +##      these packets do not have any peer labeling
> > +##      information present.
> > +##	</p>
> > +## </desc>
> > +## <param name="domain">
> > +##	<summary>
> > +##	Domain allowed access.
> > +##	</summary>
> > +## </param>
> > +#
> > +interface(`corenet_recvfrom_unlabeled_peer',`
> > +	kernel_recvfrom_unlabeled_peer($1)
> > +')
>
> Seems unnecessary since it seems like it should be called from
> corenet_(tcp|udp|raw)_recvfrom_unlabeled?

Okay, would you prefer to add kernel_recvfrom_unlabeled_peer() to 
corenet_{tcp,udp,raw}_recvfrom_unlabeled() or simply add the new allow 
rule to kernel_{tcp,udp,raw}_recvfrom_unlabeled()?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
