Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA10385
	for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2003 04:47:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA20563
	for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2003 09:44:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id JAA20559
	for <selinux@tycho.nsa.gov>; Tue, 7 Jan 2003 09:44:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4809C9246B
	for <selinux@tycho.nsa.gov>; Tue,  7 Jan 2003 20:46:43 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D8D5526D
	for <selinux@tycho.nsa.gov>; Tue,  7 Jan 2003 10:46:36 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: auditallow and { sbin_t bin_t }
Date: Tue, 7 Jan 2003 10:46:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301071046.32774.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A problem that I regularly have is that some program does something I don't 
like/understand but I don't know why the program in question is being run.  A 
modern Unix system is so complex that finding out what exactly happens by 
using a debugger or reading source code is excessively difficult.

In the past I've done things such as give the file a type test_exec_t and 
putting in an auditallow rule allowing everyone to execute it so I can see 
what happens.

I think that this is useful enough that I am considering adding it to my 
policy tree.

I was thinking of having audit_sbin_t and audit_bin_t file types and then 
changing all policy such that everything that allows an action for sbin_t 
will also allow it for audit_sbin_t.  Then if you want to discover what is 
running that strange process you can just use a simple chsid and wait for it 
to be run again.

This is fairly ugly, but I can't think of a better solution to the problem at 
the moment.  Any suggestions will be appreciated.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
