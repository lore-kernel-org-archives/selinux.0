Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBFLputl024296
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 16:51:56 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBFLqU2A000811
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 21:52:30 GMT
Message-Id: <20061215214926.018950000@hp.com>
Date: Fri, 15 Dec 2006 16:49:26 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 0/2] A bugfix patchset for NetLabel
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set fixes two bugs that were found recently when adding new CIPSOv4
DOI definitions.  These patches are pretty small and have been tested by a few
different people on several different platforms.

Please apply these for 2.6.20 and they should probably be pushed to the 2.6.19
stable tree as well; is there anything special I need to do for that?

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
