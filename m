Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA03781
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 07:03:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA04789
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 11:02:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA04785 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 11:02:12 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 26C7092457
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 21:03:19 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id CD31A93B
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 13:03:11 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: init and sigchld
Date: Thu, 18 Apr 2002 13:03:11 +0200
MIME-Version: 1.0
Message-Id: <20020418110311.CD31A93B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the benefit in denying sigchld access to init?

How can a process do harm by sending sigchld to the init process?

I am thinking of doing the following:

allow domain init_t:signal sigchld;

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
