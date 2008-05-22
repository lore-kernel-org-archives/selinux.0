Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4MLZOb7027333
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 17:35:24 -0400
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4MLZNKO004420
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 21:35:23 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id 7CB4D84AE
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2008 21:35:23 +0000 (UTC)
Message-Id: <20080522213252.557433869@hp.com>
Date: Thu, 22 May 2008 17:32:52 -0400
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/1] Latest network peer labeling patch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch is a few months late but takes into account all of the feedback I
received from Chris back in March.  One of the nice things about this version
of the patch is that it removes the need for all of the changes outside the
kernel/ modules.

Take a look and please apply if there are no objections.  Thanks.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
