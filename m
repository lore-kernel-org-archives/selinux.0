Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OA6lrT024909
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 06:06:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OA6iCV027655
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 10:06:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Fedora and udev
Date: Tue, 24 Aug 2004 20:06:41 +1000
Cc: Joshua Brindle <jbrindle@tresys.com>, Greg KH <greg@kroah.com>,
   SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
References: <200408222125.38169.russell@coker.com.au> <412A74A6.9070206@tresys.com> <20040824092853.GD25356@lkcl.net>
In-Reply-To: <20040824092853.GD25356@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408242006.41591.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 19:28, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  2) it ONLY set the permissions on the inode NOT on any symlinks and NOT
>     on any directories or subdirectories created.

This part is OK.  We have moved to using device_t (the default) as the context 
for all directories and sym-links under /dev.

>  what _should_ be done is that udev (or udevd) should be patched to
>  popen("setfiles -q -s", "w") and then when each device inode is
>  created (and a udevsend is exec'd to do it), the filename of the
>  device inode is ALSO sent down the pipe to setfiles.
>
>  i say should, what i mean is, this is the most non-nasty solution
>  with the tools and options presently available.

Sounds good to me.

>  if the file_contexts stuff was somehow pre-munged and
>  transferred into kernel, and the regexp matching code (or
>  something similar) was _also_ transferred into the kernel,
>  then this problem would go away.

I think it's already been decided not to do that.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
