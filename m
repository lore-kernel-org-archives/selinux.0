Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l05KFwrj001936
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 15:15:58 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l05KGiBd007586
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 20:16:44 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070105200820.975960210@hp.com>
Date: Fri, 05 Jan 2007 15:08:20 -0500
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 0/2] Two pretty trivial NetLabel bugfixes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a small patchset both in the number of patches (two) and the size of
the patches themselves.  The first patch fixes a potential locking issue with
a NetLabel state variable and the second patch fixes a couple of problems seen
when adding new CIPSO DOI definitions.

In light of the recent NetLabel locking issues I've spent this week going over
all of the NetLabel related locks and I firmly believe this patchset should
address the last of the problems.  However, if anyone with a good knowledge of
socket/sk locking can afford to take a look I would greatly appreciate it.

I tested both of these patches with what I believe to be pretty much all of
the kernel debug options enabled and I have not encountered any problems.
Please consider these for the 2.6.20 release.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
