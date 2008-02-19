Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1JI9cwJ011840
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 13:09:38 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1JI9bsW000266
	for <selinux@tycho.nsa.gov>; Tue, 19 Feb 2008 18:09:37 GMT
Subject: Re: [PATCH 4/4] REFPOL: Add new labeled networking permissions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200802191212.45302.paul.moore@hp.com>
References: <20080208212534.491651808@hp.com>
	 <200802132254.14625.paul.moore@hp.com> <1202999824.30706.34.camel@gorn>
	 <200802191212.45302.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 13:07:15 -0500
Message-Id: <1203444435.13618.94.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-19 at 12:12 -0500, Paul Moore wrote:
> On Thursday 14 February 2008 9:36:59 am Christopher J. PeBenito wrote:
> > On Wed, 2008-02-13 at 22:54 -0500, Paul Moore wrote:
> > > On Tuesday 12 February 2008 9:39:59 am Christopher J. PeBenito 
> wrote:
> > > > On Fri, 2008-02-08 at 16:25 -0500, paul.moore@hp.com wrote:
> > > > > plain text document attachment (refpol-peer_perms)
> > > > > The 2.6.25 kernel will introduce a new set of labeled
> > > > > networking controls to SELinux and this patch makes the
> > > > > necessary changes to the Reference Policy to support unlabeled
> > > > > network traffic with the new controls.
[...]
> > > > I'm not so sure about the kernel interface changes.  The docs
> > > > probably should be revised, its more about using sockets whose
> > > > types have been invalidated.  It doesn't have anything to do with
> > > > unlabeled networking.
> > >
> > > Hmmm, okay.  Do you have a suggestion for how to add these new
> > > allow rules?  A new interface?  I would need to go check again, but
> > > these seemed to be the most logical of the existing interfaces when
> > > I made the change (and I suspect not much has changed in this
> > > area).
> >
> > I'm thinking along the lines of new interfaces like
> > kernel_recvfrom_unlabeled_peer().
> 
> Before I go ahead an make all of the changes to the other modules, are 
> the two interfaces below what you had in mind?

Yes.

> **** from kernel.if
> ########################################
> ## <summary>
> ##	Receive packets from an unlabeled peer.
> ## </summary>
> ## <desc>
> ##	<p>
> ##	Receive packets from an unlabeled peer,
> ##      these packets do not have any peer labeling
> ##      information present.
> ##	</p>
> ##	<p>
> ##	The corenetwork interface
> ##	corenet_recvfrom_unlabeled_peer() should
> ##	be used instead of this one.
> ##	</p>
> ## </desc>
> ## <param name="domain">
> ##	<summary>
> ##	Domain allowed access.
> ##	</summary>
> ## </param>
> #
> interface(`kernel_recvfrom_unlabeled_peer',`
> 	gen_require(`
> 		type unlabeled_t;
> 	')
> 
> 	allow $1 unlabeled_t:peer recv;
> ')
> 
> **** from corenetwork.if.in
> ########################################
> ## <summary>
> ##	Receive packets from an unlabeled peer.
> ## </summary>
> ## <desc>
> ##	<p>
> ##	Receive packets from an unlabeled peer,
> ##      these packets do not have any peer labeling
> ##      information present.
> ##	</p>
> ## </desc>
> ## <param name="domain">
> ##	<summary>
> ##	Domain allowed access.
> ##	</summary>
> ## </param>
> #
> interface(`corenet_recvfrom_unlabeled_peer',`
> 	kernel_recvfrom_unlabeled_peer($1)
> ')
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
