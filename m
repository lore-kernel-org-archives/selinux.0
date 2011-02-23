Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1NLZ4ni006162
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 16:35:04 -0500
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1NLZ3qa006709
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 21:35:04 GMT
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 07/10] selinux: Check receiving against sending interface on packet forwarding
Date: Wed, 23 Feb 2011 16:34:59 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <20110214131651.GA15640@secunet.com> <1297888360.25079.35.camel@sifl> <20110222130409.GD20852@secunet.com>
In-Reply-To: <20110222130409.GD20852@secunet.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102231635.00378.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, February 22, 2011 8:04:09 AM Steffen Klassert wrote:
> On Wed, Feb 16, 2011 at 03:32:40PM -0500, Paul Moore wrote:
> > On Mon, 2011-02-14 at 14:21 +0100, Steffen Klassert wrote:
> > > As it is, it is not possible to check in the forwarding and
> > > the postrouting hook whether a packet that is received via some
> > > network interface is allowed to be forwarded via some other network
> > > interface. With this patch we decode the security identifier on
> > > selinux_xfrm_decode_session to the sid of the incoming interface,
> > > if we have neither a secpath nor socket context, so this check is
> > > possible now. Also set the sid to SECINITSID_KERNEL if we have none
> > > of secpath, socket context and incoming interface as the packet
> > > must be kernel generated in this case.
> > > 
> > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > 
> > If you want to control which interface is allowed to forward to which
> > other interface, you should use good ol' iptables, not SELinux.
> 
> Well, I think the problem is that we can't use labled SA's on
> packet forwarding.
> 
> Consider the following: As it is, the sid of the labeled SA and the sid of
> the flow must be identical. Say we receive a plain IP packet that should be
> forwarded ...

For this argument I'm assuming "plain IP packet" == "IP packet without a peer 
label associated with it".

> ... IPsec transformed with a labeled SA.

Okay, I think that is our disconnect right there.  You are trying to send an 
unlabeled packet (peer label set to "unlabeled_t") over a labeled SA (peer 
label set to "foo_t") without any explicit relabel operation by the 
administrator.  This is a Very Bad Thing.

> Now __xfrm_route_forward() decodes the sid of the flow with
> selinux_xfrm_decode_session(). This packet has neither a secpath nor socket
> conext. So the sid of the flow is decoded to SECSID_NULL.

I suppose we probably should set the flow's label in this case to 
SECINITSID_UNLABELED instead of SECSID_NULL, that would be more consistent ... 
although we would probably need to make sure we don't break anything in 
selinux_xfrm_state_pol_flow_match().

> Then selinux_xfrm_state_pol_flow_match() enforces the sid of SA and flow to
> be identical. This in turn means, that the label of the SA must be
> SECSID_NULL.

Which makes sense to me.  If you are forwarding unlabeled packets across an 
IPsec gateway, the IPsec gateway should establish SAs which are also 
unlabeled.

> So I think we have to chane something if we want to use labeled SAs on
> packet forwarding, or do I miss something here?

I think so, look below.

> With this patch we would decode the sid of the flow to the sid of the
> receiving interface, so the used SA could have the same sid as the
> receiving interface.

I think the problem is that you believe the network interface's label becomes 
the peer label of unlabeled packets, that is not the case.  If you want to 
provide a network peer label to unlabeled packets you need to use NetLabel's 
fallback labeling mechanism which applies peer labels to what would otherwise 
be unlabeled packets (see an example at the link below).

I haven't (or can't remember) testing this in the case of labeled IPsec 
gateway connected to unlabeled, single label networks but I have tested it 
against a CIPSO gateway connected to unlabeled, single label networks.  If it 
doesn't work for you in the labeled IPsec case, this would be a bug and 
something we would need to address.

* http://paulmoore.livejournal.com/1758.html

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
