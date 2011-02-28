Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1S9AAHi003299
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 04:10:13 -0500
Received: from a.mx.secunet.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1S9ACEQ010233
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 09:10:12 GMT
Date: Mon, 28 Feb 2011 10:10:10 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Moore <paul.moore@hp.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 07/10] selinux: Check receiving against sending
 interface on packet forwarding
Message-ID: <20110228091010.GC26510@secunet.com>
References: <20110214131651.GA15640@secunet.com>
 <1297888360.25079.35.camel@sifl>
 <20110222130409.GD20852@secunet.com>
 <201102231635.00378.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102231635.00378.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 23, 2011 at 04:34:59PM -0500, Paul Moore wrote:
> 
> > Now __xfrm_route_forward() decodes the sid of the flow with
> > selinux_xfrm_decode_session(). This packet has neither a secpath nor socket
> > conext. So the sid of the flow is decoded to SECSID_NULL.
> 
> I suppose we probably should set the flow's label in this case to 
> SECINITSID_UNLABELED instead of SECSID_NULL, that would be more consistent ... 
> although we would probably need to make sure we don't break anything in 
> selinux_xfrm_state_pol_flow_match().

I think using SECINITSID_UNLABELED instead of SECSID_NULL would break the
netlabel fallback labeling. security_net_peersid_resolve() requires
SECSID_NULL on unlabeled packets.

> 
> I think the problem is that you believe the network interface's label becomes 
> the peer label of unlabeled packets, that is not the case.  If you want to 
> provide a network peer label to unlabeled packets you need to use NetLabel's 
> fallback labeling mechanism which applies peer labels to what would otherwise 
> be unlabeled packets (see an example at the link below).

Ok, I've missed the possibility to relabel unlabeled packets with netlabel.
Knowing about this possibility makes many things clear, thanks for pointing
to it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
