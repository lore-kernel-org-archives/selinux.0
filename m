Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBCK8X7M020924
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 15:08:33 -0500
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBCK8WfM016708
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2007 20:08:32 GMT
From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: Network flow controls and subj/obj ordering
Date: Wed, 12 Dec 2007 15:08:26 -0500
Cc: selinux@tycho.nsa.gov
References: <203434.50468.qm@web36609.mail.mud.yahoo.com>
In-Reply-To: <203434.50468.qm@web36609.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712121508.27011.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 11 December 2007 12:51:18 pm Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> > Hello everybody,
> >
> > After a discussion with Venkat last week we decided that it was
> > probably best if I took responsibility for the flow control patches
> > and ported/cleaned them up for inclusion in the labeled networking
> > patches for 2.6.25.  In the course of doing so I ran across the
> > problem of subject/object "ordering" (probably not the best term,
> > but it's all I can think of right now).  In both the "flow in"
> > and "flow out" cases I'm tempted to use the packet's peer label as
> > the object just for the sake of consistency and the ability to use
> > the new "peer" object class for all network peer label access
> > checks.  However, I wanted to make sure that is what everyone had in
> > mind from a conceptual point of view.
> >
> > See the two simple policy examples below:
> >
> >  * Packet "flows" into the system, peer label is the object
> >
> >    allow netif_t peerlbl_t:peer flow_in;
> >
> >  * Packet "flows" out of the system, peer label is the object
> >
> >    allow netif_t peerlbl_t:peer flow_out;
> >
> > Thoughts, opinions?
>
> Networking policy is always fun to debate. I've gotten it wrong
> so many times I've lost count. Let's see if I can add anything of
> value.

[Sorry for the delay, I was distracted yesterday]

Yes indeed, hence the reason for my mail.  I'm trying to get it "right" 
this time around ... probably a bit naive, but I'm crazy like that.

> A packet appears out of the ether and is attached to a flow. If the
> packet is a labeled object and the flow is a labeled object, what
> is the subject? If the packet moves on out of the system (it is
> being forwarded) and the packet is a labeled object, what is the
> subject? Do you even have a subject/object relationship in this case?
> I think that if you can identify the subject involved in flow
> processing the policy implications ought to be pretty clear. If
> you don't, and you have nothing but objects to deal with, it gets
> painfully difficult to produce a security model that can be described
> using traditional methods.

Unfortunately we are talking about two different things here (although 
your argument above sorta fits in a strange way).  I'm talking about 
the "flow control" patches that Venkat posted back in September and it 
looks like you are talking about access controls involving the kernel 
flow constructs.  Somewhat related, but two different things.

We should probably pick a better name that "flow control" as it has a 
tendency to get associated with the kernel flow construct and the two 
are different.  I'm thinking of "packet ingress/egress controls" so 
unless anyone has any better ideas I'm gonna go with that for now ...

Your post was an interesting read that I think summed up a lot of the 
discussions around labeled network access controls that we have had on 
the list but I'm going to trim it from this reply to help eliminate 
the "flow" confusion from the rest of the thread.  However, I would 
like to keep discussion the subj/obj issues you talked about as that is 
the reason for my original email.

Currently the SELinux network access controls treats packets as objects 
and I'm in no hurry to change that unless there is a real compelling 
reason.  Keeping that in mind, there is a desire to add packet ingress 
and egress access controls and I'm trying to determine how we want to 
define these two new controls.  The packet ingress control will be 
placed such that _all_ IP traffic entering the system, regardless of 
the destination (local or remote), will be subject to the access check.  
In a similar manner, the packet egress control will be placed such that 
_all_ IP traffic exiting the system, regardless of the source (local or 
remote), will be subject to the access check.  In both cases, there is 
a user desire to have checks between the network interface (netif_t) 
and the packet's peer label (peer_t) as well as between the source 
address (netnode_t) and the packet's peer label (peer_t).

With all this in mind I'm currently leaning towards the following:

 * packet ingress (inbound)

   allow netif_t peer_t:peer ingress;
   allow netnode_t peer_t:peer ingress;

 * packet egress (outbound)

   allow netif_t peer_t:peer egress;
   allow netnode_t peer_t:peer egress;

You'll notice in both cases this continues the packet-as-an-object 
tradition while treating both the network interfaces and nodes as 
subjects.  This seems reasonable to me, but I could be convinced to go 
the other way if that is what everyone else thinks is best (I really 
like the idea of getting all the labeled networking access controls to 
use the "peer" object class).

With (hopefully) a better explanation this time, do you have any further 
thoughts/comments?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
