Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DF6Das003157
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 11:06:14 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k9DF4sBI015713
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 15:04:55 GMT
Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <001501c6ee39$dd9cb8a0$cc0a010a@tcssec.com>
References: <001501c6ee39$dd9cb8a0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 11:06:53 -0400
Message-Id: <1160752013.5980.102.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-12 at 15:06 -0500, Venkat Yekkirala wrote:
> What security goals can I express in the new paradigm that I can NOT
> in the existing paradigm?
> 
> Answer: Flow controlling on forwarded traffic, localhost traffic labeling.

Now that you mention the forwarded traffic, I can see this being useful
in the context of making decision in a network router, so I'll concede
the point on multiple checks.  Though I'm curious why localhost traffic
labeling would be tied to the multiple checks.

> > 4. can the domain send to the ipsec association?
> > 
> > 5. can the packet flow into the ipsec association?
> 
> This is actually the same question as "4" above. What's the difference?

This is like a filesystem associate check.  As an example, we have
mozilla_t communicating with httpd_t.  Mozilla_t needs to send
dns_client_packet_t for doing DNS lookups, and httpd_client_packet_t is
obvious.  Mozilla_t needs to send/recv to the httpd_t association.
Without 5, we can't restrict the association traffic to just
http_client_packet_t, so mozilla_t can't be denied sending/receiving
dns_client_packets_t over the httpd_t association.

> Like I mentioned yesterday, there's no IPSec stuff involved at the
> netfilter level. A packet can only use a labeled IPSec association (SA)
> iff the domain on the packet EXACTLY matches the domain on the SA
> as signified by the constraint in the policy patch I posted a week or so
> back.

I'm glad you mentioned this constraint, because I forgot about it.  I
hadn't planned on adding it to the policy.  In light of setsockcreate
and a SELinux aware inetd in the future (having the sockets be the type
of their child processes), this constraint makes less sense.  I also
find it objectionable to have the code depend on a policy when there is
no guarantee that the constraint will be there.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
