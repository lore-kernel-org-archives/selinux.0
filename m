Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11588
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 12:55:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA05521
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 16:53:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA05517 for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 16:53:58 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g5PGtEu18460
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 12:55:14 -0400 (EDT)
Date: Tue, 25 Jun 2002 12:55:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: libsecure fails to compile (fwd)
Message-ID: <Pine.GSO.4.33.0206251254250.7048-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I forgot to include the list on my original reply below.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

---------- Forwarded message ----------
Date: Tue, 25 Jun 2002 12:24:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: gdsmarshall@hushmail.com
Subject: Re: libsecure fails to compile


On Tue, 25 Jun 2002 gdsmarshall@hushmail.com wrote:

> make -C src
> make[1]: Entering directory `/root/selinux/selinux/libsecure/src'
> cc -o arch/i386/fstat64_secure.o -c -I../include -I/usr/local/selinux/include arch/i386/fstat64_secure.c
> In file included from arch/i386/fstat64_secure.c:6:
> arch/i386/xstat64_conv.h: In function `xstat64_conv':
> arch/i386/xstat64_conv.h:38: structure has no member named `__st_ino'
> make[1]: *** [arch/i386/fstat64_secure.o] Error 1
> make[1]: Leaving directory `/root/selinux/selinux/libsecure/src'
> make: *** [all] Error 2
> gatekeeper:~/selinux/selinux/libsecure#
>
> I understand xstat64_conv.h is missing __st_ino, what should this be please?
>
> I had no problems compiling the kernel which is now running quite happily,
> Linux gatekeeper 2.4.18-selinux #4 Mon Jun 24 18:18:25 BST 2002 i486 unknown
>
> I am using debian (stable)  I know Russell Coker has done lots of work with SELinux on debian, but I can not get to the stage of compiling the utilities yet.

Are you using the Debian selinux packages created by Russell, or the
upstream SELinux distribution?

Try removing the '#define _HAVE_STAT64___ST_INO' in
libsecure/src/arch/i386/kernel_stat64.h.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
