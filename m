Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA20821
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 10:38:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA04210
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 14:38:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA04206
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 14:38:37 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id ECD9F92461
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 00:38:53 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 7480513F4
	for <selinux@tycho.nsa.gov>; Sun, 16 Jun 2002 16:38:45 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: fd use rules
Date: Sun, 16 Jun 2002 16:38:44 +0200
MIME-Version: 1.0
Message-Id: <20020616143845.7480513F4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For many programs (including most daemons) we need to have access to the fds 
coming from the parent process (opened by sshd, newrole, or run_init).

Would it make sense to do the following?

allow myprog_t privrole:fd use;


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
