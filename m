Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1NLGj0M005013
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 16:16:45 -0500
Received: from g1t0028.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1NLGiqa003391
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 21:16:44 GMT
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 05/10] selinux: selinux_xfrm_decode_session check for socket sid
Date: Wed, 23 Feb 2011 16:16:38 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <20110214131651.GA15640@secunet.com> <1297887085.25079.24.camel@sifl> <20110222121143.GC20852@secunet.com>
In-Reply-To: <20110222121143.GC20852@secunet.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102231616.39183.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, February 22, 2011 7:11:43 AM Steffen Klassert wrote:
> On Wed, Feb 16, 2011 at 03:11:25PM -0500, Paul Moore wrote:
> > On Mon, 2011-02-14 at 14:20 +0100, Steffen Klassert wrote:
> > > selinux_xfrm_decode_session is used to decode the security identifyer
> > > of the originating flow. So return the sid of the socket instead of
> > > SECSID_NULL, if we have socket context but no secpath. This is
> > > needed because ip_xfrm_me_harder (and selinux_xfrm_decode_session)
> > > is invoked on outbound packets and before the xfrm transformations,
> > > therefore we have no secpath and the sid of a labeled IPsec SA usually
> > > does not match SECSID_NULL.
> > > 
> > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > 
> > Granted, it has been some time since I've looked at the labeled IPsec
> > code in some detail so I might be a little off here, but is it possible
> > to move the xfrm_decode LSM hook to an area on the outbound processing
> > where we do have a valid secpath?
> 
> No, we don't have a secpath for outbound packets. The secpath is used to
> do a inbound policy check, check the used SA against their selectors etc.
> With these checks we ensure that the packet is transformed back to it's
> native form in the right way. That's not needed on outbound packets,
> so we don't record a secpath in this case. The lack of a outbound
> secpath was also the problem I mentioned in the introduction mail
> of the patchset.

Be warned: most of this reply is just me tossing out ideas ...

Okay, so basically selinux_xfrm_decode_session() is a total waste of time in 
the output path, yes?  I'm looking at the current code and it does nothing if 
the sec_path is NULL, so I'm wondering why we even keep it around for the 
outbound path.

> > If not, I'd rather see us split this
> > hook so that we preserve the existing xfrm_decode_session() hook for
> > input (I believe it is also used for input, yes?) and create a new hook
> > which only grabs the sksec's label on output (preferably named so that
> > it is clear this is the socket's label and not the SA's label).
> 
> I think that's not possible too. The security_xfrm_decode_session()
> hook is used from within xfrm_decode_session(). This function
> is used in codepaths that are used for both, inbound and outbound
> processing (xfrm_lookup, xfrm_policy_check etc.).

This makes me wonder if the LSM hook is even in the right place.

> The xfrm_decode_session() function simply fills a 'struct flowi' with
> the informations of the originating flow whenever these informations
> are needed, selinux_xfrm_decode_session just adds the sid the
> that struct.
> 
> In the case we are constructing a 'struct flowi' within the outbound
> packet path, we use selinux_sk_getsecid() which just adds the
> sksec label from the socket if we have socket context.
> 
> So with this patch we would use the secpath's sid on inbound
> packets and the sksec label from the socket if we are on
> oubound packet processing with socket context, when we construct
> a 'struct flowi' from xfrm_decode_session().

I _really_ think we need to split the inbound and outbound handling for xfrm.  
I suppose we can always fall back to selecting the right path based on the 
presence of a sec_path pointer, but I would rather see us get rid of an 
unnecessary conditional.

The inbound handling can stick with the logic in selinux_xfrm_decode_session() 
but the outbound handling should follow similar logic to how we determine the 
network peer label in selinux_ip_postroute().

 1. If we have a valid sk_security_stuct, use it.
 2. If we are forwarding the packet, call selinux_skb_peerlbl_sid().
 3. If all else fails, use SECINITSID_KERNEL.

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
