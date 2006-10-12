Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CKBhSl008076
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 16:11:43 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9CKB3RR000187
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 20:11:03 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "Joshua Brindle" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Thu, 12 Oct 2006 15:06:11 -0500
Message-ID: <001501c6ee39$dd9cb8a0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1160679078.5980.71.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I read this email several times, and as a policy writer I repeatedly
> came up with this question: what security goals can I express with the
> multiple "security points" going though the mangle table?

First of all, any time you have an indirection such as this available,
that could serve to simplify policy and/or make it flexible. You could
for example have the "initial" netfilter contexts specified based on a
generic set of attributes (without taking the interface into account for
example), and then have a later rule specify a secpoint on the interface.
This can currently only be leveraged for the outbound however, since no
such indirection is currently available for the inbound.

As for what security goals can be expressed: the questions I would ask are
the following:

What security goals can I NOT express in the new paradigm that I can
in the existing paradigm?

Answer: 0

What security goals can I express in the new paradigm that I can NOT
in the existing paradigm?

Answer: Flow controlling on forwarded traffic, localhost traffic labeling.

>  I thought
> about this for a couple hours and could not come up with an answer.
> 
> I believe that for each direction, the mangle table represents _one
> labeling decision_.  Its just like the file_contexts: 
> multiple lines may
> match and the last one wins.  Do we have access checks for each line
> matched in the file_contexts?  No.  The access check is 
> performed after
> all of the file context entries have been tested when the file is
> relabeled.  The intermediate labels are irrelevant; if they were
> relevant, setfiles would relabel the file for each matching line in
> file_contexts.  In the same line of logic, the intermediate labels in
> the mangle table are irrelevant.

There is no denying they *should* have been irrelevant, but here we do
NOT have a choice (at least that I can think of).

> 
> The arguments for the current implementation (which is not an
> implementation of the agreed design)

but very close to the agreed design, with the "fallout" from the
implementation constraints to be "manageable" in the policy.

> is implementation constraints.
> This tells me that if we can't implement our design then we 
> need to make
> a new design.

Before talking about a new design the question to be answered is
whether the fallout from the digression can be managed in the
policy or not.

>  I realize thats an inflammatory remark, but I 
> don't think
> we're far off.  I don't have any problem with label reconciliations or
> any of the previously contentious parts, only the access 
> control checks.

which should be manageable in the policy.

> 
> So what do I think are the pieces needed to express labeled networking
> security goals?
> 
> Using a send as an example, and having the assumption that the
> association has the label of the domain on the other end:
> 
> 1. can the domain write to the socket?
> 
> 2. can the socket send this packet in the basic networking sense
> (ip address, port, protocol, etc)?
> 
> 3. can the domain(socket?) match a particular spd entry?
> 
> 4. can the domain send to the ipsec association?

This is now implicit by making sure the domain context matches
exactly with the SA context.

> 
> 5. can the packet flow into the ipsec association?

This is actually the same question as "4" above. What's the difference?

> 
> I don't see how the multiple checks nor all traffic eventually flowing
> into network_t addresses anything in the above.

The thing to really see is how these come in the way of accomplishing
any of the above goals.

>  My 
> understanding of the
> agreed design succeeded in meeting these goals.

As does, I would contend, the implementation. It's just that policy
needs to be laid out taking the constraints into account.

>  Coincidentally, the
> mainline kernel already does #1-4 for the non labeled networking case.

But lacking in the features provided by the new controls.

> The last one seems like a nice check, since you can say "only
> httpd_client_packet_t and httpd_server_packet_t" can go into 
> a apache_t
> association; however, its debatable as to whether or not its strictly
> required, if it came down it.

Like I mentioned yesterday, there's no IPSec stuff involved at the
netfilter level. A packet can only use a labeled IPSec association (SA)
iff the domain on the packet EXACTLY matches the domain on the SA
as signified by the constraint in the policy patch I posted a week or so
back.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
