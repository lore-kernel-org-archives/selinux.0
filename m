Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i738IlrT019042
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 04:18:47 -0400 (EDT)
Received: from snowstorm.hosts.ndo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i738ID6o003473
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 08:18:14 GMT
Date: Tue, 3 Aug 2004 09:27:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Marco d'Itri" <md@Linux.IT>
Cc: 263079@bugs.debian.org, linux-hotplug-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#263079: udev: missing mknod on ppp
Message-ID: <20040803082752.GA3504@lkcl.net>
References: <E1Brl5k-0006Jd-1F@lkcl.net> <20040802224118.GA18849@wonderland.linux.it> <20040802231534.GB16238@lkcl.net> <20040802231148.GA19178@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040802231148.GA19178@wonderland.linux.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 03, 2004 at 01:11:48AM +0200, Marco d'Itri wrote:
> On Aug 03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> 
> > thank you for pointing me at the README.Debian because it makes clear
> > that for SE/Linux there are certain /dev entries that may not get
> > fired up by udev, and consequently won't have se/linux permissions set!
> On debian, *all* devices are supposed to be created by udev if udev is
> installed (because /dev is a tmpfs).
> I don't know why /dev/ppp is not being created on your system.


this could have something to do with it: it looks like udev
is not quick enough to create the device node in time for pppd
to use it.


Aug  3 09:18:49 localhost udev[3255]: creating device node '/dev/ttyUSB0'
Aug  3 09:18:54 localhost pppd[3258]: pppd is unable to open the /dev/ppp device. You need to create the /dev/ppp device node by executing the following command as root: ^Imknod /dev/ppp c 108 0 
Aug  3 09:19:02 localhost kernel: CSLIP: code copyright 1989 Regents of the University of California
Aug  3 09:19:02 localhost kernel: PPP generic driver version 2.4.2
Aug  3 09:19:02 localhost pppd[3270]: pppd 2.4.2 started by root, uid 0
Aug  3 09:19:02 localhost udev[3269]: creating device node '/dev/ppp'
> 
> > i've had to modify /etc/init.d/udev to do a manual /sbin/restorecon on
> > all entries listed in /etc/udev/links.conf.
> This is a special-case, links.conf is supposed to be used *only* to
> create some symlinks and directories. I do not know enough about SE
> Linux to tell how it should be integrated with this.

 i do.

 i've patched my kernel to have tmpfs(shmfs) support se/linux
 attributes.

 _anything_ that goes into the /dev-mounted tmpfs _must_ have selinux
 attributes set on them.

 in the case of a persistent filesystem (ext2 etc) those attributes can
 be set once, and subsequently ignored.

 of course, with a tmpfs, then it's a bit like saying it's okay to
 create entries in /dev with chmod 0000 and not calling chgrp,
 we'll do it later sort of thing.

 so any symlinks and directories, also you _must_ call /sbin/restorecon
 or some equivalent.

 i've patched udev-0.030 to do likewise: all inodes, all directories
 (including subdirectories) and all symlinks in fact all creates,
 are now created with the correct selinux context.


> 
> > i have some vague and rushed recollection of forcibly doing an
> > /sbin/restorecon in /etc/init.d/modutils, too.
> /etc/init.d/modutils is 2.4.x stuff.
> 
> > the issue is, therefore that /etc/init.d/modutils will endeavour to
> > manually install modules at startup - even before udev is run - and
> > it doesn't bother to set the selinux permissions.
> No, it will not: udev is run S04 and module-init-tools at S20 of rcS.d.

 hm, then should that order be reversed, or do you think that
 module-init-tools should be fixed?
 
 (or other)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
