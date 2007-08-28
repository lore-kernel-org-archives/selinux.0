From: Paul Moore <paul.moore@hp.com>
To: Darrel Goeddel <sedgoeddel@gmail.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 15:07:20 -0400
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <200708281151.07120.paul.moore@hp.com> <46D45A1C.9090703@gmail.com>
In-Reply-To: <46D45A1C.9090703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281507.20999.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, August 28 2007 1:23:40 pm Darrel Goeddel wrote:
> Paul Moore wrote:
> > Hmm, so in summary, you (TCS) don't see a need for flow control of
> > fallback labels with granularity greater then a single host and if really
> > pushed interface level granularity would most likely suffice.  I'll
> > venture that host/network level granularity might be nice for normal
> > users who only have one interface which connects to multiple networks,
> > e.g. the person sitting at home on a private home network which also
> > connects to the big-bad-internet via a nat box provided by their ISP.
>
> I don't see the need for the granularity of flow control mechanisms to
> go beyond the host level.  I also don't see the need to apply fallback
> labels at a granularity greater than host level.  Note that they are
> separate items, not just flow control for fallback labels (as phrased in
> your response), but flow control for all labels.

Yes, that was a typo/braino what I mean to say was "... you (TCS) don't see a 
need for flow control _or_ [not "of"] fallback labels ..."

> > This now has me rethinking the need for a full featured netfilter based
> > mechanism for flow control (SECFILTER).  I'm wondering if we would be
> > better served by simple hooks in the network device layer for in/out and
> > possible forward.  As James pointed out in the off-list discussion, the
> > whole netfilter mechanism seems like a bit much for what we actually
> > need.
>
> I agree here as well.  It was necessary when I was talking about
> "re-purposing" SECMARK, but not that SECMARK makes it though unscathed,
> I'm not sure it is necessary (hopefully I won't have an epiphany after
> hitting send...).  However, if we are assigning fallback labels at a
> host level granularity, should we restrict flow at the same level?

I think leaving flow control with host level granularity makes sense, actually 
I think interface level is probably "safe" but host level granularity may 
make it easier to apply the controls to a more general case.

> If 
> so, is the iptables mechanism the easiest route (the default unlabeled
> check cimplicates this), or would we want to do a netif flow check and a
> host flow check (using the existing nodecon rules?).

I'm almost certain netfilter/iptables is more than we need here and drags a 
unnecessary dependency into the mix.  How we go about defining the 
relationship in policy (netif/nodecon or something new?) is something we 
should discuss with the policy folks before settling on anything.

> As long as forwarded traffic hit both the in and out flow checks, I
> don't think we need a separate forward check.  The forward check would
> really have to be one of those weird "triplet" checks that would take in
> the peer label, the incoming interface label, and the outgoing interface
> label.

Yes, like we discussed earlier, the only real reason I can see for having a 
forwarding hook is if we needed for on-the-wire labeling.  An access check 
here doesn't sound like it would be serving any real need.

> The flow_out check is obvious in postroute_last.  We have a spot 
> around xfrm_policy_check where the flow_in check fits nicely and catches
> forwarded traffic as well as locally bound traffic.

That's good.  I like it when we can do things without adding new hooks, it 
keeps the netdev people from throwing stuff ;)

> >> Can we make the netif optional or add a wildcard netif?  That would
> >> allow for a truly generic fallback if desired.  Currently if you add a
> >> new interface, you need to go back and add a new rule (I think, could be
> >> wrong since I haven't actually tried it).
> >
> > Sure, I can add a default netif which is used if a match isn't found.  I
> > originally considered adding one (the NetLabel domain mapping mechanism
> > has a default rule match) but it seemed a little "dangerous" at the time,
> > although I think I was just being too cautious.
>
> Cool.  That would give the flexibility to define netif only based
> fallbacks (using 0.0.0.0/0) and host only fallbacks (using the defalut
> if) or some combo of the two.
>
> eth0:0.0.0.0/0		confidential
> eth1:0.0.0.0/0		secret
> eth2:0.0.0.0/0		ts

This you can do now (it works for IPv6 too) ...

> any:0.0.0.0/0		systemhigh

... but not this ...

> any:10.0.1.0/24		confidential
> any:10.0.2.0/24		secret
> any:10.0.3.0/24		ts
> any:0.0.0.0/0		systemhigh

... or this ...

> That would work, right?

... as soon as I can make the changes.  It seems that lately I've been 
spending almost all of my time typing into my email client and not my 
editor :)  (I'm not complaining, we're having a good discussion here, I just 
look forward to actually acting on it)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
