Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2VKIpDo028947
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 15:18:51 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2VKHTiv008828
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 20:17:29 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j2VKHNB9020377
	for <selinux@tycho.nsa.gov>; Thu, 31 Mar 2005 15:17:23 -0500 (EST)
Subject: userhelper + xauth files - staff vs sysadm
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 31 Mar 2005 15:23:34 -0500
Message-Id: <1112300614.12948.98.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

userhelper (staff_userhelper_t) and xauth (staff_xauth_t) 
fail to create/delete/write .xauth files under /root 
when I try to run the system-config-* tools.

What should be done?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
