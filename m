Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAL2c3Rb026814
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 21:38:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAL2bPp5018183
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 02:37:25 GMT
Received: from imail.etsu.edu (imail.etsu.edu [151.141.8.36])
	by jazzswing.ncsc.mil  with ESMTP id hAL2bOt0018177
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 02:37:24 GMT
Date: Thu, 20 Nov 2003 21:37:48 -0500
Message-Id: <200311202137.AA25034968@imail.etsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Achanta, Venkata Phani" <ZVPA2@imail.etsu.edu>
Reply-To: <ZVPA2@imail.etsu.edu>
To: <russell@coker.com.au>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Kernel panic: No init found with SE patched kernel 2.6.0-test6
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi everybody,

I have applied SELinux patch against kernel 2.6.0-test6 and i get the following error when i boot the new kernel.

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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
