From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v8 18/18] SELinux: Add network ingress and egress control permission checks
Date: Tue, 18 Dec 2007 12:03:15 -0500
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20071214213548.10069.59135.stgit@flek.lan> <200712180859.34571.paul.moore@hp.com> <1197990881.7967.70.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197990881.7967.70.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712181203.16482.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 18 December 2007 10:14:41 am Stephen Smalley wrote:
> On Tue, 2007-12-18 at 08:59 -0500, Paul Moore wrote:
> > Thoughts?  Should I just forget all this and use the peer label as a
> > subject label?
>
> I'm not certain what we gain by using the peer as the object and class
> in these checks, and it seems to make their meaning less clear.  It
> should be noted that we already use process labels as both subjects
> (when the actor) and objects (when the target/recipient of an action, as
> in signal delivery or IPC), and that process labels "flow" to sockets
> they create and socket labels "flow" to packets they send, and socket
> labels likewise serve dual roles as subjects (Can this socket send/recv
> this packet?) and objects (Can this process send/recv on this socket?).
>
> In the case of locally generated or destined traffic, we always have a
> local socket that we can use as the subject of the check, which I think
> is why we end up not using packet/peer as the subject generally - we
> essentially have two subjects to choose from, and we favor the local
> one.  But in the forwarded case, the packet/peer is the only
> subject/actor in view really.

Yep, I think you are right and I'm just slow to realize it.  As pointed out 
earlier in the discussion, the awkwardness of using the packet's peer label 
as an object should have clued me into the fact that this was a bad idea.

So, my last question is what permissions do we want to use for the netif/node 
object classes?

 allow peer_t netif_t:netif { egress ingress };
 allow peer_t netnode_t:node { sendto/send recvfrom/recv };

What I'd like to avoid if possible is the protocol specific permissions we 
currently have for the netif and node object classes; it requires extra work 
in the kernel, it doesn't work at all for the forwarding case, and I have my 
doubts about the usefulness of the distinction.  I think the ingress/egress 
permissions still make sense when applied to the netif object class but it's 
a bit of a stretch when applied to the node object class.  I personally like 
the sendto/recvfrom permissions but if that is too much of a violation from 
existing precedence I imagine send/recv would work.

Thoughts?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
