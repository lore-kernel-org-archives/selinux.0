Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j048bSIi022891
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 03:37:29 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j048bTA9021973
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 08:37:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: tty files, console login on debian
Date: Tue, 4 Jan 2005 19:37:18 +1100
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <1100024374.18347.5.camel@wintermute.xmldesign.de>
In-Reply-To: <1100024374.18347.5.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501041937.21843.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 November 2004 05:19, Erich Schubert <erich@debian.org> wrote:
> I just updated my system to your lates debian policy package.
> Afterwards I could no longer login on the console, ssh worked.
> I believe i found the problem in types/file.te:
> I solved it by adding the following:

I've just uploaded a new Debian policy package that fixes this among other 
things.

> Since the type of the staff/user ttys is "ttyfile", but no longer
> "device_type". Maybe you'll prefer a different fix, though.
> It is also possible that the mountpoint or so needs to be relabeled?
> (redhat appears to have tmpfs_t there, not fs_t)

In Fedora now the terminal device nodes are only on tmpfs_t for a udev managed 
tmpfs on /dev.  In Debian the normal use is to have ext2/3 file systems for 
root which includes /dev.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
