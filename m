Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA09274
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 08:12:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA21078
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 12:10:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA21074 for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 12:10:49 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2DE9B92452
	for <selinux@tycho.nsa.gov>; Tue,  7 May 2002 22:14:50 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 390C36C13
	for <selinux@tycho.nsa.gov>; Tue,  7 May 2002 22:11:56 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: run_init and chdir()
Date: Tue, 7 May 2002 22:11:55 +1000
MIME-Version: 1.0
Message-Id: <20020507121156.390C36C13@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would it make sense to have run_init do "chdir /" before executing it's 
program?

It's annoying when you accidentally execute a daemon with a current directory 
that it can't read...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
