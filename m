Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA11659
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 16:09:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA03498
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 21:09:40 GMT
Received: from mx2.tds.com (mx2.tds.com [165.159.62.4])
	by jazzswing.ncsc.mil  with ESMTP id VAA03494
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 21:09:39 GMT
Received: from mx2.tds.com (localhost.localdomain [127.0.0.1])
	by mx2.tds.com (8.9.3/8.9.3) with ESMTP id NAA24764
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 13:09:56 -0800
Received: from cerberus ([165.159.62.50])
	by mx2.tds.com (8.9.3/8.9.3) with SMTP id NAA24758
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2001 13:09:56 -0800
Message-ID: <7408C3158945264B85D07250D7A2C8010C7976@satxmail.tds.com>
From: "Pagano, Art" <art_pagano@tds.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Is This a Bad Thing!
Date: Fri, 23 Feb 2001 13:09:32 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

If so has anyone found a fix???

Art

./tools/install-kernel

Logging install output to install-kernel-log.
Installing the kernel and kernel modules.
Root device is (3, 8)
Boot sector 512 bytes.
Setup is 1396 bytes.
System is 649 kB
+ [ -x /sbin/installkernel ]
+ exec /sbin/installkernel 2.2.12-FLASK bzImage /slinux/kernel/System.map
Installing checkpolicy.
Installing the initial policy configuration.

error in the statement ending on line 22875 (token 'user'): syntax error

../kernel/security/checkpolicy:  error(s) encountered while parsing
configuratio
n
make: *** [initpolicy] Error 1

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
