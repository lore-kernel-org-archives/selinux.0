Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFG3OIi023957
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 11:03:24 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFG1evq029029
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 16:01:44 GMT
Message-ID: <4198D752.2020405@gentoo.org>
Date: Mon, 15 Nov 2004 18:20:34 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for snmpd
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0764D833CA581EFB0DFA12A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0764D833CA581EFB0DFA12A
Content-Type: multipart/mixed;
 boundary="------------000507000700010605060007"

This is a multi-part message in MIME format.
--------------000507000700010605060007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

gentoo as a special context for /proc/net:
genfscon proc /net  system_u:object_r:proc_net_t

so a small diff is needed for the snmpd policy. attached.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------000507000700010605060007
Content-Type: text/plain;
 name="selinux-snmpd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-snmpd.diff"

--- /root/public_html/policy/nsa/domains/program/unused/snmpd.te	2004-11-08 11:44:39.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/snmpd/snmpd.te	2004-11-09 10:03:15.000000000 +0200
@@ -70,6 +70,12 @@
 ')
 allow snmpd_t var_lib_nfs_t:dir search;
 
+ifdef(`distro_gentoo', `
+# needed in order to retrieve net traffic data
+allow snmpd_t proc_net_t:dir search;
+allow snmpd_t proc_net_t:file r_file_perms;
+')
+
 dontaudit snmpd_t domain:dir { getattr search };
 
 dontaudit snmpd_t selinux_config_t:dir search;
--- /root/public_html/policy/nsa/file_contexts/program/snmpd.fc	2004-10-21 12:56:53.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/snmpd/snmpd.fc	2004-10-28 11:53:07.000000000 +0300
@@ -1,6 +1,7 @@
 # snmpd
 /usr/sbin/snmp(trap)?d	--	system_u:object_r:snmpd_exec_t
 /var/lib/snmp(/.*)?		system_u:object_r:snmpd_var_lib_t
+/var/lib/net-snmp(/.*)?	system_u:object_r:snmpd_var_lib_t
 /etc/snmp/snmp(trap)?d\.conf -- system_u:object_r:snmpd_etc_t
 /usr/share/snmp/mibs/\.index -- system_u:object_r:snmpd_var_lib_t
 /var/run/snmpd\.pid	--	system_u:object_r:snmpd_var_run_t

--------------000507000700010605060007--

--------------enigE0764D833CA581EFB0DFA12A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmNdSGSBEIeh4AEYRAkYpAJ4wLqyiSfcO1FMUNB12EQVcsPE+sgCfU3w8
WWh7SNhTPdL934pYTAdRb5A=
=HC5W
-----END PGP SIGNATURE-----

--------------enigE0764D833CA581EFB0DFA12A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
