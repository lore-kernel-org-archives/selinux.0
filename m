Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA13410
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 07:59:54 -0500 (EST)
From: j.logsdon@lancaster.ac.uk
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0NCxsI21120
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 12:59:54 GMT
Received: from parmenides.zen.co.uk (parmenides.zen.co.uk [212.23.8.69])
        by jazzband.ncsc.mil  with SMTP id h0NCxrf21116 for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 12:59:53 GMT
Received: from localhost (j.logsdon@localhost)
	by quantex-research.com (8.8.7/8.8.7) with ESMTP id NAA16057
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 13:03:02 GMT
Date: Thu, 23 Jan 2003 13:03:01 +0000 (GMT)
To: selinux@tycho.nsa.gov
Subject: Good news and bad news with the NSA version
Message-ID: <Pine.LNX.4.10.10301231244480.5934-100000@mercury.quantex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi again

Firstly the good news - recall that I had a problem looking for some 2.96
modules with RH8 which uses gcc-3.2.  I cleared out both directories and
re-expanded the tarball that I downloaded.  This compilation went fine and
all the files were relabelled OK.

Then I rebooted using the new kernel and to start with it all looked good
but then hung after the 'initialising random number generator' stage.  The
last messages were:

Jan 23 12:10:43 venus random: Initializing random number generator:
succeeded
Jan 23 12:10:43 venus kernel: Initializing RT netlink socket
Jan 23 12:10:43 venus kernel: Starting kswapd
Jan 23 12:10:43 venus kernel: Journalled Block Device driver loaded
Jan 23 12:10:44 venus kernel: Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).

then after a further 8 minutes my patience ran out and I rebooted into RH8
again.

There was a message during the selinux boot against ne (I am using an old
NE2000 ISA card) that the device had failed so I don't know whether there
would still have been a problem with the networking side.  Under a normal
boot, the networking is set up after the random number generator so the
failure may be due to this.  

Can anyone guide me as to what is wrong?  When it boots into RH8 there is
no delay at all.

TIA

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
