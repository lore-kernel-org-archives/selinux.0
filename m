Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8FHeJNs018139
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 13:40:19 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8FHb6rW000035
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2005 17:37:06 GMT
Subject: mqueue labeling
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 13:40:46 -0400
Message-Id: <1126806046.18007.133.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While updating reference policy baseline to NSA CVS, I noticed that the
mqueue filesystem has two labeling rules:

genfscon mqueue / system_u:object_r:mqueue_t

fs_use_trans mqueue system_u:object_r:tmpfs_t;

Which is the correct one?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
