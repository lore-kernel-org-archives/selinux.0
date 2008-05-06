Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m46KI4Ci007612
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 16:18:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m46KI3AB012867
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 20:18:03 GMT
Subject: rbacsep: transition/inherit perms
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 06 May 2008 16:17:51 -0400
Message-Id: <1210105071.8778.5.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I branched refpolicy for the RBAC separation, and began the new
constraints.  I'm trying to decide what to do with the process
permissions rlimitinh, siginh, and noatsecure.  Since these go with a
transition, it seems that they could be added the the existing role
constraint on transition.  Opinions?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
