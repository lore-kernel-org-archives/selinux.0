Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA04392
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 03:20:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA12235
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 07:20:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA12231
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 07:20:35 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B129D92461
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 17:20:10 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id AF7376E90
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 09:20:17 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Is this a module bug?
Date: Wed, 22 May 2002 09:13:43 +0200
MIME-Version: 1.0
Message-Id: <20020522072017.AF7376E90@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

May 22 08:42:57 lyta kernel: IPv6 v0.8 for NET4.0
May 22 08:42:57 lyta kernel:
May 22 08:42:57 lyta kernel: avc:  denied  { net_raw } for  pid=71 
exe=/sbin/insmod capability=13 scontext=system_u:system_r:insmod_t 
tcontext=system_u:system_r:insmod_t tclass=capability
May 22 08:42:57 lyta kernel: IPv6 over IPv4 tunneling driver

The above is a cut from my syslog while booting.  It appears to me that the 
kernel code for the IPv6 module is still being registered as insmod_t domain.

Is this a bug in the IPv6 module?

I haven't even looked at the kernel code in question so I could be way off on 
this...

-- 
Get Bonnie++ file system benchmark suite from:
http://www.coker.com.au/bonnie++/
Now with Solaris package support.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
