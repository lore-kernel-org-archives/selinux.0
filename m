Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7GNPkrT010415
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 19:25:46 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7GNP5qL029573
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 23:25:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B7BEE61AEF
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 09:25:38 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 31252-02 for <selinux@tycho.nsa.gov>;
	Tue, 17 Aug 2004 09:25:38 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6E5C261AD8
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 09:25:38 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B2775B58B0
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 09:25:36 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: udev and capabilities
Date: Tue, 17 Aug 2004 09:25:36 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408170925.36215.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { dac_read_search } for  pid=4079 exe=/bin/bash capability=2 
scontext=system_u:system_r:udev_t tcontext=system_u:system_r:udev_t 
tclass=capability

I notice the above in my log files with the latest rawhide.  However udev.te 
has the following policy.  I was under the impression that dac_override was 
checked before dac_read_search and it was redundant to have dac_read_search 
if you already had dac_override.  Did I misunderstand this or have things 
changed in this regard?

allow udev_t self:capability { chown dac_override fowner fsetid sys_admin 
mknod};

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
