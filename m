Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA01158
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 20:12:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA10707
	for <selinux@tycho.nsa.gov>; Sun, 2 Jun 2002 00:11:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA10703 for <selinux@tycho.nsa.gov>; Sun, 2 Jun 2002 00:11:05 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3891192461
	for <selinux@tycho.nsa.gov>; Sun,  2 Jun 2002 10:12:23 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 4F1A77125
	for <selinux@tycho.nsa.gov>; Sun,  2 Jun 2002 02:12:16 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: compressed policy DB
Date: Sun, 2 Jun 2002 02:12:16 +0200
MIME-Version: 1.0
Message-Id: <20020602001216.4F1A77125@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

12 hours ago I gave a talk to the Nederlandse Linux Gebruikers Groep on SE 
Linux.  During the talk one of the audience members asked why the policy db 
can't be gzip compressed.

This seems to be a good idea, the kernel already contains code for the gzip 
algorithm which is used for compressed initrd images, cramfs, and ppp.  Using 
the same code for policy db's would not add any significant code to the 
kernel, and would save significant amounts of disk space on an initrd.

What do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
