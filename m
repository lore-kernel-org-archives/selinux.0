Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i535hLrT009818
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 01:43:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i545h30x020065
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 01:43:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E8A6D61BD6
	for <selinux@tycho.nsa.gov>; Thu,  3 Jun 2004 15:43:17 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03026-06 for <selinux@tycho.nsa.gov>;
	Thu, 3 Jun 2004 15:43:17 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8AFB761BB0
	for <selinux@tycho.nsa.gov>; Thu,  3 Jun 2004 15:43:17 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1D8AEB586F
	for <selinux@tycho.nsa.gov>; Thu,  3 Jun 2004 15:43:16 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: samba
Date: Thu, 3 Jun 2004 15:43:15 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200406031543.15551.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When discussing SE Linux and Samba with Andrew Tridgell last night we came up 
with an idea that should work reasonably well without hurting performance 
much.

Firstly we consider Samba to be a trusted object manager, so there is no plan 
to prevent any Samba process from exceeding it's access (IE we are not 
protecting against a buffer overflow or other attack to make the Samba daemon 
perform inappropriate actions).

For operations which require access to a directory tree (IE every operation 
that does not involve an open file handle - open, creat, unlink, rename, 
stat, chmod, chown, truncate, etc) we can have a separate samba process 
that's run in a different context (eg smbd_user_t, smbd_staff_t, etc).  The 
operations that result in an open file handle (open() and creat()) can then 
pass back a file handle to the parent process over a Unix domain socket.  For 
read/write/ioctl/fstat/ftruncate operations the main Samba process can query 
the SE Linux kernel (or maybe use user space AVC code) as to whether the 
operations are permitted.

This was one of many possible ways of doing this that we discussed.  I don't 
think it was Andrew's favourite, but I think it works best with what we are 
trying to do.


Another possibility is to just not permit multiple SMB identities over the 
same TCP socket, there's apparently a registry setting that can be used on 
each SMB client machine to make it use a separate TCP socket per connection.  
In which case we just need to change the Samba code from fork/setuid to 
fork/setuid/exec (which will not be fun).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
