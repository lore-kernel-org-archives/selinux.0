Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA06546
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 00:49:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA15319
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 05:49:01 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id FAA15315
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 05:48:59 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2A9959266B
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 16:49:50 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id E1F12B7A9
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 15:50:56 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: gdm
Date: Mon, 11 Feb 2002 15:50:56 +1000
MIME-Version: 1.0
Message-Id: <20020211055056.E1F12B7A9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The gdm.te file gives gdm access to apm_bios, why is this?

I am thinking of creating some SE policy files which include a macro for xdm 
type programs (there are about a dozen xdm type programs which are mostly the 
same in terms of SE issues so they can use almost the same config apart from 
minor issues such as apm_bios).

Or should we just make it xdm.te and have lots of comments of the form 
"uncomment this for gdm" for the rules that are specific to a particular dm?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
