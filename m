Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA18321
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 08:26:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA28020
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 12:26:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA28016
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 12:26:14 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8ED9392452
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 22:26:15 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 989A28B9
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2002 14:26:08 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: mini policy for initrd
Date: Fri, 24 May 2002 14:26:08 +0200
MIME-Version: 1.0
Message-Id: <20020524122608.989A28B9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've developed a mini policy for an initrd, but now I have a problem.

On boot after the root file system is mounted the mappings of PSIDs to SIDs 
are made BEFORE the policy is loaded from the root file system.  This means 
that 95% of all files on my root file system lose their labels...

Is there any possibility of solving this in the kernel?  Or should I just 
make sure that my initrd policy contains all the types for all files on the 
root file system?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
