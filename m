Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2LXTXZ010134
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 16:33:29 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2LXSLn015107
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 21:33:28 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 2 Nov 2004 22:33:28 +0100
Date: Tue, 2 Nov 2004 22:33:12 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: arpwatch cleanup
Message-Id: <20041102213312.GB3804@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FFoLq8A0u+X9iRU8
Content-Type: multipart/mixed; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following patch cleans up the arpwatch policy. It does not add any
new permissions, it just organizes them more cleanly.
It also adds /var/lib/arpwatch to the file_contexts file since this is=20
the place where both SuSE and Debian store arpwatch data.

Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="arpwatch-cleanup.patch"

--- orig/domains/program/unused/arpwatch.te
+++ mod/domains/program/unused/arpwatch.te
@@ -10,22 +10,23 @@
 # arpwatch_exec_t is the type of the arpwatch executable.
 #
 daemon_domain(arpwatch, `, privmail')
+
+# for files created by arpwatch
 type arpwatch_data_t, file_type, sysadmfile;
-allow arpwatch_t self:netlink_route_socket r_netlink_socket_perms;
-allow arpwatch_t self:capability { net_admin net_raw };
-allow arpwatch_t self:udp_socket create_socket_perms;
-allow arpwatch_t self:unix_dgram_socket create_socket_perms;
-allow arpwatch_t arpwatch_t:capability { setgid setuid };
-allow arpwatch_t arpwatch_t:packet_socket create_socket_perms;
-allow arpwatch_t arpwatch_t:unix_stream_socket create_stream_socket_perms;
 create_dir_file(arpwatch_t,arpwatch_data_t)
-allow arpwatch_t tmp_t:dir { search };
 tmp_domain(arpwatch)
-allow arpwatch_t net_conf_t:file { getattr read };
-allow arpwatch_t netif_lo_t:netif { udp_send };
-allow arpwatch_t sbin_t:dir { search };
-allow arpwatch_t sbin_t:lnk_file { read };
+
+allow arpwatch_t self:capability { net_admin net_raw setgid setuid };
+
 can_network(arpwatch_t)
+allow arpwatch_t self:netlink_route_socket r_netlink_socket_perms;
+allow arpwatch_t self:udp_socket create_socket_perms;
+allow arpwatch_t self:unix_dgram_socket create_socket_perms;
+allow arpwatch_t self:packet_socket create_socket_perms;
+allow arpwatch_t self:unix_stream_socket create_stream_socket_perms;
+
+allow arpwatch_t sbin_t:dir search;
+allow arpwatch_t sbin_t:lnk_file read;
 can_ypbind(arpwatch_t)
 allow system_mail_t arpwatch_tmp_t:file rw_file_perms;
 ifdef(`postfix.te', `


--- orig/file_contexts/program/arpwatch.fc
+++ mod/file_contexts/program/arpwatch.fc
@@ -1,3 +1,7 @@
 # arpwatch - keep track of ethernet/ip address pairings
 /usr/sbin/arpwatch	--	system_u:object_r:arpwatch_exec_t
+ifdef(`distro_redhat', `
 /var/arpwatch(/.*)?	system_u:object_r:arpwatch_data_t
+', `
+/var/lib/arpwatch(/.*)?		system_u:object_r:arpwatch_data_t
+')




--lCAWRPmW1mITcIfM--

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBh/0YxWIrrrL0q+cRAh1/AKCQU3vEP/7fHnB0/dzWbW6UXHh4wACfRsU1
SjZKmvMXIzXcvNx/2/vMIbE=
=i6ar
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
