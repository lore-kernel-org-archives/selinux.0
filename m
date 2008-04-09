Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m39MwSTR021917
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2008 18:58:29 -0400
Received: from QMTA06.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m39MwR2t009344
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2008 22:58:28 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH v2 0/2] SELinux networking patches for 2.6.26
To: selinux@tycho.nsa.gov
Date: Wed, 09 Apr 2008 18:57:30 -0400
Message-ID: <20080409225618.18745.56458.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A tweak of the patchset posted earlier this week with the secid/secctx patch
dropped and the size/index variables converted from u32 to unsigned int.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
