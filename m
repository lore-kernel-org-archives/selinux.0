Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA06500
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 00:34:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA14930
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 05:34:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id FAA14926
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 05:34:03 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2C3689266B
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 16:34:54 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 6A3D0167DD
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 15:36:02 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: insmod needs to write to /proc/sys/kernel/tainted
Date: Mon, 11 Feb 2002 15:36:02 +1000
MIME-Version: 1.0
Message-Id: <20020211053602.6A3D0167DD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the current default policy the insmod_t domain is explicitely prohibited 
from writing to sysctl_kernel_t objects.

What is the best way of resolving this?  Should I change the type of 
/proc/sys/kernel/tainted?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
