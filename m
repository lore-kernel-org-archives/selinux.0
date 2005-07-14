Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6EHEBgA004801
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 13:14:12 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6EHAk5c028750
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 17:10:46 GMT
Received: from nexus.verbum.private (localhost.localdomain [127.0.0.1])
	by monk.area614.net (Postfix) with ESMTP id D2BCB4107A0
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 13:10:48 -0400 (EDT)
Subject: security context character set
From: Colin Walters <walters@verbum.org>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ioQmTYgcLzFvM0TDMtVw"
Date: Thu, 14 Jul 2005 13:10:41 -0400
Message-Id: <1121361041.29699.10.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ioQmTYgcLzFvM0TDMtVw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I was wondering if there was a guarantee that security contexts would be
valid UTF-8 (or more strictly ASCII).  This came up because I wrote a
patch for D-BUS which sends contexts over the network; right now they
are marshaled as DBUS_TYPE_STRING which is defined to be UTF-8.

http://lists.freedesktop.org/archives/dbus/2005-July/003037.html

I'm pretty sure they have to be because all the tools just dump them to
the user's terminal (which expects UTF-8), and tools like seaudit use
them in GTK+ which requires UTF-8 strings.  But I just thought I'd check
here.


--=-ioQmTYgcLzFvM0TDMtVw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1pyROIkJWWp2WGURAnxDAJ9UTxZPRPUFaVCiYNbHpWOo3ozuYACeJ6Hx
ph3OBAaoZWh1PZKzBMh/Jdg=
=7NVe
-----END PGP SIGNATURE-----

--=-ioQmTYgcLzFvM0TDMtVw--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
