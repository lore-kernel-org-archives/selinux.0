Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3B5hRb020488
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 06:05:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB3B5gqY010137
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 11:05:42 GMT
Received: from tesla.eecs.ku.edu (tesla.eecs.ku.edu [129.237.87.2])
        by jazzband.ncsc.mil  with ESMTP id hB3B5f0o010129 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 11:05:42 GMT
Received: from tesla.eecs.ku.edu (tesla.eecs.ku.edu [129.237.87.2])
	by tesla.eecs.ku.edu (8.12.10/8.12.3) with ESMTP id hB3B5asQ013700
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 05:05:36 -0600 (CST)
	(envelope-from nmucci@eecs.ku.edu)
Date: Wed, 3 Dec 2003 05:05:36 -0600 (CST)
From: Nicholas Mucci <nmucci@eecs.ku.edu>
To: selinux@tycho.nsa.gov
Subject: machine check exception
Message-ID: <20031203043334.S1461@tesla.eecs.ku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
	Recently I installed the 2.6.0-test6-selinux1 kernel on my box and
noticed that it will occassionally throw a machine check exception after
detecting IDE devices on startup.  I never saw this occur with the
2.6.0-test3 selinux kernel, 2.4.18 from RedHat 8, 2.4.9 or 2.4.8 on this
machine.  I know there is probably a hardware issue that is causing this,
but I am curious as to why the MCE only surfaces now.  If I use the older
kernels this problem does not show up and I don't see an MCE.  Has anyone
seen or heard of this before?  The MCE handler was modified in test5
to remove "useless junk" that caused problems on some cpus.  This may be
just a mainstream 2.6 thing, but I figured I would check and see if
anybody here has any thoughts or ideas about this.

Thanks,

---------------------------------------
Nicholas Mucci
Institute for Educational Research
and Public Service
University of Kansas
Home: 785-812-2520
Cell: 847-445-7023


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
