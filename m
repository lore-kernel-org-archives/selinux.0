Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7N29BrT015331
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 22:09:12 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7N297V1016502
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 02:09:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Alexandre Oliva <aoliva@redhat.com>
Subject: Re: Fedora and udev
Date: Mon, 23 Aug 2004 12:09:01 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
References: <200408222125.38169.russell@coker.com.au> <orzn4nuval.fsf@livre.redhat.lsd.ic.unicamp.br>
In-Reply-To: <orzn4nuval.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408231209.01521.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 23 Aug 2004 00:00, Alexandre Oliva <aoliva@redhat.com> wrote:
> On Aug 22, 2004, Russell Coker <russell@coker.com.au> wrote:
> > It seems that udev is now virtually mandatory as of the latest
> > rawhide update.
>
> This is what makes it, like, mandatory:
>
> /etc/udev/udev.conf:
> UDEV_INITRD="yes"
>
> Change it to `no' and hopefully everything will work again.  It breaks
> more than SELinux.

Thanks for that advice.  Once I looked at that I noticed that there's an 
option UDEV_RAMFS in the same file which must be set to "no".  I'm not sure 
whether UDEV_RAMFS="no" would allow it to work on SE Linux with 
UDEV_INITRD="yes" but don't have any plans to test this at the moment.

We either need to get ramfs working in the Fedora kernels or make some changes 
to the udev plans.

One option would be to use an ext2 file system on a ram disk for udev.  It 
would do all the same stuff as ramfs (at a slightly higher memory cost) and 
work perfectly with SE Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
