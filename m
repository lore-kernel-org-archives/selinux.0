Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA15421
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 10:06:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26340
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 14:05:59 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA26336
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 14:05:56 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id F1A6892469
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 00:06:44 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 492AC125E
	for <selinux@tycho.nsa.gov>; Fri,  9 Aug 2002 16:06:36 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: libsecure/test/Makefile
Date: Fri, 9 Aug 2002 16:06:35 +0200
MIME-Version: 1.0
Message-Id: <20020809140636.492AC125E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Could libsecure/test/Makefile be changed to include chsid, lchsid, and 
chsidfs in the default build?  I can't think of any good reason for leaving 
them out.

In a minimal install of SE Linux you won't have chcon so chsid is quite 
necessary IMHO.

Also maybe this directory should be renamed, maybe "utils" would be a better 
name than "test".

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
