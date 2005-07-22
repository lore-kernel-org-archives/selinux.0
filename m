Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MIj7gA008542
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:45:07 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MIeIYP016617
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 18:40:19 GMT
Message-Id: <200507221840.j6MIe4vx019652@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 14:40:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1122056320.29328.38.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> >  Any idea about what the rules
> > that will be generated will look like? I'm trying to get a handle on exactly
> how
> > this network configuration will look and whether it is going to require
> pulling
> > out parts of the existing policy.
> 
> I don't know what the rules will look like yet, but please note
> that iptables has both deny and allow rules...right...
> I'm not sure how we can handle the deny ones.
> 
> >  For example, would the apache module stop
> > allowing any send / receive on any node, netif, or port and then there would
> be
> > a default local network configuration provided?
> 
> So, when the firewall shuts down, the default networking policy
> is reset to ACCEPT all in our firewall scripts, but that's
> done only after the interfaces are shut down. Similarly,
> the firewall comes up before the interfaces go up...
> I'm not sure how all that applies to selinux.

This brings up the tension that Josh mentioned between the 'runtime' nature of
the iptables policy and the selinux - regenerating the policy everytime you
invoke iptables seems problematic. This and the whole everything is allowed
until denied approach seems like it is going to make this challenging.

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
