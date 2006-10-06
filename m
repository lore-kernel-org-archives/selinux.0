Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96DVnWs024695
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 09:31:49 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96DUX4o012218
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 13:30:34 GMT
Subject: Denials from newest kernel
From: Joshua Brindle <jbrindle@tresys.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 09:31:59 -0400
Message-Id: <1160141519.16462.33.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I grabbed Erics new kernel builds and installed them and got some
interesting denials. I started with no secmark rules whatsoever on the
machine.

avc:  denied  { flow_out } for  pid=1815 comm="avahi-daemon" saddr=10.1.13.105 daddr=224.0.0.22 netif=eth0 scontext=system_u:object_r:unlabeled_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=packet

the target seems reasonable (unlabeled_t since there are no secmark
rules) but the target should have been network_t (the unlabeled
association) right?

avc:  denied  { flow_in } for  pid=1815 comm="avahi-daemon" scontext=system_u:object_r:unlabeled_t:s0 tcontext=system_u:system_r:avahi_t:s0 tclass=packet

don't understand this one at all, source should be network_t (i thought)
and target should be a packet object (and there aren't any). Why is it
getting the domain context?

avc:  denied  { recv } for  pid=1815 comm="avahi-daemon" src=5353 dest=5353 netif=eth0 scontext=system_u:system_r:avahi_t:s0 tcontext=system_u:system_r:avahi_t:s0 tclass=packet

So the source here seems correct but the target is avahi_t again..


I'm going to load up some secmark rules as soon as I get an iptables
build that lets me (wonder why rawhides doesn't come with SECMARK :\ )
and try this again.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
