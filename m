Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NEPMHa025588
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 10:25:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6NEPLDW011785
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 14:25:21 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6NEPJeN011776 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 14:25:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen Reese" <sreese@prcdigital.com>, selinux@tycho.nsa.gov
Subject: Re: grub/boot redhat9 problem
Date: Tue, 22 Jul 2003 23:15:05 -0400
References: <001a01c350a8$9bf0e750$6601a8c0@inspiron>
In-Reply-To: <001a01c350a8$9bf0e750$6601a8c0@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307222315.05213.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 22 Jul 2003 19:25, Stephen Reese wrote:
> kmod: failed to exec /sbinmodprobe -s -k ide-disk, errno2
> VFS: Cannot open root device "hda2" or 03:02
> Please apend a correct "root" boot option
> Kernel panic: VFS: Unable to mount root fs on 03:02

That's an issue of configuring the modules for a 2.4.21 kernel in a way that 
doesn't work (kernel is buggy).  Compile the IDE drivers into the kernel to 
solve this.

Also I strongly recommend that you compile and boot a non-SE kernel first 
before you try to get SE Linux running.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
