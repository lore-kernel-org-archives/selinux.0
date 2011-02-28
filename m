Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1S8pXJA001639
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 03:51:33 -0500
Received: from a.mx.secunet.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1S8pVT5004358
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 08:51:32 GMT
Date: Mon, 28 Feb 2011 09:51:29 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Moore <paul.moore@hp.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 05/10] selinux: selinux_xfrm_decode_session check for
 socket sid
Message-ID: <20110228085129.GB26510@secunet.com>
References: <20110214131651.GA15640@secunet.com>
 <1297887085.25079.24.camel@sifl>
 <20110222121143.GC20852@secunet.com>
 <201102231616.39183.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102231616.39183.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 23, 2011 at 04:16:38PM -0500, Paul Moore wrote:
> > 
> > No, we don't have a secpath for outbound packets. The secpath is used to
> > do a inbound policy check, check the used SA against their selectors etc.
> > With these checks we ensure that the packet is transformed back to it's
> > native form in the right way. That's not needed on outbound packets,
> > so we don't record a secpath in this case. The lack of a outbound
> > secpath was also the problem I mentioned in the introduction mail
> > of the patchset.
> 
> Be warned: most of this reply is just me tossing out ideas ...
> 
> Okay, so basically selinux_xfrm_decode_session() is a total waste of time in 
> the output path, yes?  

Right.

> > 
> > I think that's not possible too. The security_xfrm_decode_session()
> > hook is used from within xfrm_decode_session(). This function
> > is used in codepaths that are used for both, inbound and outbound
> > processing (xfrm_lookup, xfrm_policy_check etc.).
> 
> This makes me wonder if the LSM hook is even in the right place.
> 

As security_xfrm_decode_session() should add the sid of the originating
flow, I think it was was quite reasonable to place it to the function
that constructs the flow. 

> 
> I _really_ think we need to split the inbound and outbound handling for xfrm.  
> I suppose we can always fall back to selecting the right path based on the 
> presence of a sec_path pointer, but I would rather see us get rid of an 
> unnecessary conditional.

This would require some structural changes in the core IPsec code too.
At first glance I don't see a good way to do this. Any suggestions?

> 
> The inbound handling can stick with the logic in selinux_xfrm_decode_session() 
> but the outbound handling should follow similar logic to how we determine the 
> network peer label in selinux_ip_postroute().
> 
>  1. If we have a valid sk_security_stuct, use it.
>  2. If we are forwarding the packet, call selinux_skb_peerlbl_sid().
>  3. If all else fails, use SECINITSID_KERNEL.
> 

Sounds reasonable for outbound packets. But we have to be carefull
on packet forwarding. selinux_skb_peerlbl_sid() gets the xfrm sid
from selinux_xfrm_decode_session(). So if we receive a IPsec transformed
packet and forward it, transformed back, we have a valid secpath and we
use the sid of the SA as the peer label. If we receive a plain IP packet
and forward it, IPsec transformed, we have no secpath. So we would stick
with SECSID_NULL, even though it might be transformed with a labeled SA.
I think the sid of the SA should be used as the peer label in this case
too.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
