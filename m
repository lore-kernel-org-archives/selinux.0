Message-ID: <72222DC86846D411ABD300A0C9EB08A1015244D3@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Curtis Greer'" <curtlg@msn.com>, SELinux@tycho.nsa.gov
Subject: RE: Selinux on smp
Date: Wed, 12 Feb 2003 15:09:42 -0600
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you are using grub and have a root=LABEL=/ I have seen
that fail with the same error messages.

Try
root=/dev/XXXXX

where XXXXX is where your root file system is loaded.

Mark

-----Original Message-----
From: Curtis Greer [mailto:curtlg@msn.com]
Sent: Wednesday, February 12, 2003 1:09 PM
To: SELinux@tycho.nsa.gov
Subject: Selinux on smp


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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
