Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i978fFrT012448
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 04:41:16 -0400 (EDT)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i978e6nr016003
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 08:40:07 GMT
Message-ID: <41650174.4090103@gentoo.org>
Date: Thu, 07 Oct 2004 11:42:28 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for ipsec
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig97D291447783FBAECCFDD76C"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97D291447783FBAECCFDD76C
Content-Type: multipart/mixed;
 boundary="------------010401000705050702000201"

This is a multi-part message in MIME format.
--------------010401000705050702000201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi!

This policy was generated using the ipsec-tools that comes with gentoo [1]
setkey was used to set-up the Security Policy Database and Security Association Database and racoon to do the x509 certificate exchange.

the diff is needed because:

ipsec_conf_file_t is a directory structure, not a single file

ipsec_key_file_t is a directory structure that also contains symlinks (one of the ipsec_key_file_t directories must contain openssl hash-links to each certificate)

racoon is the IKE daemon that is started by initrc_t. so this is why the daemon_base_domain is used.


[1]. http://ipsec-tools.sourceforge.net/

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------010401000705050702000201
Content-Type: text/plain;
 name="selinux-ipsec-tools.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-ipsec-tools.diff"

--- /root/public_html/policy/nsa/file_contexts/program/ipsec.fc	2004-09-09 18:27:39.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/ipsec-tools/ipsec.fc	2004-10-06 04:59:57.000000000 +0300
@@ -25,3 +25,6 @@
 # Kame
 /usr/sbin/racoon	--	system_u:object_r:ipsec_exec_t
 /usr/sbin/setkey	--	system_u:object_r:ipsec_exec_t
+/etc/racoon(/.*)?		system_u:object_r:ipsec_conf_file_t
+/etc/racoon/certs(/.*)?	system_u:object_r:ipsec_key_file_t
+/etc/racoon/psk\.txt	--	system_u:object_r:ipsec_key_file_t
--- /root/public_html/policy/nsa/domains/program/unused/ipsec.te	2004-09-23 05:08:20.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/ipsec-tools/ipsec.te	2004-10-06 06:12:51.000000000 +0300
@@ -10,10 +10,7 @@
 # Rules for the ipsec_t domain.
 #
 # a domain for things that need access to the PF_KEY socket
-type ipsec_t, domain, privlog;
-
-# type for executables that will run in the ipsec_t domain
-type ipsec_exec_t, file_type, sysadmfile, exec_type;
+daemon_base_domain(ipsec, `, privlog')
 
 # type for ipsec configuration file(s) - not for keys
 type ipsec_conf_file_t, file_type, sysadmfile;
@@ -48,9 +45,8 @@
 # I do not know where this pesky pipe is...
 allow ipsec_t initrc_t:fifo_file { write };
 
-allow ipsec_t ipsec_conf_file_t:file { getattr read ioctl };
-allow ipsec_t ipsec_key_file_t:file { getattr read ioctl };
-allow ipsec_t ipsec_key_file_t:dir r_dir_perms;
+r_dir_file(ipsec_t, ipsec_conf_file_t)
+r_dir_file(ipsec_t, ipsec_key_file_t)
 allow ipsec_mgmt_t ipsec_conf_file_t:file { getattr read ioctl };
 rw_dir_create_file(ipsec_mgmt_t, ipsec_key_file_t)
 

--------------010401000705050702000201--

--------------enig97D291447783FBAECCFDD76C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBZQF4GSBEIeh4AEYRAqsMAJ9HPjv0UXqBtipfMH4IMo0CKOhpDQCgi5Oq
WbIQvjzyOHnCRLNei7UnJ6E=
=zd98
-----END PGP SIGNATURE-----

--------------enig97D291447783FBAECCFDD76C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
