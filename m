Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA14727
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 14:42:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA10725
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 19:42:34 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA10719
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2001 19:42:33 GMT
Date: Fri, 9 Nov 2001 14:42:38 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Hugo F. Martinez" <hmartinez@cti.com.ar>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problems with pcmcia
In-Reply-To: <3BEC7497.58C585C5@cti.com.ar>
Message-ID: <Pine.GSO.4.33.0111091440270.125-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 9 Nov 2001, Hugo F. Martinez wrote:

> Hi i just installed selinux-200110161355 on RedHat 7.1 compiled ok but
> when i want to compile a module for my pcmcia card (WaveLAN) i get the
> following error message.
>
> [root@radon-ntb wireless]# make all
> cc   -MD -O3 -Wall -Wstrict-prototypes -pipe -I../include/static
> -I/usr/src/slinux/kernel/include -I../include  -D__KERNEL__ -DMODULE -c
> netwave_cs.c
> In file included from /usr/src/slinux/kernel/include/asm/uaccess.h:8,
>                  from ../include/static/asm/uaccess.h:49,
>                  from ../include/pcmcia/k_compat.h:161,
>                  from netwave_cs.c:41:
> /usr/src/slinux/kernel/include/linux/sched.h: In function
> `process_file_mac_permission':
> /usr/src/slinux/kernel/include/linux/sched.h:957: structure has no
> member named `i_sid'
> make: *** [netwave_cs.o] Error 1

Looks like you still have the old SELinux prototype in /usr/src/slinux.
If you are using the new LSM-based SELinux prototype, then you should be
building your modules against the LSM kernel, so you should be pulling
your kernel headers from lsm/include.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
