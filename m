Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25414
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 09:42:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA00592
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 14:41:21 GMT
Received: from gto-mailer1.bbn.com (cam-mailer1.bbn.com [128.33.0.36])
        by jazzband.ncsc.mil  with ESMTP id OAA00588 for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 14:41:20 GMT
Received: from rospo1.bbn.com (rospo1.bbn.com [192.233.49.145])
	by gto-mailer1.bbn.com (8.9.3+Sun/8.9.3) with ESMTP id JAA19036
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 09:42:38 -0500 (EST)
Received: from meighan-d1.bbn.com (ros-dun052-160.bbn.com [192.233.52.160])
	by rospo1.bbn.com (8.9.1a/8.9.1) with ESMTP id JAA01653
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 09:27:41 -0500 (EST)
Message-Id: <5.1.0.14.2.20020221093245.02dbbe28@rospo1.bbn.com>
Date: Thu, 21 Feb 2002 09:41:19 -0500
To: selinux@tycho.nsa.gov
From: Beth Meighan <bmeighan@bbn.com>
Subject: Postgres Policy Files
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The only dialogue I saw on this mail list about Postgres had ended with the 
Postgres system processes in initrc_t domain and the recommendation to move 
them into their own domain.  Has anyone made domains and types for 
Postgres?  If so, would you be willing to share your .te file and any other 
policy files you edited?

Thank you in advance,
Beth Meighan

Beth Meighan
BBN Technologies
9861 Broken Land Parkway
Suite 156
Columbia, MD 21046
Tel. (410) 312-6930


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
