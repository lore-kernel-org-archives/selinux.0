Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CIoh3s005414
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 14:50:43 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9CIo3RR018578
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 18:50:03 GMT
Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <000901c6eca6$3b6ddda0$cc0a010a@tcssec.com>
References: <000901c6eca6$3b6ddda0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 14:51:18 -0400
Message-Id: <1160679078.5980.71.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-10 at 14:56 -0500, Venkat Yekkirala wrote:
> > > My point is that you already were applying constraints to
> > the chaining
> > > of iptabels rules in the current secmark paradigm, which is that the
> > > secmark label on the last rule will prevail. Were you not?
> > >
> >
> > I wouldn't call making the last rule prevail a constraint in the
> > previous model, but yes that is how it worked.
> >
> > To me - and I guess Josh and Chris - it seems natural to
> > allow netfilter
> > to refine the label of a packet as it passes through the process of
> > evaluating the rules without imposing access checks. This is, as you
> > point out, because of the previous idea of secmark as a labeling only.
> >
> > However, in the new paradigm it seems that there is some value to only
> > enforcing access checks after the processing of the mangle
> > rules. Namely
> > it reduces the number of checks performed and allows the secmark rules
> > to be more similar - I think - to other iptables rules.
> >
> > I may be misunderstanding, but essentially I am suggesting
> > that secmark
> > labels the flow point through processing the mangle rules. After that
> > label is determined the flow checks are made against the
> > final label for
> > the flow point.
> 
> This is exactly what I had intended to do but couldn't due to
> implementation constraints. James got us the one secmark field
> on the skb with great difficulty, and this secmark initially
> carries the label of the socket (or the security point it entered
> into the system in the forwarding case) it originates from. Now
> when we hit a secmark rule, there's no place to save the secmark
> context for a check later AFTER all the mangle rules have been
> processed for the packet. So, I have had to essentially perform the
> check at the time I hit the secmark rule and again each time
> I hit another applicable rule. If the check succeeds, I replace the
> secmark on the packet with the secmark from the secmark (aks security point)
> rule. I have to do this replacing of the secmark on the packet so that
> a following connsecmark/save would use the context from the secmark
> rule that it follows.
> 
> >
> > What advantage do you see to make the check more often?
> 
> As described above, we are forced to make the check due to the
> current implementation constraints, but I do see the advantage
> of a policy that isn't arbitrary, but forces the policy writer
> to aknowledge the multiple security points a packet hits by additionally
> having to write allow rules allowing one security point domain
> to flow out a succeeding one. A very useful and perhaps crude way
> to visualize this is to think of smaller pipes entering bigger
> ones, with network_t being the all-encompassing-one/the-network.
> 
> Another way to describe this is:
> 
> 1. One could define several levels of security check points (one in
>    the OUTPUT chain and another in POSTROUTING for example, or
>    multiple points in the OUTPUT chain itself for another example).
> 
> 2. As a packet passes a security point, it assumes the label of the
>    security point for further flow control checks at subsequent security
>    points.

I read this email several times, and as a policy writer I repeatedly
came up with this question: what security goals can I express with the
multiple "security points" going though the mangle table?  I thought
about this for a couple hours and could not come up with an answer.

I believe that for each direction, the mangle table represents _one
labeling decision_.  Its just like the file_contexts: multiple lines may
match and the last one wins.  Do we have access checks for each line
matched in the file_contexts?  No.  The access check is performed after
all of the file context entries have been tested when the file is
relabeled.  The intermediate labels are irrelevant; if they were
relevant, setfiles would relabel the file for each matching line in
file_contexts.  In the same line of logic, the intermediate labels in
the mangle table are irrelevant.

The arguments for the current implementation (which is not an
implementation of the agreed design) is implementation constraints.
This tells me that if we can't implement our design then we need to make
a new design.  I realize thats an inflammatory remark, but I don't think
we're far off.  I don't have any problem with label reconciliations or
any of the previously contentious parts, only the access control checks.

So what do I think are the pieces needed to express labeled networking
security goals?

Using a send as an example, and having the assumption that the
association has the label of the domain on the other end:

1. can the domain write to the socket?

2. can the socket send this packet in the basic networking sense
(ip address, port, protocol, etc)?

3. can the domain(socket?) match a particular spd entry?

4. can the domain send to the ipsec association?

5. can the packet flow into the ipsec association?

I don't see how the multiple checks nor all traffic eventually flowing
into network_t addresses anything in the above.  My understanding of the
agreed design succeeded in meeting these goals.  Coincidentally, the
mainline kernel already does #1-4 for the non labeled networking case.
The last one seems like a nice check, since you can say "only
httpd_client_packet_t and httpd_server_packet_t" can go into a apache_t
association; however, its debatable as to whether or not its strictly
required, if it came down it.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
