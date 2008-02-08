Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18LSqrs010501
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:28:52 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18LSn5u019220
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 21:28:49 GMT
Received: from g1t0029.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 197F33816D
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:26 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id 0CF68380CA
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:25 +0000 (UTC)
Message-Id: <20080208212534.491651808@hp.com>
Date: Fri, 08 Feb 2008 16:25:34 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/4] Reference Policy patches for the new labeled networking code in 2.6.25
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Four relatively small patches to Reference Policy to support the new labeled
networking controls which are now in Linus' tree and scheduled for 2.6.25.
The first three patches have been posted previously but are not yet in SVN,
while the last patch is new.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
