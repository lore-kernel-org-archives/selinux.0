Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1HjOXZ028048
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 12:45:24 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1Hi3CC017875
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 17:44:03 GMT
Message-Id: <200411011745.iA1HjGZ0004102@turing-police.cc.vt.edu>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: add assert statement for syslog 
In-Reply-To: Your message of "Mon, 01 Nov 2004 11:24:14 +0100."
             <20041101102345.GA3377@jmh.mhn.de>
From: Valdis.Kletnieks@vt.edu
References: <20041101102345.GA3377@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-284213844P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 01 Nov 2004 12:45:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-284213844P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 Nov 2004 11:24:14 +0100, Thomas Bleher said:

> The following patch adds an assertion so that only domains with the
> "privlog"-attribute can actually syslog.

Unless I'm missing a 'privlog' entry on a 'type' line someplace, this
basically means that unless you write some policy, an arbitrary program can't
syslog() at all.  This does help prevent "flood the syslog" attacks, but
I'm not sure we want to be *that* draconian without a site-settable flag.

It sort of renders /usr/bin/logger in a shell script useless, for starters...

--==_Exmh_-284213844P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBhnYrcC3lWbTT17ARAlHlAKCxuBAQVuD9ldkGHO7MIJ2XFl25swCghrWu
Yu8mpWx2wZVo/qMGVzFKJRI=
=J7YP
-----END PGP SIGNATURE-----

--==_Exmh_-284213844P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
