Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iALBW2Ii000249
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 06:32:02 -0500 (EST)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iALBW4q6018229
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 11:32:05 GMT
Message-ID: <41A08072.5000904@gentoo.org>
Date: Sun, 21 Nov 2004 13:48:02 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: gentoo diff for dhcpd
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8C73F3F0A25D96968D00137A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C73F3F0A25D96968D00137A
Content-Type: multipart/mixed;
 boundary="------------000609030504040102050103"

This is a multi-part message in MIME format.
--------------000609030504040102050103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


added needed capabilities
sys_chroot-related file locations

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------000609030504040102050103
Content-Type: text/plain;
 name="selinux-dhcp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-dhcp.diff"

--- /root/public_html/policy/nsa/file_contexts/program/dhcpd.fc	2004-11-19 10:48:10.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/dhcp/dhcpd.fc	2004-11-19 10:35:55.000000000 +0200
@@ -8,3 +8,27 @@
 /var/lib/dhcp(3)?	-d	system_u:object_r:dhcp_state_t
 define(`dhcp_defined')
 ')
+
+ifdef(`distro_gentoo', `
+/etc/dhcp			-d	system_u:object_r:dhcp_etc_t
+/etc/dhcp(/.*)?			--	system_u:object_r:dhcp_etc_t
+/var/lib/dhcp			-d 	system_u:object_r:dhcp_state_t
+/var/lib/dhcp/dhcpd\.leases.* 	--	system_u:object_r:dhcpd_state_t
+/var/run/dhcp/dhcpd\.pid     	--	system_u:object_r:dhcpd_var_run_t
+
+# for the chroot setup
+/chroot						-d	system_u:object_r:root_t
+/chroot/dhcp					-d	system_u:object_r:root_t
+/chroot/dhcp/dev				-d	system_u:object_r:device_t
+/chroot/dhcp/etc				-d	system_u:object_r:etc_t
+/chroot/dhcp/etc/dhcp               -d  system_u:object_r:dhcp_etc_t
+/chroot/dhcp/etc/dhcp(/.*)?         --  system_u:object_r:dhcp_etc_t
+/chroot/dhcp/usr/sbin/dhcpd         --  system_u:object_r:dhcpd_exec_t
+/chroot/dhcp/var				-d	system_u:object_r:var_t
+/chroot/dhcp/var/run				-d	system_u:object_r:var_run_t
+/chroot/dhcp/var/lib				-d	system_u:object_r:var_lib_t
+/chroot/dhcp/var/lib/dhcp			-d	system_u:object_r:dhcp_state_t
+/chroot/dhcp/var/lib/dhcp/dhcpd\.leases.*	--	system_u:object_r:dhcpd_state_t
+/chroot/dhcp/var/run/dhcp/dhcpd\.pid     	--	system_u:object_r:dhcpd_state_t
+')
+
--- /root/public_html/policy/nsa/domains/program/unused/dhcpd.te	2004-11-20 09:01:20.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/dhcp/dhcpd.te	2004-11-20 09:47:28.000000000 +0200
@@ -67,3 +67,8 @@
 # allow reading /proc
 allow dhcpd_t proc_t:{ file lnk_file } r_file_perms;
 tmp_domain(dhcpd)
+
+ifdef(`distro_gentoo', `
+allow dhcpd_t self:capability { chown dac_override setgid setuid sys_chroot };
+allow initrc_t dhcpd_state_t:file setattr;
+')

--------------000609030504040102050103--

--------------enig8C73F3F0A25D96968D00137A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBoIByGSBEIeh4AEYRApJGAJwPvP01Nghwq8h98D46jjc0MyCLzgCfb/GF
tT/93oXEIWsrZ2ES5AdvdFU=
=Bp3d
-----END PGP SIGNATURE-----

--------------enig8C73F3F0A25D96968D00137A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
