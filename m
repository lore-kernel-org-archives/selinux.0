Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i711BirT004612
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 21:11:45 -0400 (EDT)
Received: from darksorcerers.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i711BglX013539
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 01:11:42 GMT
Message-Id: <200408010111.i711BglX013539@zombie.ncsc.mil>
Date: Sun, 1 Aug 2004 4:10:34 -0000
From: "Nikolay" <Nikolay@alexandrov.ws>
To: selinux@tycho.nsa.gov
Reply-to: "Nikolay" <nikolay@alexandrov.ws>
Subject: Hi. Read below.
Content-Type: text/plain; charset="iso-8859-1";
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I'm new to the mail list and to the SE linux project.
Last night I read some pieces of the patched kernel and here is my idea:
Correct me if I'm wrong (which is quite possible:) but I think that when new
process is created the memory is not cleared (until it is written to?) and I
see that as a problem :) So here's what I suggest (if I'm right), if the
process which is being cloned is created by root (uid 0), the memory area
which is assigned is checked and if needed - cleared. I think that could
prevent malicious users from gathering important information. If I'm right
please let me know so I would write the patch for fixing this potential
issue.
Best regards,
Nikolay


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
