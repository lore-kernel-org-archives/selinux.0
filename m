Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA02079
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 20:04:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA03433
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 00:03:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA03429 for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 00:03:08 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8407C92467
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 10:04:43 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9B76584D3
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 02:04:33 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: ioctl on a directory?
Date: Tue, 24 Sep 2002 02:04:33 +0200
MIME-Version: 1.0
Message-Id: <200209240204.33176.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sep 24 00:30:01 lyta kernel: avc:  denied  { ioctl } for  pid=21927 
exe=/bin/rm path=/root dev=03:02 ino=7466 
scontext=system_u:system_r:system_crond_t 
tcontext=system_u:object_r:sysadm_home_dir_t tclass=dir

I am seeing the above from part of my daily cron job.  But as everything seems 
to be working OK it's difficult to track down.

Why would rm want to do an IOCTL on a directory anyway?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
