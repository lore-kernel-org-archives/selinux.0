Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6I3QXrT006301
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 23:26:33 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6I3Q8IR001175
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 03:26:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 972BF61C9D
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 13:26:30 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 32664-10 for <selinux@tycho.nsa.gov>;
	Sun, 18 Jul 2004 13:26:30 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4DE7261C9C
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 13:26:30 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D0FA1B59AF
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2004 13:26:28 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: dri
Date: Sun, 18 Jul 2004 13:26:28 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200407181326.28308.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

allow xdm_t dri_device_t:dir rw_dir_perms;

What is the above policy line used for?  xdm_t does not have create access to 
dri_device_t objects so it doesn't seem that there is any way it can actually 
write to that directory.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
