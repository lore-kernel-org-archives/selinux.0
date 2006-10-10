Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AGSjdM021025
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 12:28:45 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AGRRvk010423
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 16:27:28 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFE51@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito"
	 <cpebenito@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: Denials from newest kernel
Date: Tue, 10 Oct 2006 12:28:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I (think) understand what is happening technically, everytime 
> you hit a
> secmark rule the label gets set on the skbuff which triggers an access
> check. Subsequent secmark rules trigger an access check 
> between the old
> label and the new one (I still suspect this should be a different
> permission), but it is still very unintuitive to me, and I'd imagine
> pretty much everyone else.

I wonder what's so unintuitive about the following description:

1. One could define several levels of security check points (one in
   the OUTPUT chain and another in POSTROUTING for example, or
   multiple points in the OUTPUT chain itself for another example).

2. As a packet passes a security point, it assumes the label of the
   security point for further flow control checks at subsequent security
   points.

> 
> (reading your email that just arrived..) 
> You really think that you can tell millions of users that they have to
> use iptables in James' way, with hundreds or thousands of chains and
> they'll buy it?

They will or they will not, to the same that they won't buy the "constraint"
that the last label prevails.

> That is not how iptables is normally used, noone who
> currently uses iptables is going to like it.. 

It's a matter of just looking at all existing and new verdict points and
just sticking in a SECMARK label before issuing the verdict, possibly in
the same rule.

> 
> 
> Anyway, the real issue I have is that I was under the impression

I hope would have been disspelled by the long discussions we have been
having on this stuff. Hopefully, the documentation I posted yesterday
for policy writers is clear enough.

> that
> flow_out was a permission between a packet type and an association, to

between a domain the packet is carrying and a security point domain

> indicate that the packet type can flow out the association type.

to indicate that the packet from the domain can flow out to the security
point domain.

> This
> makes sense and is very useful, so that we can bind very specific
> properties of packets to ipsec associations. 

This is not possible at the iptables level. Your ability to define
the "very specific properties of packets" is limited to what the
spd offers, in conjunction with the polmatch check ofcourse.

ipsec labeling (which is the exact same as the originating domain)
happens long before and has nothing to do with the new flow controls.

> 
> I just don't get why there are denials on flow_in and 
> flow_out that have
> no association in either the source or target, how does flow_out make
> sense for a secmark changing because it hit more than 1 
> iptables rule? 
> 

Hopefully the above addressed this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
