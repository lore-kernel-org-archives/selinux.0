Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21676
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 10:43:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA17573
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 14:42:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA17569
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 14:42:34 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DBD5792469
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 00:43:28 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id F421F272
	for <selinux@tycho.nsa.gov>; Sat, 10 Aug 2002 16:43:19 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: conditional compilation
Date: Sat, 10 Aug 2002 16:43:19 +0200
MIME-Version: 1.0
Message-Id: <20020810144320.F421F272@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In my latest experimental policy on 
http://www.coker.com.au/selinux/policy.tgz I have added a change to the 
mount_macros.te file contributed by Brian May.  I made it define a macro 
$2_mount_def which can be checked by any code calling the mount_domain() 
macro so that if some other policy code has called the macro with the same 
parameter then it can avoid calling it again (which would result in defining 
a type more than once and giving an error).

I've got my new chroot() macro calling mount_domain() in such a fashion, and 
I've also got it doing it's own checking for types it defines (for when one 
user has multiple chroot's defined).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
