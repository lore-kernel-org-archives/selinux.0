Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7VNF9rT016773
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 19:15:09 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7VNF7S3014181
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 23:15:08 GMT
Date: Wed, 1 Sep 2004 00:26:16 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jim McCullough <jim.mccullough@gmail.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Nigel Kukard <nkukard@lbsd.net>,
   linux-hotplug-devel@lists.sourceforge.net, SELinux <selinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831232616.GX4375@lkcl.net>
References: <20040830173744.GD10151@lbsd.net> <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net> <20040831191809.GC4375@lkcl.net> <1093980403.8517.239.camel@moss-spartans.epoch.ncsc.mil> <20040831200210.GH4375@lkcl.net> <ae023b6004083114183fafe6da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ae023b6004083114183fafe6da@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

well, the patch is at um.. oh no it's not... um, hang on...
yep, it's _now_ at http://hands.com/~lkcl/selinux/selinux-hooks.patch


On Tue, Aug 31, 2004 at 05:18:05PM -0400, Jim McCullough wrote:
> This should be of great assistance with two home projects currently
> and  1 work project due to the filesystem types.  I am still working
> through size issues and further locking down the images.
> 
> Project 1 = SE Linux image for Netgear MR314 Wireless Lan Router
> Project 2 = SE Linux image for Cisco 2501 Router
> Project 3 = Debian Sarge Server build on SGI Octane with reiserfs (
> Work for Network Management Server )

> > > The more important issue is that fscontext= lets you set the superblock
> > > security context, not just the root directory context.  restorecon can't
> > > do that.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
