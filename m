Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA02504
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2002 23:24:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA26987
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 04:23:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id EAA26977 for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 04:23:46 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 565109265F
	for <selinux@tycho.nsa.gov>; Sat,  9 Feb 2002 15:24:37 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id AC5233A6AB2
	for <selinux@tycho.nsa.gov>; Sat,  9 Feb 2002 14:25:33 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: run_init(8)
Date: Sat, 9 Feb 2002 14:25:33 +1000
MIME-Version: 1.0
Message-Id: <20020209042533.AC5233A6AB2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that the run_init man page should be in section 8.  There is (AFAIK) 
no reason for a non-sysadm_r user to be running it and therefore the binary 
belongs in /sbin and the man page should be in section 8.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
