Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AFJlcC005455
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 11:19:47 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3AFJeUX026962
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 15:19:41 GMT
From: Paul Moore <paul.moore@hp.com>
To: "John Wan" <J.Wan@mbs.edu>
Subject: Re: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Tue, 10 Apr 2007 11:18:58 -0400
Cc: selinux@tycho.nsa.gov
References: <11C75E9645FB0F428EFA37F5BEADFEA10419916A@CAR-MBUS-MX1.mbus.local>
In-Reply-To: <11C75E9645FB0F428EFA37F5BEADFEA10419916A@CAR-MBUS-MX1.mbus.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704101118.58830.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, April 10 2007 7:30:23 am John Wan wrote:
> I am new to SELinux, I would like to configure the SELinux (on a Linux
> box running RH EL AS4 ) to work as a Proactive IPS device (such as
> TippingPoint Intrusion Prevention Systems--- Proactive Network Security,
> it would cost about $20K, which is way beyond my budget). I wish the
> SELinux would work as an IPS device to protect our staff network from
> our wireless network (the Linux RH EL AS4 box with Chillispots & SELinux
> connects the staff network and the wireless network).  For example, a
> student wireless laptop with a Trojan virus would not be able to go
> through the Linux box (with Chillispots &SELinux) from the wireless
> network to the staff network. This is because of the SELinux would act
> as a TippingPoint IPS to block the nasty Trojan traffic.
>
>  My question is: Is this possible?

I'm not very familiar with TippingPoint but I assume from you description that 
what you are looking for is a piece of software that would identify certain 
network traffic signatures and trigger blocking behavior when such signatures 
were found.  If that is the case I think SELinux (in it's current form) alone 
will not accomplish what you are trying to do, however, it could be part of 
the solution used to protect the integrity of the router.

> Anti-virus and IDS/IPS systems based on signatures are reactive,
> operating only on known threats, which is why zero-day exploits are so
> prized by malware authors.
>
> SELinux, on the other hand, can be compared to a firewall with a default
> "deny any" rule, and a set of "allow" rules to only permit actions that
> are necessary for proper system operation.
>
> My ultimate goal is to use the SELinux policy to block the abnormal
> network traffic (such as a Trojan virus) from one network to another
> network. Or the Linux box would be able to stop the contagious network
> traffic in the wireless network by using the SELinux policy.
>
> Is that possible? Or am I terribly wrong here?

There are two things which immediately spring to mind:

1. SELinux as a general rule does not do packet inspection like some IDS/IPS 
solutions
2. SELinux does not provide any packet forwarding access controls

Granted, item #2 is something we (or at least I) want very badly and will be 
working on over the course of this year.  The initial work will most likely 
be limited to external labels (CIPSO, labeled IPsec, etc.), but it should be 
possible to expand the packet forwarding controls to make use locally 
generated labels as well (SECMARK).  As for item #1, perhaps others have some 
thoughts on this, but I don't see this happening anytime soon.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
