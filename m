Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T0kNrT015365
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 20:46:23 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6T0jqVb028246
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 00:45:52 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 00:46:22 -0000
Date: Thu, 29 Jul 2004 01:57:27 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729005727.GA4335@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <410844F9.3010203@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya joshua,

a recent release of udev (0.26) from like, two weeks ago
(which i only just noticed) appears to have had its
udev "hard-coded" support removed - and incidentally
the equally hard-coded dbus support removed...

... to be replaced with an /etc/dev.d/something/selinux
which runs restorecon $DEVICE.

and, amazingly, it works.

what is getting my goat at the moment is as i said having
to use /udev instead of /dev.

GREAT.  a patch.

it wouldn't have occurred to me to do the inode and special
node stuff.

thanks v. much.

l.

On Wed, Jul 28, 2004 at 08:29:45PM -0400, Joshua Brindle wrote:
> Luke Kenneth Casson Leighton wrote:
> 
> >i have a requirement (use of usb-mount, see
> >http://users.actrix.co.nz/michael/usbmount.html) that forces the use
> >of udev on an selinux system.
> >
> >fighting with it for a day, and after seeing some clues in the
> >file contexts (/(u)dev/....) i decided to try editing
> >/etc/udev/udev.conf to set it to use /udev instead of /dev.
> >
> >other than a warning about udev not starting up, well, everything
> >seems to work hunky-dory.
> >
> >somehow i do _get_ a udevd running, i could not tell you how it got
> >there.
> >
> >i notice the following message 
> >
> >	http://www.redhat.com/archives/fedora-devel-list/2004-March/msg00888.html
> >
> >in which steven (hi steven :) says that support for udev "fake"
> >attributes for ramfs and tmpfs, just like for devpts.
> >
> >is that literally as simple as cut/paste the devpts code...
> >the xattr stuff?
> >
> >cos if so, i _like_ cut/paste :)
> >
> >l.
> >
> > 
> >
> Chris PeBenito made this patch for Gentoo when we were evalutating udev 
> on selinux
> 
> http://dev.gentoo.org/~method/1330_linux-2.6.5-ramfs-xattr.patch
> 
> that should patch cleanly into 2.6.7, but I'd like to note that at this 
> point udev is braindead wrt SELinux.
> Once upon a time udev had selinux support integrated so that setfscreate 
> was called to set the context of the devices being written however it 
> was changed at some point to make SELinux an after device creation addon 
> script which makes it label the devices after they are created. Because 
> of this Hardened Gentoo has decided not to support udev at this time.
> 
> 
> Joshua Brindle

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
