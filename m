Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5UKMnrT001054
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2004 16:22:50 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5UKMmWY005977
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2004 20:22:48 GMT
Message-Id: <200406302022.i5UKM8if002745@turing-police.cc.vt.edu>
To: Magnus Therning <magnus-work@therning.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Subject: Re: SELinux on Debian (Sid), second try 
In-Reply-To: Your message of "Wed, 30 Jun 2004 10:29:35 +0200."
             <20040630082935.GK1688@philips.com>
From: Valdis.Kletnieks@vt.edu
References: <20040624163900.GB3290@philips.com> <200406282347.41232.russell@coker.com.au> <20040628150448.GF1688@philips.com> <200406291533.10068.russell@coker.com.au> <20040629085928.GH1688@philips.com>
            <20040630082935.GK1688@philips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1060137792P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 30 Jun 2004 16:22:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1060137792P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <28099.1088626927.1@turing-police.cc.vt.edu>

On Wed, 30 Jun 2004 10:29:35 +0200, Magnus Therning said:

> Some more information (that might be interesting).
> 
> /etc/fstab has an entry like this:
> 
>  none /selinux selinuxfs noauto 0 0
> 
> 'mount' doesn't report it mounted though. Should it?

Sounds like it gets mounted before / gets remounted R/W, so
the mount isn't recorded in /etc/mtab.  Poke around in whatever Debian
uses as a /etc/rc.sysinit or similar, and there's probably a block of
calls that look something like:

# Enter root, /proc and (potentially) /proc/bus/usb and devfs into mtab.
mount -f /
mount -f /proc
mount -f /sys >/dev/null 2>&1 
mount -f /dev/pts
[ -f /proc/bus/usb/devices ] && mount -f -t usbdevfs usbdevfs /proc/bus/usb
[ -e /dev/.devfsd ] && mount -f -t devfs devfs /dev

(That's what Fedora Core 2 has).  If you have such a block, does adding:

mount -f /selinux

to it make things work as expected, or at least more like it>?

--==_Exmh_-1060137792P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA4yDwcC3lWbTT17ARAuMtAKDbESsVdXsgYd0gzUKlWvXe2RbM0wCdEvMz
KGtINsA4E3nB9p9jWBBjKhk=
=iT1o
-----END PGP SIGNATURE-----

--==_Exmh_-1060137792P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
