Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95Mb7aZ005944
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 18:37:07 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95MZsqJ008553
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 22:35:54 GMT
Message-Id: <20061005222823.387569000@hp.com>
Date: Thu, 05 Oct 2006 18:28:23 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org
Subject: [PATCH 0/1] NetLabel changes from yesterday's discussion
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In case you missed it (har har) there was a pretty good discussion about
labeled networking yesterday.  One of the results of the dicussion was the
realization that the way NetLabel determines what to use for the SELinux TE
portion of the packet's label was not the best choice.  This patch should
address the issue.

This patch does not rely on the secid patches currently in progress and should
be considered a bugfix against the current net-2.6 tree.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
