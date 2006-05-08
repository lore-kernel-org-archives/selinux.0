Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4832NAO008660
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 23:02:23 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4832KiA005673
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 03:02:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: /etc/mtab and namespaces
Date: Mon, 8 May 2006 13:02:18 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200605072345.49483.russell@coker.com.au> <200605080101.k4811Gle007489@turing-police.cc.vt.edu>
In-Reply-To: <200605080101.k4811Gle007489@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605081302.22637.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 08 May 2006 11:01, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 07 May 2006 23:45:45 +1000, Russell Coker said:
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190962
> > I have filed a bugzilla entry requesting that /etc/mtab be made a
> > sym-link to /proc/mounts to allow df(1) to work correctly when multiple
> > name spaces are being used.
>
> Not that simple - first all the code that uses /etc/mtab has to be fixed
> to deal with the slight differences between mtab and /proc/mounts.

It's been done before.  The Familiar distribution had /etc/mtab as a sym-link 
the last time I used it (which was a couple of years ago).  It's not a new 
idea.

> On my system at the moment:
>
> /etc/mtab has:
>
> none /proc proc rw 0 0
> /dev/hda1 /boot ext3 ro,noexec,nosuid,nodev,noatime,nodiratime 0 0
> none /tmp tmpfs
> rw,noexec,nosuid,nodev,noatime,nodiratime,size=1532M,mode=1777 0 0
> /dev/mapper/rootvg-var /var ext3
> rw,noexec,nodev,noatime,nodiratime,usrquota,grpquota 0 0
>
> and /proc/mounts says:
>
> /proc /proc proc rw 0 0
> /dev/hda1 /boot ext3 ro,nosuid,nodev,noexec,noatime,nodiratime,data=ordered
> 0 0 none /tmp tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
> /dev/rootvg/var /var ext3
> rw,nodev,noexec,noatime,nodiratime,data=ordered,usrquota,grpquota 0 0

The difference seems to be some mount options related to journaling, size, and 
permission mode.  I think that this should be regarded as a kernel bug in 
that the kernel does not export such data.  There is no reason why the kernel 
code could not export such data.

> If you're *positive* that nothing in userspace cares about the differences
> noted, it might be doable...  Big "if" though...

What do you believe will care about those differences?  df, mount, and the 
quota utilities don't care, and I can't think of any other program that 
uses /etc/mtab (apart from other programs that do df type operations).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
