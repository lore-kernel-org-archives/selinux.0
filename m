Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1NLxLEA007526
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 16:59:21 -0500
Received: from g6t0184.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1NLxKdV006111
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 21:59:20 GMT
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 10/10] selinux: Perform xfrm checks for unlabeled access in any case
Date: Wed, 23 Feb 2011 16:59:17 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <20110214131651.GA15640@secunet.com> <1297890498.25079.53.camel@sifl> <20110222135217.GF20852@secunet.com>
In-Reply-To: <20110222135217.GF20852@secunet.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102231659.18121.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, February 22, 2011 8:52:17 AM Steffen Klassert wrote:
> On Wed, Feb 16, 2011 at 04:08:18PM -0500, Paul Moore wrote:
> > On Mon, 2011-02-14 at 14:23 +0100, Steffen Klassert wrote:
> > > We do the checks for unlabeled access with selinux_xfrm_postroute_last
> > > and selinux_xfrm_sock_rcv_skb just in compatibility mode.
> > > However these checks are required in any case as we have to ensure
> > > that a packet is allowed to be send to (or received from) an unlabeled
> > > destination if we have no security association configured.
> > > 
> > > This patch fixes this by calling selinux_xfrm_postroute_last and
> > > selinux_xfrm_sock_rcv_skb in any case.
> > > 
> > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > 
> > Big NACK on this patch.
> > 
> > While it may seem odd to bail out on the labeled network access checks,
> > we should only do this when the admin has not configured any of the
> > labeled networking bits in the kernel (labeled IPsec, NetLabel,
> > Secmark).  The idea is that if the admin hasn't configured anything, all
> > you are going to end up checking is if unlabeled packets can be sent up,
> > down and around the network stack.  Not a very interesting access
> > control, and when you consider the policy headache and performance
> > impact it was causing we decided that dynamic access controls would be
> > okay for networking.
> 
> If we want to keep that behaviour, we should change the Kconfig help
> of labeled IPsec at least, there one can find:
> 
> Non-IPSec communications are designated as unlabelled, and only sockets
> authorized to communicate unlabelled data can send without using IPSec.
> 
> What is simply not the case, as far as I can see.

Here is the full text of CONFIG_SECURITY_NETWORK_XFRM for those of you 
following along at home:

          This enables the XFRM (IPSec) networking security hooks.
          If enabled, a security module can use these hooks to
          implement per-packet access controls based on labels
          derived from IPSec policy.  Non-IPSec communications are
          designated as unlabelled, and only sockets authorized
          to communicate unlabelled data can send without using
          IPSec.
          If you are unsure how to answer this question, answer N.

What do you suggest?  If you're going to complain about help text you have to 
offer some suggestions, that's the rule :)

> > All you have to do to enable the dynamic access controls is configure
> > the system and viola, you get back all your unlabeled_t AVCs.
> 
> If I understand it correct, the dynamic access controls are just active
> if a labeled SA/policy is inserted to the kernel.

... or Secmark rules, or NetLabel configuration.

> So if no labeled SA/policy is loaded, we might send confidential data
> untransformed over the network.

If you haven't configured any of the SELinux network access controls, meaning 
_all_ data flowing into and out of the system via the network is considered 
to be unlabeled_t:SystemHigh, then yes, confidential and every other type of 
data can be sent out the network.

Ask yourself this question: why would an admin, running SELinux, who cares 
about restricting what data can be sent over the network not configure any of 
SELinux's network access controls?  It just doesn't make sense ...

> Even though, we could have a selinux policy rule that enforces the usage of
> a certain labeled SA. So for example if the key daemon does not start up
> for some reason, we have no labeled SA and the traffic leaves the system
> untransformed. That's what I wanted to avoid.

This will not happen, or rather it should not happen if everything works the 
way it should.

In this case you may not have an automatically generated SAs with labels, but 
you will have SPD rules with labels so the network access controls will be 
enabled (if not, we have a bug).  See how selinux_xfrm_refcount is managed in 
selinux/xfrm.c to see what I mean.

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
