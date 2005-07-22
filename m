Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MIPugA008332
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:25:56 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MIL8YP014496
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 18:21:08 GMT
Subject: RE: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221528.j6MFSSvx017547@gotham.columbia.tresys.com>
References: <200507221528.j6MFSSvx017547@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 14:18:40 -0400
Message-Id: <1122056320.29328.38.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Are you imagining a file like local.users for network related configuration -
> this would allow direct modification of the configuration files for those that
> would prefer that to using tools / libsemanage?

If you're talking about ports and interfaces, then yes, that would make
sense. For iptables-generated allow rules and such, I don't
know....it actually makes little sense to write out the rules.

>  Any idea about what the rules
> that will be generated will look like? I'm trying to get a handle on exactly how
> this network configuration will look and whether it is going to require pulling
> out parts of the existing policy.

I don't know what the rules will look like yet, but please note
that iptables has both deny and allow rules...right...
I'm not sure how we can handle the deny ones.

>  For example, would the apache module stop
> allowing any send / receive on any node, netif, or port and then there would be
> a default local network configuration provided? 

So, when the firewall shuts down, the default networking policy
is reset to ACCEPT all in our firewall scripts, but that's
done only after the interfaces are shut down. Similarly,
the firewall comes up before the interfaces go up...
I'm not sure how all that applies to selinux.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
