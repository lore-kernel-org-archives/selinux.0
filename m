Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7N8jZrT016608
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 04:45:36 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7N8jXwb021051
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 08:45:34 GMT
Date: Mon, 23 Aug 2004 09:56:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Alexandre Oliva <aoliva@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040823085648.GC15972@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <orzn4nuval.fsf@livre.redhat.lsd.ic.unicamp.br> <200408231209.01521.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408231209.01521.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 23, 2004 at 12:09:01PM +1000, Russell Coker wrote:
> On Mon, 23 Aug 2004 00:00, Alexandre Oliva <aoliva@redhat.com> wrote:
> > On Aug 22, 2004, Russell Coker <russell@coker.com.au> wrote:
> > > It seems that udev is now virtually mandatory as of the latest
> > > rawhide update.
> >
> > This is what makes it, like, mandatory:
> >
> > /etc/udev/udev.conf:
> > UDEV_INITRD="yes"
> >
> > Change it to `no' and hopefully everything will work again.  It breaks
> > more than SELinux.
> 
> Thanks for that advice.  Once I looked at that I noticed that there's an 
> option UDEV_RAMFS in the same file which must be set to "no".  I'm not sure 
> whether UDEV_RAMFS="no" would allow it to work on SE Linux with 
> UDEV_INITRD="yes" but don't have any plans to test this at the moment.

 where does that option come from?  on debian, all the options in
 0.030's config file are lower-case, and there's no udev_initrd="yes"
 or "no".

> We either need to get ramfs working in the Fedora kernels or make some changes 
> to the udev plans.
> 
> One option would be to use an ext2 file system on a ram disk for udev.  It 
> would do all the same stuff as ramfs (at a slightly higher memory cost) and 
> work perfectly with SE Linux.
 
 *whew*.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
