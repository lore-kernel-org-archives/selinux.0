Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06000
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 09:14:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA16761
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:14:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA16757
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 13:14:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: emger@norwich.edu, selinux@tycho.nsa.gov
Subject: Re: XFS and LSM
Date: Thu, 13 Jun 2002 15:14:35 +0200
References: <5772.1023963428@ocs3.intra.ocs.com.au> <20020613104731.CF50F1F09@lyta.coker.com.au> <20030708180754.1bc130f8.emger@norwich.edu>
In-Reply-To: <20030708180754.1bc130f8.emger@norwich.edu>
MIME-Version: 1.0
Message-Id: <20020613131435.77B3340BF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 9 Jul 2003 00:07, Ryan Emge wrote:
> ext2 and ext3 would be optimum filesystems that would not "break" SE Linux?

Stephen says that the quota changes in question are already in 2.5 kernels, 
so if you can find a 2.5.x kernel patch for XFS then it should not cause any 
difficulty (unless you use IA64).

Ext2/3 are not the only file systems that will work without problems.  
ReiserFS is working well for me, there's no reason to expect a problem with 
Minix or any other Inode based file system either.

The only problems are with file systems that lack Inodes (DOS and NFS), and 
with file systems that aren't in the kernel as applying several patches to 
the kernel is likely to result in patches not applying or a kernel that 
doesn't compile.

Anyway I have a 2.4.18 kernel running with XFS support compiled in.  When I 
quickly hacked the support in I probably broke SE support for quotas, but I 
don't care as it's not something that's important to me.  The only problem 
here is that I can't be sure that my sample policy works well for other 
people in this regard (but it would not be difficult for them to fix).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
