Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0QJY7Rb026335
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2004 14:34:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0QJWpxr017949
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2004 19:32:51 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
	by jazzswing.ncsc.mil  with ESMTP id i0QJWpYc017946
	for <selinux@tycho.nsa.gov>; Mon, 26 Jan 2004 19:32:51 GMT
Subject: Gentoo SELinux LiveCD
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9uYvTg/sYvsSuxjaD7XK"
Message-Id: <1075145644.1235.93.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Mon, 26 Jan 2004 13:34:05 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9uYvTg/sYvsSuxjaD7XK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Announcing the Gentoo SELinux LiveCD

The Hardened Gentoo SELinux team has put out an experimental SELinux
LiveCD (108MB).  This is primarily meant for Gentoo users to install
SELinux from scratch, but also it can be used to try out SELinux.  I
have been able to successfully boot the CD in enforcing.  The main
requirement is at least a pentium pro machine, since it is compiled with
-march=3Di686.  Please keep in mind its experimental, and if you find bugs
please report them to me, or Gentoo bugzilla (bugs.gentoo.org).  The
only issue I know of is some denials with dhcpcd.


http://gentoo.oregonstate.edu/experimental/x86/livecd/gentoo-selinux-2004.0=
-i686-20040125.iso

MD5:

a4ae323152948633082f5ddf9272f677  gentoo-selinux-2004.0-i686-20040125.iso

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-9uYvTg/sYvsSuxjaD7XK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAFWusvI7kLeavkkMRArwxAKCFh8eSd1pmmEcHWNna3M2Ya/aJsQCeLXzH
sIutPO2deMG6bTZh7g+uQ3A=
=R3Kp
-----END PGP SIGNATURE-----

--=-9uYvTg/sYvsSuxjaD7XK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
