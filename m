Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4DNAZRb007819
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 19:10:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4DNAXMi012255
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 23:10:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4DNAXpI012252 for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 23:10:33 GMT
Received: from moss-huskies (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4DNAXYf012722
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 19:10:33 -0400 (EDT)
Subject: Updated Release
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pHheItK9cSwNvbTFSEZp"
Message-Id: <1084489830.11135.80.camel@moss-huskies>
Mime-Version: 1.0
Date: 13 May 2004 19:10:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pHheItK9cSwNvbTFSEZp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The SELinux web site <http://www.nsa.gov/selinux/> has been updated. The
site includes a new release of the SELinux prototype. The current
prototype and the experimental NFS code are now based on Linux kernel
2.6.6. Several races and kernel socket creation have been fixed and a
runtime disable has been added. The old linux 2.4-based kernel patch has
been ported to 2.4.26. The userland patches have been updated from
Fedora Core 2 development. There are now man pages for libselinux. X
server security classes and access vector definitions were added and
many policy updates were made.

--=20
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency

--=-pHheItK9cSwNvbTFSEZp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBApABm4bzZdP61mHERAohwAJ0XnBFbPx/Yjv5fZU3aOBnMHFqQ5QCfcc+a
orXUTM475RygWWBUgp7zQNc=
=0Orw
-----END PGP SIGNATURE-----

--=-pHheItK9cSwNvbTFSEZp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
