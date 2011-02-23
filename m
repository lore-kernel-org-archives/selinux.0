Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1NLk0iM006775
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 16:46:00 -0500
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1NLjxqa008459
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 21:46:00 GMT
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 08/10] selinux: Fix handling of kernel generated packets on labeled IPsec
Date: Wed, 23 Feb 2011 16:45:57 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <20110214131651.GA15640@secunet.com> <1297889847.25079.44.camel@sifl> <20110222133150.GE20852@secunet.com>
In-Reply-To: <20110222133150.GE20852@secunet.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102231645.58047.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, February 22, 2011 8:31:50 AM Steffen Klassert wrote:
> On Wed, Feb 16, 2011 at 03:57:27PM -0500, Paul Moore wrote:
> > On Mon, 2011-02-14 at 14:21 +0100, Steffen Klassert wrote:
> > > As it is, we require the security context of a labeled SA to be the
> > > same as the security context of the originating flow. On a nontrivial
> > > selinux policy the security context of the flow of kernel generated
> > > packets, like echo reply packets, are usually not equal to the
> > > security context of the labeled SA. So it is not possible to send
> > > such packets in this case. The fact that the security context of a
> > > labeled SA must be the same as the security context of the originating
> > > flow can also lead to problems if an outgoing SA is used for packet
> > > forwarding and for locally generated traffic.
> > > 
> > > This patch fixes this by removing this equality check. Instead we
> > > ask the access vector cache if the security context of the SA is
> > > compatible to the security context of the IPsec policy. This
> > > partially reverts commit 67f83cbf081a70426ff667e8d14f94e13ed3bdca
> > > 
> > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > 
> > I think understand the problem you're running up against, and if I'm
> > understanding it correctly it is an inherent problem with the labeled
> > IPsec design - not something that we can fix.
> 
> Hm, I think we need to get this to work. Echo reply packets are just
> one thing. Also other icmp messages can't be send. For example path mtu
> discovery can't work with labeled IPsec. And have you tried to use
> labeled IPsec on IPv6 networks? Kernel generated icmp messages are
> quite important here.

Yes, several years ago I worked on the IPsec stack for a commercial UNIX OS 
and we had to basically allow all IPv6/ICMP in the SPD so that router/neighbor 
discovery would work correctly.  I believe that the specifications have now 
evolved to allow type/code which would make this a bit easier now.

Why not just create a SPD rule that would send these ICMP packets over a 
traditional, unlabeled SA?  Am I missing something that would require them to 
be sent over a labeled SA?

> > The core issue is that with labeled IPsec the packets themselves are not
> > labeled, the SAs are labeled instead.  This means that in order to
> > accurately convey peer labels over the network you need to ensure that
> > the flow's label matches the SA label; this is why there is a direct SID
> > to SID comparison in the code.  Failing to match a flow to the
> > associated SA will result in data being mis/relabeled which is a big
> > no-no.
> 
> I still don't understand why this is necessary, would'nt it be also
> ok to enforce this with a policy rule? I have to think a bit longer
> about that...

Think about it some more and let me know if you are still having problems.

It is absolutely critical that the SA's label matches the peer's label 
_exactly_.  Once you understand how labeled IPsec conveys peer labels across 
the network, you will understand why this is so important.

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
