From: "Curtis Greer" <curtlg@msn.com>
To: SELinux@tycho.nsa.gov
Subject: Selinux on smp
Date: Wed, 12 Feb 2003 19:09:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F309haIsUCDZ2UehKla00014297@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been successfully buidling SLEinux 2.4.20 on Red Hat 7.3 on a 
uni-processor Intel based computer. I'm now trying to do the  same on a dual 
processor Dell 6600.  The build works fine.  When attempting to run SELinux 
I get the following errors:

  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
  ds: no socket drivers loaded!
  kmod: failed to exec /sbin/modprobe -s -k block-major-8, errno = 2
  VFS: Cannot open root device "807" or 08:07
  Please append a correct "root=" boot option
  Kernel panic: VFS: Unable to mount root fs on 08:07

  I'm new at this unix game so I'm stuck. Is something missing from the 
kernel?

  Also, there is an error in /usr/selinux/policy/makefile.  In the 
[install-src] section the second line begins with mv.  This should be
  -mv.

  Dr. Curtis L. Greer




_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
