Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA20756
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 07:55:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA01158
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 11:55:34 GMT
Received: from mx01.uni-tuebingen.de (mx01.uni-tuebingen.de [134.2.3.11])
	by jazzband.ncsc.mil  with ESMTP id LAA01154
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 11:55:31 GMT
Received: from linux45.zdv.uni-tuebingen.de (linux45.zdv.uni-tuebingen.de [134.2.18.45])
	by mx01.uni-tuebingen.de (8.9.3/8.9.3) with ESMTP id NAA00811
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 13:55:29 +0200
Date: Tue, 8 May 2001 13:55:29 +0200 (CEST)
From: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: SELinux as a desktop / workstation?
Message-ID: <Pine.LNX.4.30.0105081344290.18206-100000@linux45.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello there,

I assume, that most of you are using SELinux for server purposes. Is there
someone, who is using it for his everyday-desktop machine?

The reason for this question is:
- a server needs higher security levels than a client (normally, because
it is more exposed).
- a server can be limited to certain tasks (e.g. serving web-pages only),
whereas a workstation has to fit far more general needs (involving the use
of code belonging to the users), so far more complicated policies
would be necessary.

On the other hand, it would be useful, if simple workstations would offer
high (or at least a medium) level of security. For e.g., if the user
installs a program in his own userspace, he would want to limit the
program to certain capabilities. (You don't want your brand-new
napster-client to share your private keys with the napster-community ;)

Thank you,

JanP


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
