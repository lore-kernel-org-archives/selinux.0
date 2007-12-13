Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBDECbZe017532
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 09:12:37 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lBDECZ1s029122
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 14:12:35 GMT
Subject: Re: Network flow controls and subj/obj ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200712121518.15454.paul.moore@hp.com>
References: <200712111202.20074.paul.moore@hp.com>
	 <1197404602.12626.185.camel@gorn>  <200712121518.15454.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 13 Dec 2007 09:12:08 -0500
Message-Id: <1197555128.12626.205.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-12 at 15:18 -0500, Paul Moore wrote:
> On Tuesday 11 December 2007 3:23:22 pm Christopher J. PeBenito wrote:
> > On Tue, 2007-12-11 at 12:02 -0500, Paul Moore wrote:
> > > After a discussion with Venkat last week we decided that it was
> > > probably best if I took responsibility for the flow control patches
> > > and ported/cleaned them up for inclusion in the labeled networking
> > > patches for 2.6.25.  In the course of doing so I ran across the
> > > problem of subject/object "ordering" (probably not the best term,
> > > but it's all I can think of right now).  In both the "flow in" and
> > > "flow out" cases I'm tempted to use the packet's peer label as the
> > > object just for the sake of consistency and the ability to use the
> > > new "peer" object class for all network peer label access checks. 
> > > However, I wanted to make sure that is what everyone had in mind
> > > from a conceptual point of view. See the two simple policy examples
> > > below:
> > >
> > >  * Packet "flows" into the system, peer label is the object
> > >
> > >    allow netif_t peerlbl_t:peer flow_in;
> > >
> > >  * Packet "flows" out of the system, peer label is the object
> > >
> > >    allow netif_t peerlbl_t:peer flow_out;
> >
> > Can you give an example for the forwarding case?  Also, how about in
> > the non-labeled networking case?
> 
> Sorry, I wasn't trying to get into a detailed discussion about the 
> policy involved in all this, but I understand it's probably necessary 
> to get your head around it so I'll give it a shot.  If you haven't yet, 
> go read my reply to Casey first as I'll build upon that here ...

Sure; I find it useful to see the checks in the context of the whole
operation.

> First off, these access checks would only become active if labeled 
> networking was "enabled".  This means that either labeled IPsec or 
> NetLabel has some configuration loaded.  For labeled IPsec this means 
> an entry was created in the SPD or SAD with a SELinux context assigned 
> to it.  For NetLabel this means a CIPSO DOI configuration was loaded 
> into the kernel.  If labeled networking is not "enabled" then these 
> access checks will never happen; this was done to help reduce the 
> impact of the network access controls on the common case.
> 
> Assuming labeled networking is enabled, a forwarded packet would hit 
> four checks:
> 
>  # inbound checks
>  allow netif_t peer_t:peer ingress;
>  allow netnode_t peer_t:peer ingress;
>  # outbound checks
>  allow netif_t peer_t:peer egress;
>  allow netnode_t peer_t:peer egress;

This helps.  But this seems to be for the old networking, how does it
work with the secmark stuff?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
