Subject: Re: [RFC PATCH v8 18/18] SELinux: Add network ingress and egress
	control permission checks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com,
        Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <200712180859.34571.paul.moore@hp.com>
References: <20071214213548.10069.59135.stgit@flek.lan>
	 <200712161147.55119.paul.moore@hp.com>
	 <1197921937.17307.114.camel@moss-spartans.epoch.ncsc.mil>
	 <200712180859.34571.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 10:14:41 -0500
Message-Id: <1197990881.7967.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-18 at 08:59 -0500, Paul Moore wrote:
> On Monday 17 December 2007 3:05:37 pm Stephen Smalley wrote:
> > On Sun, 2007-12-16 at 11:47 -0500, Paul Moore wrote:
> > > We should probably have different permissions for the interface and node
> > > cases.  Take the example of an admin who is only interested in enforcing
> > > interface controls and not node controls.  They would most likely write
> > > the following policy rule to nullify the node check ...
> > >
> > >  allow unlabeled_t peer_t:peer egress;
> > >
> > > ... which would end up applying to both the interface and node checks
> > > because they use the same permission.  I'm thinking we should split the
> > > permissions like this:
> > >
> > >  allow netif_t peer_t:peer if_egress;
> > >  allow netnode_t peer_t: peer node_egress;
> > >
> > > ... and do something similar for the ingress side.  Thoughts?
> >
> > That starts to sound a lot like using netif and node classes instead of
> > the peer class.
> > 	allow peer_t netif_t:netif egress;
> > 	allow peer_t netnode_t:node egress;
> 
> Thinking about this some more ... egress/ingress make sense from an interface 
> point of view but they sound out of place from a node point of view.  After 
> all, you are not "egressing" to a node, to are "sending to" a node.  The same 
> thing applies in the opposite direction, you don't "ingress" from a node, 
> you "receive from" a node.  With that in mind I'm thinking of going with the 
> following:
> 
>  allow netif_t peer_t:peer { ingress egress };
>  allow netnode_t peer_t:peer { recv_from send_to };

nit:  recvfrom and sendto don't really require an underscore to be
readable, and we've already set a precedent for them in the socket and
association classes.

> Thoughts?  Should I just forget all this and use the peer label as a subject 
> label?

I'm not certain what we gain by using the peer as the object and class
in these checks, and it seems to make their meaning less clear.  It
should be noted that we already use process labels as both subjects
(when the actor) and objects (when the target/recipient of an action, as
in signal delivery or IPC), and that process labels "flow" to sockets
they create and socket labels "flow" to packets they send, and socket
labels likewise serve dual roles as subjects (Can this socket send/recv
this packet?) and objects (Can this process send/recv on this socket?). 

In the case of locally generated or destined traffic, we always have a
local socket that we can use as the subject of the check, which I think
is why we end up not using packet/peer as the subject generally - we
essentially have two subjects to choose from, and we favor the local
one.  But in the forwarded case, the packet/peer is the only
subject/actor in view really.

OTOH, I'm not sure your original concern about unlabeled_t is
well-founded now that I think about it; the netif and node type space is
disjoint and they default to discrete initial SIDs and types (netif_t,
node_t), not to unlabeled_t, right?  So the types themselves encode the
class there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
