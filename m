Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AK5TTF028351
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 16:05:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9AK4Dvk023112
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 20:04:14 GMT
Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <000801c6eca0$75eee1f0$cc0a010a@tcssec.com>
References: <000801c6eca0$75eee1f0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 16:05:51 -0400
Message-Id: <1160510751.20774.115.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-10 at 14:15 -0500, Venkat Yekkirala wrote:
> > On Tue, 2006-10-10 at 10:42 -0400, Venkat Yekkirala wrote:
> > > > I don't think this is a desired behavior for a couple
> > reasons.  First,
> > > > this means that every domain that has access to a
> > specific packet, for
> > > > example, http_client_packet_t, but not to client_packet_t,
> > > > will have to
> > > > dontaudit the client_packet_t access.  Thats a lot of
> > >
> > > But this is a problem of our own making in the policy. If we
> > > jump into a unique chain for a label (or a set of labels all
> > > fine-grained to the same "grade", and hence are non-conflicting)
> > > then we shouldn't see this. Please refer to the links I mentioned in
> > > my response to Joshua.
> > >
> > > > dontauditing, and
> > > > also it will cover up legitimate denials on
> > client_packet_t.  Second,
> > >
> > > It won't if you defined the catch-all security point only for the
> > > real catch-all cases.
> >
> > On both of the above two points, you're making my point.  You're
> > applying to constraints to the chaining of iptables rules,
> 
> My point is that you already were applying constraints to the chaining
> of iptabels rules in the current secmark paradigm, which is that the
> secmark label on the last rule will prevail. Were you not?

Yes, but this isn't an extra constraint, its how netfilter works.  If
you have a MARK mangle rule that does --set-mark, and then later in the
chain you have a MARK mangle rule that does a --set-mark, the result is
always whatever is done by the last MARK.  Thats how the refpolicy
SECMARK labeling works right now.

What I'm describing also seems to be consistent with your docs:

> 1. PACKETS ENTERING SYSTEM FROM A NON-LOOPBACK DEVICE:
> 
>    Can a packet "carrying" external domain label x_t "flow_in" thru the
>    security point with the peer domain label p_d_t?
> 
> 	NOTE:
> 	a. x_t defaults to unlabeled_t, if no external label.
> 	b. p_d_t defaults to network_t in the absence of any applicable
> 	   [conn]secmark rules for the packet. If there are multiple
> 	   secmark rules applicable to a packet, the context on the LAST
> 	   rule will apply.
> 
>    NO: Drop packet.
>    YES: If no external label, let packet "carry" p_d_t.

On point b, you say the last context will be used in the check.

> > making
> > secmark work differently than the remainder of netfilter.
> 
> I don't understand this point; can't really compare an accessory (semark)
> to the mechanism it's piggybacking on (netfilter).

I'm comparing SECMARK to IPMARK or MARK, etc.

> > > > this will cause permissive to have a different behavior than
> > > > enforcing.
> > > > This makes development in permissive more difficult,
> > since you'll get
> > > > spurious denials that you wouldn't get in enforcing.
> 
> Can you give an example of a spurious denial here?

I'm going to retract this, based on the fact that it isn't spurious
based on the current implementation.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
