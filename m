Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TJCmrT018345
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 15:12:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TJBinY001824
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 19:11:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ReiserFS
Date: Thu, 30 Sep 2004 05:12:44 +1000
Cc: fedora-selinux-list@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200409300512.44632.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134111

We are having some discussions of ReiserFS in the Red Hat bugzilla.

fs_use_xattr reiserfs system_u:object_r:fs_t;

It seems to me that the easiest solution is to remove the above line from 
fs_use and add the following to genfs_contexts:

genfscon reiserfs /                     system_u:object_r:nfs_t

The reason for this hack is that we already have the policy for home 
directories on NFS.  ReiserFS will never work for a root FS and isn't worth 
any more effort than this hack.

Another suggestion was to entirely remove ReiserFS support from Fedora (IE no 
reiserfs.ko file in the kernel package).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
