Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6AI35rT025117
	for <selinux@tycho.nsa.gov>; Sat, 10 Jul 2004 14:03:05 -0400 (EDT)
Date: Sat, 10 Jul 2004 13:02:39 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: small dhcpc.fc patch
Message-ID: <20040710180239.GA16267@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--61jdw2sOBCFtR2d/
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please consider applying the attached dhcpc.fc patch to CVS.  It's
needed by the dhcp3-client package in Debian.  Thanx!

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dhcpc.fc.diff"
Content-Transfer-Encoding: quoted-printable

--- dhcpc.fc.orig	2004-07-10 12:33:24.000000000 -0500
+++ dhcpc.fc	2004-07-10 12:38:04.000000000 -0500
@@ -1,5 +1,6 @@
 # dhcpcd=20
 /etc/dhcpc.*(/.*)?		system_u:object_r:dhcp_etc_t
+/etc/dhcp3?/dhclient.*		system_u:object_r:dhcp_etc_t
 /etc/dhclient.*conf	--	system_u:object_r:dhcp_etc_t
 /etc/dhclient-script	--	system_u:object_r:dhcp_etc_t
 /sbin/dhcpcd		--	system_u:object_r:dhcpc_exec_t

--EVF5PPMfhYS0aIcm--

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8C8/grEMyr8Cx2YRAnmKAKDQetq/mSjUzzyhD2Gp2ipvjqNm9gCg0oL4
U+OlW0O/Dt5KU5mvqarzypM=
=CWoR
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
