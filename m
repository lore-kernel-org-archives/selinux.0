Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AJa43I027190
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 15:36:04 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AJYmvk017388
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 19:34:49 GMT
Subject: RE: Denials from newest kernel
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: vyekkirala@TrustedCS.com
Cc: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <000801c6eca0$75eee1f0$cc0a010a@tcssec.com>
References: <000801c6eca0$75eee1f0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:35:00 -0400
Message-Id: <1160508900.5530.9.camel@localhost.localdomain>
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
> 

I wouldn't call making the last rule prevail a constraint in the
previous model, but yes that is how it worked.

To me - and I guess Josh and Chris - it seems natural to allow netfilter
to refine the label of a packet as it passes through the process of
evaluating the rules without imposing access checks. This is, as you
point out, because of the previous idea of secmark as a labeling only.

However, in the new paradigm it seems that there is some value to only
enforcing access checks after the processing of the mangle rules. Namely
it reduces the number of checks performed and allows the secmark rules
to be more similar - I think - to other iptables rules.

I may be misunderstanding, but essentially I am suggesting that secmark
labels the flow point through processing the mangle rules. After that
label is determined the flow checks are made against the final label for
the flow point.

What advantage do you see to make the check more often?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
