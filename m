Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j049uSIi023074
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 04:56:28 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j049uUA9022970
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 09:56:31 GMT
Date: Tue, 4 Jan 2005 10:06:35 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Erich Schubert <erich@debian.org>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: tty files, console login on debian
Message-ID: <20050104100635.GI10906@lkcl.net>
References: <1100024374.18347.5.camel@wintermute.xmldesign.de> <200501041937.21843.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200501041937.21843.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 04, 2005 at 07:37:18PM +1100, Russell Coker wrote:
> > Since the type of the staff/user ttys is "ttyfile", but no longer
> > "device_type". Maybe you'll prefer a different fix, though.
> > It is also possible that the mountpoint or so needs to be relabeled?
> > (redhat appears to have tmpfs_t there, not fs_t)
> 
> In Fedora now the terminal device nodes are only on tmpfs_t for a udev managed 
> tmpfs on /dev.  In Debian the normal use is to have ext2/3 file systems for 
> root which includes /dev.
 
 and the abnormal use (for mad people like me) is to hand-patch
 the /etc/init.d debian scripts like makevirtfs etc. and also
 the selinux strict policy to cope with an initrd.

 none of which stands a dog's chance of being accepted until sarge is
 released because libselinux1 is presently "optional" and all the
 critical packages must have "optional" dependencies.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
