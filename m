Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4F9ObgA012452
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 05:24:37 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4F9LDsN004504
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 09:21:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5060461AEC
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 06:33:48 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12934-02 for <selinux@tycho.nsa.gov>;
	Sun, 15 May 2005 06:33:48 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D4FDB61AEB
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 06:33:47 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id D382738
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 19:21:24 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>
Subject: ls -Z on non-SE machine
Date: Sun, 15 May 2005 19:21:20 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200505151921.23171.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently "ls -Z" refuses to operate if it detects that SE Linux is not 
enabled on the machine.

This makes no sense to me.  Files that are labelled when running SE Linux keep 
their labels (and the values of such labels may still be read) when not 
running SE Linux.  It seems quite reasonable to me that an administrator may 
want to take a disk out of a SE Linux machine and mount it on a non-SE 
machine for debugging problems or forensics.  The current behavior of ls 
works against such operations.

I believe that the best thing to do is to have ls not be linked against 
libselinux and instead just call the XATTR api for reading the file contexts.  
Ideally I think that such functionality should be enabled unconditionally so 
that any administrator who receives a disk that was used on a SE Linux system 
will have the ability to conveniently view all the data on it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
