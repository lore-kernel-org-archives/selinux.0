Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA02670
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 00:11:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA03697
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 05:10:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id FAA03693
	for <selinux@tycho.nsa.gov>; Sat, 9 Feb 2002 05:10:23 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 45FA39265F
	for <selinux@tycho.nsa.gov>; Sat,  9 Feb 2002 16:11:12 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 10FB23A6ACC
	for <selinux@tycho.nsa.gov>; Sat,  9 Feb 2002 15:11:45 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: changing a process SID
Date: Sat, 9 Feb 2002 15:11:44 +1000
MIME-Version: 1.0
Message-Id: <20020209051145.10FB23A6ACC@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is it possible for a process to change it's own SID?  Or is execve_secure() 
the only way?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
