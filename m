Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA04751
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 06:22:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA24349
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 10:20:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA24345 for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 10:20:30 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E31E492462
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 20:21:57 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8E9C6269F
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 12:21:49 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: cleaning psidfiles database
Date: Wed, 10 Jul 2002 12:21:48 +0200
MIME-Version: 1.0
Message-Id: <20020710102149.8E9C6269F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

psidfiles_init:  error 22 in obtaining SID for context 
system_u:object_r:dmesg_exec_t (psid 9).
psidfiles_init:  error 22 in obtaining SID for context 
system_u:object_r:mesg_exec_t (psid 107).

As a follow up to my previous messages on the topic of psidfiles, if the root 
file system is mounted without a valid policy (or if an initrd is used that 
doesn't have a valid policydb) then messages such as the above appear for all 
types that used to be applied to files on the file system.  The above two 
examples are for file types that were not used for several months!

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
