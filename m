Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhL8X013853
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:21 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMfgUg029628
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:41:42 GMT
Message-Id: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:42 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org
Subject: [PATCH 00/13] NetLabel cleanups for 2.6.20
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset consists of a lot of small-ish cleanups for NetLabel and in some
cases labeled networking in general.  I've tested these patches for the past
few days and I haven't seen any regressions so please consider them for the
net-2.6.20 git tree.

The patches are fairly varied so it doesn't make sense to go into too much
details here, please see each patch for an explanation of what it does.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
