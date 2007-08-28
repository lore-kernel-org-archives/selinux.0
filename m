Message-ID: <D709A20F2164C84E8B7014B0301F5EF8521408@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley
	 <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris
	 <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 12:30:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Tuesday, August 28, 2007 9:52 AM
> To: Venkat Yekkirala
> Cc: selinux@tycho.nsa.gov; James Morris; Darrel Goeddel; Stephen
> Smalley; kaigai@ak.jp.nec.com; joe@nall.com; Eric Paris
> Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
> 
> 
> On Monday, August 27 2007 6:09:12 pm Venkat Yekkirala wrote:
> > [Darrel has made me aware I am breaking threads; will fix this
> > in a day or two]
> 
> I'm really curious at this point, someday you guys are going 
> to have to 
> explain how your email system works ;)
> 
> > > -----Original Message-----
> > > From: Paul Moore [mailto:paul.moore@hp.com]
> >
> > (snip)
> >
> > > > Also, in the forwarding case, while the original 
> xfrm-label should
> > > > still be around in the labeled-IPSec to 
> non-labeled-IPSec case, I
> > > > would imagine in the NetLabel case, the option field 
> would lose the
> > > > "original" label in a DOI gateway instance (if and when 
> NateLabel
> > > > does this), right?
> > >
> > > Yes, once you change the packet's label on the wire you have
> > > to potential to
> > > change the packet's label.  However, simply changing the
> > > label to reflect a
> > > different CIPSO DOI (I assume that is the DOI you were
> > > talking about?)
> >
> > Yes.
> >
> > > shouldn't change the NetLabel/CIPSO label as seen by SELinux
> > > since the only
> > > thing the on-the-wire label translation would be doing is
> > > translating the
> > > label between two different security domains/DOIs, the
> > > semantic value of the
> > > label should be preserved.
> > >
> > > I would consider removing the NetLabel/CIPSO label from a
> > > packet to be the
> > > same as relabeling a packet to unlabeled_t and I still
> > > believe that the
> > > kernel should not get involved in packet relabeling at this
> > > point, leave that
> > > up to userspace.
> >
> > Traditionally anyway, the original label has been used all the
> > way thru for flow-control, etc., since that's the original label
> > of the packet. I believe the packet losing the label is just
> > a recognition of the fact that the packet can't explicitly
> > carry the label onto the other network, but the label is
> > implicit from what I understand.
> 
> Okay, I understand your point now; I still don't think this 
> is too much of a 
> problem.  As you pointed out below we are most likely going 
> to need a final 
> catch-all flow control hook for the default, no-config case 
> (more on this 
> below) and this appears to be an excellent place to make the final 
> on-the-wire labeling decision for forwarded packets that make use of 
> CIPSOesque labeling protocols.  There is also the 
> ip_build_options() hook 
> which I keep talking about, but it may happen to early in the 
> forwarding 
> patch to be useful, I would have to check the stack.  
> Regardless, I'm pretty 
> confident that whatever hooks we put in place to control 
> packet flow should 
> be sufficient to handle the on-the-wire labeling we want/need 
> so lets move on 
> to defining those hooks and see where that leaves us.

As for xfrm, the patch we have already does this. I will send a version
out once we make a final decision on the filtering aspect. Major pieces
missing will be loopback labeling, fallback, OTW labeling for NetLabel
as you talked about earlier, compatibility coding etc. You can perhaps
take by patch and add these to it?

(snip)
> > > As far as I can tell there is still one important issue we
> > > need to resolve -
> > > how to introduce new packet access checks without causing a
> > > regression for
> > > users with older policy.  This of course is tied to the
> > > desire to have a
> > > default/unlabeled_t packet access check in the case where the
> > > admin has not
> > > explicitly setup any SECFILTER points/gates/etc.  Can we live
> > > without a
> > > default check?
> >
> > I highly doubt it. We have erred on the side of caution on this
> > in our patch since we didn't want any inadvertent flows between
> > Secret and TS networks for example. This also obviously retains
> > the SELinux philosophy of no allows by default.
> 
> I noticed there was no comment about how to avoid 
> compatibility issues :)
> 
> I agree that having a default, flow control "catch 
> all"/unlabeled_t check is a 
> good idea and preserved the SELinux philosophy but doing so 
> without breaking 
> the flow of packets in/out/through a system with old policy 
> is not an easy 
> task.  At some point in the future, if we want to reconcile 
> all of the peer 
> label access checks to a single object class, we'll probably 
> need to do 
> something similar to the compat_net (compat_net_peer?) flag.  

We could actually do this as part of this, correct (unless I
missed any one's objections elsewhere).

> If we want to 
> get the flow control functionality in sooner we'll need 
> something more 
> elegant.

Could you please elaborate on this.

> 
> <mental note>
> We should probably look at putting the old compat_net bits in 
> the feature 
> removal queue if they aren't already ...
> </mental note>

I wonder what the current standard is for removing deprecated
code. Is there a certain number of versions we need to wait or
does it vary based on what's been deprecated?

(snip)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
