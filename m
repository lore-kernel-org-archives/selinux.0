Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA27426
	for <selinux@tycho.nsa.gov>; Sat, 22 Dec 2001 16:17:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA07616
	for <selinux@tycho.nsa.gov>; Sat, 22 Dec 2001 21:16:57 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzband.ncsc.mil  with ESMTP id VAA07612
	for <selinux@tycho.nsa.gov>; Sat, 22 Dec 2001 21:16:55 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AA45292708
	for <selinux@tycho.nsa.gov>; Sun, 23 Dec 2001 08:17:29 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 479731A62
	for <selinux@tycho.nsa.gov>; Sat, 22 Dec 2001 22:18:04 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: su etc
Date: Sat, 22 Dec 2001 22:18:03 +0100
MIME-Version: 1.0
Message-Id: <20011222211804.479731A62@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At the moment I'm trying to compile the shadow password programs from 
Julianne Frances Haugh (as used in Debian for /bin/login and friends) with SE 
support.

I've got login almost working (I think) but haven't tested it yet (anyone 
who's interested in seeing what I'm doing please contact me off the list - 
I'm not publishing untested patches).

I'm now thinking about what to do with su.  Should su change the security of 
the tty with chsid() before spawning a new shell and then change it back 
afterwards as login does?  Or is there some difference in the way that su and 
login work that requires some different code?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
