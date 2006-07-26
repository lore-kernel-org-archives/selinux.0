Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6QFMqkK003600
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 11:22:52 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6QFMomc026655
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 15:22:50 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel9.hp.com (Postfix) with ESMTP id 76666373BC
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 11:22:51 -0400 (EDT)
Received: from [16.116.96.193] (flek.zko.hp.com [16.116.96.193])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 139CA5D5EA
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 15:22:51 +0000 (UTC)
Message-ID: <44C788CA.8040907@hp.com>
Date: Wed, 26 Jul 2006 11:22:50 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Converting ebitmaps to copy-on-write?
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can anyone think of reason why converting the ebitmap code to a copy on
write scheme would be a bad idea?  Yes, there would be some overhead in
maintaining reference counts but I suspect the added overhead would be
more than offset by the reduction in kmalloc() calls ... thoughts?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
