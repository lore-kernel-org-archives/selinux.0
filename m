Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA10693
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 18:30:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA24489
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 22:30:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA24485
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 22:30:31 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 262B492461
	for <selinux@tycho.nsa.gov>; Tue,  4 Jun 2002 08:30:38 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 44BC568D
	for <selinux@tycho.nsa.gov>; Tue,  4 Jun 2002 00:30:26 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: auditdeny is painful
Date: Tue, 4 Jun 2002 00:30:26 +0200
MIME-Version: 1.0
Message-Id: <20020603223026.44BC568D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that auditdeny is misdesigned.  Having to specify that we want to 
audit the opposite of what we don't want to audit is really confusing when 
you first start, and even with some practise it can result in results other 
than what you expect.  Consider the situation where you want to specify in 
one file to not audit getattr while in another file you want to specify not 
to audit search (this has seemed to be impossible in my tests).

Also I am having problems with the following:
auditdeny apmd_t { file_type fs_type }:dir_file_class_set ~getattr;
auditdeny apmd_t user_home_t:dir ~{ search getattr };

The result is that "apmd_t user_home_t:dir search" is audited.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
