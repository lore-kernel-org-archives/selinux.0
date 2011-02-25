Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1PLLeR0032113
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 16:21:40 -0500
Received: from e39.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1PLLdkx012987
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 21:21:39 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1PL8wPh004078
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:08:58 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p1PLLc0v085578
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:21:38 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p1PLLcON018959
	for <selinux@tycho.nsa.gov>; Fri, 25 Feb 2011 14:21:38 -0700
Subject: Re: [PATCH 08/10] selinux: Fix handling of kernel generated
 packets on labeled IPsec
From: Joy Latten <latten@austin.ibm.com>
Reply-To: latten@austin.ibm.com
To: Paul Moore <paul.moore@hp.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <201102231645.58047.paul.moore@hp.com>
References: <20110214131651.GA15640@secunet.com>
	 <1297889847.25079.44.camel@sifl> <20110222133150.GE20852@secunet.com>
	 <201102231645.58047.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 25 Feb 2011 14:50:37 -0600
Message-Id: <1298667037.2715.221.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-02-23 at 16:45 -0500, Paul Moore wrote:
> On Tuesday, February 22, 2011 8:31:50 AM Steffen Klassert wrote:
> > On Wed, Feb 16, 2011 at 03:57:27PM -0500, Paul Moore wrote:
> > > On Mon, 2011-02-14 at 14:21 +0100, Steffen Klassert wrote:
> > > > As it is, we require the security context of a labeled SA to be the
> > > > same as the security context of the originating flow. On a nontrivial
> > > > selinux policy the security context of the flow of kernel generated
> > > > packets, like echo reply packets, are usually not equal to the
> > > > security context of the labeled SA. So it is not possible to send
> > > > such packets in this case. The fact that the security context of a
> > > > labeled SA must be the same as the security context of the originating
> > > > flow can also lead to problems if an outgoing SA is used for packet
> > > > forwarding and for locally generated traffic.

hmmm... i am thinking that if the security context of the flow does
not match the security context of the SA, then that means an SA pair
needs to have been negotiated for that outgoing pkt(s). Labeled ipsec
design calls for SApair-per-security-context for a traffic stream, 
thus there may be more than one SA-pair per traffic stream. As Paul
stated, this is inherent in design.

selinux_xfrm_policy_lookup does check that flow has permission to use
the spd entry. 

> > > > 
> > > > This patch fixes this by removing this equality check. Instead we
> > > > ask the access vector cache if the security context of the SA is
> > > > compatible to the security context of the IPsec policy. This
> > > > partially reverts commit 67f83cbf081a70426ff667e8d14f94e13ed3bdca
> > > > 
> > > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > > 
> > > I think understand the problem you're running up against, and if I'm
> > > understanding it correctly it is an inherent problem with the labeled
> > > IPsec design - not something that we can fix.
> > 
> > Hm, I think we need to get this to work. Echo reply packets are just
> > one thing. Also other icmp messages can't be send. For example path mtu
> > discovery can't work with labeled IPsec. And have you tried to use
> > labeled IPsec on IPv6 networks? Kernel generated icmp messages are
> > quite important here.
> 
> Yes, several years ago I worked on the IPsec stack for a commercial UNIX OS 
> and we had to basically allow all IPv6/ICMP in the SPD so that router/neighbor 
> discovery would work correctly.  I believe that the specifications have now 
> evolved to allow type/code which would make this a bit easier now.
> 
> Why not just create a SPD rule that would send these ICMP packets over a 
> traditional, unlabeled SA?  Am I missing something that would require them to 
> be sent over a labeled SA?
> 
> > > The core issue is that with labeled IPsec the packets themselves are not
> > > labeled, the SAs are labeled instead.  This means that in order to
> > > accurately convey peer labels over the network you need to ensure that
> > > the flow's label matches the SA label; this is why there is a direct SID
> > > to SID comparison in the code.  Failing to match a flow to the
> > > associated SA will result in data being mis/relabeled which is a big
> > > no-no.
> > 
> > I still don't understand why this is necessary, would'nt it be also
> > ok to enforce this with a policy rule? I have to think a bit longer
> > about that...
> 
> Think about it some more and let me know if you are still having problems.
> 
> It is absolutely critical that the SA's label matches the peer's label 
> _exactly_.  Once you understand how labeled IPsec conveys peer labels across 
> the network, you will understand why this is so important.
> 

I agree with Paul.

regards,
Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
