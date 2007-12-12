Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBCKILW3022213
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 15:18:21 -0500
Received: from g5t0007.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBCKIKjW020864
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 20:18:20 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Network flow controls and subj/obj ordering
Date: Wed, 12 Dec 2007 15:18:15 -0500
Cc: selinux@tycho.nsa.gov
References: <200712111202.20074.paul.moore@hp.com> <1197404602.12626.185.camel@gorn>
In-Reply-To: <1197404602.12626.185.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712121518.15454.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 11 December 2007 3:23:22 pm Christopher J. PeBenito wrote:
> On Tue, 2007-12-11 at 12:02 -0500, Paul Moore wrote:
> > After a discussion with Venkat last week we decided that it was
> > probably best if I took responsibility for the flow control patches
> > and ported/cleaned them up for inclusion in the labeled networking
> > patches for 2.6.25.  In the course of doing so I ran across the
> > problem of subject/object "ordering" (probably not the best term,
> > but it's all I can think of right now).  In both the "flow in" and
> > "flow out" cases I'm tempted to use the packet's peer label as the
> > object just for the sake of consistency and the ability to use the
> > new "peer" object class for all network peer label access checks. 
> > However, I wanted to make sure that is what everyone had in mind
> > from a conceptual point of view. See the two simple policy examples
> > below:
> >
> >  * Packet "flows" into the system, peer label is the object
> >
> >    allow netif_t peerlbl_t:peer flow_in;
> >
> >  * Packet "flows" out of the system, peer label is the object
> >
> >    allow netif_t peerlbl_t:peer flow_out;
>
> Can you give an example for the forwarding case?  Also, how about in
> the non-labeled networking case?

Sorry, I wasn't trying to get into a detailed discussion about the 
policy involved in all this, but I understand it's probably necessary 
to get your head around it so I'll give it a shot.  If you haven't yet, 
go read my reply to Casey first as I'll build upon that here ...

First off, these access checks would only become active if labeled 
networking was "enabled".  This means that either labeled IPsec or 
NetLabel has some configuration loaded.  For labeled IPsec this means 
an entry was created in the SPD or SAD with a SELinux context assigned 
to it.  For NetLabel this means a CIPSO DOI configuration was loaded 
into the kernel.  If labeled networking is not "enabled" then these 
access checks will never happen; this was done to help reduce the 
impact of the network access controls on the common case.

Assuming labeled networking is enabled, a forwarded packet would hit 
four checks:

 # inbound checks
 allow netif_t peer_t:peer ingress;
 allow netnode_t peer_t:peer ingress;
 # outbound checks
 allow netif_t peer_t:peer egress;
 allow netnode_t peer_t:peer egress;

Does this help?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
