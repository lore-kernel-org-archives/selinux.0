Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i29DFWRb012052
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 08:15:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i29DDp6Q023457
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 13:13:51 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i29DDn5t023380
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 13:13:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: XFS and SE Linux
Date: Wed, 10 Mar 2004 00:14:03 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403100014.03542.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

XFS defaults to an Inode size of 256 bytes and a block size of 4K on i386.

The "security.selinux" xattr name and the data stored in it can apparently be 
counted on to not fit into the <50 bytes left in a 256 byte Inode after all 
the other meta-data is stored.  This will mean that a new block is used for 
the XATTR (which in 99.99% of all cases will be the only XATTR on the file).

Using an extra 4K block per file is a significant waste of disk space, XFS 
apparently does not support block sharing so you have 4K of disk space for 50 
bytes of data.

If at mkfs time you make the Inode 512 bytes in size you will have enough 
space for the SE Linux xattr.  This will save huge amounts of space on a SE 
Linux system as there will effectively be 256 bytes of overhead per file 
instead of 4096.

Currently in SE Linux the contexts for files are of the form 
"system_u:object_r:file_t", why not express them on disk as 
"system_u:file_t"?  Saving 9 bytes in this manner could make some of them fit 
into a 256 byte Inode in XFS which would be a significant advantage.  Also 
for Ext2/Ext3 it will save some space as well.

I wonder what Hans Reiser will make of this, I wouldn't be surprised if he 
comes up with some stem compression scheme for XATTR's that makes all the SE 
Linux xattr's take up significantly less than half the space they do on 
Ext2/3 and packs them in with tails.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
