Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8MDtsrT002175
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 09:55:54 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8MDstVY020727
	for <selinux@tycho.nsa.gov>; Wed, 22 Sep 2004 13:54:55 GMT
Message-Id: <200409221355.i8MDtnFZ018380@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: fuse 
In-Reply-To: Your message of "Wed, 22 Sep 2004 01:55:09 BST."
             <20040922005509.GD14303@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20040922005509.GD14303@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2139163588P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 22 Sep 2004 09:55:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-2139163588P
Content-Type: text/plain; charset=us-ascii

On Wed, 22 Sep 2004 01:55:09 BST, Luke Kenneth Casson Leighton said:

> fusexmp provides stateless proxy access to a linux filesystem,
> so if HAL chops off /media/usbdisk1 without warning, then the
> fusexmp mountpoint (say /home/user/proxyroot/media/usbdisk1)
> just... doesn't _care_.

Somehow, I can't convince myself that isn't a good way to livelock the kernel
because the VFS has locked something and then gone away for a LONG time in
userspace - mostly because I've seen it all too many times with an NFS mount
that includes 'hard' but *not* 'intr'...)


--==_Exmh_-2139163588P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBUYRkcC3lWbTT17ARAsUlAKCC2G4tEjdYXLp8o2vGE314KyTzbgCaA6V4
N+dPvNOYhZqETAkELEBdZEs=
=hFSf
-----END PGP SIGNATURE-----

--==_Exmh_-2139163588P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
