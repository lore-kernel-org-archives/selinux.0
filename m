Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA08175
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 11:30:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA26248
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 15:30:53 GMT
Received: from mx03.uni-tuebingen.de (mx03.uni-tuebingen.de [134.2.3.13])
	by jazzband.ncsc.mil  with ESMTP id PAA26244
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 15:30:53 GMT
Received: from linux16.zdv.uni-tuebingen.de (linux16.zdv.uni-tuebingen.de [134.2.18.16])
	by mx03.uni-tuebingen.de (8.9.3/8.9.3) with ESMTP id RAA32599
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 17:30:54 +0200
Date: Fri, 18 May 2001 17:30:53 +0200 (CEST)
From: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Immunity against Buffer Overflows / exploits
Message-ID: <Pine.LNX.4.30.0105181722100.6378-100000@linux16.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello there,

I just wondered, whether the security mechanisms implemented in SELinux
would be able to protect the system from the exploit (not the occurrence)
of Buffer Overflows.

Let's assume, the security mechanism and the kernel are sane & safe. An
application runs in "underpriviledged" mode, that is the policy permits
the application to read file A and read & write to file B. Now, if the
application tries to go berserk, the policy control mechanism will take it
out and shoot it. But if somehow a buffer within the application gets an
overflow, will it be able to acces memory areas, that belong to other
applications?

Thank you,

JanP


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
