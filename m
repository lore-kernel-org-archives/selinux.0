Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA06499
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 15:40:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA13698
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 20:37:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA13694
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 20:37:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Curtis Greer" <curtlg@msn.com>
Subject: Re: Selinux on smp
Date: Wed, 12 Feb 2003 21:40:07 +0100
References: <F309haIsUCDZ2UehKla00014297@hotmail.com>
In-Reply-To: <F309haIsUCDZ2UehKla00014297@hotmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302122140.07673.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 12 Feb 2003 20:09, Curtis Greer wrote:
> dual processor Dell 6600.  The build works fine.  When attempting to run
> SELinux I get the following errors:
>
>   NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
>   ds: no socket drivers loaded!
>   kmod: failed to exec /sbin/modprobe -s -k block-major-8, errno = 2
>   VFS: Cannot open root device "807" or 08:07
>   Please append a correct "root=" boot option
>   Kernel panic: VFS: Unable to mount root fs on 08:07
>
>   I'm new at this unix game so I'm stuck. Is something missing from the
> kernel?

It looks like you didn't compile the kernel driver for the device /dev/sda so 
the root file system can't be mounted from /dev/sda7.

I don't think that this is related to SE Linux in any way.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
