Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0J0InIi024485
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 19:18:49 -0500 (EST)
Received: from ms-smtp-02.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0J0IkY7017886
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2005 00:18:47 GMT
Received: from sasami.localdomain (CPE-67-48-98-59.kc.rr.com [67.48.98.59])
	by ms-smtp-02.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id j0J0IdIM008878
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 18:18:40 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 941CE4A626
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 18:18:39 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04678-04 for <selinux@tycho.nsa.gov>;
	Tue, 18 Jan 2005 18:18:39 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 484324A624
	for <selinux@tycho.nsa.gov>; Tue, 18 Jan 2005 18:18:39 -0600 (CST)
Date: Tue, 18 Jan 2005 18:18:39 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [patch] dpkg.fc
Message-ID: <20050119001839.GA8704@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--RASg3xLB4tUQ4RcS
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch removes a duplicate entry from dpkg.fc, which causes=20
`make relabel' to complain.  Please apply.


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dpkg.fc.diff"

--- dpkg.fc.orig	2004-11-24 00:12:20.000000000 -0600
+++ dpkg.fc	2005-01-18 18:15:39.000000000 -0600
@@ -35,7 +35,6 @@
 /etc/kde2/.+\.sh	--	system_u:object_r:install_menu_exec_t
 /usr/share/console/getkmapchoice\.pl -- system_u:object_r:bin_t
 /var/run/update-menus\.pid --	system_u:object_r:install_menu_var_run_t
-/usr/share/openoffice\.org-debian-files/install-hook -- system_u:object_r:bin_t
 /usr/share/dlint/digparse --	system_u:object_r:bin_t
 /usr/share/gimp/1\.2/user_install -- system_u:object_r:bin_t
 /usr/share/openoffice\.org-debian-files/install-hook -- system_u:object_r:bin_t

--bg08WKrSYDhXBjb5--

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB7adfgrEMyr8Cx2YRAq4AAKDAe4LqxJche3tD9KWyvpQpVSKi1wCdEwxm
EglI6phbIJrQfPVSmWMVhr4=
=GOSm
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
