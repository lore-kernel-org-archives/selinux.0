Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA21870
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2001 11:34:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA12369
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2001 15:34:40 GMT
Received: from smtp2.abac.com (smtp2.abac.com [216.55.128.11])
	by jazzband.ncsc.mil  with ESMTP id PAA12365
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2001 15:34:40 GMT
Received: from steve.computer.org (02-104.039.popsite.net [64.24.107.104])
	by smtp2.abac.com (8.10.1/8.10.1) with ESMTP id f6LFYqn11262
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2001 08:34:52 -0700 (PDT)
Message-Id: <4.3.2.7.2.20010721085700.00ad08a0@mail1.abac.com>
Date: Sat, 21 Jul 2001 09:35:31 -0600
To: selinux@tycho.nsa.gov
From: Steve Eckmann <eckmann@computer.org>
Subject: running programs
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I enable MAC with avc_toggle I can no longer run "ping"
either as root or as a regular user. Can anyone explain how
to fix this? There's no avc "denied" message, but there is
a message about not being able to open a socket (don't have
an se-linux system at hand and can't remember the exact msg).

Also, the tara (aka tiger) security scanner won't run with MAC
enabled. I'm guessing that I just have to change the SID on the
tiger executable, but I'm not sure what it should be so sysadm
users can run it but regular users cannot. Suggestions?

Thanks.

Steve


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
