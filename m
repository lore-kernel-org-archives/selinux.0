Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T1rRrT015670
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 21:53:27 -0400 (EDT)
Received: from smtp814.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6T1quVb000058
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 01:52:56 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp814.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 01:53:26 -0000
Date: Thu, 29 Jul 2004 03:04:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729020431.GA10044@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org> <20040729013510.GC4335@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040729013510.GC4335@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, i've added in some stuff for tmpfs, just like chris did,
joshua.

if anyone would like to play with this (aside from kicking the
udev developer) then you can find the code at
http://hands.com/~lkcl/selinux/2.6.6.

it's too late in the morning to go making patches, sorry: help yourself.
i'll sort patches later.

i added, like chris did, some "special" inodes stuff, and some stuff
to do symlinks too.

of course, the default policy files all expect the root filesystem
to be a hard drive not a tmpfs_t so boot poos up.

i started adding in selinux permissions to udev.te.

... i get the impression that i need to do stuff like create a
new initrd that has /selinux in it and things.

but what i _can_ do that's fairly easy is write a message to the
nice udev developer :)

l.

On Thu, Jul 29, 2004 at 02:35:10AM +0100, Luke Kenneth Casson Leighton wrote:
> > >i have a requirement (use of usb-mount, see
> > >http://users.actrix.co.nz/michael/usbmount.html) that forces the use
> > >of udev on an selinux system.

> > Chris PeBenito made this patch for Gentoo when we were evalutating udev 
> > on selinux
> > 
> > http://dev.gentoo.org/~method/1330_linux-2.6.5-ramfs-xattr.patch

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
