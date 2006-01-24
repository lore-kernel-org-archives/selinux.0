Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0O3VZXf022492
	for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2006 22:31:36 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0O3UKCZ009336
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 03:30:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 72DDA61B07
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 14:31:29 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27014-04 for <selinux@tycho.nsa.gov>;
	Tue, 24 Jan 2006 14:31:29 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1699A61B02
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 14:31:29 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 56C09A80A7
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2006 14:31:25 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: apparent bug in setrans
Date: Tue, 24 Jan 2006 14:31:20 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200601241431.25155.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

$ runcon -l s0:c1.c3 id
uid=500(rjc) gid=500(rjc) groups=500(rjc) context=rjc:system_r:unconfined_t

Above is the result of running id on a fairly recent rawhide machine.  It 
appears that there's a bug in setrans which maps everything to "" if it can't 
find a name.

I'm currently finishing my paper for the SE Linux Symposium and then I've got 
to work on a tutorial for LCA in a few days.  I'll schedule fixing this bug 
for the weekend if no-one else beats me to it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
