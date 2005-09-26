Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8QFXVNs014204
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 11:33:31 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8QFSHqv014944
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 15:28:22 GMT
Subject: setfiles vs restorecon in MLS
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 11:28:17 -0400
Message-Id: <1127748497.32172.13.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I noticed that restorecon_t has mlsfileread, mlsfilewrite,
mlsfileupgrade, and mlsfiledowngrade attributes, but setfiles_t doesn't.
It seems like setfiles should also have these privileges.  Is this
intentional, or just an oversight?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
