Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i730MMrT017250
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 20:22:22 -0400 (EDT)
Received: from flame.hosts.ndo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i730MKKV001287
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 00:22:20 GMT
Date: Tue, 3 Aug 2004 00:15:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Marco d'Itri" <md@Linux.IT>
Cc: 263079@bugs.debian.org, SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: Bug#263079: udev: missing mknod on ppp
Message-ID: <20040802231534.GB16238@lkcl.net>
References: <E1Brl5k-0006Jd-1F@lkcl.net> <20040802224118.GA18849@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040802224118.GA18849@wonderland.linux.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 03, 2004 at 12:41:18AM +0200, Marco d'Itri wrote:
> On Aug 03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> 
> > udev appears to be missing out ppp: i got a request
> > to mknod /dev/ppp c 108 0 when running pon provider
> I see no sign of this being an udev bug.
> Please upgrade your kernel and read again README.Debian.
> If you don't have /sys/class/ppp/ppp/dev, your kernel is too old.
> 
> -- 
> ciao, |
> Marco | [7408 op/KllxVxdFKI]



Script started on Tue Aug  3 00:07:18 2004
highfield:~# more /etc/motd
Linux highfield 2.6.6-selinux1 #5 Tue May 18 16:33:29 GMT 2004 i686 GNU/Linux
highfield:~# ls /sys/class/ppp/ppp/dev
/sys/class/ppp/ppp/dev
highfield:~# 
Script done on Tue Aug  3 00:07:30 2004


so this might be a kernel bug then?

thank you for pointing me at the README.Debian because it makes clear
that for SE/Linux there are certain /dev entries that may not get
fired up by udev, and consequently won't have se/linux permissions set!

i've had to modify /etc/init.d/udev to do a manual /sbin/restorecon on
all entries listed in /etc/udev/links.conf.

i have some vague and rushed recollection of forcibly doing an
/sbin/restorecon in /etc/init.d/modutils, too.

does anyone have any suggestions on how /etc/modutils should be dealt
with on a tmpfs-mounted /dev?

bearing in mind that a [patched, see
http://hands.com/~lkcl/selinux/2.6.6 tmfs-xattr patch] selinux tmpfs
would be mounted with NO initial selinux permissions, and that
ANYTHING that goes into it will need to have a security context set
on it for there to be any chance of it being accessible.

the issue is, therefore that /etc/init.d/modutils will endeavour to
manually install modules at startup - even before udev is run - and
it doesn't bother to set the selinux permissions.

and also, as this initial bug might be raising, if udev doesn't
notice a device driver, /sbin/restorecon (or equivalent) won't ever
get called.

ideas, anyone?

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
