Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA21235
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2001 19:27:28 -0400 (EDT)
From: james@spunkysoftware.com
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA19554
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2001 23:26:09 GMT
Received: from host7.hrwebservices.net ([216.74.100.93])
	by jazzswing.ncsc.mil  with ESMTP id XAA19550
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2001 23:26:03 GMT
Received: from 1cust58.tnt1.glen-innes.au.da.uu.net ([63.60.254.185] helo=spunky)
	by host7.hrwebservices.net with asmtp (Exim 3.20 #1)
	id 15bVmi-0006nB-00
	for selinux@tycho.nsa.gov; Mon, 27 Aug 2001 19:27:12 -0400
Message-ID: <005201c12f50$c8891240$b9fe3c3f@spunky>
Reply-To: <james@spunkysoftware.com>
To: <selinux@tycho.nsa.gov>
Subject: No RAM swapout to disk for "sandbox" run programs
Date: Tue, 28 Aug 2001 09:34:10 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

PGP uses, or did use, a (sloppy?) memory driver which prevented process
address space active in RAM from being swapped out to disk.

I have written Linus Torvalds talking about a range of PIDs, or a new field
in the task_struct, which would indicate to the mm in the kernel that
swapping this process' address space out to disk was forbidden.

A program can be launched from a shell that acts as a "sandbox" to run
programs that shouldn't be swapped to disk. All tasks forked from this
should be regarded as unswappable. This would be useful for encryption
programs, since PGP on WinNT at least was already doing it. I'm not sure how
GnuPG handles this at the moment.

Any thoughts anyone?

Also, I am wondering where I can get software that will allow me to look at
arbitrary memory ranges, the purpose being to look at "deleted" files on
Windows and Linux. Anybody know of any such software? Is there a kernel
module that allows this?

James Buchanan



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
