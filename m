Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2CIZ1Rb003089
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2004 13:35:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2CIXI6Q015637
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2004 18:33:18 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2CIXI5t015634
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2004 18:33:18 GMT
Received: from moss-huskies (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2CIZ0jP004090
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2004 13:35:00 -0500 (EST)
Subject: Updated Release
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K08Ac9yehodUJxBco3wx"
Message-Id: <1079116499.9107.292.camel@moss-huskies>
Mime-Version: 1.0
Date: 12 Mar 2004 13:34:59 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-K08Ac9yehodUJxBco3wx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The SELinux web site <http://www.nsa.gov/selinux/> including the mail
list archive has been updated. OpenPGP signatures are now available for
released code. The site includes a new release of the SELinux prototype.
Experimental SELinux NFS code has been made available. The base kernel
version for 2.4 has been updated to 2.4.25. The base version for 2.6
remains 2.6.3, but the SELinux patch has been updated.  Among the
improvements in this release: Fine-grained boolean labeling support has
been merged. The userspace AVC has been enhanced to handle netlink
selinux notifications. MLS improvements have been merged as well as
updates to slat and the example policy.

--=20
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--=-K08Ac9yehodUJxBco3wx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAUgLT4bzZdP61mHERAg1GAKDenwl3Uo9BzVGt69npzQNeRGR4+ACeI3Of
4pbjkJDQ+EN+386XXY8kq+w=
=N6fL
-----END PGP SIGNATURE-----

--=-K08Ac9yehodUJxBco3wx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
