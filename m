Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GKLprT001858
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 16:21:52 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GKLnNn019200
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 20:21:50 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 16 Jul 2004 22:21:50 +0200
Date: Fri, 16 Jul 2004 22:21:28 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: small policy fixes
Message-Id: <20040716202128.GC4940@obadja.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--KJY2Ze80yH5MUxol
Content-Type: multipart/mixed; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch fixes some small policy issues. The most important change
here is the in_user_role() macro in traceroute.te, otherwise user_ping
doesn't work for traceroute.

Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="small-fixes.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/macros/program/ssh_agent_macros.te
+++ mod/macros/program/ssh_agent_macros.te
@@ -10,7 +10,7 @@
 # ssh_agent_domain(domain_prefix)
 #
 # The type declaration for the executable type for this program is
-# provided separately in domains/program/ssh.te.=20
+# provided separately in domains/program/ssh-agent.te.=20
 #
 define(`ssh_agent_domain',`
 # Define a derived domain for the ssh-agent program when executed
--- orig/domains/program/unused/tcpd.te
+++ mod/domains/program/tcpd.te
@@ -36,7 +36,7 @@
 # These rules have been moved to each target domain .te file.
=20
 # Run other daemons in the inetd_child_t domain.
-allow tcpd_t sbin_t:dir search;
+allow tcpd_t { bin_t sbin_t }:dir search;
 domain_auto_trans(tcpd_t, inetd_child_exec_t, inetd_child_t)
=20
 allow tcpd_t device_t:dir search;
--- orig/domains/program/unused/traceroute.te
+++ mod/domains/program/traceroute.te
@@ -15,6 +15,8 @@
 type traceroute_t, domain, privlog;
 role sysadm_r types traceroute_t;
 role system_r types traceroute_t;
+# for user_ping:
+in_user_role(traceroute_t)
 uses_shlib(traceroute_t)
 can_network(traceroute_t)
 allow traceroute_t node_t:rawip_socket node_bind;
@@ -27,7 +29,7 @@
 allow traceroute_t etc_t:file { getattr read };
=20
 # Use capabilities.
-allow traceroute_t traceroute_t:capability { net_admin net_raw setuid setg=
id };
+allow traceroute_t self:capability { net_admin net_raw setuid setgid };
=20
 allow traceroute_t self:rawip_socket create_socket_perms;
 allow traceroute_t self:netlink_route_socket { bind create getattr nlmsg_r=
ead read write };
--- orig/domains/program/unused/usbmodules.te
+++ mod/domains/program/usbmodules.te
@@ -19,6 +19,7 @@
 ifdef(`hotplug.te',`
 domain_auto_trans(hotplug_t, usbmodules_exec_t, usbmodules_t)
 allow usbmodules_t hotplug_etc_t:file r_file_perms;
+allow usbmodules_t hotplug_etc_t:dir search;
 ')
 allow usbmodules_t init_t:fd use;
 allow usbmodules_t console_device_t:chr_file { read write };

--mR8QP4gmHujQHb1c--

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+DjIxWIrrrL0q+cRAtIuAJ9POETRT1IRDlrRkgmGJ7bm9MjTGACfXUFf
Z5eKxiuwU1LP9/2LCrcTv6o=
=shSW
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
