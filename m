Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20199
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 09:17:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA14281
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 13:17:20 GMT
Received: from mrelay.jrc.it (mrelay.jrc.it [139.191.1.65])
	by jazzband.ncsc.mil  with ESMTP id NAA14277
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 13:17:19 GMT
Received: from mrelay.jrc.it (localhost [127.0.0.1])
	by mrelay.jrc.it (LMC5614B) with ESMTP id f93DHlW15787
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 15:17:47 +0200 (MEST)
Received: from isis-ms.sti.jrc.it (isis-gs.sti.jrc.it [139.191.8.244])
	by mrelay.jrc.it (LMC5614A) with ESMTP id f93DHlJ15783
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 15:17:47 +0200 (MEST)
Received: from jrc.it ([139.191.63.149]) by isis-ms.sti.jrc.it
          (Netscape Messaging Server 4.15) with ESMTP id GKMSXI00.LAY for
          <selinux@tycho.nsa.gov>; Wed, 3 Oct 2001 15:17:42 +0200
Message-ID: <3BBB0FF1.6060309@jrc.it>
Date: Wed, 03 Oct 2001 15:17:37 +0200
From: "James Bishop" <james.bishop@jrc.it>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Compiling for SuSE 7.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good afternoon,

This is my first posting to this list, so "hello world!\n".

I'm building the lsm-selinux-200109261436.tgz distribution on my SuSE 
7.2 system. Up to item 6) in the installation instructions, everything 
has worked without a hitch.

Compilation of the modified applications in the selinux/utils 
sub-directory required commenting out the contents of the 
fileutils-4.0/m4/isc-posix.m4 file (I don't know m4); and changing the 
Makefile in psmisc to link pstree with the ncurses library instead of 
the termcap library.

Now I'm up against the differences between the RedHat 7.1 and SuSE 7.2 
distributions. The MCONFIG files of the util-linux package are different 
(also SuSE 7.2 uses util-linux-2.11). I know from past experience that 
getting things wrong with util-linux is "a bit of a bore".

If I proceed to install the utils package as is, can anyone tell me 
whether login will still work? Or could / should I modify the MCONFIG 
file of SELinux to bring it closer into line with the SuSE 7.2 version?

I see that the SELinux Makefile moves the original /bin/login to 
/bin/login.old and then installs the new /bin/login. If I could ensure 
that /bin/login.old was used (perhaps on the basis of the result of the 
uname command - SuSE 7.2 is kernel version 2.4.4)I would feel better. 
How could I do this?

Should I remove shadow passwords from the SuSE 7.2 system before 
proceeding, or can I leave them in place?

All the best,
James Bishop


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
