Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA06803
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 06:40:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA06971
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 10:39:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA06967 for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 10:39:22 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EDF8C92467
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 20:40:52 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id BB95C163
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 12:40:48 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: directory write denied messages
Date: Thu, 25 Jul 2002 12:40:48 +0200
MIME-Version: 1.0
Message-Id: <20020725104048.BB95C163@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Could the kernel message log messages for denied write access to a directory 
be changed to give the path of the file that the process is attempting to 
create or rename?  It would make it much easier to determine what was 
attempted...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
