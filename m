Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3I21nI4009468
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 22:01:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3I21mVf001101
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 02:01:48 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
	by jazzswing.ncsc.mil  with ESMTP id h3I21V4D001092
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2003 02:01:47 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6800194C2
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2003 09:40:14 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: uses_shlib() and device_t
Date: Thu, 17 Apr 2003 09:40:13 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304170940.13881.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In my tree I have just changed the uses_shlib() macro to include:
allow $1 device_t:dir search;

The rationale is that the macro allows access to null_device_t and it is 
almost always necessary to allow search access on the directory to actually 
open /dev/null (and it is necessary for the mmap /dev/null operations that 
shared libraries use).

I decided to do this after adding a huge number of allow rules for 
device_t:dir search as part of the process of removing every_domain().

Steve, please let me know what you think of this.  If you think it's worthy of 
inclusion in the CVS then I'll go through my policy tree and remove all the 
redundant rules from the various .te files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
