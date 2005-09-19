Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8JEoVNs018554
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 10:50:31 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8JEkYh5004811
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2005 14:46:34 GMT
Subject: fsadm tmpfs_t:file
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 10:50:51 -0400
Message-Id: <1127141451.18007.145.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While merging stuff in from NSA CVS, I noticed that this rule was added
to fsadm.te:

allow fsadm_t tmpfs_t:file { read write };

The comment above it says "for /dev/shm".  What is this file, and why
isn't it being transitioned to a derived type?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
