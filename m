Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AJvE6A027896
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 15:57:14 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AJtuvk021301
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 19:55:57 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>,
        "Joshua Brindle" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Tue, 10 Oct 2006 14:56:52 -0500
Message-ID: <000901c6eca6$3b6ddda0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1160508900.5530.9.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > My point is that you already were applying constraints to
> the chaining
> > of iptabels rules in the current secmark paradigm, which is that the
> > secmark label on the last rule will prevail. Were you not?
> >
>
> I wouldn't call making the last rule prevail a constraint in the
> previous model, but yes that is how it worked.
>
> To me - and I guess Josh and Chris - it seems natural to
> allow netfilter
> to refine the label of a packet as it passes through the process of
> evaluating the rules without imposing access checks. This is, as you
> point out, because of the previous idea of secmark as a labeling only.
>
> However, in the new paradigm it seems that there is some value to only
> enforcing access checks after the processing of the mangle
> rules. Namely
> it reduces the number of checks performed and allows the secmark rules
> to be more similar - I think - to other iptables rules.
>
> I may be misunderstanding, but essentially I am suggesting
> that secmark
> labels the flow point through processing the mangle rules. After that
> label is determined the flow checks are made against the
> final label for
> the flow point.

This is exactly what I had intended to do but couldn't due to
implementation constraints. James got us the one secmark field
on the skb with great difficulty, and this secmark initially
carries the label of the socket (or the security point it entered
into the system in the forwarding case) it originates from. Now
when we hit a secmark rule, there's no place to save the secmark
context for a check later AFTER all the mangle rules have been
processed for the packet. So, I have had to essentially perform the
check at the time I hit the secmark rule and again each time
I hit another applicable rule. If the check succeeds, I replace the
secmark on the packet with the secmark from the secmark (aks security point)
rule. I have to do this replacing of the secmark on the packet so that
a following connsecmark/save would use the context from the secmark
rule that it follows.

>
> What advantage do you see to make the check more often?

As described above, we are forced to make the check due to the
current implementation constraints, but I do see the advantage
of a policy that isn't arbitrary, but forces the policy writer
to aknowledge the multiple security points a packet hits by additionally
having to write allow rules allowing one security point domain
to flow out a succeeding one. A very useful and perhaps crude way
to visualize this is to think of smaller pipes entering bigger
ones, with network_t being the all-encompassing-one/the-network.

Another way to describe this is:

1. One could define several levels of security check points (one in
   the OUTPUT chain and another in POSTROUTING for example, or
   multiple points in the OUTPUT chain itself for another example).

2. As a packet passes a security point, it assumes the label of the
   security point for further flow control checks at subsequent security
   points.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
