Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA16162
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 11:52:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA26937
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 15:51:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA26933
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 15:51:13 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4069B92467
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 01:51:58 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 135D819C3
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 17:51:58 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: more thoughts on the ssh policy
Date: Fri, 26 Jul 2002 17:51:57 +0200
MIME-Version: 1.0
Message-Id: <20020726155158.135D819C3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Do we need two types for the files under ~/.ssh?

With the current setup in my policy tree the sshd can read the ~/.ssh/id* 
files from all users, which of course could be useful in attacking other 
machines.

Of course if you have a bug in sshd then you can (in theory at least) cause 
it to execute a shell in the user's security context which runs "scp" to 
transfer the ~/.ssh/id* files to a host controlled by the attacker.  Although 
such exploits may be easier said than done (maybe there's a bug in sshd that 
doesn't allow executing arbitary code but merely allows reading arbitary 
files and sending the result out the TCP socket).

What do you think?

If I am to use two types then I will have to modify ssh-keygen to use 
open_secure...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
