Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA12144
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 19:49:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA19719
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 23:49:23 GMT
Received: from pslhp.castandcrew.com (sdfw-ext.castandcrew.com [63.113.17.130])
	by jazzswing.ncsc.mil  with ESMTP id XAA19711
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 23:49:22 GMT
Subject: Re: new policy changes
From: Gregory Ade <gkade@bigbrother.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20020619113740.9045569D@lyta.coker.com.au>
References: <20020619113740.9045569D@lyta.coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-wh0lXkGNmhAYxGQ1pwnm"
Date: 19 Jun 2002 16:49:20 -0700
Message-Id: <1024530561.32149.22.camel@pslgregory>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wh0lXkGNmhAYxGQ1pwnm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-06-19 at 04:37, Russell Coker wrote:
> I've changed /dev/console to be writable only by the admin domains not by=
=20
> every_domain().
>=20
> This means of course that if you login at the console you have to do so a=
s an=20
> administrator, this is fair IMHO, there's no cause for regular users to l=
ogin=20
> at the console.

What about the case of a workstation?  I log in to the console of my
machine as myself every day.  Also, i believe that KDM/GDM/XDM logins
via the physically attached kb/mouse/monitor are treated as "console"
logins.

--=20
Gregory K. Ade <gkade@bigbrother.net>
http://bigbrother.net/~gkade
OpenPGP Key ID: EAF4844B  keyserver: pgpkeys.mit.edu

--=-wh0lXkGNmhAYxGQ1pwnm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9ERiAeQUEYOr0hEsRAs6WAKDDHHhjqF/k2ENFYkiSfw4SOnMUKwCfRZQX
l6X543My1EG6vipqKjqXVjY=
=urgX
-----END PGP SIGNATURE-----

--=-wh0lXkGNmhAYxGQ1pwnm--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
