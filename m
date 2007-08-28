From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 15:26:35 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8521408@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8521408@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281526.36289.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Okay, I understand your point now; I still don't think this
> > is too much of a
> > problem.  As you pointed out below we are most likely going
> > to need a final
> > catch-all flow control hook for the default, no-config case
> > (more on this
> > below) and this appears to be an excellent place to make the final
> > on-the-wire labeling decision for forwarded packets that make use of
> > CIPSOesque labeling protocols.  There is also the
> > ip_build_options() hook
> > which I keep talking about, but it may happen to early in the
> > forwarding
> > patch to be useful, I would have to check the stack.
> > Regardless, I'm pretty
> > confident that whatever hooks we put in place to control
> > packet flow should
> > be sufficient to handle the on-the-wire labeling we want/need
> > so lets move on
> > to defining those hooks and see where that leaves us.
>
> As for xfrm, the patch we have already does this.

Yep, that's why I tried to say "CIPSOesque"; this is one area where the 
standard IPsec processing is rather helpful.

> I will send a version 
> out once we make a final decision on the filtering aspect.

Great.  FWIW, I think we are there.  Flow control filtering should be done 
when a packet enters the system and when it exits the system, regardless of 
it's destination (locally consumed, forwarded).  For packets entering the 
system checks should be done between the peer label and the receiving 
interface as well as the peer label and the source address (with support for 
netmasks).  For packets leaving the system checks should be done between the 
peer label and the sending interface as well as the peer label and the 
destination address (with support for netmasks).

> Major pieces 
> missing will be loopback labeling, fallback, OTW labeling for NetLabel
> as you talked about earlier, compatibility coding etc. You can perhaps
> take by patch and add these to it?

There is a _lot_ of work to do and I don't expect to get it all done next 
week.  It's going to take some time to get everything in place and working 
together.  Those features which we can safely integrate with the existing 
code base we should do (fallback and loopback labeling should be safe) but 
the rest will probably involve a compat_net type of solution and should 
probably be merged together into one kernel release.

Please keep sending RFCs/patches to the SELinux list while we sort out all of 
the implementation details and I'll see about setting up a git tree where we 
can do all of the bigger/intrusive changes.  This should make it easier for 
us to work together and people who are interesting in testing the new 
features will have a working tree to pull from.  Once things are looking good 
I'll work to get all of the contributed patches upstream.

> > I noticed there was no comment about how to avoid
> > compatibility issues :)
> >
> > I agree that having a default, flow control "catch
> > all"/unlabeled_t check is a
> > good idea and preserved the SELinux philosophy but doing so
> > without breaking
> > the flow of packets in/out/through a system with old policy
> > is not an easy
> > task.  At some point in the future, if we want to reconcile
> > all of the peer
> > label access checks to a single object class, we'll probably
> > need to do
> > something similar to the compat_net (compat_net_peer?) flag.
>
> We could actually do this as part of this, correct (unless I
> missed any one's objections elsewhere).
>
> > If we want to
> > get the flow control functionality in sooner we'll need
> > something more
> > elegant.
>
> Could you please elaborate on this.

I'll will in response to Darrel's mail as he gets into this a bit more

> > <mental note>
> > We should probably look at putting the old compat_net bits in
> > the feature
> > removal queue if they aren't already ...
> > </mental note>
>
> I wonder what the current standard is for removing deprecated
> code. Is there a certain number of versions we need to wait or
> does it vary based on what's been deprecated?

All I'm aware of is Documentation/feature-removal-schedule.txt.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
