Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10078
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 08:45:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA12098
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 13:45:21 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id NAA12094
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 13:45:19 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015240BD@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Wade Hampton'" <whampton@staffnet.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: RedHat 7.0?
Date: Fri, 9 Mar 2001 07:45:37 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I had to modify the Makefile to point the CC compiler to kgcc.
The is a bug somewhere the prevents the gcc from compiling the
kernel. Redhat has kgcc to compile the kernel. I have a working
somewhat version of the Redhat 7.0. Let me know how it goes 
with your try of 7.0

Mark

-----Original Message-----
From: Wade Hampton [mailto:whampton@staffnet.com]
Sent: Thursday, March 08, 2001 8:07 AM
To: selinux@tycho.nsa.gov
Subject: RedHat 7.0?


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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
