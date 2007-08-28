From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 10:51:42 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281051.42665.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, August 27 2007 6:09:12 pm Venkat Yekkirala wrote:
> [Darrel has made me aware I am breaking threads; will fix this
> in a day or two]

I'm really curious at this point, someday you guys are going to have to 
explain how your email system works ;)

> > -----Original Message-----
> > From: Paul Moore [mailto:paul.moore@hp.com]
>
> (snip)
>
> > > Also, in the forwarding case, while the original xfrm-label should
> > > still be around in the labeled-IPSec to non-labeled-IPSec case, I
> > > would imagine in the NetLabel case, the option field would lose the
> > > "original" label in a DOI gateway instance (if and when NateLabel
> > > does this), right?
> >
> > Yes, once you change the packet's label on the wire you have
> > to potential to
> > change the packet's label.  However, simply changing the
> > label to reflect a
> > different CIPSO DOI (I assume that is the DOI you were
> > talking about?)
>
> Yes.
>
> > shouldn't change the NetLabel/CIPSO label as seen by SELinux
> > since the only
> > thing the on-the-wire label translation would be doing is
> > translating the
> > label between two different security domains/DOIs, the
> > semantic value of the
> > label should be preserved.
> >
> > I would consider removing the NetLabel/CIPSO label from a
> > packet to be the
> > same as relabeling a packet to unlabeled_t and I still
> > believe that the
> > kernel should not get involved in packet relabeling at this
> > point, leave that
> > up to userspace.
>
> Traditionally anyway, the original label has been used all the
> way thru for flow-control, etc., since that's the original label
> of the packet. I believe the packet losing the label is just
> a recognition of the fact that the packet can't explicitly
> carry the label onto the other network, but the label is
> implicit from what I understand.

Okay, I understand your point now; I still don't think this is too much of a 
problem.  As you pointed out below we are most likely going to need a final 
catch-all flow control hook for the default, no-config case (more on this 
below) and this appears to be an excellent place to make the final 
on-the-wire labeling decision for forwarded packets that make use of 
CIPSOesque labeling protocols.  There is also the ip_build_options() hook 
which I keep talking about, but it may happen to early in the forwarding 
patch to be useful, I would have to check the stack.  Regardless, I'm pretty 
confident that whatever hooks we put in place to control packet flow should 
be sufficient to handle the on-the-wire labeling we want/need so lets move on 
to defining those hooks and see where that leaves us.

> For example, in the case of xfrm, the label should be preserved
> in the skb->sp field all the way thru, and so we should be able
> to prevent a Top Secret xfrm-labeled packet from being forwarded
> to a Secret interface even when the packet needs to be sent
> in the clear (or using non-labeled IPsec) onto the Secret network.
> In the NetLabel case, I wonder if we could use the
> same special IP Option that we would use for Loopback packet labeling
> to carry the "original" label thru to the last check and
> strip it out before it gets on the wire? 

At present I'm thinking that the "special IP option" would be a CIPSO option 
with a freeform tag similar to Selopt, however, nothing is set in stone.  The 
prospect of trying to sell a non IANA listed/approved IP option upstream is 
not very appealing to me, however, if we want IPv6 compat with Trusted 
Solaris we may have to do just that ... sigh.  Regardless, see my comments 
above about moving forward with the design of LSM hooks for packet flow 
first.

