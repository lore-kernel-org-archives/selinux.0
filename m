Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA06864
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 16:17:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA23478
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 21:16:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA23468 for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 21:16:52 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian Devel <debian-devel@lists.debian.org>
Subject: SE-Debian is almost working!
Date: Thu, 17 Jan 2002 20:51:43 +0100
MIME-Version: 1.0
Message-Id: <20020117195144.2984932E5E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've got a working flask package on my site http://www.coker.com.au/selinux/ 
.  After installing it you have to run "make -C /etc/flask install" to 
install the policy file and then "make -C /etc/flask relabel" from single 
user mode before booting a kernel that has SE-Linux with policydb V8 enabled 
(IE the latest patch from Immunix).

However at the moment the only other SE-Linux package I have is stat, this is 
enough to show you that it's working if you enable SE-Linux before locking 
you out of your system.

The libselinux-dev package should enable you to compile your own packages of 
cron, sshd, login, and other essential things.

This is still very experimental...

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
