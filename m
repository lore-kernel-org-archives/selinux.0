Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA09483
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 10:53:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA27949
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 14:51:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA27945 for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 14:51:43 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 67E5B9246C
	for <selinux@tycho.nsa.gov>; Tue,  6 Aug 2002 00:53:16 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 096EC2CA8
	for <selinux@tycho.nsa.gov>; Mon,  5 Aug 2002 16:53:09 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: what is "null" access?
Date: Mon, 5 Aug 2002 16:53:05 +0200
MIME-Version: 1.0
Message-Id: <20020805145309.096EC2CA8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Aug ?5 10:58:57 ns kernel: avc: ?denied ?null for ?pid=30897 
exe=/usr/sbin/apache IPCID=0 scontext=system_u:system_r:httpd_t 
tcontext=system_u:system_r:httpd_t tclass=shm
Aug ?5 10:58:57 ns kernel: avc: ?denied ?null for ?pid=30897 
exe=/usr/sbin/apache IPCID=0 scontext=system_u:system_r:httpd_t 
tcontext=system_u:system_r:httpd_t tclass=shm

The above messages are appearing on a system running a version of SE Linux 
that's not the latest (running the original 2002.07.03 release).

Bug?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
