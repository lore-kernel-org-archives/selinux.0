Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11639
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 12:59:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA21245
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 16:58:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA21241
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 16:58:39 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7C39F92462
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2002 02:58:49 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 137142492
	for <selinux@tycho.nsa.gov>; Tue, 25 Jun 2002 12:58:46 -0400 (EDT)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: macros like dir_file_class_set
Date: Tue, 25 Jun 2002 12:58:45 -0400
MIME-Version: 1.0
Message-Id: <20020625165846.137142492@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve, could macros like dir_file_class_set be changed to expand to a single 
line?

The reason is that I find it very conveniant to have all lines in the policy 
file be independant.  Sure it's good to have the policy file be free-form to 
enable the user to write such policy files, but for generated code I think 
that every line should be atomic, so that for example I can do "grep -v 
dontaudit" if I want to test something.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
