Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA10935
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 04:09:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA18555
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 08:09:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA18551
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 08:09:30 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7067392460
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 18:09:27 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id BB39948E
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 10:08:57 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: signal permissions
Date: Thu, 23 May 2002 10:08:57 +0200
MIME-Version: 1.0
Message-Id: <20020523080857.BB39948E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why is it possible to specify sigstop but not sigcont in the permissions?  
Surely it would make sense to be able to control starting in the same way as 
controlling stopping?  If you allow "signal" access to get the sigcont then 
you are also allowing sigusr*, sigsegv, etc.

Also what about sighup?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
