Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFFY6Ii023641
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 10:34:06 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFFWcvq026734
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 15:32:39 GMT
Message-ID: <4198D07B.6070401@gentoo.org>
Date: Mon, 15 Nov 2004 17:51:23 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for arpwatch
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDC39FE4936CBFA3C6EB213CF"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC39FE4936CBFA3C6EB213CF
Content-Type: multipart/mixed;
 boundary="------------080700030200010203010901"

This is a multi-part message in MIME format.
--------------080700030200010203010901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

attached you'll find a +15 -5 patch to the arpwatch policy

both /var/lib/arpwatch and /var/arpwatch are used by gentoo.
etc_t is used when arpwatch_t reads nsswitch.conf, usr_t is needed to read the ethercodes file.

the distro_gentoo block is needed because init creates ethX.dat files before the daemon is started.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------080700030200010203010901
Content-Type: text/plain;
 name="selinux-arpwatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-arpwatch.diff"

--- /root/public_html/policy/nsa/file_contexts/program/arpwatch.fc	2004-11-05 23:33:23.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/arpwatch/arpwatch.fc	2004-11-14 09:37:57.000000000 +0200
@@ -1,7 +1,4 @@
 # arpwatch - keep track of ethernet/ip address pairings
 /usr/sbin/arpwatch	--	system_u:object_r:arpwatch_exec_t
-ifdef(`distro_redhat', `
-/var/arpwatch(/.*)?	system_u:object_r:arpwatch_data_t
-', `
+/var/arpwatch(/.*)?		system_u:object_r:arpwatch_data_t
 /var/lib/arpwatch(/.*)?		system_u:object_r:arpwatch_data_t
-')
--- /root/public_html/policy/nsa/domains/program/unused/arpwatch.te	2004-11-05 23:33:22.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/arpwatch/arpwatch.te	2004-11-14 18:37:37.000000000 +0200
@@ -25,11 +25,24 @@
 allow arpwatch_t self:packet_socket create_socket_perms;
 allow arpwatch_t self:unix_stream_socket create_stream_socket_perms;
 
-allow arpwatch_t sbin_t:dir search;
+allow arpwatch_t { sbin_t var_lib_t }:dir search;
 allow arpwatch_t sbin_t:lnk_file read;
+allow arpwatch_t { etc_t usr_t }:file r_file_perms;
+
 can_ypbind(arpwatch_t)
 allow system_mail_t arpwatch_tmp_t:file rw_file_perms;
+allow system_mail_t arpwatch_t:packet_socket { read write };
 ifdef(`postfix.te', `
 allow postfix_local_t arpwatch_data_t:dir { search };
 ')
+ifdef(`qmail.te', `
+allow arpwatch_t bin_t:dir search;
+allow qmail_inject_t arpwatch_tmp_t:file { read write };
+allow qmail_inject_t arpwatch_t:packet_socket { read write };
+')
+
+ifdef(`distro_gentoo', `
+allow initrc_t arpwatch_data_t:dir { add_name write };
+allow initrc_t arpwatch_data_t:file create;
+')
 

--------------080700030200010203010901--

--------------enigDC39FE4936CBFA3C6EB213CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmNB/GSBEIeh4AEYRAqYBAJ9OIScHKSzv4j16Fq2pal+0KlEMVwCfXric
6eMT9iprdRdwTeEhlC9f4b0=
=SHxk
-----END PGP SIGNATURE-----

--------------enigDC39FE4936CBFA3C6EB213CF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
