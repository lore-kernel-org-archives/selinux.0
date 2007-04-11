Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3B0Bpp4031373
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 20:11:52 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3B0BoSl002423
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 00:11:50 GMT
Message-ID: <461C27C0.6030805@manicmethod.com>
Date: Tue, 10 Apr 2007 20:11:44 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: John Wan <J.Wan@mbs.edu>, selinux@tycho.nsa.gov
Subject: Re: Would the SELinux  act as a TippingPoint IPS to block the nasty
 Trojan traffic?
References: <11C75E9645FB0F428EFA37F5BEADFEA10419916A@CAR-MBUS-MX1.mbus.local> <200704101118.58830.paul.moore@hp.com>
In-Reply-To: <200704101118.58830.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday, April 10 2007 7:30:23 am John Wan wrote:
>   
> There are two things which immediately spring to mind:
>
> 1. SELinux as a general rule does not do packet inspection like some IDS/IPS 
> solutions
>   
SELinux doesn't need to do the packet inspection. The packet inspection 
should be done in userspace and the userspace daemon can take the 
appropriate action. One such action would be flipping some booleans when 
an attack is detected which would close down some network access. The 
obvious disadvantage here (aside from the raciness which doesn't seem to 
phase IPS advocates) is that there is no way of isolating a single 
session and shutting off that access, once an attack is detected and 
reacted to all traffic labeled the same as the session being attacked 
would be killed (eg., if using iptables based controls any attack 
detected on an http port would kill all http traffic).

OTOH it might be possible to use userspace queuing of packets in 
conjunction with secmark to label bad packets something else but that is 
barely different from just using the DROP target. Ofcourse this all 
depends on something local receiving the traffic due to lack of 
forwarding controls...

I'd love to see your suggestions on solving the forwarding problem, I 
suppose those are forthcoming? :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
