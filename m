Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7FJa8Ob007206
	for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2005 15:36:08 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7FJRFdf025042
	for <selinux@tycho.nsa.gov>; Mon, 15 Aug 2005 19:27:16 GMT
Subject: pty / idr_remove problem persists
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 15:27:34 -0400
Message-Id: <1124134054.6379.53.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is anyone currently working on the pty/idr_remove problem?  The problem
been around for a while, and it seems that more people may be hitting it
lately, from what I've seen in the IRC channels.  Steve, you said here

http://marc.theaimsgroup.com/?l=selinux&m=111589787131836&w=2

that you weren't yet convinced that it was SELinux's fault.  Is this
still the case?  From my experience, it seems to only be hit in
enforcing, which really makes it sound like a SELinux problem.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
