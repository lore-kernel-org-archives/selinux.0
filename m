Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13407
	for <selinux@tycho.nsa.gov>; Sun, 31 Mar 2002 09:58:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA04603
	for <selinux@tycho.nsa.gov>; Sun, 31 Mar 2002 14:57:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA04599
	for <selinux@tycho.nsa.gov>; Sun, 31 Mar 2002 14:57:04 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EF56392452
	for <selinux@tycho.nsa.gov>; Mon,  1 Apr 2002 00:58:22 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 6615A230AB
	for <selinux@tycho.nsa.gov>; Sun, 31 Mar 2002 16:58:08 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: package selinux is in Debian!
Date: Sun, 31 Mar 2002 16:58:07 +0200
MIME-Version: 1.0
Message-Id: <20020331145808.6615A230AB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It's currently in the wrong section by mistake, but at least it's in.

The "selinux" package contains sample policy files, all programs from 
selinux-small and all non-development man pages.

The "libselinux-dev" package contains header files, libs, and man pages for 
the new system calls.

The recent versions of the stat package in Debian maintained by Michael 
Meskes <meskes@debian.org> also have SE Linux support and when given the "-s" 
option display the security context.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
