Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA02231
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 08:35:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA21466
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 12:34:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA21462
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 12:34:36 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5E61A92462
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 22:35:12 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id B0E2F400
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 14:35:04 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: fileutils
Date: Sun, 14 Jul 2002 14:35:04 +0200
MIME-Version: 1.0
Message-Id: <20020714123504.B0E2F400@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've created a fileutils 4.1.9 package with SE Linux patches.  It's on 
http://www.coker.com.au/selinux/fileutils/ .  There is a problem though, 4 of 
the regression tests fail...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
