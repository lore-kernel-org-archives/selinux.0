Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBH1MRIi029229
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 20:22:27 -0500 (EST)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBH1MTqv007410
	for <selinux@tycho.nsa.gov>; Fri, 17 Dec 2004 01:22:29 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-03.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id iBH1MPWj019874
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 19:22:26 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 8F8714A626
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 19:22:25 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19578-02 for <selinux@tycho.nsa.gov>;
	Thu, 16 Dec 2004 19:22:25 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id 304D54A624
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 19:22:25 -0600 (CST)
Date: Thu, 16 Dec 2004 19:22:24 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [patch] misc. policy updates
Message-ID: <20041217012224.GA11330@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--wq9mPyueHGvFACwf
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached diff against ddclient.te is necessary in order for it to
work properly with the new networking macros.  Also, it updates my email
address in the policy header.  The other two simply perform the latter
update for the other policies I've submitted.

Please apply.

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ddclient.te.diff"
Content-Transfer-Encoding: quoted-printable

--- ddclient.te.orig	2004-12-16 19:03:49.000000000 -0600
+++ ddclient.te	2004-12-16 19:04:50.000000000 -0600
@@ -1,6 +1,6 @@
 #DESC ddclient - Update dynamic IP address at DynDNS.org
 #
-# Author: Greg Norris <adric@debian.org>
+# Author: Greg Norris <haphazard@kc.rr.com>
 # X-Debian-Packages: ddclient
 #
=20
@@ -20,17 +20,18 @@
=20
 # misc. requirements
 allow ddclient_t self:fifo_file rw_file_perms;
-allow ddclient_t self:unix_stream_socket create_socket_perms;
+allow ddclient_t self:socket create_socket_perms;
 allow ddclient_t etc_t:file { getattr read };
 allow ddclient_t etc_runtime_t:file r_file_perms;
 allow ddclient_t ifconfig_exec_t:file { rx_file_perms execute_no_trans };
 allow ddclient_t urandom_device_t:chr_file { read };
-allow ddclient_t proc_t:file r_file_perms;
+general_proc_read_access(ddclient_t)
 allow ddclient_t sysctl_net_t:dir { search };
=20
 # network-related goodies
-can_network_server(ddclient_t)
+can_network_udp(ddclient_t)
 allow ddclient_t self:unix_dgram_socket create_socket_perms;
+allow ddclient_t self:unix_stream_socket create_socket_perms;
=20
 # allow access to ddclient.conf and ddclient.cache
 allow ddclient_t ddclient_etc_t:file r_file_perms;

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dnsmasq.te.diff"
Content-Transfer-Encoding: quoted-printable

--- dnsmasq.te.orig	2004-12-16 19:08:32.000000000 -0600
+++ dnsmasq.te	2004-12-16 19:09:34.000000000 -0600
@@ -1,6 +1,6 @@
 #DESC dnsmasq - DNS forwarder and DHCP server
 #
-# Author: Greg Norris <adric@debian.org>
+# Author: Greg Norris <haphazard@kc.rr.com>
 # X-Debian-Packages: dnsmasq
 #
=20

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fetchmail.te.diff"

--- fetchmail.te.orig	2004-12-16 19:08:37.000000000 -0600
+++ fetchmail.te	2004-12-16 19:09:42.000000000 -0600
@@ -1,6 +1,6 @@
 #DESC fetchmail - remote-mail retrieval utility
 #
-# Author: Greg Norris <adric@debian.org>
+# Author: Greg Norris <haphazard@kc.rr.com>
 # X-Debian-Packages: fetchmail
 #
 # Note: This policy is only required when running fetchmail in daemon mode.

--bp/iNruPH9dso1Pn--

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBwjTQgrEMyr8Cx2YRAkLZAJ0T15XYUzo1HIpUoWzdschF47L+tACgvyAN
pDs7Zgq9YpCA8mFcmU9Tfho=
=72X8
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
