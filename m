Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA10092
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 19:41:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA02424
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 23:39:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA02420 for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 23:39:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 13F1E92457
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 09:41:12 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 3AA7A640
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 01:40:48 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new Debian package
Date: Thu, 25 Apr 2002 01:40:47 +0200
MIME-Version: 1.0
Message-Id: <20020424234048.3AA7A640@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just uploaded a new "selinux" package to Debian and to my site.

It has the new .fc file method for setfiles, all the latest setfiles patches, 
and quite a number of changes to the policy files with M4 macros to allow you 
to easily remove a .te file and have the policy still compile.

Enjoy!

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
