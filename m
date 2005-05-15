Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4FBEpgA012823
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 07:14:51 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4FBBdiA007733
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 11:11:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: ls -Z on non-SE machine
Date: Sun, 15 May 2005 21:11:31 +1000
Cc: SELinux <selinux@tycho.nsa.gov>
References: <200505151921.23171.russell@coker.com.au> <20050515102704.GA16326@lkcl.net>
In-Reply-To: <20050515102704.GA16326@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505152111.34732.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 15 May 2005 20:27, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> how about just silently ignoring the -Z option if selinux is
> detected to not be enabled?
>
> or placing dummy information in its place which any selinux-aware
> shell scripts can pick up on.

You appear to have totally ignored my points about analysis of SE Linux disks 
in non-SE machines and recovery of SE Linux systems from non-SE rescue disks.

We could just not use the -Z option if we don't want the security contexts to 
be displayed.  But the entire point here is to have them available.

> On Sun, May 15, 2005 at 07:21:20PM +1000, Russell Coker wrote:
> > Currently "ls -Z" refuses to operate if it detects that SE Linux is not
> > enabled on the machine.
> >
> > This makes no sense to me.  Files that are labelled when running SE Linux
> > keep their labels (and the values of such labels may still be read) when
> > not running SE Linux.  It seems quite reasonable to me that an
> > administrator may want to take a disk out of a SE Linux machine and mount
> > it on a non-SE machine for debugging problems or forensics.  The current
> > behavior of ls works against such operations.
> >
> > I believe that the best thing to do is to have ls not be linked against
> > libselinux and instead just call the XATTR api for reading the file
> > contexts. Ideally I think that such functionality should be enabled
> > unconditionally so that any administrator who receives a disk that was
> > used on a SE Linux system will have the ability to conveniently view all
> > the data on it.
> >
> > --
> > http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
> > packages http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> > http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> > http://www.coker.com.au/~russell/  My home page
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > with the words "unsubscribe selinux" without quotes as the message.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
