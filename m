Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFFeaIi023733
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 10:40:36 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFFd8vq027117
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 15:39:09 GMT
Message-ID: <4198D20C.9070009@gentoo.org>
Date: Mon, 15 Nov 2004 17:58:04 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo diff for postgresql
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA220C7F6558686F9F7296CDA"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA220C7F6558686F9F7296CDA
Content-Type: multipart/mixed;
 boundary="------------080602040502070007040602"

This is a multi-part message in MIME format.
--------------080602040502070007040602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

a diff that handles the gentoo init scripts and the location of database files.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------080602040502070007040602
Content-Type: text/plain;
 name="selinux-postgresql.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-postgresql.diff"

--- /root/public_html/policy/nsa/file_contexts/program/postgresql.fc	2004-10-21 12:56:53.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/postgresql/postgresql.fc	2004-10-28 11:48:44.000000000 +0300
@@ -12,7 +12,7 @@
 /usr/bin/pg_id		--	system_u:object_r:postgresql_exec_t
 /usr/bin/pg_restore	--	system_u:object_r:postgresql_exec_t
 
-/var/lib/postgres(/.*)?		system_u:object_r:postgresql_db_t
+/var/lib/postgres(ql)?(/.*)? system_u:object_r:postgresql_db_t
 /var/lib/pgsql(/.*)?		system_u:object_r:postgresql_db_t
 /var/run/postgresql(/.*)?	system_u:object_r:postgresql_var_run_t
 /etc/postgresql(/.*)?		system_u:object_r:postgresql_etc_t
--- /root/public_html/policy/nsa/domains/program/unused/postgresql.te	2004-10-12 12:32:18.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/postgresql/postgresql.te	2004-10-28 11:48:12.000000000 +0300
@@ -108,3 +108,11 @@
 dontaudit postgresql_t selinux_config_t:dir { search };
 allow postgresql_t mail_spool_t:dir { search };
 rw_dir_create_file(postgresql_t, var_lock_t)
+
+ifdef(`distro_gentoo', `
+# "su - postgres ..." is called from initrc_t
+allow initrc_su_t postgresql_db_t:dir { search };
+allow postgresql_t initrc_su_t:process { sigchld };
+dontaudit initrc_su_t sysadm_devpts_t:chr_file rw_file_perms;
+')
+

--------------080602040502070007040602--

--------------enigA220C7F6558686F9F7296CDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmNIMGSBEIeh4AEYRArnEAJ0dOhYadzgFF218NT6WBfyM0EbxFACfXmUM
mr7sbcfj1luGma0IdMWsDhU=
=9nW7
-----END PGP SIGNATURE-----

--------------enigA220C7F6558686F9F7296CDA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
