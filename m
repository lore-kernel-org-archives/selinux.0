Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8CHiBLa026178
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 13:44:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8CHgXLY024754
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 17:42:33 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8CHgVsG024750
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 17:42:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: rfs xattr's, mkinitrd and other stories
Date: Sat, 13 Sep 2003 03:44:00 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030910164854.GO5397@vnl.com> <200309130100.49934.russell@coker.com.au> <20030912160613.GA13578@vnl.com>
In-Reply-To: <20030912160613.GA13578@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309130344.00862.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 13 Sep 2003 02:06, Dale Amon wrote:
> On Sat, Sep 13, 2003 at 01:00:49AM +1000, Russell Coker wrote:
> > MKIMAGE='genromfs -f /dev/fd/1 -d %s | gzip -9 > %s'
> > I use the above to gzip compress it in the same command (an uncompressed
> > gzip is no good).
>
> Either way I get:
>
> 	RAMDISK: rom filesystem found at block 0
> 	RAMDISK: Loading 2815 blocks [1 disk] into ram disk... done.
> 	freeing initrd memory: 2815k freed
> 	sh-2021: reiserfs_fill_super: cannot find reiserfs on ram0
> 	Kernel panic: VFS: unable to mount root files system on sda2
>
> at which point I have to reboot into my safety kernel for further
> testing. I set things up with:

Looks like you didn't compile in ROMFS support in your kernel.  You have to 
have CONFIG_ROMFS_FS=y.

It's not an SE Linux issue so it's probably best if we take discussion off the 
list.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
