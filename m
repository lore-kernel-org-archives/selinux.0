Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA05998
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 06:46:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA22169
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 11:45:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA22165 for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 11:45:02 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B55D392713
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 22:46:44 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5DF9D1BFF
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 12:46:37 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: strange problem
Date: Thu, 31 Oct 2002 12:46:37 +0100
MIME-Version: 1.0
Message-Id: <200210311246.37017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { execute_no_trans } for  pid=11872 exe=/bin/bash 
path=/usr/bin/tr dev=09:03 ino=459224 scontext=system_u:system_r:crack_t 
tcontext=system_u:object_r:unlabeled_t tclass=file
root@test:~# ls --context /usr/bin/tr
-rwxr-xr-x  root     root     system_u:object_r:bin_t          /usr/bin/tr
root@test:~#

The above is a problem that's happened twice to me now.  This time it happened 
with all the SE patches applied, the previous time it happened without.

When I run "tr" from the command line it works!

So why is it being denied when run from crack_t?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
