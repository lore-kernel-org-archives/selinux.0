Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4NLiPRb006957
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 17:44:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4NLfuB2001932
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 21:41:56 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
	by jazzswing.ncsc.mil  with ESMTP id i4NLftwi001929
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 21:41:55 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 23 May 2004 23:44:20 +0200
Date: Sun, 23 May 2004 23:44:06 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: [patch] policy for nrpe
Message-Id: <20040523214406.GB6147@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QRj9sO5tAVLaXnSD
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch adds policy support for nrpe.
(nrpe stands for Nagios Remote Plugin Execution and is a client called
=66rom inetd which performs checks on a client on behalf of a Nagios
server)

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nrpe.patch"

--- orig/domains/program/unused/nrpe.te	1970-01-01 01:00:00.000000000 +0100
+++ mod/domains/program/unused/nrpe.te	2004-05-23 23:28:33.000000000 +0200
@@ -0,0 +1,39 @@
+# DESC nrpe - Nagios Remote Plugin Execution
+#
+# Author: Thomas Bleher <ThomasBleher@gmx.de>
+#
+# Depends: tcpd.te
+# X-Debian-Packages: nagios-nrpe-server
+#
+# This policy assumes that nrpe is called from inetd
+
+type nrpe_port_t, port_type;
+
+daemon_base_domain(nrpe)
+domain_auto_trans(tcpd_t, nrpe_exec_t, nrpe_t)
+
+allow nrpe_t urandom_device_t:chr_file { getattr ioctl read };
+
+allow nrpe_t self:fifo_file rw_file_perms;
+# use sockets inherited from inetd
+allow nrpe_t inetd_t:tcp_socket { ioctl read write };
+allow nrpe_t inetd_t:fd { use };
+allow nrpe_t inetd_t:process { sigchld };
+allow nrpe_t devtty_t:chr_file { read write };
+
+allow nrpe_t self:process setpgid;
+
+etc_domain(nrpe)
+
+# permissions for the scripts executed by nrpe
+#
+# call shell programs
+can_exec(nrpe_t, { bin_t shell_exec_t ls_exec_t })
+allow nrpe_t { bin_t sbin_t }:dir search;
+# for /bin/sh
+allow nrpe_t bin_t:lnk_file read;
+
+# read /proc/meminfo, /proc/self/mounts and /etc/mtab
+allow nrpe_t { self proc_t etc_runtime_t }:file { getattr read };
+
+# you will have to add more permissions here, depending on the scripts you call!
--- orig/file_contexts/program/nrpe.fc	1970-01-01 01:00:00.000000000 +0100
+++ mod/file_contexts/program/nrpe.fc	2004-05-23 23:28:13.000000000 +0200
@@ -0,0 +1,5 @@
+# nrpe
+/usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
+/etc/nagios/nrpe.cfg	--	system_u:object_r:nrpe_etc_t
+/usr/lib/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
+/usr/lib/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
--- orig/net_contexts
+++ mod/net_contexts
@@ -142,6 +142,7 @@
 portcon tcp 5269 system_u:object_r:jabber_interserver_port_t
 ')
 ifdef(`postgresql.te', `portcon tcp 5432 system_u:object_r:postgresql_port_t')
+ifdef(`nrpe.te', `portcon tcp 5666 system_u:object_r:nrpe_port_t')
 ifdef(`use_x_ports', `
 portcon tcp 6000  system_u:object_r:xserver_port_t
 portcon tcp 6001  system_u:object_r:xserver_port_t
--- orig/domains/program/unused/inetd.te
+++ mod/domains/program/inetd.te
@@ -54,6 +54,7 @@
 ifdef(`rshd.te', `allow inetd_t rsh_port_t:tcp_socket name_bind;')
 ifdef(`amanda.te', `allow inetd_t amanda_port_t:tcp_socket name_bind;')
 ifdef(`swat.te', `allow inetd_t swat_port_t:tcp_socket name_bind;')
+ifdef(`nrpe.te', `allow inetd_t nrpe_port_t:tcp_socket name_bind;')
 ifdef(`amanda.te', `
 allow inetd_t biff_port_t:tcp_socket name_bind;
 allow inetd_t biff_port_t:udp_socket name_bind;

--Yylu36WmvOXNoKYn--

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsRsmxWIrrrL0q+cRAjeYAJwL1t73RqGSCW1gSagm7Y7mWvXlggCfdiGo
J3Ta+CZnscA2gZSLzYMbnoo=
=Za3A
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
