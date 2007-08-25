From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Sat, 25 Aug 2007 17:01:32 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8481CBD@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8481CBD@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708251701.32662.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 24 August 2007 1:37:22 pm Venkat Yekkirala wrote:
> >  * Fallback labels
> >
> > The simple idea that started this whole discussion.  The need
> > for a usable
> > peer label fallback mechanism is understood by everyone but
> > the granularity
> > with which peer fallback labels are assigned are still a
> > source of debate.
> > The idea is wether the granularity proposed in this NetLabel
> > patchset which
> > allows per-host/subnet granularity for each interface is
> > enough, and if not
> > is a very granular iptables/netfilter peer label assignment
> > of fallback
> > labels required?  This topic did come up briefly some time
> > ago on the public
> > mailing list between Joshua Brindle and myself and we agreed that the
> > granularity presented in this patchset is sufficient,
> > however, not everyone
> > feels this way so we are still discussing the best solution.
>
> I am one of those that feel that non-granular fallbacks would
> be restrictive enough for the general case. We would essentially
> need per interface/node/port granularity, which is easily
> accomplished via iptables.

Help me understand why including the port is important for selecting a 
fallback label.

If we use the remote peer's port, the source port for the packet, it is going 
to be very hard to create a desired match since in most cases a random, 
ephemeral would be used by the client application.  Using the local 
destination port is probably a bit more reasonable, as well as predictable, 
but it would seem to encourage creating application specific/dependent 
labeling at the system level which I'm not certain is a good idea.  If the 
application needs a specific fallback label to operate, it might be a good 
candidate for providing it's own fallback label when getpeercon() returns an 
error.

However, the thing that concerns me most about allowing fallback label 
selectors to have granularity greater than a single host is that it would 
open the door for misinterpreting a unlabeled/single-label remote peer as 
multi-label remote peer.  I'm still on the fence as if this is really 
important or not, but if there is no compelling reason for offering greater 
than host granularity I'm tempted to vote against it.

I'd really appreciate some scenarios that demonstrate the need for greater 
than host granularity but all I've seen (or can remember right now) so far 
have been use cases that require only host level granularity.  I think it 
would help everyone better understand what we need.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
