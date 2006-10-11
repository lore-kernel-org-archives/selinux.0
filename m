Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9BE4nO6022105
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 10:04:49 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9BE48MI029176
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 14:04:09 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Joshua Brindle" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Wed, 11 Oct 2006 09:04:32 -0500
Message-ID: <000a01c6ed3e$2d9a4cc0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1160510751.20774.115.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > My point is that you already were applying constraints to 
> the chaining
> > of iptabels rules in the current secmark paradigm, which is that the
> > secmark label on the last rule will prevail. Were you not?
> 
> Yes, but this isn't an extra constraint, its how netfilter works.

More specifically, I see you were referring to the MARK module here.

>  If
> you have a MARK mangle rule that does --set-mark, and then 
> later in the
> chain you have a MARK mangle rule that does a --set-mark, the 
> result is
> always whatever is done by the last MARK.

That's the semantics of the MARK module.

>  Thats how the refpolicy
> SECMARK labeling works right now.

That's correct. This is where I have often wondered if we should
change the name to SECPOINT to signify the change in semantics.

> 
> What I'm describing also seems to be consistent with your docs:
> 
> > 1. PACKETS ENTERING SYSTEM FROM A NON-LOOPBACK DEVICE:
> > 
> >    Can a packet "carrying" external domain label x_t 
> "flow_in" thru the
> >    security point with the peer domain label p_d_t?
> > 
> > 	NOTE:
> > 	a. x_t defaults to unlabeled_t, if no external label.
> > 	b. p_d_t defaults to network_t in the absence of any applicable
> > 	   [conn]secmark rules for the packet. If there are multiple
> > 	   secmark rules applicable to a packet, the context on the LAST
> > 	   rule will apply.
> > 
> >    NO: Drop packet.
> >    YES: If no external label, let packet "carry" p_d_t.
> 
> On point b, you say the last context will be used in the check.

Only in relation to the flow_in controls. Not the flow_out.

> 
> > > making
> > > secmark work differently than the remainder of netfilter.
> > 
> > I don't understand this point; can't really compare an 
> accessory (semark)
> > to the mechanism it's piggybacking on (netfilter).
> 
> I'm comparing SECMARK to IPMARK or MARK, etc.

Again, I wonder if we should change the name to SECPOINT, especially
since we aren't in a huge rush currently.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
