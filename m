Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA10642
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 04:58:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA16397
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 08:57:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id IAA16393 for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 08:57:19 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1BA1C92461
	for <selinux@tycho.nsa.gov>; Sun,  9 Jun 2002 18:58:39 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 59B6E466
	for <selinux@tycho.nsa.gov>; Sun,  9 Jun 2002 10:59:23 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: auditing etc
Date: Sun, 9 Jun 2002 10:59:23 +0200
MIME-Version: 1.0
Message-Id: <20020609085923.59B6E466@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What are the future plans for auditing on SE Linux?

I was just speaking to a HP representative about their Linux security 
solution (which has GPL kernel code and expensive user-space tools).  The 
access control sounds less capable than SE Linux (EG it only controls 
read/write/append for files instead of all the operations SE controls).  But 
the auditing seems much more capable.  Maybe if SE auditing worked with the 
new IBM logging (which complies with the appropriate specs from POSIX for 
logging) and logged more data it would address this.

Also would it be possible to have an option in the debugging kernel build to 
send a signal 11 to a process that violates the security policy?  It would 
make it much easier to find out why it chose to do what I don't want...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
