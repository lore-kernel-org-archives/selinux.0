Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA22893
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 13:16:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA10466
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 17:15:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA10462
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 17:15:48 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1C3FA92466
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 03:16:53 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 31517307F
	for <selinux@tycho.nsa.gov>; Sat, 24 Aug 2002 19:16:43 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: kernel patches from new release
Date: Sat, 24 Aug 2002 19:16:42 +0200
MIME-Version: 1.0
Message-Id: <20020824171643.31517307F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the past we have been advised not to use the system calls for determining 
the SID of the process at the other end of a socket due to the code being 
incomplete.

I notice that the new kernel patch for 2.4.19 in the 2002.08.23 release of SE 
Linux appears to have significant improvements in this regard, does this mean 
that we can now rely on the system calls related to socket contexts?  If not 
then what is the exact status of this work?  Can we rely on some of the 
system calls?  If so which ones?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
