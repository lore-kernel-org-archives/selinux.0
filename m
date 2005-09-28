Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8SIsjNs008691
	for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2005 14:54:45 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8SInHjf011414
	for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2005 18:49:18 GMT
Subject: apmd policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 14:49:35 -0400
Message-Id: <1127933375.32172.79.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the apmd.te, what is the difference between the apm_t and apmd_t
domains?  The naming make it very confusing.  By looking at the TE rules
and file contexts, I'm guessing that apm_t is an interactive program.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
