Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j042xoIi021777
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 21:59:51 -0500 (EST)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j042vwFS004880
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 02:57:59 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-01.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id j042xogU011677
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 20:59:51 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id A28E74A65B
	for <selinux@tycho.nsa.gov>; Mon,  3 Jan 2005 20:59:50 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19066-06 for <selinux@tycho.nsa.gov>;
	Mon, 3 Jan 2005 20:59:50 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 4C58E4A624
	for <selinux@tycho.nsa.gov>; Mon,  3 Jan 2005 20:59:50 -0600 (CST)
Date: Mon, 3 Jan 2005 20:59:50 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [patch] types.fc
Message-ID: <20050104025950.GA5321@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--0eh6TmSyL6TZE2Uz
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch against types.fc is needed by Debian, which currently
supports only a single policy type.  At present "make relabel" mislabels
the binary policy file, which as you can probably imagine is somewhat
inconvenient. ;-)  The patch was generated against current CVS.

Please apply.

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="types.fc.diff"
Content-Transfer-Encoding: quoted-printable

--- types.fc.orig	2005-01-03 20:38:22.000000000 -0600
+++ types.fc	2005-01-03 20:49:39.000000000 -0600
@@ -307,7 +307,7 @@
 /etc/security/default_contexts.*	system_u:object_r:default_context_t
 /etc/services		--	system_u:object_r:etc_t
=20
-/etc/selinux/[^/]*/policy(/.*)?	system_u:object_r:policy_config_t
+/etc/selinux/([^/]*/)?policy(/.*)?	system_u:object_r:policy_config_t
 /etc/selinux/[^/]*/src(/.*)?	system_u:object_r:policy_src_t
 /etc/selinux/[^/]*/contexts(/.*)?	system_u:object_r:default_context_t
 /etc/selinux/[^/]*/contexts/files(/.*)? system_u:object_r:file_context_t

--fdj2RfSjLxBAspz7--

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2gamgrEMyr8Cx2YRAie2AKCEDbU09qpFfZCdoMEVoKM2DMJgLQCeMD/Z
5L8KxGyxnpPWlF5csFF/gZw=
=t+2N
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
