Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10600
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 11:53:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0QGrBI25907
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 16:53:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0QGr9f25903 for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 16:53:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: UML
Date: Sun, 26 Jan 2003 17:52:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301261752.58069.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On http://www.coker.com.au/uml/ I have put some patches for User Mode Linux 
and SE Linux.

uml-patch-2.4.20-1um-djc.bz2 is the UML patch that I used.

uml-se.patch is the patch for the code I wrote, it applies on a kernel that 
has the lateset LSM patch and the UML patch applied.  These patches do 
conflict a bit and one file has to be edited by hand.

lsm-on-uml-2.4.20.patch.bz2 is the patch to apply on top of the UML patch for 
all LSM code and my code to make LSM and SE work.

All my code does is patch the sys_exec_secure() system call.  On Intel it uses 
a pt_regs structure so that the kernel code can fix up the registers for the 
new process.  On UML this is not necessary so I have put the code in an 
arch-specific file and have separate versions for i386 and UML.

Thanks to Jeff Dike for the advice.

NB  I have not yet tested whether my patch breaks compilation for i386.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
