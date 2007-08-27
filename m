From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Mon, 27 Aug 2007 10:37:52 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF852116C@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF852116C@HAVOC.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708271037.52956.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, August 27 2007 8:44:17 am Venkat Yekkirala wrote:
> >  * Splitting the SECMARK field
> >
> > After it was agreed to continue using both the peer and
> > secmark labels the
> > discussion turned to how best to propagate those labels with
> > the packet.  As
> > you probably know there is a 32 bit field already in the
> > packet/sk_buff
> > structure which is currently used exclusively by the secmark
> > label.  Once
> > again, there were two approaches considered.  The first was
> > the continuation
> > of the status quo where the secmark label is determined by
> > looking directly
> > at the secmark field in the sk_buff, "sk_buff.secmark", and
> > the peer label is
> > determined through a function call with the sk_buff as an
> > argument, "peer_label(sk_buff)".
>
> This should be possible, with the obvious drawback that of a
> performance overhead of "resolving" all the different "peer"
> labels each time we need it (for example at each filter point).

True.

> Also, in the forwarding case, while the original xfrm-label should
> still be around in the labeled-IPSec to non-labeled-IPSec case, I
> would imagine in the NetLabel case, the option field would lose the
> "original" label in a DOI gateway instance (if and when NateLabel
> does this), right?

Yes, once you change the packet's label on the wire you have to potential to 
change the packet's label.  However, simply changing the label to reflect a 
different CIPSO DOI (I assume that is the DOI you were talking about?) 
shouldn't change the NetLabel/CIPSO label as seen by SELinux since the only 
thing the on-the-wire label translation would be doing is translating the 
label between two different security domains/DOIs, the semantic value of the 
label should be preserved.

I would consider removing the NetLabel/CIPSO label from a packet to be the 
same as relabeling a packet to unlabeled_t and I still believe that the 
kernel should not get involved in packet relabeling at this point, leave that 
up to userspace.

> >  The second idea was to
> > divide the secmark
> > field in the sk_buff into two 16 bit sub-fields effectively
> > shortening peer
> > and secmark SIDs to 16 bits.
>
> I would vote for this (or some variant). This has 2 advantages:
>
> 1. Resolve the external labels just once and plant it in the
>    split secmark.
>
> 2. Also use this for a loopback packet labeling (as also pointed
>    out by you later).

I'm slowly warming up to the idea of splitting the secmark field, although I 
still remain very concerned about the long term effects and compatibility 
issues.  Yes, there is the potential for a network SID mapper but I'm not 
very excited about that idea right now.  I guess what I'd like to see is 
something similar to the change below go through a few iterations of testing 
before we make up our minds.  We'd also need to entire SELinux braintrust to 
agree to the idea, and aside from Stephen and James, I'm not sure they are 
still reading this thread.

Index: linux-2.6_misc/security/selinux/ss/sidtab.c
===================================================================
--- linux-2.6_misc.orig/security/selinux/ss/sidtab.c
+++ linux-2.6_misc/security/selinux/ss/sidtab.c
@@ -212,7 +212,7 @@ int sidtab_context_to_sid(struct sidtab
                if (sid)
                        goto unlock_out;
                /* No SID exists for the context.  Allocate a new one. */
-               if (s->next_sid == UINT_MAX || s->shutdown) {
+               if (s->next_sid > 0x0000ffff || s->shutdown) {
                        ret = -ENOMEM;
                        goto unlock_out;

Let's figure out what we need for flow control and forwarding and then we can 
start a separate thread regarding 16 bit SIDs to get everyone's attention.

> >  * Loopback/Localhost peer packet labeling
> >
> > This has been a long standing requirement which at first
> > glance seems like it
> > would be simple to achieve but in practice it has proven
> > quiet difficult to
> > implement.  Current solutions to the problem involve using either
> > NetLabel/CIPSO or labeled IPsec over loopback to provide peer labels,
> > unfortunately both have drawbacks.  NetLabel/CIPSO is
> > currently limited to
> > only conveying the MLS sensitivity label over the wire and
> > only then for IPv4
> > packets.
>
> This can perhaps be worked-around by passing the sid verbatim
> using a special IP option (I believe suggested by Pete looking
> at the Symposium minutes).

Yep, this is basically the idea behind Selopt or similar.

> >  * Packet flow control
> >
> > Another long standing goal that has not seen much success
> > over the years.  The
> > two approaches currently being considered are: per-interface
> > checks against
> > the peer label with the possibility of an additional
> > forwarding hook/check if
> > needed for labeling purposes, as well as an iptables based filtering
> > mechanism which has already been discussed off and on on the
> > public SELinux
> > and LSPP mailing lists (SECFILTER/SECPOINT).  The idea behind
> > the iptables
> > based filtering mechanism is that "filter points" could be
> > defined using
> > iptables/netfilter which would provide very granular access
> > control checks.
> > The big question that is currently being debated is how much
> > granularity is
> > needed and how much makes sense?
>
> I believe this is hard to predict for the general case.

Yep, I believe you're right and the fact that this discussion has gone on for 
quite some time without any real obvious answer makes me think we won't 
arrive at one.  In that case, I guess we should just provide the most 
granularity possible and let the admins sort it out (the SECFILTER idea).

As far as I can tell there is still one important issue we need to resolve - 
how to introduce new packet access checks without causing a regression for 
users with older policy.  This of course is tied to the desire to have a 
default/unlabeled_t packet access check in the case where the admin has not 
explicitly setup any SECFILTER points/gates/etc.  Can we live without a 
default check?  It certainly makes the implementation cleaner and the 
compatibility issues less of a concern.  Thoughts?

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
> Well, there may be a case, where there's a need to identify an
> sshd_t peer different from a httpd_t peer. Or a http_client_t
> peer from an rss_aggregator_t peer. Scalability from coarse to
> granular should meet the entire spectrum of general cases.

Yes, but you're not really distinguishing between a ssh_t peer and a http_t 
peer, e.g. ssh -p 80, which is what troubles me about port level granularity.  
I sent another mail earlier which I believe described these concerns a bit 
better.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
