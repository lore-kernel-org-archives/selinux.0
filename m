Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NHmfgA009576
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 13:48:41 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NHhkhI009011
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 17:43:48 GMT
Message-Id: <200505231628.j4NGStKQ016569@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Kurt Wall <kwall@kurtwerks.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: depinit 
In-Reply-To: Your message of "Sun, 22 May 2005 21:25:55 BST."
             <20050522202555.GR10156@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050522174200.GP10156@lkcl.net> <200505221403.26383.kwall@kurtwerks.com>
            <20050522202555.GR10156@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116865734_3973P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 23 May 2005 12:28:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1116865734_3973P
Content-Type: text/plain; charset=us-ascii

On Sun, 22 May 2005 21:25:55 BST, Luke Kenneth Casson Leighton said:

>  i may have a requirement for utilising depinit instead of debian
>  /etc/init.d and /sbin/init - because i believe it to be much more
>  capable of doing fast boot-times.
> 
>  one of the other requirements is selinux.
> 
>  one plus one equals a whole boat-load more work.

The current Fedora patch to add SELinux support to SysVinit is all of 318
lines.  150 lines of that is one large chunk of added subroutines you can
use yourself, another 15 is adding all the "should we enable it" testing.
100 lines is adding SELinux support to 'killall' and 'sulogin'.

You're handed most of the code you need, and identifying the correct place
to add the 15 lines of checking is pretty easy.  It's *not* a boat-load more
work.

--==_Exmh_1116865734_3973P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCkgTGcC3lWbTT17ARAonvAKDwGhpzEiVlCYmWUOyFP3LcNhSFVgCdFM6K
QgNhFZ6a31U2oSsFnZguYnQ=
=+6LD
-----END PGP SIGNATURE-----

--==_Exmh_1116865734_3973P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
