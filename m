Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA26128
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 17:25:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA17930
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 22:24:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA17926 for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2002 22:24:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 70C989265F
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2002 09:25:39 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id C73133A2671
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2002 08:26:00 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: runas.c line 131
Date: Fri, 8 Feb 2002 00:44:19 +1000
MIME-Version: 1.0
Message-Id: <20020207222600.C73133A2671@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The context_new() call on line 131 of runas.c doesn't include a check for a 
return of NULL if the context is invalid.  Shortly afterwards the pointer is 
dereferenced giving a SEGV.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
