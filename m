Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA11791
	for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 09:53:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA08521
	for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 14:51:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA08517 for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 14:51:52 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 150E692668
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 01:53:42 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6C0C0141B
	for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 15:53:31 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: executing a sock_file
Date: Thu, 28 Nov 2002 15:53:30 +0100
MIME-Version: 1.0
Message-Id: <200211281553.30105.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nov 28 15:50:18 lyta kernel: avc:  denied  { execute } for  pid=4084 
exe=/usr/lib/openoffice/program/soffice.bin 
path=/tmp/OSL_PIPE_1001_SingleOfficeIPC_-383479802 dev=03:02 ino=900 
scontext=rjc:user_r:user_t tcontext=rjc:object_r:user_tmp_t tclass=sock_file

What does it mean by executing a sock_file?

Star Office seems to run OK anyway...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
