Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA14194
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 07:29:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA13878
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:28:59 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA13874
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:28:57 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5250392467
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 21:29:42 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8CAC91802
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 13:29:40 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: can_exec_any
Date: Fri, 26 Jul 2002 13:29:40 +0200
MIME-Version: 1.0
Message-Id: <20020726112940.8CAC91802@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that we should add the following to can_exec_any()
allow $1 { bin_t sbin_t lib_t etc_t }:dir search;

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
