Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O7PDrT024099
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 03:25:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O7PACV025062
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 07:25:11 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Date: Tue, 24 Aug 2004 17:25:07 +1000
Cc: Jeremy Katz <katzj@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <200408222125.38169.russell@coker.com.au> <200408231209.01521.russell@coker.com.au> <1093286952.4101.47.camel@bree.local.net>
In-Reply-To: <1093286952.4101.47.camel@bree.local.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408241725.07093.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 04:49, Jeremy Katz <katzj@redhat.com> wrote:
> > One option would be to use an ext2 file system on a ram disk for udev. 
> > It would do all the same stuff as ramfs (at a slightly higher memory
> > cost) and work perfectly with SE Linux.
>
> It has a number of other, not really desired side effects as well.
> 1) Kernel people don't really like ramdisks anymore
> 2) Doing this requires mke2fs in the initramfs.  Bleah.
> 3) It puts an artificial cap on the size of your /dev that then has to
> be adjustable.  And the cap is related to an overhead of memory usage.
> This is ugly to get "right"

I agree that ext2 is not a long-term solution to this problem.

However at the moment we have a default configuration that's grossly broken 
with regard to SE Linux.  If you upgrade a machine which runs the "targeted" 
policy to rawhide then several important daemons (including syslogd) stop 
working.  If you upgrade a machine which runs the "strict" policy then it 
will fail to boot.

If we were unable to get ramfs working in a reasonable amount of time then 
ext2 would be a good option to consider IMHO.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
