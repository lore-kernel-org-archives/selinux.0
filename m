Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA00299
	for <selinux@tycho.nsa.gov>; Sat, 1 Feb 2003 17:52:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA14810
	for <selinux@tycho.nsa.gov>; Sat, 1 Feb 2003 22:49:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA14806
	for <selinux@tycho.nsa.gov>; Sat, 1 Feb 2003 22:49:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: tmpfs_t
Date: Sat, 1 Feb 2003 23:51:48 +0100
References: <200301271320.IAA05862@moss-shockers.ncsc.mil>
In-Reply-To: <200301271320.IAA05862@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302012351.48969.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Jan 2003 14:20, Stephen D. Smalley wrote:
> The problem is that tmpfs is also used for the kernel internal mount
> for System V shared memory and shared anonymous mappings.  The current
> fs_use configuration and the existing $1_tmpfs_t types and rules are
> oriented toward that usage of tmpfs.  Distinguishing different instances
> of tmpfs mounts and providing different labeling behaviors and contexts
> for those different instances would require further changes to SELinux.

I believe that changes are required.

For UML and busy Apache servers using tmpfs as /tmp is common practise.  The 
current SE Linux setup will force many of the people who run big servers to 
change their operation in a way that will hurt performance to support running 
SE Linux.

I've experimented with using chcon to set the type after mounting which seems 
to work OK.

I believe that the best option is to label the root inode of tmpfs as 
system_u:object_r:tmp_t via initial_sid_contexts.  I've been looking at the 
kernel code, is superblock_doinit() the right place to do a change?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
