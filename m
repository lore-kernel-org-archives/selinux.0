Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA28541
	for <selinux@tycho.nsa.gov>; Sun, 23 Dec 2001 08:29:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA29484
	for <selinux@tycho.nsa.gov>; Sun, 23 Dec 2001 13:28:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id NAA29480
	for <selinux@tycho.nsa.gov>; Sun, 23 Dec 2001 13:28:17 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: Debian packages of SE Linux update
Date: Sun, 23 Dec 2001 14:28:50 +0100
Cc: Debian Devel <debian-devel@lists.debian.org>
MIME-Version: 1.0
Message-Id: <20011223132851.223F4FDF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've put a new version of my packaging of selinux-small online at 
http://www.coker.com.au/selinux/ .  I now have it generate packages 
libselinux-dev (header files and library for compilation) and flask (policy 
files and utilities).

The flask package uses /etc/flask for the policy configuration files (let me 
know what you think about this - /usr/local/selinux/policy is unacceptable 
for Debian).  Also let me know what you think of the package names.

For the moment if you want to experiment with Debian and SE Linux then I 
recommend using my libselinux-dev package for compilation, my flask package 
for the policy, and compiling the other things (sshd, login, etc) into 
/usr/local/bin etc.

Now it should be possible to boot a SE Linux kernel on a Debian machine using 
only Debian packages for the SE stuff!  I haven't been able to test this as 
my test machine can't boot any kernel later than 2.4.14 without Oopsing on 
boot.  Hopefully I'll be able to test on another machine soon.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
