Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3MHEQ8c018838
	for <selinux@tycho.nsa.gov>; Sat, 22 Apr 2006 13:14:26 -0400
Received: from rwcrmhc14.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3MHEPbY025572
	for <selinux@tycho.nsa.gov>; Sat, 22 Apr 2006 17:14:26 GMT
Subject: textrel_shlib_t handling
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MxFWNNO6KE9F22gJDLkz"
Date: Sat, 22 Apr 2006 13:14:18 -0400
Message-Id: <1145726058.9106.70.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-MxFWNNO6KE9F22gJDLkz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I remember seeing some discussion about RPM being enhanced so that it
detects libraries with text relocations, and labels them textrel_shlib_t
when installing them onto the filesystem.  So I thought that it would be
useful for Gentoo's Portage too.  The problem is that if a library isn't
already textrel_shlib_t in the file contexts, a relabel will reset them
back to shlib_t.  I came up with two possible solutions:

1. the package manager adds file contexts using semanage fcontext, then
the library will get the right label by default.  The problem with this
is that this would need to be recorded somewhere (probably the package
manager db) so the package manager removes this fcontext if the package
is removed/upgraded.

2. textrel_shlib_t is made a customizable type.  The problem is that the
libs can still get set back to shlib_t if using -F on
restorecon/setfiles.

While #1 is the best solution, it may require significant changes in the
package manager, and may not be acceptable to the upstream because of
that.  #2 is a simpler solution, but has the -F problem.  My feeling is
that the -F problem is not a significant problem, so we should go with
#2.  Thoughts?

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


--=-MxFWNNO6KE9F22gJDLkz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBESmRqvI7kLeavkkMRAl0PAJ0RS0k97LMN6eW1vPRsXuH3SxNZUACdEhVo
ev9FsuAd3rcotPFRuqi2/1M=
=tqbw
-----END PGP SIGNATURE-----

--=-MxFWNNO6KE9F22gJDLkz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
