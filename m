Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA08262
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 03:45:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA00131
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 07:45:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA00127
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 07:45:16 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 76AE292460
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 17:45:13 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 42F59746
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 09:45:04 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: deficiency in logging in enforcing mode
Date: Wed, 29 May 2002 08:08:20 +0200
MIME-Version: 1.0
Message-Id: <20020529074504.42F59746@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that messages such as the following are not logged in enforcing 
mode, only in permissive mode.  So if I can't execute a program because it's 
got a domain_auto_trans rule specifying that it should transition to a domain 
that is not permitted for the role I'm in then it just doesn't get executed 
with no reason being logged!

This makes it difficult to determine why something is not working if you make 
a mistake in the role definitions, and limits the use of roles.  Can this be 
fixed in the next version?

security_compute_sid:  invalid context rjc:sysadm_r:apmd_t for 
scontext=rjc:sysadm_r:sysadm_t tcontext=system_u:object_r:apmd_exec_t 
tclass=process

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
