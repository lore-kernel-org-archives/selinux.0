Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAM67Ii023972
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 17:06:07 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAM4Swg026944
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 22:04:29 GMT
Received: from lkcl.net (host81-153-247-118.range81-153.btcentralplus.com [81.153.247.118])
	by open.hands.com (Postfix) with ESMTP id 256ADBFB4
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 22:05:59 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Cct4A-0001WR-IT
	for selinux@tycho.nsa.gov; Fri, 10 Dec 2004 22:16:46 +0000
Date: Fri, 10 Dec 2004 22:16:46 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [owner@bugs.debian.org: Bug#271030 acknowledged by developer (Bug#271030: fixed in xfree86 4.3.0.dfsg.1-9)]
Message-ID: <20041210221646.GE5239@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

wha-heeey!

[btw i hope this was the right thing to do :) ]

l.

----- Forwarded message from Debian Bug Tracking System <owner@bugs.debian.org> -----

This is an automatic notification regarding your Bug report
#271030: xfree86-common: init script should restore SELinux security context for ICE and X server sockets after chmod/chown,
which was filed against the xfree86-common package.

It has been closed by one of the developers, namely
fabbione@fabbione.net (Fabio M. Di Nitto).

   * If the restorecon command is available, restore SELinux file security
     contexts after setting up X server and ICE socket directories
     (xfree86-common) and font server socket directories (xfs) after creating
     them in the init scripts.  (Closes: #268812, #271030)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
