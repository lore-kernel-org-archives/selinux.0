Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7E5vbHa027490
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 01:57:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7E5uHOD009689
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 05:56:17 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h7E5uGKO009686
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 05:56:16 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4971B92719
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 15:57:29 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 957D57F002
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2003 15:57:23 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: 2.6.0-test3 and UML
Date: Thu, 14 Aug 2003 15:57:23 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308141557.23034.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For 2.6.0-test3 to work with UML the following changes are necessary:

In security/selinux/avc.c add the following:
#include <linux/init.h>

In include/asm-um/common.lds.S add the following:
  __security_initcall_start = .;
  .security_initcall.init : { *(.security_initcall.init) }
  __security_initcall_end = .;

This makes it compile and appear to run.  I'm fairly certain that adding 
init.h is OK, but I'm not sure if the initcall stuff is right.  Hopefully 
Steve can advise.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
