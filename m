Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MCgPgA004785
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 08:42:25 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MCaoKk016930
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:36:51 GMT
Message-Id: <200507221237.j6MCbHvx015373@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 08:37:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1122033206.19625.7.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> 
> ------
> 
> Let me get to the point - we have iptables, which configures netfilter.
> Then we have policy, which configures selinux. That's two configuration
> systems, and having two configuration systems is not good - you have to
> go change both to get anything to work. Furthermore, iptables has
> a superior configuration system from a user's point of view, because
> it's easier to work with than writing policy in m4 macros.
> 
> So, what do we do about that? Dan is suggesting we might integrate
> iptables with policy, and have it automatically generate some rules,
> pertaining to interfaces, ports, etc... we can now query sepol
> for the port label, and query sepol for the interface label.
> 
> I'm not sure how this should be done, or whether this should be done,
> but it merits further discussion. Should modules play a role into
> this...is it a good idea...etc.

I understand the goal of this integration and agree that it is difficult for a
user to specify network policy in two places. The same could be said, though,
about many aspects of the policy. There must be agreement between the apache
config and the apache policy for example. This is a general failing of Linux (it
is also a strength in that the loose coupling allows replacing large subsystems
easily).

Having said that, I have a _very_ strong preference for all of the network
policy being part of the SELinux policy. Many of our customers care about the
ability to reason about and analyze SELinux policy in an automated way. If
significant parts of the policy are moved out of the SELinux policy proper or,
more importantly, expressed in a language with a model that has received none of
the rigorous scrutiny that type enforcement has received then our ability to do
this automated analysis will be seriously degraded. This would be a real loss,
particular for customers that need higher levels of assurance about the
correctness of the security of their systems (I'm using the term assurance in an
informal way here).

I would suggest that making this choice based on whether the iptables syntax or
the SELinux policy syntax is more intuitive is missing an important point: both
are too complicated and potentially beyond the ability or patience of many users
/ admins that will want to make these customizations. Why not create a tool that
generates both and leave the loose coupling? That frees you to do some real
user-interface work to create something easier to understand.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
