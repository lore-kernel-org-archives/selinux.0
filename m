Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06953
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 07:10:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA11906
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 11:10:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA11902
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 11:10:04 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E9C9A92467
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 21:10:47 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 5D5B923A
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 13:10:44 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: default_context
Date: Thu, 25 Jul 2002 13:10:43 +0200
MIME-Version: 1.0
Message-Id: <20020725111044.5D5B923A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that it would be good to have default_context differ per login 
program.

EG When you login via ssh you don't want to have a default role of sysadm_r 
because the policy for sshd prohibits it.  But when logging in as root at the 
console you want it to default to sysadm_r to save time in emergencies.

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
