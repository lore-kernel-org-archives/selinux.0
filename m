Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8CG6KLa025311
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 12:06:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8CG6Jmw000834
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 16:06:19 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8CG6J9d000831 for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 16:06:19 GMT
Date: Fri, 12 Sep 2003 17:06:13 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030912160613.GA13578@vnl.com>
References: <20030910164854.GO5397@vnl.com> <200309111048.16590.russell@coker.com.au> <20030912142131.GA4648@vnl.com> <200309130100.49934.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309130100.49934.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 13, 2003 at 01:00:49AM +1000, Russell Coker wrote:
> MKIMAGE='genromfs -f /dev/fd/1 -d %s | gzip -9 > %s'
> I use the above to gzip compress it in the same command (an uncompressed gzip 
> is no good).

Either way I get:

	RAMDISK: rom filesystem found at block 0
	RAMDISK: Loading 2815 blocks [1 disk] into ram disk... done.
	freeing initrd memory: 2815k freed
	sh-2021: reiserfs_fill_super: cannot find reiserfs on ram0
	Kernel panic: VFS: unable to mount root files system on sda2

at which point I have to reboot into my safety kernel for further
testing. I set things up with: 

	mkinitrd /boot.romfs

and have in lilo.conf

	append="selinux=1"
	initrd=/boot.romfs

and your fstab line in /etc/fstab. A manual mount of an unzipped boot.romfs
looks quiet reasonable. I presume something is going bonkers during the
pivot to sda2, but I can't really prove the initrd /linuxrc did anything.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
