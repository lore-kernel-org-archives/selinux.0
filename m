Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03108
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2001 09:06:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA18293
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2001 14:06:35 GMT
Received: from staffnet.com (staffnet.com [207.226.80.14])
	by jazzband.ncsc.mil  with ESMTP id OAA18289
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2001 14:06:34 GMT
Message-ID: <3AA791EE.8E90634E@staffnet.com>
Date: Thu, 08 Mar 2001 09:06:38 -0500
From: Wade Hampton <whampton@staffnet.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: RedHat 7.0?
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Greetings,

Has anyone built slinux on RedHat 7.0, 7.0 patched
to latest GCC, or 7.9x (Fisher or Wolverine)?
I am trying to build it with 7.0 patched running
in VMWare and am getting build errors:

Multiple warnings on "%eax" used instead of "%ax" due to 'l' suffix....
...

Checksum.S:231  badly punctuated parameter list in #define
Checksum.S:237  badly punctuated parameter list in #define

make[2]:  *** [checksum.o] error 1
make[1]:  *** [first_rule] error 2
make: *** [_dir_arch/i386/lib] error 2

Cheers,
-- 
W. Wade, Hampton  <whampton@staffnet.com>  
If Microsoft Built Cars:  Every time they repainted the 
lines on the road, you'd have to buy a new car.
Occasionally your car would just die for no reason, and 
you'd have to restart it, but you'd just accept this.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
