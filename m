Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9OMg8Wt017692
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 18:42:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9OMftIS010747
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 22:41:55 GMT
Received: from mail.rollinghorse.com (dsl093-033-002.snd1.dsl.speakeasy.net [66.93.33.2])
	by jazzswing.ncsc.mil  with ESMTP id h9OMfsDc010744
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 22:41:54 GMT
Received: from hewey.RollingHorse.com (Hewey.RollingHorse.com [10.11.12.6])
	by mail.rollinghorse.com (8.11.6/8.8.7) with ESMTP id h9OMg5U16325
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 15:42:05 -0700
Message-Id: <5.2.1.1.2.20031024155304.0c94a990@Shire>
Date: Fri, 24 Oct 2003 15:58:44 -0700
To: "SE Linux" <selinux@tycho.nsa.gov>
From: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
Subject: When to use SEL kernel
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just completed the installation of LFS v4.1 on a server I intend to use 
as a firewall.  For those not familiar with LFS, it is Linux From Scratch, 
i.e. a Linux system built from source code.  It is FHS-compliant.  What I 
would like to do is run the SE kernel.  I still need to add some packages 
to this system (notably iptables).  My question is:  Does it matter if I 
install additional packages before or after I install (and use) the SE 
Linux kernel?

TIA,
Carsten

-- 
Carsten Gehrke     LFS No.: 190    using Linux since kernel 0.98
carsten@gehrke.org                 http://tech.rollinghorse.com/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