> > > >  * Packet flow control
> > > >
> > > > Another long standing goal that has not seen much success
> > > > over the years.  The
> > > > two approaches currently being considered are: per-interface
> > > > checks against
> > > > the peer label with the possibility of an additional
> > > > forwarding hook/check if
> > > > needed for labeling purposes, as well as an iptables
> >
> > based filtering
> >
> > > > mechanism which has already been discussed off and on on the
> > > > public SELinux
> > > > and LSPP mailing lists (SECFILTER/SECPOINT).  The idea behind
> > > > the iptables
> > > > based filtering mechanism is that "filter points" could be
> > > > defined using
> > > > iptables/netfilter which would provide very granular access
> > > > control checks.
> > > > The big question that is currently being debated is how much
> > > > granularity is
> > > > needed and how much makes sense?
> > >
> > > I believe this is hard to predict for the general case.
> >
> > Yep, I believe you're right and the fact that this discussion
> > has gone on for
> > quite some time without any real obvious answer makes me
> > think we won't
> > arrive at one.  In that case, I guess we should just provide the most
> > granularity possible and let the admins sort it out (the
> > SECFILTER idea).
> >
> > As far as I can tell there is still one important issue we
> > need to resolve -
> > how to introduce new packet access checks without causing a
> > regression for
> > users with older policy.  This of course is tied to the
> > desire to have a
> > default/unlabeled_t packet access check in the case where the
> > admin has not
> > explicitly setup any SECFILTER points/gates/etc.  Can we live
> > without a
> > default check?
>
> I highly doubt it. We have erred on the side of caution on this
> in our patch since we didn't want any inadvertent flows between
> Secret and TS networks for example. This also obviously retains
> the SELinux philosophy of no allows by default.

I noticed there was no comment about how to avoid compatibility issues :)

I agree that having a default, flow control "catch all"/unlabeled_t check is a 
good idea and preserved the SELinux philosophy but doing so without breaking 
the flow of packets in/out/through a system with old policy is not an easy 
task.  At some point in the future, if we want to reconcile all of the peer 
label access checks to a single object class, we'll probably need to do 
something similar to the compat_net (compat_net_peer?) flag.  If we want to 
get the flow control functionality in sooner we'll need something more 
elegant.

<mental note>
We should probably look at putting the old compat_net bits in the feature 
removal queue if they aren't already ...
</mental note>

> > > >  * Fallback labels
> > > >
> > > > The simple idea that started this whole discussion.  The need
> > > > for a usable
> > > > peer label fallback mechanism is understood by everyone but
> > > > the granularity
> > > > with which peer fallback labels are assigned are still a
> > > > source of debate.
> > > > The idea is wether the granularity proposed in this NetLabel
> > > > patchset which
> > > > allows per-host/subnet granularity for each interface is
> > > > enough, and if not
> > > > is a very granular iptables/netfilter peer label assignment
> > > > of fallback
> > > > labels required?  This topic did come up briefly some time
> > > > ago on the public
> > > > mailing list between Joshua Brindle and myself and we
> >
> > agreed that the
> >
> > > > granularity presented in this patchset is sufficient,
> > > > however, not everyone
> > > > feels this way so we are still discussing the best solution.
> > >
> > > Well, there may be a case, where there's a need to identify an
> > > sshd_t peer different from a httpd_t peer. Or a http_client_t
> > > peer from an rss_aggregator_t peer. Scalability from coarse to
> > > granular should meet the entire spectrum of general cases.
> >
> > Yes, but you're not really distinguishing between a ssh_t
> > peer and a http_t
> > peer, e.g. ssh -p 80, which is what troubles me about port
> > level granularity.
> > I sent another mail earlier which I believe described these
> > concerns a bit
> > better.
>
> I missed it earlier. We have been brainstorming on this among
> myself, Chad and Darrel and our current thinking (assuming I am
> putting it forward correctly) is that if one limits trust to the
> interface, it actually seems to make sense to allow defaults at
> just the interface level and further it seems to make sense to
> have the same level of granularity for both the fallback and the
> filtering case. At least for MLS, it seems enough to have the ability
> to define fallbacks as also perform filtering at just the interface level.
> The question to be debated is if for TE, we need granularity
> beyond the interface for fallbacks and flow-control.

I'm not hearing a real use case for granularity greater than a single host yet 
and I think everyone who has an opinion has already voiced it.  While I 
understand the argument for keeping the same level of granularity for both 
the flow controls checks and the fallback label, I see no compelling reason 
to keep parity here and further I see potential problems with allowing that 
fine of a granularity for a fallback label.

I'll leave this open for new arguments as I'm still messing with the patches, 
but I'm going to continue with the current approach of static/fallback 
labeling based on the interface/network.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
