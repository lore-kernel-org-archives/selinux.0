Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FH8erT019137
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 13:08:40 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FH7eHF027335
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 17:07:44 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 15 Sep 2004 19:08:35 +0200
Date: Wed, 15 Sep 2004 19:09:10 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Patch: Kill duplicate permissions
Message-Id: <20040915170909.GA2560@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--v9Ux+11Zm5mwPlX6
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kill a few duplicate permissions, plus some small cleanup.

crond.te: already defined in logrotate.te
xserver_macros.te: already defined in xdm.te

Others have duplicate permissions in the same file.

Please apply.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kill_duplicates.patch"
Content-Transfer-Encoding: quoted-printable

--- orig/domains/program/checkpolicy.te
+++ mod/domains/program/checkpolicy.te
@@ -55,7 +55,7 @@
 ##########################
 # Allow users to execute checkpolicy without a domain transition
 # so it can be used without privilege to write real binary policy file
-can_exec(user_t, checkpolicy_exec_t)
+can_exec(unpriv_userdomain, checkpolicy_exec_t)
=20
 allow checkpolicy_t { userdomain privfd }:fd use;
=20
--- orig/domains/program/crond.te
+++ mod/domains/program/crond.te
@@ -139,11 +139,6 @@
 allow crond_t mail_spool_t:lnk_file read;
 allow crond_t mail_spool_t:dir search;
=20
-# Run logrotate in the logrotate_t domain.
-ifdef(`logrotate.te', `
-system_crond_entry(logrotate_exec_t, logrotate_t)
-')
-
 ifdef(`mta.te', `
 r_dir_file(system_mail_t, crond_tmp_t)
 ')
--- orig/domains/program/hostname.te
+++ mod/domains/program/hostname.te
@@ -1,4 +1,4 @@
-#DESC Initrc - System initialization scripts
+#DESC hostname - show or set the system's host name
 #
 # Author: Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: hostname
--- orig/domains/program/unused/postfix.te
+++ mod/domains/program/unused/postfix.te
@@ -92,7 +93,6 @@
 file_type_auto_trans({ sysadm_mail_t system_mail_t }, etc_t, etc_aliases_t)
 allow postfix_master_t sendmail_exec_t:file r_file_perms;
 allow postfix_master_t sbin_t:lnk_file { getattr read };
-domain_auto_trans(initrc_t, postfix_master_exec_t, postfix_master_t)
 ifdef(`pppd.te', `
 domain_auto_trans(pppd_t, postfix_master_exec_t, postfix_master_t)
 ')
--- orig/domains/program/unused/quota.te
+++ mod/domains/program/unused/quota.te
@@ -17,10 +17,6 @@
 role sysadm_r types quota_t;
 allow quota_t admin_tty_type:chr_file { read write };
=20
-domain_auto_trans(sysadm_t, quota_exec_t, quota_t)
-role sysadm_r types quota_t;
-allow quota_t admin_tty_type:chr_file { read write };
-
 type quota_flag_t, file_type, sysadmfile;
 type quota_db_t, file_type, sysadmfile;
=20
--- orig/macros/program/xserver_macros.te
+++ mod/macros/program/xserver_macros.te
@@ -43,7 +43,6 @@
 ifdef(`xdm.te', `
 domain_auto_trans(xdm_t, xserver_exec_t, xdm_xserver_t)
 ')
-domain_auto_trans(initrc_t, xserver_exec_t, xdm_xserver_t)
 ', `
 domain_auto_trans($1_t, xserver_exec_t, $1_xserver_t)
 ')dnl end ifelse xdm

--a8Wt8u1KmwUX3Y2C--

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBSHc1xWIrrrL0q+cRAsM1AKCh3eeQ/dbB8ThBw4ffkLn2W3j9WQCeOJ84
u5GaxJIMCwlZAEHrU8qfj3E=
=lIPY
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
