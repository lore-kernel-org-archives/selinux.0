Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA26605
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 17:46:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA18595
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 21:44:00 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzswing.ncsc.mil  with ESMTP id VAA18591
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 21:43:59 GMT
Subject: RedHat 7.3
From: Justin Smith <jsmith@mcs.drexel.edu>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 20 May 2002 17:43:04 -0400
Message-Id: <1021930985.1441.5.camel@vorpal.mcs.drexel.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So far I have not encountered any significant difficulties --- except
for an odd problem when rebooting the system: it crashed with a null
pointer exception as it was going down, and was unable to complete the
shutdown. It also complained about tainted memory.

The exact messages were hard to write down because they scrolled off the
screen, but included a little core dump.


--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
