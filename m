Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA01985
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 17:33:36 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA01470
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 22:33:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA01466
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 22:32:59 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1B50D92746
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 09:33:22 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8F7D715BBF
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 23:33:08 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: 2.4.17 support?
Date: Wed, 16 Jan 2002 23:33:08 +0100
MIME-Version: 1.0
Message-Id: <20020116223308.8F7D715BBF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The latest kernel patch for 2.4.17 from immunix uses version 8 of the Policy 
DB, while the latest utilities on the NSA site are clearly designed for 
version 7 only (compile errors when trying to compile with version 8 headers).

Could someone please post a patch to selinux-small to make it compile with 
the latest headers?  I am anticipating that the NSA web site won't be updated 
as quickly as we would like so it'd be good to get a patch on the list...

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
