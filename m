Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9UMYoWt016256
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 17:34:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9UMYmKl020488
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 22:34:49 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id h9UMYh5m020479 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 22:34:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0EC2D7F002
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 09:33:47 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: attr_copy_file()
Date: Fri, 31 Oct 2003 09:33:46 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310310933.46513.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This function usually returns errors when running on SE Linux.  It tries to 
set the security.selinux attribute which in most cases will fail, and is 
often not desirable even if it will work.

To deal with this it has to check for a security.selinux attribute name and 
for whether SE Linux is active, if so then it needs special case handling.

I am considering two options for dealing with this.  One is to just never copy 
security.selinux when SE Linux is enabled, the other is to never display 
EPERM error messages in this case if the operation fails.  The problem with 
the latter is that every cp by sysadm_t acts like a "cp -c", which often is 
not what you desire.

This gets ugly in that code for is_selinux_enabled() will need to be copied 
into libxattr source (can't have libxattr and libselinux depend on each 
other).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
