Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA03429
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 08:36:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA14204
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 13:35:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA14198
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 13:35:20 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 576B292443
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 00:36:30 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 22DD67B83
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2002 14:36:14 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: stat64
Date: Wed, 13 Mar 2002 14:36:14 +0100
MIME-Version: 1.0
Message-Id: <20020313133615.22DD67B83@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is the URL for some errors reported by Debian build daemons (see the 
ia64 records).

It seems that there is no stat64 on 64bit architectures.

I think that the right thing to do is to merge %stat64_secure.c with 
%stat_secure.c and surround the stat64 code with #ifdef __i386__



http://buildd.debian.org/build.php?&pkg=selinux-small

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
