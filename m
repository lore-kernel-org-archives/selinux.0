Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA07752
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 19:36:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA25413
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 23:34:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA25409
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 23:34:43 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EACCA92461
	for <selinux@tycho.nsa.gov>; Tue,  7 May 2002 09:39:17 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 5D9373107
	for <selinux@tycho.nsa.gov>; Tue,  7 May 2002 09:35:51 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: selinux-small doc/
Date: Tue, 7 May 2002 08:12:56 +1000
MIME-Version: 1.0
Message-Id: <20020506233551.5D9373107@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I believe that the doc/ directory from the selinux-small archive should be in 
a separate archive.

Having the documentation separate will suit the needs of people who want to 
read the documentation without downloading the files needed to actually use 
SE Linux.  It will also suit the needs of people who want to upgrade their SE 
Linux system without the need to upgrade the documentation.  Finally it will 
be a definate advantage to people using packaging systems, I produced 12 
versions of my selinux packages from the last release from the NSA site, if 
the doc was included then a typical user would end up downloading the 
documentation 12 times when they only needed to download it once at most!

Finally selinux-small isn't going to stay small with sgml documentation being 
added to it...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
