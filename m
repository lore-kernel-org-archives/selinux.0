Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA22095
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 10:38:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA06960
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 14:38:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA06954
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 14:38:06 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4095F92462
	for <selinux@tycho.nsa.gov>; Sat, 22 Jun 2002 00:38:21 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 4F44456
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 16:38:13 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: error
Date: Fri, 21 Jun 2002 16:38:12 +0200
MIME-Version: 1.0
Message-Id: <20020621143813.4F44456@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/usr/sbin/checkpolicy:  loading policy configuration from policy.conf
security:  5 users, 4 roles, 400 types
security:  29 classes, 48761 rules
security:  SID igmp_packet was never defined.
make: *** [policy.9] Error 1

Stephen, I applied the latest patches you sent me and got the above error.  
Could you please explain where it came from?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
