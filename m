Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2D5AMDo016104
	for <selinux@tycho.nsa.gov>; Sun, 13 Mar 2005 00:10:22 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2D54tlQ023961
	for <selinux@tycho.nsa.gov>; Sun, 13 Mar 2005 05:04:55 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2D54sD8025659
	for <selinux@tycho.nsa.gov>; Sun, 13 Mar 2005 00:04:54 -0500 (EST)
Subject: sysadm home label
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 13 Mar 2005 00:09:45 -0500
Message-Id: <1110690585.29852.68.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, I've noticed that every time I try to run any nontrivial app
that writes to $HOME as root, it causes pure chaos on my system. 
That brings me to my two questions:

1) Why is /root labeled staff_home_dir_t, and its content staff_home_t
Why is it not sysadm_home_dir_t, and sysadm_home_t?

2) If it should stay at staff_home_t, why can't I typealias
staff_home_t and staff_home_dir_t to sysadm_home_t/sysadm_home_dir_t.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
