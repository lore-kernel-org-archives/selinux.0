Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O9UerT024721
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 05:30:41 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O9UdCV027072
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:30:39 GMT
Date: Tue, 24 Aug 2004 10:41:57 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Greg KH <greg@kroah.com>, russell@coker.com.au,
   SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
Message-ID: <20040824094157.GF25356@lkcl.net>
References: <200408222125.38169.russell@coker.com.au> <4128B637.8040900@tresys.com> <20040822173457.GD13842@lkcl.net> <20040823224444.GI4694@kroah.com> <412A74A6.9070206@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <412A74A6.9070206@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dear fedora-selinux people,

i am not subscribed to the fedora-selinux list so am just going through
the archives looking for bits i may have missed.

regarding this:

> >  udev is so completely full of race conditions - known to the
> >  developers even _without_ selinux - that the general consensus
> >  seems to be that a few more really won't hurt.

> Huh?  I know of no such thing.

> Without SELinux, and with the recent patch on the hotplug mailing list,
> I know of no race conditions in the current udev code.

the present (0.030's /etc/udev.d/default/selinux script and past
(0.024 built-in)selinux udev support allows for a race condition
in between the creation of the inode (with its default, per-directory
selinux context being used) and the context being properly set
(with /sbin/restorecon in the case of 0.030 and with setfilecon()
in the case of 0.024).

that's why i added code to use setfscreatecon().

the debian maintainer for udev is under the impression that udev has
stacks of race conditions: if that isn't actually the case, then great!

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
