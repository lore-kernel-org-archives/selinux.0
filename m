Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hALEZCRb028798
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 09:35:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hALEZBqY015181
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 14:35:12 GMT
Received: from southwark.dsl.net (southwark.dsl.net [65.84.81.9])
        by jazzband.ncsc.mil  with ESMTP id hALEZB0o015178 for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 14:35:11 GMT
Reply-To: <don.patterson@tresys.com>
From: "Don Patterson" <don.patterson@tresys.com>
To: <ZVPA2@imail.etsu.edu>
Cc: "'selinux'" <selinux@tycho.nsa.gov>
Subject: RE: Kernel panic: No init found with SE patched kernel 2.6.0-test6
Date: Fri, 21 Nov 2003 09:35:09 -0500
Message-ID: <000b01c3b03c$aaffc100$5100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200311202137.AA25034968@imail.etsu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a guess, but if your root partition is ext3, your kernel may not be
configured with BUILT-IN ext3 support. This is one of the problems I
encountered while installing SE Linux on Redhat 9. You can also refer to the
mailing archives for further information.
(http://marc.theaimsgroup.com/?l=selinux&m=106695360807833&w=2)

--Don

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Achanta, Venkata Phani
Sent: Thursday, November 20, 2003 9:38 PM
To: russell@coker.com.au
Cc: selinux
Subject: Kernel panic: No init found with SE patched kernel 2.6.0-test6


hi everybody,

I have applied SELinux patch against kernel 2.6.0-test6 and i get the
following error when i boot the new kernel.

VFS:Mounted root(ext2 filesystem)
Red hat nash version 3.4.42 starting
Mounting /proc filesystem
creating block devices
creating root device
Mounting root file system
mount: error 19 mounting ext3
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed:2
umount /initrd/proc failed:2
Freeing unused kernel memory:228k freed
kernel panic:No init found.Try passing init= option to kernel

Any help will be appriciated.Is this a issue with ext3 fs support?

Thanks in Advance,

Venkata Phani Achanta
Graduate Student
Dept of Computer Science
East Tennessee state university
USA







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
