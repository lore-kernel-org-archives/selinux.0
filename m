Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA21881
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 10:27:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA13523
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 14:25:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA13519
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 14:25:29 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3E19E92467
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 00:26:56 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 56589140
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 16:26:48 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: SE Linux and UML compile problems...
Date: Thu, 26 Sep 2002 16:26:47 +0200
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200209261626.47960.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I haven't had time to try this yet...

----------  Forwarded Message  ----------

Subject: Re: pt_regs
Date: Wed, 25 Sep 2002 20:32:30 -0500
From: Jeff Dike <jdike@karaya.com>
To: Russell Coker <russell@coker.com.au>

russell@coker.com.au said:
>        unsigned int magic = regs.ebx;
>        unsigned int call = regs.ecx;

unsigned int magic = regs.args[1];
unsigned int call = regs.args[2];

				Jeff

-------------------------------------------------------

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
