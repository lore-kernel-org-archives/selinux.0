Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBL4mvRb017772
	for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2003 23:48:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBL4m6jx019255
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 04:48:06 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
	by jazzswing.ncsc.mil  with ESMTP id hBL4m5SR019252
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 04:48:05 GMT
Subject: sshd subsystems
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eiKzP39kK3oEGail5veL"
Message-Id: <1071982130.10602.6.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Sat, 20 Dec 2003 22:48:50 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-eiKzP39kK3oEGail5veL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've been trying to decide what would be the best way to deal with sshd
subsystems (sftp-server for example).  Right now they can't be used
because of their label (transition to unpriv_userdomain domain is denied
for one).  The simplest way to fix it would be to label the sftp-server
binary as shell_exec_t.  I was also thinking about using a
sshd_subsys_exec_t or something similar instead, and add the appropriate
policy.  Any thoughts?

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

--=-eiKzP39kK3oEGail5veL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5SYxvI7kLeavkkMRAgaQAJ4l+9n45t3m99PyBrgLcN2nO0QLzQCff+Si
zAbAGQd0fMrGQmTNcrWnK54=
=DhF2
-----END PGP SIGNATURE-----

--=-eiKzP39kK3oEGail5veL--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
