Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0LMTHFX016102
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 17:29:18 -0500 (EST)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0LMTJ5L009224
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 22:29:19 GMT
Received: from sasami.localdomain (CPE-67-48-98-59.kc.rr.com [67.48.98.59])
	by ms-smtp-04.rdc-kc.rr.com (8.12.8p1/8.12.7) with ESMTP id j0LMIxxF027661
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 16:19:02 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id A5C8F4A626
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 16:29:15 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14806-08 for <selinux@tycho.nsa.gov>;
	Fri, 21 Jan 2005 16:29:15 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 5422D4A624
	for <selinux@tycho.nsa.gov>; Fri, 21 Jan 2005 16:29:15 -0600 (CST)
Date: Fri, 21 Jan 2005 16:29:15 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [patch] ddclient
Message-ID: <20050121222914.GA2208@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bCsyhTFzCvuiizWE
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patches fix a few ddclient problems.  Please apply.

ddclient.fc
  * Make `ddclient_var_t' match the `/var/cache/ddclient' directory,=20
    rather than just the files therein.

ddclient.te
  * Allow execution of bin_t programs.
  * Allow client-level access to TCP networking, instead of UDP only.
  * Allow ddclient to create it's cache file if necessary.

Thanx!


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ddclient.fc.diff"

--- ddclient.fc.orig	2005-01-21 16:10:12.000000000 -0600
+++ ddclient.fc	2005-01-21 16:10:47.000000000 -0600
@@ -1,7 +1,7 @@
 # ddclient
 /etc/ddclient\.conf		--	system_u:object_r:ddclient_etc_t
 /usr/sbin/ddclient		--	system_u:object_r:ddclient_exec_t
-/var/cache/ddclient(/.*)?	--	system_u:object_r:ddclient_var_t
+/var/cache/ddclient(/.*)?		system_u:object_r:ddclient_var_t
 /var/run/ddclient\.pid		--	system_u:object_r:ddclient_var_run_t
 # ddt - Dynamic DNS client
 /usr/sbin/ddtcd		--	system_u:object_r:ddclient_exec_t

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ddclient.te.diff"
Content-Transfer-Encoding: quoted-printable

--- ddclient.te.orig	2005-01-21 16:09:59.000000000 -0600
+++ ddclient.te	2005-01-21 16:12:50.000000000 -0600
@@ -15,7 +15,7 @@
 var_lib_domain(ddclient)
=20
 base_file_read_access(ddclient_t)
-can_exec(ddclient_t, shell_exec_t)
+can_exec(ddclient_t, { shell_exec_t bin_t })
=20
 # ddclient can be launched by pppd
 ifdef(`pppd.te',`domain_auto_trans(pppd_t, ddclient_exec_t, ddclient_t)')
@@ -31,11 +31,11 @@
 allow ddclient_t sysctl_net_t:dir { search };
=20
 # network-related goodies
-can_network_udp(ddclient_t)
+can_network_client(ddclient_t)
 allow ddclient_t self:unix_dgram_socket create_socket_perms;
 allow ddclient_t self:unix_stream_socket create_socket_perms;
=20
 # allow access to ddclient.conf and ddclient.cache
 allow ddclient_t ddclient_etc_t:file r_file_perms;
 allow ddclient_t ddclient_var_t:dir rw_dir_perms;
-allow ddclient_t ddclient_var_t:file rw_file_perms;
+allow ddclient_t ddclient_var_t:file create_file_perms;

--liOOAslEiF7prFVr--

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8YI6grEMyr8Cx2YRAhIzAJ9xQh6fXVvwJbIgfNn4nT2+vtzwqwCgyPTw
KQ2yu7gvjL688gS39sNvY+Q=
=YX/D
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
