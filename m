Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T0TlrT015281
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 20:29:47 -0400 (EDT)
Received: from sccrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6T0TGVb027806
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 00:29:16 GMT
Message-ID: <410844F9.3010203@gentoo.org>
Date: Wed, 28 Jul 2004 20:29:45 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
References: <20040728232043.GF18711@lkcl.net>
In-Reply-To: <20040728232043.GF18711@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>i have a requirement (use of usb-mount, see
>http://users.actrix.co.nz/michael/usbmount.html) that forces the use
>of udev on an selinux system.
>
>fighting with it for a day, and after seeing some clues in the
>file contexts (/(u)dev/....) i decided to try editing
>/etc/udev/udev.conf to set it to use /udev instead of /dev.
>
>other than a warning about udev not starting up, well, everything
>seems to work hunky-dory.
>
>somehow i do _get_ a udevd running, i could not tell you how it got
>there.
>
>i notice the following message 
>
>	http://www.redhat.com/archives/fedora-devel-list/2004-March/msg00888.html
>
>in which steven (hi steven :) says that support for udev "fake"
>attributes for ramfs and tmpfs, just like for devpts.
>
>is that literally as simple as cut/paste the devpts code...
>the xattr stuff?
>
>cos if so, i _like_ cut/paste :)
>
>l.
>
>  
>
Chris PeBenito made this patch for Gentoo when we were evalutating udev 
on selinux

http://dev.gentoo.org/~method/1330_linux-2.6.5-ramfs-xattr.patch

that should patch cleanly into 2.6.7, but I'd like to note that at this 
point udev is braindead wrt SELinux.
Once upon a time udev had selinux support integrated so that setfscreate 
was called to set the context of the devices being written however it 
was changed at some point to make SELinux an after device creation addon 
script which makes it label the devices after they are created. Because 
of this Hardened Gentoo has decided not to support udev at this time.


Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
