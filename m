Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82J3ArT002159
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:03:10 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82J38v0025270
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:03:08 GMT
Received: from [10.1.12.42] (twoface.columbia.tresys.com [10.1.12.42])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id i82J29Sf029716
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:02:09 -0400
Message-ID: <41376E31.60702@tresys.com>
Date: Thu, 02 Sep 2004 15:02:09 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: LD_DEBUG issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

see http://lwn.net/Articles/99137 first for an overview.

Now, we (Gentoo) have this fixed in our glibc to disallow LD_DEBUG on 
suid binaries but i believe it is necessary to add this to AT_SECURE so 
that we can prevent this kind of info leak during domain transitions, 
What do you guys think?

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
