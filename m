Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0431IIi021811
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 22:01:18 -0500 (EST)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0431K6C017363
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 03:01:21 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-03.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id j0431IWj007450
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 21:01:18 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 586F54A626
	for <selinux@tycho.nsa.gov>; Mon,  3 Jan 2005 21:01:18 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19043-08 for <selinux@tycho.nsa.gov>;
	Mon, 3 Jan 2005 21:01:18 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 009B54A624
	for <selinux@tycho.nsa.gov>; Mon,  3 Jan 2005 21:01:18 -0600 (CST)
Date: Mon, 3 Jan 2005 21:01:17 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [patch] logrotate
Message-ID: <20050104030117.GB5321@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MAH+hnPXVZWQ5cD/
Content-Type: multipart/mixed; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here are a handful of patches for logrotate, which I've found to be=20
necessary for my Debian SELinux box... all are against current CVS. =20
Please apply.

   logrotate.fc.diff

Debian creates the logrotate state file as "/var/lib/logrotate/status",
rather than "/var/lib/logrotate.status".  The updated pattern will match
both cases.

   logrotate.te.1.diff

Logrotate 3.7 tries to do open(".", O_RDONLY) during startup (so it can
fchdir() back later), and aborts if unsuccessful.  When run from cron it
has a CWD of "/root", which is unreadable under the current policy. =20
I've added read access for "staff_home_dir_t" and "sysadm_home_dir_t".

I'm not completely happy with this approach (perhaps logrotate and/or
the crontab entries should be modified?), but it sees like it should be
safe.

   logrotate.te.2.diff

Logcheck (which is also handled by the logrotate policy) fails without=20
the ability to relabel it's tempfiles.  I've given it "relabelfrom" and=20
"relabelto" on "logrotate_tmp_t:file".


As always, let me know if additional information is desired.  Thanx!


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="logrotate.fc.diff"

--- logrotate.fc.orig	2005-01-01 15:17:35.000000000 -0600
+++ logrotate.fc	2005-01-01 15:20:33.000000000 -0600
@@ -5,7 +5,7 @@
 /usr/bin/savelog	--	system_u:object_r:logrotate_exec_t
 ')
 /etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
-/var/lib/logrotate\.status --	system_u:object_r:logrotate_var_lib_t
+/var/lib/logrotate(/.*)?	system_u:object_r:logrotate_var_lib_t
 /var/lib/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
 # using a hard-coded name under /var/tmp is a bug - new version fixes it
 /var/tmp/logcheck	-d	system_u:object_r:logrotate_tmp_t

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="logrotate.te.1.diff"
Content-Transfer-Encoding: quoted-printable

--- logrotate.te.orig	2005-01-01 15:17:26.000000000 -0600
+++ logrotate.te	2005-01-03 19:16:39.000000000 -0600
@@ -41,8 +41,7 @@
 allow logrotate_t etc_runtime_t:file r_file_perms;
=20
 # it should not require this
-allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { getattr searc=
h };
-dontaudit logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir read;
+allow logrotate_t {staff_home_dir_t sysadm_home_dir_t}:dir { getattr read =
search };
=20
 # create lock files
 rw_dir_create_file(logrotate_t, var_lock_t)

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="logrotate.te.2.diff"
Content-Transfer-Encoding: quoted-printable

--- logrotate.te.orig	2005-01-01 15:17:26.000000000 -0600
+++ logrotate.te	2005-01-03 19:16:56.000000000 -0600
@@ -50,6 +50,7 @@
 # Create temporary files.
 tmp_domain(logrotate)
 can_exec(logrotate_t, logrotate_tmp_t)
+allow logrotate_t logrotate_tmp_t:file { relabelfrom relabelto };
=20
 # Run helper programs.
 allow logrotate_t { bin_t sbin_t }:dir r_dir_perms;

--s9fJI615cBHmzTOP--

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2gb9grEMyr8Cx2YRAmboAJ0ZgkfAZvAH5CIajuol15gO9a9o8wCdHuPq
Zw0u7xyNT1IiT+gNw83POlE=
=R/l/
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
