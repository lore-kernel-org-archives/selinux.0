Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NBrcrT017222
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 07:53:38 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NBrawb023863
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 11:53:36 GMT
Date: Mon, 23 Aug 2004 13:04:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>, Alexandre Oliva <aoliva@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040823120441.GG13842@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <orzn4nuval.fsf@livre.redhat.lsd.ic.unicamp.br> <200408231209.01521.russell@coker.com.au> <20040823085648.GC15972@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040823085648.GC15972@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 23, 2004 at 09:56:48AM +0100, Luke Kenneth Casson Leighton wrote:

> > We either need to get ramfs working in the Fedora kernels or make some changes 
> > to the udev plans.
> > 
> > One option would be to use an ext2 file system on a ram disk for udev.  It 
> > would do all the same stuff as ramfs (at a slightly higher memory cost) and 
> > work perfectly with SE Linux.
  
  ... but it would still leave you with the patches to udev to apply
  [to do symlinks and directories as well as inodes]

  and also would leave you with an "initial startup" issue to set up
  initial perms on /dev/null, /dev/initctl, rights to create /dev/fd/
  etc. all the stuff that the /etc/init.d/udev "hacks" do.

  ... just because you're using a persistent ext2 filesystem with
  xattr permissions storable on a ramdisk it doesn't mean you'd have
  initial setup issues!

  but yes, those could be set up once, in permissive mode, and
  consequently the problem is avoided.

  l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
