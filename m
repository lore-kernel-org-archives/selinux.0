Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MJ9JgA008798
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:09:19 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MJ4UYP019527
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 19:04:30 GMT
Subject: RE: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221840.j6MIe4vx019652@gotham.columbia.tresys.com>
References: <200507221840.j6MIe4vx019652@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 15:01:58 -0400
Message-Id: <1122058918.29328.55.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> This brings up the tension that Josh mentioned between the 'runtime' nature of
> the iptables policy and the selinux - regenerating the policy everytime you
> invoke iptables seems problematic. This and the whole everything is allowed
> until denied approach seems like it is going to make this challenging.

To solve that problem I guess you'd add a tool that could process 
iptables rules in a loop, rather than restarting the process at every
rule. 

Once you have a concept of a config block of rules, instead of a
bunch of invocations...you could do configuration-wide auditing and say:
no DENY rules or ALLOW default policy are allowed on an selinux system.
Of course, that's completely changing the way iptables works, at which
point you lose the benefit of having frontend tools already 
written for you.

Then, if I remember correctly, there was talk about preserving
attributes in the kernel... will that help us? If we remove
the netif_type attribute somehow once iptables starts managing
that interface? I don't know anything about kernel-side selinux,
so I'm not sure if that's even possible.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
