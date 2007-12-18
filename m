From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v8 18/18] SELinux: Add network ingress and egress control permission checks
Date: Tue, 18 Dec 2007 08:59:33 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
References: <20071214213548.10069.59135.stgit@flek.lan> <200712161147.55119.paul.moore@hp.com> <1197921937.17307.114.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197921937.17307.114.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712180859.34571.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 17 December 2007 3:05:37 pm Stephen Smalley wrote:
> On Sun, 2007-12-16 at 11:47 -0500, Paul Moore wrote:
> > We should probably have different permissions for the interface and node
> > cases.  Take the example of an admin who is only interested in enforcing
> > interface controls and not node controls.  They would most likely write
> > the following policy rule to nullify the node check ...
> >
> >  allow unlabeled_t peer_t:peer egress;
> >
> > ... which would end up applying to both the interface and node checks
> > because they use the same permission.  I'm thinking we should split the
> > permissions like this:
> >
> >  allow netif_t peer_t:peer if_egress;
> >  allow netnode_t peer_t: peer node_egress;
> >
> > ... and do something similar for the ingress side.  Thoughts?
>
> That starts to sound a lot like using netif and node classes instead of
> the peer class.
> 	allow peer_t netif_t:netif egress;
> 	allow peer_t netnode_t:node egress;

Thinking about this some more ... egress/ingress make sense from an interface 
point of view but they sound out of place from a node point of view.  After 
all, you are not "egressing" to a node, to are "sending to" a node.  The same 
thing applies in the opposite direction, you don't "ingress" from a node, 
you "receive from" a node.  With that in mind I'm thinking of going with the 
following:

 allow netif_t peer_t:peer { ingress egress };
 allow netnode_t peer_t:peer { recv_from send_to };

Thoughts?  Should I just forget all this and use the peer label as a subject 
label?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
