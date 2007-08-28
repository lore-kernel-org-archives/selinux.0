From: Paul Moore <paul.moore@hp.com>
To: Darrel Goeddel <sedgoeddel@gmail.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 11:51:06 -0400
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <46D43808.4050008@gmail.com>
In-Reply-To: <46D43808.4050008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281151.07120.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 28 2007 10:58:16 am Darrel Goeddel wrote:
> Venkat Yekkirala wrote:
> <snip>
>
> >> From: Paul Moore [mailto:paul.moore@hp.com]
> >> Yes, but you're not really distinguishing between a ssh_t
> >> peer and a http_t
> >> peer, e.g. ssh -p 80, which is what troubles me about port
> >> level granularity.
> >> I sent another mail earlier which I believe described these
> >> concerns a bit
> >> better.
> >
> > I missed it earlier. We have been brainstorming on this among
> > myself, Chad and Darrel and our current thinking (assuming I am
> > putting it forward correctly) is that if one limits trust to the
> > interface, it actually seems to make sense to allow defaults at
> > just the interface level and further it seems to make sense to
> > have the same level of granularity for both the fallback and the
> > filtering case. At least for MLS, it seems enough to have the ability
> > to define fallbacks as also perform filtering at just the interface
> > level. The question to be debated is if for TE, we need granularity
> > beyond the interface for fallbacks and flow-control.
>
> We batted around a bunch of ideas and it almost always seemed that the
> granularity of fallback labels should match the granularity of the flow
> control checks.  As Venkat stated, anything past the netif is really
> extending turst on our part, whether it is for applying a fallback label
> or performing an access check.  If we apply fallbacks at the host level,
> we should also allow flow control at the host level.  It doesn't seem to
> make sense that we would say "info from 1.2.3.4 is SECRET", but not be
> able to "info going to 1.2.3.4 should be SECRET).  I personally don't
> see a current need to go past host for either, and even host *could* be
> argued away in my eyes.  That being said, I would never be opposed to
> flexibility.

Hmm, so in summary, you (TCS) don't see a need for flow control of fallback 
labels with granularity greater then a single host and if really pushed 
interface level granularity would most likely suffice.  I'll venture that 
host/network level granularity might be nice for normal users who only have 
one interface which connects to multiple networks, e.g. the person sitting at 
home on a private home network which also connects to the big-bad-internet 
via a nat box provided by their ISP.

This now has me rethinking the need for a full featured netfilter based 
mechanism for flow control (SECFILTER).  I'm wondering if we would be better 
served by simple hooks in the network device layer for in/out and possible 
forward.  As James pointed out in the off-list discussion, the whole 
netfilter mechanism seems like a bit much for what we actually need.

> NOTE that I said almost in my first sentence...  The only "opposing"
> scenario that seemed intuitive to me was apply fallbacks using
> network/netmask only and apply flow checks at interface only.  An
> example of operation would be:
>
> netif access rules:
> eth1	SECRET	10.0.1.0/24
> eth2	TS	10.0.2.0/24
>
> host fallback labels:
> 10.0.1.100/32	SYSHI
> 10.0.1.0/24	SECRET
> 10.0.2.0/24	TS
>
> That CON host would obviously get denied coming in if it was not using
> some on-the-wire labeling because it would be assigned a label of SYSHI,
> which would be blocked at the netif flow check.  I'm sure something is
> wrong with the host label/netif access check idea, but I can't put my
> finger on it...  Too much trust in the IP address and routing?

Well, we kinda have to trust that IP works correctly as it is beyond our 
control - we only get to effect the box, not the networks it attached to.  If 
you can't trust the network make use of something like IPsec which can at 
least provide you data confidentiality/integrity/auth.

> Paul, why the netif/host combo in the original netlabel fallback patch?
>   Why not just hosts (or really network/netmask)?
{patched in from the other email}
> Can we make the netif optional or add a wildcard netif?  That would allow
> for a truly generic fallback if desired.  Currently if you add a new
> interface, you need to go back and add a new rule (I think, could be wrong
> since I haven't actually tried it). 

Sure, I can add a default netif which is used if a match isn't found.  I 
originally considered adding one (the NetLabel domain mapping mechanism has a 
default rule match) but it seemed a little "dangerous" at the time, although 
I think I was just being too cautious.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
