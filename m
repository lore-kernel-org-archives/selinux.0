Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA11071
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 05:05:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA20178
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 09:05:27 GMT
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com [194.25.134.84])
	by jazzswing.ncsc.mil  with ESMTP id JAA20174
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 09:05:25 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.dr-baldeweg.de (Postfix) with ESMTP id CF3A1148EF
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 11:03:29 +0200 (CEST)
Message-ID: <3CECB29D.391E0E55@dr-baldeweg.de>
Date: Thu, 23 May 2002 11:13:01 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: boot.msg
References: <Pine.GSO.4.33.0205141211560.25712-100000@raven>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi !

I found in my boot.msg follow lines:

Security Scaffold v1.0.0 initialized
AVC:  allocated 14760 bytes during initialization.
SELinux:  module inserted
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized

Is it OK with the "failed" in line 5? 

Thanks for your comments.

Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
