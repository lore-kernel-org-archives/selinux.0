Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFG6mIi024002
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 11:06:48 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFG5Lvq029287
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 16:05:21 GMT
Message-ID: <4198D830.6050002@gentoo.org>
Date: Mon, 15 Nov 2004 18:24:16 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for snort
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B18CB82654EBE0ACFADBBAE"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B18CB82654EBE0ACFADBBAE
Content-Type: multipart/mixed;
 boundary="------------020709090601060802050509"

This is a multi-part message in MIME format.
--------------020709090601060802050509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

diff needed by snort 2.2.0

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------020709090601060802050509
Content-Type: text/plain;
 name="selinux-snort.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-snort.diff"

--- /root/public_html/policy/nsa/file_contexts/program/snort.fc	2003-11-28 16:57:12.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/snort/snort.fc	2004-10-28 17:00:48.000000000 +0300
@@ -1,4 +1,4 @@
 # SNORT
-/usr/sbin/snort	--	system_u:object_r:snort_exec_t
+/usr/(s)?bin/snort --	system_u:object_r:snort_exec_t
 /etc/snort(/.*)?	system_u:object_r:snort_etc_t
 /var/log/snort(/.*)?	system_u:object_r:snort_log_t
--- /root/public_html/policy/nsa/domains/program/unused/snort.te	2004-06-25 23:02:24.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/snort/snort.te	2004-10-28 16:58:33.000000000 +0300
@@ -7,7 +7,8 @@
 
 daemon_domain(snort)
 
-log_domain(snort)
+logdir_domain(snort)
+allow snort_t snort_log_t:dir create;
 can_network(snort_t)
 type snort_etc_t, file_type, sysadmfile;
 
@@ -17,7 +18,7 @@
 # use iptable netlink
 allow snort_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 allow snort_t self:packet_socket create_socket_perms;
-allow snort_t self:capability { setgid setuid net_admin net_raw };
+allow snort_t self:capability { setgid setuid net_admin net_raw dac_override };
 
 r_dir_file(snort_t, snort_etc_t)
 allow snort_t etc_t:file { getattr read };
@@ -28,3 +29,5 @@
 
 # for start script
 allow initrc_t snort_etc_t:file read;
+
+dontaudit snort_t { etc_runtime_t proc_t }:file read;

--------------020709090601060802050509--

--------------enig0B18CB82654EBE0ACFADBBAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmNgwGSBEIeh4AEYRAgpFAJ9olhTxu/NcIor1RvWudRsvHVOxQgCeItkI
umqbRcDd8VKsMSp44L8pzIQ=
=Sa0v
-----END PGP SIGNATURE-----

--------------enig0B18CB82654EBE0ACFADBBAE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
