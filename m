Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01436
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 13:51:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA17506
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 17:50:35 GMT
Received: from vorpal.mcs.drexel.edu (IDENT:JEjk//kNDtN8QtUjJHFGOtH0fJVrsKhy@vorpal.mcs.drexel.edu [129.25.6.250])
        by jazzband.ncsc.mil  with ESMTP id RAA17502 for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 17:50:35 GMT
Subject: Panic on rebooting, Redhat 7.3, 2 May SELinux
From: Justin Smith <jsmith@mcs.drexel.edu>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 21 May 2002 13:48:52 -0400
Message-Id: <1022003332.1566.8.camel@vorpal.mcs.drexel.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have stumbled onto the kernel panic that occurred the first time I
used the 2 May release with RH 7.3. This time, I was able to copy down
some of the information:

---------------------------------

Unmounting file systems
Unable to handle kernel null pointer dereferencing at address 000000ac

Printing EIP:
*pdc = 00000000

Oops: 0000
CPU: 0
EIP: 0010: [<c0127495>]
Tainted: P

EFLAGS: 00010282

eax: 00000000
ebx: c8ee6000
ecx: 00000004
edx: d2e9d570
esi: d2d67460
edi: d2e9d570
ebp: c0000000
esp: c8ee7e68

Process
umount
(pid: 6001
stackpage=c8ee7000)

stack: c927c180 c013470f c927c180 d2e9d00 c1311f00 00000000



/etc/rc6.d/S01reboot: line 4 6001 Segmentation fault
--------------------------------------------------

Additional information: I am using the Reiser file system for all
partitions except /.
--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
