Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0VHQU53009161
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 12:26:30 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0VHQXGm012329
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 17:26:33 GMT
Received: from [192.168.2.96] (syr-24-58-1-204.twcny.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j0VHQV2G012222
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2005 12:26:33 -0500 (EST)
Subject: Strange Denial
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 31 Jan 2005 10:26:34 -0700
Message-Id: <1107192394.27510.0.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What's this?

audit(1107188820.754:0): avc:  denied  { } for  pid=6672 comm=mplayer
path=/dev/zero dev=tmpfs ino=2055 scontext=user_u:user_r:user_mplayer_t
tcontext=system_u:object_r:zero_device_t tclass=chr_file

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
