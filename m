Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19618
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 11:15:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA06863
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:14:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA06859
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 15:14:58 GMT
Date: Fri, 24 May 2002 11:14:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: Panic on rebooting, Redhat 7.3, 2 May SELinux
In-Reply-To: <1022003332.1566.8.camel@vorpal.mcs.drexel.edu>
Message-ID: <Pine.GSO.4.33.0205241110430.23057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Please use ksymoops or gdb to translate the addresses to symbols
based on the actual kernel that you were running at the time of the
Oops.  Other useful information:  your kernel configuration and any
modules that were inserted.

On 21 May 2002, Justin Smith wrote:

> I have stumbled onto the kernel panic that occurred the first time I
> used the 2 May release with RH 7.3. This time, I was able to copy down
> some of the information:
>
> ---------------------------------
>
> Unmounting file systems
> Unable to handle kernel null pointer dereferencing at address 000000ac
>
> Printing EIP:
> *pdc = 00000000
>
> Oops: 0000
> CPU: 0
> EIP: 0010: [<c0127495>]
> Tainted: P
>
> EFLAGS: 00010282
>
> eax: 00000000
> ebx: c8ee6000
> ecx: 00000004
> edx: d2e9d570
> esi: d2d67460
> edi: d2e9d570
> ebp: c0000000
> esp: c8ee7e68
>
> Process
> umount
> (pid: 6001
> stackpage=c8ee7000)
>
> stack: c927c180 c013470f c927c180 d2e9d00 c1311f00 00000000
>
>
>
> /etc/rc6.d/S01reboot: line 4 6001 Segmentation fault
> --------------------------------------------------
>
> Additional information: I am using the Reiser file system for all
> partitions except /.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
