Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6ECM3Ha011808
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 08:22:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6ECM2H5007156
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:22:02 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6ECM0RX007153 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:22:01 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 30347BF37
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 22:21:59 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 32290-03
 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 22:21:57 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id BE786BF32
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 22:21:57 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7A5BB924EC
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 22:21:57 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 2EC107F0C2
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 22:21:54 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: memory leak on SE Linux
Date: Mon, 14 Jul 2003 22:21:44 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200307142221.53607.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have just done a diff between the LSM patch in my kernel-patch-2.4-lsm 
Debian package and the latest release.  It seems that when merging patches or 
porting between kernel versions I made an error and caused the pointer to 
some allocated memory to be cleared incorrectly (thus making it impossible to 
free the memory).

I am still performing tests on the new kernel, but the results so far suggest 
that the kernel memory leak I had previously experienced is now solved.

I recall that some other people reported similar problems, if they were using 
my kernel patch for 2.4.21 then it would be the same thing.  If someone is 
experiencing a kernel memory leak when using a kernel patch from the NSA site 
then it would be a different issue and should be raised again.

NB my web site and the Debian repository now both contain a good patch for 
2.4.21 which solves this problem.


Below is the patch fragment in question.

diff -ruN linux-2.4.21-mine/fs/inode.c linux-2.4.21-nsa/fs/inode.c
- --- linux-2.4.21-mine/fs/inode.c        2003-07-13 12:23:29.000000000 +1000
+++ linux-2.4.21-nsa/fs/inode.c 2003-07-13 12:20:16.000000000 +1000
@@ -125,7 +125,6 @@
                mapping->host = inode;
                mapping->gfp_mask = GFP_HIGHUSER;
                inode->i_mapping = mapping;
- -               inode->i_security = NULL;
        }
        return inode;
 }

- -- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/EqBcwrB5/PXHUlYRAqQQAJ490tCtszUr2Ingm0x9UGgi7im2zwCcDAbs
7WUAkyx/JbdJE5rNqs1QB2k=
=i6yZ
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
