Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA06208
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2001 23:18:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA08619
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2001 03:18:14 GMT
Received: from mail21.bigmailbox.com (mail21.bigmailbox.com [209.132.220.195])
	by jazzband.ncsc.mil  with ESMTP id DAA08615
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2001 03:18:13 GMT
Date: Mon, 30 Jul 2001 20:18:21 -0700
Message-Id: <200107310318.UAA03373@mail21.bigmailbox.com>
Content-Type: text/plain
Mime-Version: 1.0
From: "Jonathan Day" <jd9812@my-deja.com>
To: selinux@tycho.nsa.gov, shugal@gmx.de
Subject: Re: seperate kernel modules
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HURD (as is) uses the Mach microkernel, which (frankly) is the pits.

The L4 microkernel (which you can see in L4Linux) is a better design, but still not briliant. There's still a 14% slow-down for some functions.

About the most extreme design is MIT's Exokernel. This takes everything that a microkernel leaves in, and places it in user space. For security, the Exokernel design looks extremely promising, although MIT seems to have abandoned it.

Another kernel design that looks interesting is EROS, which is designed to be secure from the outset.

IMHO, though, seperation is not the answer. Secure boundaries would be much better, as modules have considerable power. If the scope of a module is confined and pre-determined, you should be able to mathematically prove the security.

To be honest, I think that it's about time that somebody DID audit the entire of the Linux core. Not just run some pre-compiler, such as the Stanford Validator, but formally prove each of the core functions correct.

I'm limiting this to the core, as the boundaries of Linux are expanding just too fast to make it viable to start auditing it.

(The FOLK project, that I maintain, is now almost the same size as the Linux kernel it's supposed to patch! And it doesn't even begin to scratch the surface of what patches exist for Linux.)

Further, if you prove the core (including the module-handling code), then you've proved everything you need to. Any rougue module CANNOT impact any other part of the kernel, simply because that would violate the pre/post conditions of the module-handler.




------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
