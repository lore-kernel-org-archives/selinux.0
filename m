Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA06160
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:55:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA00504
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:53:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA00496
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:53:48 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6068E92457
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 02:55:27 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 6F4DF1B18
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 18:55:19 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: every.te
Date: Thu, 18 Apr 2002 18:55:19 +0200
MIME-Version: 1.0
Message-Id: <20020418165519.6F4DF1B18@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following operation from ls produces the access described below.
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff5f4, 32, (nil), 0}) = 0

Apr 18 18:51:23 lyta kernel: avc:  denied  { search } for  pid=3006 
exe=/bin/ls
scontext=system_u:system_r:dpkg_t tcontext=system_u:object_r:sysctl_kernel_t 
tclass=dir
Apr 18 18:51:23 lyta kernel:
Apr 18 18:51:23 lyta kernel: avc:  denied  { read } for  pid=3006 exe=/bin/ls 
scontext=system_u:system_r:dpkg_t tcontext=system_u:object_r:sysctl_kernel_t 
tclass=file

Would it make sense to add this to every.te?  It seems that almost everything 
wants to know the kernel version...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
