Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2U1mCDo011153
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 20:48:12 -0500 (EST)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2U1l7cn028355
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 01:47:08 GMT
Received: from sasami.localdomain (CPE-67-48-98-59.kc.rr.com [67.48.98.59])
	by ms-smtp-03.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id j2U1l2HB027400
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 19:47:04 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 0352D4A626
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 19:46:47 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28617-08 for <selinux@tycho.nsa.gov>;
	Tue, 29 Mar 2005 19:46:46 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id A3B3A4A624
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 19:46:46 -0600 (CST)
Date: Tue, 29 Mar 2005 19:46:46 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [patch] tighten fetchmail policy
Message-ID: <20050330014646.GA19610@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--oC1+HKm2/end4ao3
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patches tighten the fetchmail policy somewhat, by
restricting network access to specific ports.  It also affects (very
slightly) access to etc_t and fetchmail_etc_t files... basically just
removing "lock", since it isn't required.

Please apply.

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fetchmail.te.diff"
Content-Transfer-Encoding: quoted-printable

--- fetchmail.te.orig	2005-03-23 17:23:49.000000000 -0600
+++ fetchmail.te	2005-03-27 21:34:29.000000000 -0600
@@ -2,6 +2,7 @@
 #
 # Author: Greg Norris <haphazard@kc.rr.com>
 # X-Debian-Packages: fetchmail
+# Depends: mta.te
 #
 # Note: This policy is only required when running fetchmail in daemon mode.
=20
@@ -17,12 +18,13 @@
 allow fetchmail_t self:process setrlimit;
=20
 # network-related goodies
-can_network(fetchmail_t)
+can_network_client_tcp(fetchmail_t, { dns_port_t pop_port_t smtp_port_t })
+can_network_udp(fetchmail_t, dns_port_t)
 allow fetchmail_t self:unix_dgram_socket create_socket_perms;
 allow fetchmail_t self:unix_stream_socket create_stream_socket_perms;
=20
 # file access
-allow fetchmail_t etc_t:file r_file_perms;
-allow fetchmail_t fetchmail_etc_t:file r_file_perms;
+allow fetchmail_t etc_t:file { read getattr ioctl };
+allow fetchmail_t fetchmail_etc_t:file { read getattr ioctl };
 allow fetchmail_t mail_spool_t:dir search;
 file_type_auto_trans(fetchmail_t, mail_spool_t, fetchmail_uidl_cache_t, fi=
le)

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="network.te.diff"

--- network.te.orig	2005-03-25 17:28:18.000000000 -0600
+++ network.te	2005-03-25 17:29:36.000000000 -0600
@@ -35,6 +35,7 @@
 ifdef(`perdition.te', `define(`use_pop')')
 ifdef(`dovecot.te', `define(`use_pop')')
 ifdef(`uwimapd.te', `define(`use_pop')')
+ifdef(`fetchmail.te', `define(`use_pop')')
 ifdef(`use_pop', `
 type pop_port_t, port_type, reserved_port_type;
 ')

--TB36FDmn/VVEgNH/--

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCSgUGgrEMyr8Cx2YRAuWhAKCi98Ha7fWYlsVuNJgRlzF6nwPb0QCeI/pD
Umfo9OLEe6LvNGZaNnzVg5Y=
=BkXj
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
