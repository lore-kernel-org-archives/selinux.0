Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h435RCI4020500
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 01:27:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h435R0Vf015651
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 05:27:00 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h435Qv4D015648
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 05:26:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: kernel crashes
Date: Sat, 3 May 2003 15:26:03 +1000
Cc: selinux@tycho.nsa.gov
References: <20030501022414.GA13019@snoopy.apana.org.au> <1051876434.1377.424.camel@moss-huskers.epoch.ncsc.mil> <20030503002143.GB28891@snoopy.apana.org.au>
In-Reply-To: <20030503002143.GB28891@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305031526.03543.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 3 May 2003 10:21, Brian May wrote:
> Next time I reboot my computer, I will boot it in single user
> mode, and see if it still crashes with fewer daemons being
> loaded.

Good idea.  Then try adding different types of load (disk IO, fork/exec, etc).

> I have read with interest about this initramfs[1]. I have read the
> idea is that all special case startup code, eg mounting the root file
> system, NFS-Root code, initial networking code for NFS-Root, RAID
> initialization, etc, will get moved to user space. This suposedly will
> make the kernel simpler and easier to maintain.

Of course you can already do all of that in initrd in 2.4.x.  I've been doing 
it for ages.

> Personally, my only concern with initrd images is that the Debian initrd
> images are far to big to even consider putting on a 1.44Meg boot disk
> (at least those created with the mkinitrd script), I would hope that
> initramfs can be made small enough so that this is no longer a problem.

My initrd images are <850K on disk, my kernel images are <720K.

If I was inclined then I am sure that I could squeeze a kernel and initrd onto 
a single floppy disk formatted with 21 sectors per track.

Apparently the Debian initrd scripts now support tracking module dependencies 
(which I have been doing myself for years).  Also for a while they have 
supported using your own program for creating the initrd file system (I use 
genromfs and gzip -9).

One thing I tried was to get busybox to work as the shell.  I've been getting 
a lot of practise hacking busybox lately, so next time I try this I should be 
able to get it going.  This could reduce the size of the initrd 
significantly.

If I dig up my cut-down SE policy for initrd's then I am sure that I could 
make a single 1.44M disk be a SE Linux boot disk with the new 2.5.x 
policydb-on-initramfs scheme once I get busybox sorted out.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
