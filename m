Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA10712
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 10:17:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19298
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 15:17:56 GMT
Received: from lacrosse.corp.redhat.com (host154.207-175-42.redhat.com [207.175.42.154])
	by jazzband.ncsc.mil  with ESMTP id PAA19294
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 15:17:53 GMT
Message-ID: <3AA8F3EF.83B711A@redhat.com>
Date: Fri, 09 Mar 2001 10:17:03 -0500
From: Michael Tiemann <tiemann@redhat.com>
MIME-Version: 1.0
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
CC: "'Wade Hampton'" <whampton@staffnet.com>, selinux@tycho.nsa.gov
Subject: Re: RedHat 7.0?
References: <72222DC86846D411ABD300A0C9EB08A1015240BD@csoc-mail-box.csoconline.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Another solution is to update your compiler to the latest errata version. 
With this compiler, you can get all the optimizations we put into the
user-level compiler, plus it works on the kernel (certainly for Wolverine,
our second public beta).

M

"Westerman, Mark" wrote:
> 
> I had to modify the Makefile to point the CC compiler to kgcc.
> The is a bug somewhere the prevents the gcc from compiling the
> kernel. Redhat has kgcc to compile the kernel. I have a working
> somewhat version of the Redhat 7.0. Let me know how it goes
> with your try of 7.0
> 
> Mark
> 
> -----Original Message-----
> From: Wade Hampton [mailto:whampton@staffnet.com]
> Sent: Thursday, March 08, 2001 8:07 AM
> To: selinux@tycho.nsa.gov
> Subject: RedHat 7.0?
> 
> Greetings,
> 
> Has anyone built slinux on RedHat 7.0, 7.0 patched
> to latest GCC, or 7.9x (Fisher or Wolverine)?
> I am trying to build it with 7.0 patched running
> in VMWare and am getting build errors:
> 
> Multiple warnings on "%eax" used instead of "%ax" due to 'l' suffix....
> ...
> 
> Checksum.S:231  badly punctuated parameter list in #define
> Checksum.S:237  badly punctuated parameter list in #define
> 
> make[2]:  *** [checksum.o] error 1
> make[1]:  *** [first_rule] error 2
> make: *** [_dir_arch/i386/lib] error 2
> 
> Cheers,
> --
> W. Wade, Hampton  <whampton@staffnet.com>
> If Microsoft Built Cars:  Every time they repainted the
> lines on the road, you'd have to buy a new car.
> Occasionally your car would just die for no reason, and
> you'd have to restart it, but you'd just accept this.
> 
> --
> You have received this message because you are subscribed to the selinux
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
