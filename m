Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1SBYsRi011894
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 06:34:57 -0500
Received: from a.mx.secunet.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1SBYtEQ005247
	for <selinux@tycho.nsa.gov>; Mon, 28 Feb 2011 11:34:56 GMT
Date: Mon, 28 Feb 2011 12:34:53 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Moore <paul.moore@hp.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 10/10] selinux: Perform xfrm checks for unlabeled
 access in any case
Message-ID: <20110228113453.GF26510@secunet.com>
References: <20110214131651.GA15640@secunet.com>
 <1297890498.25079.53.camel@sifl>
 <20110222135217.GF20852@secunet.com>
 <201102231659.18121.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201102231659.18121.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 23, 2011 at 04:59:17PM -0500, Paul Moore wrote:
> > 
> > If we want to keep that behaviour, we should change the Kconfig help
> > of labeled IPsec at least, there one can find:
> > 
> > Non-IPSec communications are designated as unlabelled, and only sockets
> > authorized to communicate unlabelled data can send without using IPSec.
> > 
> > What is simply not the case, as far as I can see.
> 
> Here is the full text of CONFIG_SECURITY_NETWORK_XFRM for those of you 
> following along at home:
> 
>           This enables the XFRM (IPSec) networking security hooks.
>           If enabled, a security module can use these hooks to
>           implement per-packet access controls based on labels
>           derived from IPSec policy.  Non-IPSec communications are
>           designated as unlabelled, and only sockets authorized
>           to communicate unlabelled data can send without using
>           IPSec.
>           If you are unsure how to answer this question, answer N.
> 
> What do you suggest?  If you're going to complain about help text you have to 
> offer some suggestions, that's the rule :)
> 

Yeah, I know about the rules. Right now I've tried to change the code to
fit better to the help text. If this does not work out, I still can try
to do it the oher way arround :)

> 
> If you haven't configured any of the SELinux network access controls, meaning 
> _all_ data flowing into and out of the system via the network is considered 
> to be unlabeled_t:SystemHigh, then yes, confidential and every other type of 
> data can be sent out the network.
> 
> Ask yourself this question: why would an admin, running SELinux, who cares 
> about restricting what data can be sent over the network not configure any of 
> SELinux's network access controls?  It just doesn't make sense ...
> 
> > Even though, we could have a selinux policy rule that enforces the usage of
> > a certain labeled SA. So for example if the key daemon does not start up
> > for some reason, we have no labeled SA and the traffic leaves the system
> > untransformed. That's what I wanted to avoid.
> 
> This will not happen, or rather it should not happen if everything works the 
> way it should.
> 

Yes, if everything works the way it should we are fine and we would not even
need to use selinux, but in real live bugs happen.

Usually I have to answer questions like:
Given there is a bug in subsystem xyz, show that we still on the save
side. And depending on the confidential level I have to show several lines
of defense.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
