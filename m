Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1G2dafZ018526
	for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2009 21:39:36 -0500
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1G2aDna010799
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 02:36:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: sysvinit doesnt see libselinux/libsepol (LFS system);
Date: Mon, 16 Feb 2009 13:39:09 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <dd18b0c30902142013u323f4853v34270dd2c5e21132@mail.gmail.com>
In-Reply-To: <dd18b0c30902142013u323f4853v34270dd2c5e21132@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902161339.14054.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 15 Feb 2009, Justin Mattock <justinmattock@gmail.com> wrote:
> I'm in the process of creating a linux from scratch system.
> when looking at:
> ldd /sbin/init
> I dont see any info on
> libselinux or libsepol.
[...]
> Is there a clean patch for sysvinit_2.86.ds1.orig.tar.gz
> (I just grabbed any sysvinit from either deb/or ubuntu);
> or even better, a sysvinit(version) that has a built-in command like
> xserver does(--enable-selinux);
> appreciate the time.

# ldd /sbin/init |grep selin
        libselinux.so.1 => /lib/libselinux.so.1 (0xb7f3f000)

The above is from a stock Debian/Lenny system.  The patch (.diff.gz file) for 
that will have the SE Linux code you need.

Incidentally the Debian patch in question is version 61.  I suspect that some 
of those 61 releases have other code that you might desire.  So I suggest 
that even disregarding the fact that the SE Linux code you require is in the 
diff, it's something you would want anyway.

Also let's keep the issues of the X server and init entirely separate.  The 
part of your message which referenced X confused me.  When you do tackle the 
X issue (after you have solved your init problem) please make sure to include 
the relevant part of the "ps axZ" output.

> but results in an unable to sync error when there is no
> policy present

That sounds like you have SELINUX=enforcing in /etc/selinux/config.  Try 
SELINUX=permissive until you have things working reasonably well.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
