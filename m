Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00803
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 12:43:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA04001
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 16:43:17 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzswing.ncsc.mil  with ESMTP id QAA03997
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 16:43:16 GMT
Subject: Redhat 7.3
From: Justin Smith <jsmith@mcs.drexel.edu>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 21 May 2002 12:40:15 -0400
Message-Id: <1021999215.5009.1.camel@vorpal.mcs.drexel.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've noticed that running X windows via xinit requires changing the file
labels so that /usr/X11R6/bin/XFree86  and /usr/X11R6/bin/X are given
the correct context.
-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
