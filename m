Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04N1pIi028802
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 18:01:51 -0500 (EST)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04N1qA9017749
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 23:01:53 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-01.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id j04N1ogU013563
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 17:01:50 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 256DE4A626
	for <selinux@tycho.nsa.gov>; Tue,  4 Jan 2005 17:01:50 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25380-04 for <selinux@tycho.nsa.gov>;
	Tue, 4 Jan 2005 17:01:49 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id DE5084A624
	for <selinux@tycho.nsa.gov>; Tue,  4 Jan 2005 17:01:49 -0600 (CST)
Date: Tue, 4 Jan 2005 17:01:49 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [patch] screen_macros.te
Message-ID: <20050104230149.GA10317@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--LyciRD1jyfeSSjG0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the entries had the parameters backward, which prevented screen
=66rom HUPing it's parent.  This was causing "power detach" to fail.

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="screen_macros.te.diff"
Content-Transfer-Encoding: quoted-printable

--- screen_macros.te.orig	2004-12-11 00:13:45.000000000 -0600
+++ screen_macros.te	2005-01-04 16:36:10.000000000 -0600
@@ -76,7 +76,7 @@
 file_type_auto_trans($1_screen_t, screen_dir_t, $1_screen_var_run_t, fifo_=
file)
=20
 allow $1_screen_t self:process { fork signal_perms };
-allow $1_t $1_screen_t:process signal;
+allow $1_screen_t $1_t:process signal;
 allow $1_screen_t self:capability { setuid setgid fsetid };
=20
 dontaudit $1_screen_t shadow_t:file read;

--VS++wcV0S1rZb1Fb--

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2yBdgrEMyr8Cx2YRAjh5AJ4ktiktN7GfZEhlhwbC6W/9PsuBWQCeKL3Z
lkTep5AWA6w+PEiZOUg0uTI=
=AZ82
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
