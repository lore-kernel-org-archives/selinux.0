Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5EHBQrT019894
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 13:11:26 -0400 (EDT)
Received: from turing-police.cirt.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5EHBL0I013176
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 17:11:23 GMT
Message-Id: <200406141711.i5EHBibr011709@turing-police.cc.vt.edu>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: too many sysadmfile? 
In-Reply-To: Your message of "Mon, 14 Jun 2004 04:20:13 CDT."
             <1087204813.23933.150.camel@gorn.pebenito.net>
From: Valdis.Kletnieks@vt.edu
References: <1086884579.19414.30.camel@gorn.pebenito.net> <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil> <1086971434.19414.148.camel@gorn.pebenito.net> <200406140051.i5E0plBk003937@turing-police.cc.vt.edu>
            <1087204813.23933.150.camel@gorn.pebenito.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_975602008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 14 Jun 2004 13:11:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_975602008P
Content-Type: text/plain; charset=us-ascii

On Mon, 14 Jun 2004 04:20:13 CDT, Chris PeBenito said:

> I don't see how these would be broken.  Admin_domain() has tmp_domain(),
> so /tmp/foo will be writable.  I'm not arguing that sysadmfile should be
> eliminated, just reduced; /etc/hosts would still be a sysadmfile, and
> therefore be writable.

OK.. So pick *any* *other* file that fills these requirements:

1) You're proposing that the file in question not be a sysadmfile anymore.

2) People have been known to edit said file with a text editor.


--==_Exmh_975602008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAzdxPcC3lWbTT17ARAlRoAJ4iSq+Zjm6PRbOZ6MJsi4y43pUuJACg8LxF
6mYtqqbapC8pPzpeqeISQFs=
=TV1F
-----END PGP SIGNATURE-----

--==_Exmh_975602008P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
