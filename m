Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFFapIi023682
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 10:36:51 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFFZNvq026895
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 15:35:24 GMT
Message-ID: <4198D12A.7060002@gentoo.org>
Date: Mon, 15 Nov 2004 17:54:18 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for bind
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC45435BF90A371A373E35F3D"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC45435BF90A371A373E35F3D
Content-Type: multipart/mixed;
 boundary="------------010308000303030403050406"

This is a multi-part message in MIME format.
--------------010308000303030403050406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

This is a small diff for bind.fc

bye,
peter

--------------010308000303030403050406
Content-Type: text/plain;
 name="selinux-bind.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-bind.diff"

--- /root/public_html/policy/nsa/file_contexts/program/named.fc	2004-10-27 20:48:06.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/bind/named.fc	2004-10-30 19:37:33.000000000 +0300
@@ -35,3 +35,11 @@
 /var/named/chroot/var/named/data(/.*)? system_u:object_r:named_cache_t
 /var/named/chroot/var/named/named\.ca	--	system_u:object_r:named_conf_t
 ') dnl distro_redhat
+
+ifdef(`distro_gentoo', `
+/etc/bind(/.*)?         system_u:object_r:named_zone_t
+/etc/bind/named\.conf   --  system_u:object_r:named_conf_t
+/etc/bind/rndc\.key    --  system_u:object_r:named_conf_t
+/var/bind(/.*)?             system_u:object_r:named_cache_t
+/var/bind/pri(/.*)?         system_u:object_r:named_zone_t
+') dnl distro_gentoo

--------------010308000303030403050406--

--------------enigC45435BF90A371A373E35F3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmNEqGSBEIeh4AEYRAh3+AKCDpW98zEMXpBBw/uEC/NNERuWCZgCeNoJ+
E1Kn1bcYxbAgWUnATFq79XM=
=uoBK
-----END PGP SIGNATURE-----

--------------enigC45435BF90A371A373E35F3D--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
